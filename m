From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] cvsimport: use git-update-ref when updating
Date: Thu, 30 Mar 2006 17:50:13 -0800
Message-ID: <7vk6ab1iy2.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0603301405160.18852@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 31 03:50:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FP8mO-0004mC-Ie
	for gcvg-git@gmane.org; Fri, 31 Mar 2006 03:50:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750885AbWCaBuP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Mar 2006 20:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbWCaBuP
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Mar 2006 20:50:15 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:9211 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1750885AbWCaBuO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Mar 2006 20:50:14 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060331015014.BTMY20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 30 Mar 2006 20:50:14 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18214>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> This simplifies code, and also fixes a subtle bug: when importing in a
> shared repository, where another user last imported from CVS, cvsimport
> used to complain that it could not open <branch> for update.

The second hunk look sensible but I do not know about "use Fcntl"
since I do not see anything you are adding that starts to use it...
