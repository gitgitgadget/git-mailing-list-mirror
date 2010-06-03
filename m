From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 0/4] Don't warn about missing EOL for symlinks
Date: Thu, 03 Jun 2010 16:57:44 +0200
Message-ID: <4C07C2E8.508@drmicha.warpmail.net>
References: <cover.1275575236.git.git@drmicha.warpmail.net> <vpq1vco41go.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jun 03 16:58:15 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKBs5-0002xZ-Kh
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 16:58:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754987Ab0FCO6I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jun 2010 10:58:08 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:38088 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754052Ab0FCO6H (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Jun 2010 10:58:07 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id A1D1EF8677;
	Thu,  3 Jun 2010 10:58:06 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 03 Jun 2010 10:58:06 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=1gnFGCmvYEBExWLuBtrzV4D/Yzg=; b=SIzEIya5kFbzNSO6gZGx+vDPHYkelWznfgRcUKK4foyB1lpV8n45M3/NGmqrshUP7cWkL5V0M+L4YM90Ulerc39BQp+6BlJbbnWUws6MrDKSB20Ip5BmVKpc8m9VX3Dwv/n/L68kYJkWTY+RInBG1q6ZkZrzsY0gmjTSpqnmIOM=
X-Sasl-enc: e44F3DLdsOhXRwhdyERjwRFQbuodwz4pYja+e43RzEeU 1275577086
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 8C37F4DA404;
	Thu,  3 Jun 2010 10:58:05 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100526 Lightning/1.0b2pre Lanikai/3.1.1pre
In-Reply-To: <vpq1vco41go.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148330>

Matthieu Moy venit, vidit, dixit 03.06.2010 16:47:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> "No newline at end of file" always confuses me when looking at a diff for
>> symlinks. "File? Huh? Didn't Git recognize my symlink?"
> 
> For interactive use, I do understand. But how do you deal with the
> (improbable) case of a user actually adding a newline at the end of
> the target of the symlink, and then using format-patch and am to apply
> the changes somewhere else?
> 
> You probably want to make sure your patch doesn't modify format-patch.
> 
> BTW, I disagree that the message is a "warning": it's actually a piece
> of information, part of the patch, but that we find annoying in this
> case.
> 

May I kindly direct you to the next parts you cut out, especially the
one talking about "described thorougly along with the
rationale in 3/4", and to the commit message of 3/4? :)

I'm not breaking existing tests, of course, which also test
format-patch/apply cycles with symlinks.

Michael
