From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Teach git status to do "git diff --name-status HEAD"
Date: Wed, 17 Sep 2008 10:42:07 +0200
Message-ID: <48D0C2DF.7010308@drmicha.warpmail.net>
References: <aba84270809162340n4ea3f5feqc71d01fa6e035b79@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin@laptop.org>
X-From: git-owner@vger.kernel.org Wed Sep 17 10:43:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kfsd6-0007W4-AT
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 10:43:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751801AbYIQImM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2008 04:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751549AbYIQImL
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 04:42:11 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:51820 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751144AbYIQImK (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Sep 2008 04:42:10 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 14248163E32;
	Wed, 17 Sep 2008 04:42:10 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 17 Sep 2008 04:42:10 -0400
X-Sasl-enc: DB60KF7OZcZrrcygDtMs+u+A3GFiY+MSdOugel+PKtVR 1221640929
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 66F992A562;
	Wed, 17 Sep 2008 04:42:09 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.16 (X11/20080707)
In-Reply-To: <aba84270809162340n4ea3f5feqc71d01fa6e035b79@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96076>

Martin Langhoff venit, vidit, dixit 17.09.2008 08:40:
> I just did
> 
> $ git checkout -b mdl19-offlinetony
> A       README.offline
> M       lib/javascript.php
>     (...)
> A       lib/offline/offlinemoodle.user.js
> 
> I *like* this "brief status" style - takes me back to my cvs days :-).
> Perusing the source I found show_local_changes() which in turn led me
> to trying `git diff --name-status HEAD`. Now, including 'HEAD' in an
> alias defined in git config is going to lead to trouble... :-/

Nice!
HEAD is default, no need to stick your HEAD into the config ;)

> I might still make an alias to `git diff --name-status`. This would be
> a great thing to have as git status "--brief" IMHO... :-)

git status also shows untracked files. I don't know how to tell diff to
show untracked files as well. --diff-filter=X doesn't do it.

Michael
