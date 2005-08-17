From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Also handle CVS branches with a '/' in their name
Date: Wed, 17 Aug 2005 00:27:20 -0700
Message-ID: <7vbr3x10rr.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0508170839030.27628@wgmdd8.biozentrum.uni-wuerzburg.de>
	<7vk6il11wi.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0508170906480.10754@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp-2
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 17 09:27:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5IKj-0002sI-KB
	for gcvg-git@gmane.org; Wed, 17 Aug 2005 09:27:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750949AbVHQH1W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Aug 2005 03:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750950AbVHQH1W
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Aug 2005 03:27:22 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:54658 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1750923AbVHQH1W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2005 03:27:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050817072720.GLJQ19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 17 Aug 2005 03:27:20 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0508170906480.10754@wgmdd8.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Wed, 17 Aug 2005 09:09:54 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> That may be true, but CVS branches being named "H.ANdnsel/Gretel" do not 
> logically denote hierarchies. I never ever saw hierarchical CVS branch 
> names with a "/" separator. I saw some with a "." separator.
>
> My feeling is that it would be wrong to map CVS branch names to a 
> hierarchy.

Although I've used / in CVS branch names to denote hierarchy,
I now agree with you for a different reason.  A CVS repository
can have branches "Hnsel" and "Hnsel/Gretel" at the same time,
which we cannot express it with '/'.

However, this may make CVS tags Hnsel/Gretel and Hnsel-Gretel
clash, so maybe the name mangling should be made somehow
configurable?
