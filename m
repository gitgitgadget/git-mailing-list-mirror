From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Only the config file changes ...
Date: Tue, 02 Mar 2010 14:16:23 +0100
Message-ID: <4B8D0FA7.8070206@drmicha.warpmail.net>
References: <70786312428882320720829319256948501508-Webmail@me.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jez Caudle <gitmailinglist@me.com>
X-From: git-owner@vger.kernel.org Tue Mar 02 14:18:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmS00-0007Ex-QB
	for gcvg-git-2@lo.gmane.org; Tue, 02 Mar 2010 14:18:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753137Ab0CBNSw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Mar 2010 08:18:52 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:44121 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752718Ab0CBNSv (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Mar 2010 08:18:51 -0500
Received: from compute1.internal (compute1 [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 83FF5E2F05;
	Tue,  2 Mar 2010 08:18:50 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 02 Mar 2010 08:18:50 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=iDAb2hifEFl2Pvb/nkfDTMPqTeM=; b=mFOrYJ1XswSaADq9eUN4n3F/WHkGzZmhz9qpFqQIG8D9DxuUfIfk/molURCxK1X1SKt9SrxS494SKeefkhhFFiO8JNLl+c5nt+t/R+wCnZ9dzyAQcleFtYsZH4y0fcEdOXOirYr6iRFH+dS+20Spe3mVXLCHVSrpsEiwV4DBHMA=
X-Sasl-enc: KlAx5N8RBCXhh003DsNM1jSMUehwOMlbRDEHMlilkVcR 1267535930
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id E47F449F2A5;
	Tue,  2 Mar 2010 08:18:49 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9pre) Gecko/20100301 Lightning/1.0b2pre Shredder/3.0.3pre
In-Reply-To: <70786312428882320720829319256948501508-Webmail@me.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141394>

Jez Caudle venit, vidit, dixit 02.03.2010 13:06:
> Hi I'm new to Git and I've read the manual and tried my best to
> understand it.
> 
> I have a project that is going to have many versions, all the same
> except for the config file, the unit/functional tests and some
> display information.
> 
> I have seen that I can create branches and then merge them. I
> wondered if I could create a branch, change the config file
> information and then decree that the config file in the new branch is
> not merged.
> 
> I read about sub modules but they didn't seam relevant.
> 
> Am I barking up the wrong tree here?

You're fellow dogs may need more details in order to decide that ;)

In general, I would recommend one branch (be it master) for changes
which apply to all clients (I guess that's what you mean by "versions,
all the same except..."), and one branch each for specific changes (to
config etc.).

Then just make sure to merge in the right direction, i.e. merge the
general, common branch into the specific ones.

Cheers,
Michael
