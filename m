From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH/RFC 2/2] format-patch: show notes as message after the
 ---
Date: Tue, 26 Apr 2011 11:44:21 +0200
Message-ID: <4DB693F5.4090803@drmicha.warpmail.net>
References: <cb2af8d1ef663a68ea96dbb916dcfa0aee71abcb.1303808057.git.git@drmicha.warpmail.net> <826def15eb7204ee30fc4c358f72103ec75b4e42.1303808057.git.git@drmicha.warpmail.net> <201104261128.58527.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Apr 26 11:44:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEeor-0008Fz-0T
	for gcvg-git-2@lo.gmane.org; Tue, 26 Apr 2011 11:44:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752763Ab1DZJoY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2011 05:44:24 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:52864 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752303Ab1DZJoY (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2011 05:44:24 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id AFED2208C7;
	Tue, 26 Apr 2011 05:44:23 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 26 Apr 2011 05:44:23 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=Q+yvt0utMmZKUMcChKfiPiLF6uY=; b=f2AfZ2PiluFxj4Gp80p/NOx7uk8IpooMeuaBKalb+c6AAnBX+7jtuL2d2c8xnEpAEMVGhN6q2lbjDX8BZd4miGiY0S/qZo7iIatCjVfFVYwAr5vqUQuQAR4oehUw+kG5t8cp+IxYY42cSO1VuKOBcOPneT4zifz+jFiR2uDOVd0=
X-Sasl-enc: VlmI2+X0tUGgQKK1eyOA5G3Nc9awsTVSaR7QGdSMhc2n 1303811063
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 37D2A446342;
	Tue, 26 Apr 2011 05:44:22 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <201104261128.58527.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172083>

Johan Herland venit, vidit, dixit 26.04.2011 11:28:
> On Tuesday 26 April 2011, Michael J Gruber wrote:
>> When requesting notes with "--notes", "format-patch" produces notes
>> within the commit message which "am" misunderstands as being part of
>> the message.
>>
>> Change this so that notes are displayed after an additional "---".
>> Any "am" (old or new) will ignore that, so that it is a safe place
>> for additional comments:
>>
>> Log message
>> "---"
>> notes
>> "---"
>> diffstat
>> patch
>>
>> (The first "---" appears only when there is a note, of course.)
>>
>> Later on (say with "--format-notes") the output format can be changed
>> easily to accomodate a future "am" which knows how to create notes
>> from such patches.
>>
>> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> 
> Acked-by: Johan Herland <johan@herland.net>
> 
> (goes for 1/2 as well)
> 
> 
> /me likes :)

Thanks :)

BTW: Just before hitting "send-mail", I thought of quoting the "---" in
my commit message where I describe the format. I wonder what would have
happened else when am-ing that message...

Michael
