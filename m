From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [PATCH v6] gitweb: add test suite with Test::WWW::Mechanize::CGI
Date: Mon, 23 Jun 2008 09:00:35 +0200
Message-ID: <485F4A13.2060904@gmail.com>
References: <1214181904-30265-1-git-send-email-LeWiemann@gmail.com> <1214183688-8544-1-git-send-email-LeWiemann@gmail.com> <7vd4m8khmb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 23 09:02:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAg3u-0002i7-Vm
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 09:02:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752365AbYFWHAp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 03:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752009AbYFWHAo
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 03:00:44 -0400
Received: from wr-out-0506.google.com ([64.233.184.224]:35060 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755662AbYFWHAf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 03:00:35 -0400
Received: by wr-out-0506.google.com with SMTP id 69so1714991wri.5
        for <git@vger.kernel.org>; Mon, 23 Jun 2008 00:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:from;
        bh=mwUolN9XWdEMOTFtB7z6BV03k2G4/9T1FTM6K20Qfog=;
        b=Lkxp8VZDAqcQpT1g13T36kND0popIAyac1x6jhFMmYhnyaHR+cm9nUTxvbaQwWRrFA
         w8oGG9WjWxb2b7PaTLXwr+ptbZTFJBS3Z2VBxw93y87bnEwH9YAtVDB+EZyRv+7CG56t
         N/QTA8OwlD9OiZ335h6E9nXc5V3jo0mkan8mA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:from;
        b=XB1i9hV3yzx7nFExd1OoAdB03cedexiRNoACQHXmobP4sYeGMSWgNk+pXi2AH38+qf
         R5x8ki6CRZOA1YqBtms+W7jYIgMsceTkHJqmiIt8+91wFdrHgueg+HGV4UktBBVSl1f9
         bqFD9t9N4VK7qfI09EYWFdB2W93mLvSUHTTkA=
Received: by 10.90.65.5 with SMTP id n5mr9493321aga.110.1214204434013;
        Mon, 23 Jun 2008 00:00:34 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.209.241])
        by mx.google.com with ESMTPS id 44sm3757537hsa.9.2008.06.23.00.00.31
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 23 Jun 2008 00:00:33 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <7vd4m8khmb.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85840>

Junio C Hamano wrote:
> My Perl must be getting rusty.  I had to look up this tricky syntax in
> perlfunc.pod,

I looked in up in #perl. ;-)

>> +# Copyright (c) 2008 Jakub Narebski
>> +# Copyright (c) 2008 Lea Wiemann
> 
> If you mean by this that originally Jakub started and then Lea continued
> extending the work, probably the order of Sign-off should match that order
> to express the patch flow trail better.

Sure; I'll change it if I post another version, or feel free to change 
it when you apply the patch.

-- Lea
