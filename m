From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Why doesn't git commit -a track new files
Date: Thu, 24 Feb 2011 17:04:17 +0100
Message-ID: <4D668181.404@drmicha.warpmail.net>
References: <20110224112246.3f811ac2@glyph>	<4D6672F7.4020101@drmicha.warpmail.net> <vpqk4gp4dxf.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Marco <netuse@lavabit.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Feb 24 17:07:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsdjB-0002HL-T8
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 17:07:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756194Ab1BXQHg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Feb 2011 11:07:36 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:53664 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752306Ab1BXQHf (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Feb 2011 11:07:35 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id B1DCE201B3;
	Thu, 24 Feb 2011 11:07:34 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 24 Feb 2011 11:07:34 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=ad7uFoLlQmoH7xk8or788R3Utaw=; b=s7/jTuFr9h0JrVYFCScsVQlPm/Ztv9j+gLw2vCVAXoVxW+oxtTvSzstW5dxlr+RZ89dbCD0mSw/1KacWM459po7ATK74g98Z5m3xKTRB1E7Yyr+Gc8sOpvxYNKGOG6zZPGo8pbzmAjf+sTmHf/Z6IWEqNvPV+h9Iwx1JKxfFMrA=
X-Sasl-enc: FKnlLucCl9X75B/aND5BjegHcFbLm7i5qqQD7BFTQGDx 1298563654
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 2017C400A7C;
	Thu, 24 Feb 2011 11:07:34 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <vpqk4gp4dxf.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167831>

Matthieu Moy venit, vidit, dixit 24.02.2011 17:04:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> Why does it not exist? Because you should at least
>> "git add -A && git status && behappy && git commit".
> 
> There are alternatives like
> 
> git status && behappy && git commit -A

That may not give the full picture of untracked stuff in subdirs.

> or
> 
> git commit -A && look at status $EDITOR && behapy && save

Yes, I even mentioned that, but you cut it. Bad bad boy! ;)

>> Also, "-A" supports a very "un-gitty" way of using git. This makes it
>> unlikely that someone cares to implement it...
> 
> I guess that's it. It's not usefull to most Git developers, hence nobody
> cared to implement it. But IIRC the switch "add -A" was chosen partly
> because -A didn't exist for commit, hence this leaves room for commit

Yes.

So, we have one more volunteer for the plan just laid out, right?

Michael
