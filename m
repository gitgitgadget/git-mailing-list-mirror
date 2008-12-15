From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFCv4 1/3] gitweb: add patch view
Date: Mon, 15 Dec 2008 14:58:55 +0100
Message-ID: <200812151458.55557.jnareb@gmail.com>
References: <1228575755-13432-1-git-send-email-giuseppe.bilotta@gmail.com> <200812151417.16372.jnareb@gmail.com> <cb7bb73a0812150548w526a8c0eu13ec95785e0ab824@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Petr Baudis" <pasky@suse.cz>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 15 15:00:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCDzf-000282-J5
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 15:00:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752341AbYLON7B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 08:59:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752548AbYLON7B
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 08:59:01 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:25850 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752269AbYLON7A (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 08:59:00 -0500
Received: by nf-out-0910.google.com with SMTP id d3so453494nfc.21
        for <git@vger.kernel.org>; Mon, 15 Dec 2008 05:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=ZsMUhzrTVGddUaqsc0J/zB1oj/jhxxZ3BIDybCtE258=;
        b=g1c5HWbcG3wIGUXiF0ipavS9aYsFXuSZbnq1Jk8J3n39w10uRW7x1zjJXxpGhkgz0d
         euMot1Lk+BzYvvmN2RP+gM7mTPeBMo08d1kPmduPXDblpx9SJE/cFHiajOpUPK5QHaeR
         U7TeTN0LlXYl3jKhlTkaQB3rLO2Bxkbqx+asU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=VNDZ6UokadMVYf/Hw1URlociHxSaK6fkZDH+ag5nZH0tNCmIO9PtMIx4+grfLEpdMY
         9Xomp1ISZ18Io+wjahV7Nkar+R5NHcSkVrmuH12S9Ra4qQgB7QSiVGTpYKhim8p9RyDo
         1nHI5VSjelZKXXwjQCX0bbDRAA5TOTWitZrvw=
Received: by 10.210.139.15 with SMTP id m15mr7780948ebd.118.1229349538466;
        Mon, 15 Dec 2008 05:58:58 -0800 (PST)
Received: from ?192.168.1.11? (abva128.neoplus.adsl.tpnet.pl [83.8.198.128])
        by mx.google.com with ESMTPS id 20sm534663eyk.24.2008.12.15.05.58.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 15 Dec 2008 05:58:57 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <cb7bb73a0812150548w526a8c0eu13ec95785e0ab824@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103165>

Giuseppe Bilotta wrote:
> On Mon, Dec 15, 2008 at 2:17 PM, Jakub Narebski <jnareb@gmail.com> wrote:

>>> +     my $patch_max;
>>> +     if ($format eq 'patch') {
>>> +             $patch_max = gitweb_check_feature('patches');
>>> +             die_error(403, "Patch view not allowed") unless $patch_max;
>>> +     }
>>> +
>>
>> Hmmm... gitweb_check_feature
> 
> You're right, it's an abuse. I'll make it gitweb_get_feature()[0]

Or better

+             ($patch_max) = gitweb_get_feature('patches');

[...]
> As soon as you finish the patchset review I'll have a new version
> taking into consideration all the other suggestions and remarks I
> snipped from this reply.

Thank you very much for keeping this patch series alive.

-- 
Jakub Narebski
Poland
