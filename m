From: Junio C Hamano <junkio@cox.net>
Subject: Re: I want to release a "git-1.0"
Date: Tue, 31 May 2005 23:52:03 -0700
Message-ID: <7vacmapo18.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505301253070.1876@ppc970.osdl.org>
	<Pine.LNX.4.62.0505301644430.5330@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 01 08:49:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdN2d-0005D4-Ke
	for gcvg-git@gmane.org; Wed, 01 Jun 2005 08:49:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbVFAGwK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Jun 2005 02:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261304AbVFAGwK
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jun 2005 02:52:10 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:16855 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S261300AbVFAGwF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2005 02:52:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050601065203.HIIG550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 1 Jun 2005 02:52:03 -0400
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.62.0505301644430.5330@localhost.localdomain> (Nicolas
 Pitre's message of "Mon, 30 May 2005 16:49:33 -0400 (EDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I just remembered that I mentioned potential problems with non
rsync pulls with delta objects, especially when the git-*-pull
commands are used in "things only close to the tip" mode,
i.e. without "-a" option.  Do you think we should do something
about it before GIT 1.0 happens?  

It may be enough if we just tell people not to deltify their
public non-rsync repositories in the documentation.

