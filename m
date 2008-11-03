From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Make Pthread link flags configurable
Date: Mon, 3 Nov 2008 19:26:28 +0100
Message-ID: <200811031926.29302.jnareb@gmail.com>
References: <1225669400-79505-1-git-send-email-david.syzdek@acsalaska.net> <m3hc6pf8k6.fsf@localhost.localdomain> <9a0027270811031018t2b90ee64kcd2ef5e9afa73f6a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "David M. Syzdek" <david.syzdek@acsalaska.net>, git@vger.kernel.org
To: "David Syzdek" <syzdek@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 03 19:27:48 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kx49T-00058J-FU
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 19:27:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751924AbYKCS0e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 13:26:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751904AbYKCS0e
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 13:26:34 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:64007 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751792AbYKCS0d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 13:26:33 -0500
Received: by nf-out-0910.google.com with SMTP id d3so1054985nfc.21
        for <git@vger.kernel.org>; Mon, 03 Nov 2008 10:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=YNOJyHrFpF68d4sNH+Z1VEZ/lLY3JsfpP4pXAQBPods=;
        b=QCQ7C5pm8/C9MGHvtOooc2xM1Zz1JTxLlN5clEOGfh0gr/jCS+oE3s5EzY48u+KMNm
         iyqBqzBmxKLZcPKCf1x6oOoQnkiHZdJfUtfJSEhOHPnOGjxfX3+Gn5jkT/yGCKivvgUQ
         xHmClW1JNNyvpS3qo8tLjZgpeSHLiD1lYhW6w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=YUUg8+SDlERAeG14a7OTW4xJm2VIMePMizGD4X8oB0/RbfXLGJJPsxqeQaG7J2dk0d
         BLR7pbY6B4+K/Yqa+h2J1BmkxfZv+d25kgr7kM6KW5QY9O6gX5/1tCdGzW3SFgLFPXIC
         IUMsdv3YnupwhIepDf8vG7/niVL6v0dfZ8tW4=
Received: by 10.210.26.14 with SMTP id 14mr498967ebz.32.1225736791970;
        Mon, 03 Nov 2008 10:26:31 -0800 (PST)
Received: from ?192.168.1.11? (abvp247.neoplus.adsl.tpnet.pl [83.8.213.247])
        by mx.google.com with ESMTPS id 7sm10148689eyb.1.2008.11.03.10.26.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 03 Nov 2008 10:26:30 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <9a0027270811031018t2b90ee64kcd2ef5e9afa73f6a@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99972>

David Syzdek wrote:
> On Mon, Nov 3, 2008 at 12:44 AM, Jakub Narebski <jnareb@gmail.com> wrote:
>> david.syzdek@acsalaska.net writes:
>>
>>> From: David M. Syzdek <david.syzdek@acsalaska.net>
>>>
>>> FreeBSD 4.x systems use the linker flags `-pthread' instead of the
>>> linker flags `-lpthread' when linking against the pthread library.
>>>
>>> Signed-off-by: David M. Syzdek <david.syzdek@acsalaska.net>
>>> ---
>>>  Makefile |    4 +++-
>>>  1 files changed, 3 insertions(+), 1 deletions(-)
>>
>> Would it be possible to add support for this also to configure.ac
>> (and config.mak.in)?
>>
> 
> I just sent a patch to the list that adds autoconf tests for pthreads.
>  If the test is able to determine which flag to use, then it also sets
> THREADED_DELTA_SEARCH.

Thanks a lot.

-- 
Jakub Narebski
Poland
