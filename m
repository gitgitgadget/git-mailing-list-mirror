From: Junio C Hamano <junkio@cox.net>
Subject: Re: merge-recur status
Date: Wed, 09 Aug 2006 14:18:38 -0700
Message-ID: <7vy7tx1uc1.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0608092232000.13885@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 09 23:18:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAvRr-0002SO-Md
	for gcvg-git@gmane.org; Wed, 09 Aug 2006 23:18:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382AbWHIVSk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Aug 2006 17:18:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751383AbWHIVSk
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Aug 2006 17:18:40 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:24510 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751382AbWHIVSk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Aug 2006 17:18:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060809211839.VRSN6235.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 9 Aug 2006 17:18:39 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0608092232000.13885@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Wed, 9 Aug 2006 23:02:51 +0200
	(CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25148>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I tried to wrap my head over it, but seem unable to do so. Also, I do not 
> find the case 14ALT (which is mentioned in unpack-trees.c:603) in 
> Documentation/technical/trivial-merge.txt.

That is t/t1000-read-tree-m-3way.sh case 14.  The current
semantics for case 14 used to be called ALT until 3e03aaf
simplified the table to reflect the reality, because the
"alternative" semantics had been in use for quite some time
already back then.

I'd like to take a look at 41094b8e, the real trouble that is
causing you grief, sometime later, but I'm currently pondering
if the one I tag should be called 1.4.2 or 1.4.2-rc4 ;-).
