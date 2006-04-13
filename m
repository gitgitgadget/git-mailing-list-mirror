From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] diff-options: add --stat
Date: Wed, 12 Apr 2006 21:54:44 -0700
Message-ID: <7vy7ya13e3.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0604130301240.28688@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 13 06:55:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FTtrc-0005lE-V4
	for gcvg-git@gmane.org; Thu, 13 Apr 2006 06:55:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964782AbWDMEys (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Apr 2006 00:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964783AbWDMEys
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Apr 2006 00:54:48 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:54401 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S964782AbWDMEys (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Apr 2006 00:54:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060413045447.XYRX2467.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 13 Apr 2006 00:54:47 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0604130301240.28688@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Thu, 13 Apr 2006 03:02:10 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18647>

Interesting.

I wonder if you can also make this an independent option that
prepends diffstat in front of the patch, just like the way the
new flag --patch-with-raw flag prepends raw output in front of
the patch.

By the way, I've been wondering if anybody uses the
GIT_EXTERNAL_DIFF interface.  Does anybody miss it if we did so?
