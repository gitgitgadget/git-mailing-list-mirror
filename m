From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [ANNOUNCE] Git 1.6.5.4
Date: Thu, 03 Dec 2009 15:51:36 +0100
Message-ID: <4B17D078.6080000@drmicha.warpmail.net>
References: <7v638o76ra.fsf@alter.siamese.dyndns.org>	<m2hbs85koj.fsf@igel.home> <4B17ABE3.6060003@drmicha.warpmail.net> <m2d42w5fqq.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Thu Dec 03 15:52:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGD3B-0002NA-70
	for gcvg-git-2@lo.gmane.org; Thu, 03 Dec 2009 15:52:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756024AbZLCOwp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Dec 2009 09:52:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755939AbZLCOwp
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Dec 2009 09:52:45 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:46408 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751474AbZLCOwo (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Dec 2009 09:52:44 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 004D8C19FC;
	Thu,  3 Dec 2009 09:52:50 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 03 Dec 2009 09:52:51 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=PULF85KyqAkLBgPII9jwt/QUqY0=; b=OeNtlqtzwCqwm0irdRckWEmFrEfQei/ArGtrlB/7AcjxO8fTWe9FD19AJ6qzjy7e7buxd2csfHTSdQjtGlXHMXiWFGiXmeWc+tuDJwLtBppffemWXzQg0Fqiy2JKTcfHIFddpweDrwWCeTBfBXM16o4zdT4NBiWOM3EageCMm9o=
X-Sasl-enc: +5U7GbxqZH8L12kibwXF2pPxd9q26w5KeadxKLeV6HtC 1259851970
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 310961D11C;
	Thu,  3 Dec 2009 09:52:50 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.6pre) Gecko/20091127 Lightning/1.0b1pre Shredder/3.0.1pre
In-Reply-To: <m2d42w5fqq.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134453>

Andreas Schwab venit, vidit, dixit 03.12.2009 14:50:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> Andreas Schwab venit, vidit, dixit 03.12.2009 13:03:
>>> Junio C Hamano <gitster@pobox.com> writes:
>>>
>>>>       Unconditionally set man.base.url.for.relative.links
>>>
>>> rm -f git-add.1 && \
>>>         xmlto -m manpage-normal.xsl  --stringparam man.base.url.for.relative.links= man git-add.xml
>>> xmlto: unrecognized option '--stringparam'
>>> make[1]: *** [git-add.1] Error 1
>>>
>>> Andreas.
>>>
>>
>> and
>>
>> uname -a
>> xmlto --version
>>
>> says?
> 
> xmlto version 0.0.18
> 
> Andreas.
> 

Now that predates Git quite a bit (2004-01-21)...
I think we can require at least 0.0.20, which is in Debian Lenny and
Fedora 9, for example. I think that should have it. (I'm not sure, they
don't use a proper vcs ;) ).

Michael
