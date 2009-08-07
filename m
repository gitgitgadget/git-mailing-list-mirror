From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] push: point to 'git pull' and 'git push --force' in case
 of non-fast forward
Date: Fri, 07 Aug 2009 21:46:11 +0200
Message-ID: <4A7C8483.10704@drmicha.warpmail.net>
References: <1249579933-1782-1-git-send-email-Matthieu.Moy@imag.fr>	<4A7B3760.2000303@drmicha.warpmail.net> <vpqzlabwhue.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Aug 07 21:46:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZVOp-0004GW-IC
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 21:46:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933195AbZHGTqi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2009 15:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933185AbZHGTqi
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Aug 2009 15:46:38 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:40051 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755017AbZHGTqh (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Aug 2009 15:46:37 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 1A5211329;
	Fri,  7 Aug 2009 15:46:37 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Fri, 07 Aug 2009 15:46:37 -0400
X-Sasl-enc: n7UjtrHt1JG+1UlYutLNAugspXBo4yxP55ads0EYxNru 1249674395
Received: from localhost.localdomain (vpn-137-043.rz.uni-augsburg.de [137.250.137.43])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 6C76D4404;
	Fri,  7 Aug 2009 15:46:30 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.2pre) Gecko/20090728 Lightning/1.0pre Shredder/3.0b4pre
In-Reply-To: <vpqzlabwhue.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125214>

Matthieu Moy venit, vidit, dixit 07.08.2009 21:21:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> May I suggest "Some push was rejected because it would not result in a
>> fast forward:\n Merge in the remote changes (using git pull) before
>> pushing yours\n or use..."?
> 
> Are you sure this is "Some push _was_ ..."? In the general case,
> several branches are rejected, so that would be "were", no?
> 

Well, I'm certainly sure about the "yours" vs "your's" and about the
rewording of "due to".

If you want plural then please use "Some pushes were". I suggested the
singular, "A push was" or "Some push was". "Some" can denote an amount
but it is also used as a determiner in sentences like: "Some guy here
pretends to know English although he's not a native speaker." That would
be me :)

We don't know how many pushes failed, only that at least one did. Being
a mathematician I have to use the singular here, but feel free to use
the plural (also for the noun).

Cheers,
Michael
