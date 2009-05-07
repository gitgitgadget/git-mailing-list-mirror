From: "Matthias Andree" <matthias.andree@gmx.de>
Subject: Re: [PATCH] To make GIT-VERSION-FILE, search for git more widely
Date: Thu, 07 May 2009 11:13:21 +0200
Message-ID: <op.utjykjwx1e62zd@merlin.emma.line.org>
References: <1241684666-18956-1-git-send-email-matthias.andree@gmx.de>
 <7vws8te2ht.fsf@alter.siamese.dyndns.org> <4A02A008.30800@viscovery.net>
 <4A02A39A.3000407@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Michael J Gruber" <git@drmicha.warpmail.net>,
	"Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu May 07 11:13:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1zfb-0001aA-Iu
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 11:13:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751570AbZEGJNZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 05:13:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbZEGJNZ
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 05:13:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:36872 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750981AbZEGJNZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 05:13:25 -0400
Received: (qmail invoked by alias); 07 May 2009 09:13:23 -0000
Received: from g226231102.adsl.alicedsl.de (EHLO mandree.no-ip.org) [92.226.231.102]
  by mail.gmx.net (mp051) with SMTP; 07 May 2009 11:13:23 +0200
X-Authenticated: #428038
X-Provags-ID: V01U2FsdGVkX1/Yy2QD7h3Yk/06stITxK96V2/67vm4NR0Noi5ofI
	KB+lme7M/QzFyx
Received: from merlin.emma.line.org (localhost [127.0.0.1])
	by merlin.emma.line.org (Postfix) with ESMTP id C9F3E949A7;
	Thu,  7 May 2009 11:13:21 +0200 (CEST)
In-Reply-To: <4A02A39A.3000407@drmicha.warpmail.net>
User-Agent: Opera Mail/9.64 (Linux)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118454>

Am 07.05.2009, 11:02 Uhr, schrieb Michael J Gruber  
<git@drmicha.warpmail.net>:

> Johannes Sixt venit, vidit, dixit 07.05.2009 10:47:
>> Junio C Hamano schrieb:
>>> Matthias Andree <matthias.andree@gmx.de> writes:
>>>
>>>> Problem: when git is installed into /usr/local/bin, running 'sudo make
>>>> install' won't find git in $PATH (because sudo strips PATH, for  
>>>> instance
>>>> on openSUSE 11.1, and doesn't include /usr/local/whatever).
>>>
>>> That sounds like a bug/misfeature in sudo (which I do not use) to me.
>>
>> sudo resets the environment, in particular also PATH. Why would this be  
>> a bug?
>>
>> Current distros set env_reset in /etc/soduers for a reason. Not that I
>> know the reason in detail, but I won't claim that I'm more clever with
>> regards to security issues than distro packagers; so I trust that if  
>> they
>> do it, then it makes sense.
>>
>> -- Hannes
>
> sudo's behaviour is fine, but the OP's is not: doing "sudo make install"
> amounts to building git as root, unless you have done a make as non-root
> before. If you have done that make then GIT-VERSION-FILE will be
> up-to-date, and GIT-VERSION-GEN will not even be called by "make  
> install".

Michael,

believe me that I've thoroughly analyzed this before proposing the change.

More details in the followup - I need to fix the commit message :-)

> So I think the proposed patch would encourage wrong behaviour. (also,
> the commit message mixes up ...-GEN and ...-FILE)

Whoops, good catch. PATCH v3 in a minute.

Best regards

-- 
Matthias Andree
