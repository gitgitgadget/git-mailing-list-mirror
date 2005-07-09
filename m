From: Junio C Hamano <junkio@cox.net>
Subject: Re: Bootstrapping into git, commit gripes at me
Date: Fri, 08 Jul 2005 18:31:04 -0700
Message-ID: <7vwto03gvb.fsf@assigned-by-dhcp.cox.net>
References: <20050708230750.GA23847@buici.com>
	<7v4qb46dff.fsf@assigned-by-dhcp.cox.net>
	<20050709003636.GA26526@buici.com>
	<7v1x684wgr.fsf@assigned-by-dhcp.cox.net>
	<20050709011628.GA11253@buici.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 09 03:33:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dr4Dy-0008Pr-Ep
	for gcvg-git@gmane.org; Sat, 09 Jul 2005 03:33:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263031AbVGIBdK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jul 2005 21:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261586AbVGIBdK
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jul 2005 21:33:10 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:16050 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S263031AbVGIBbL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2005 21:31:11 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050709013105.KQGC1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 8 Jul 2005 21:31:05 -0400
To: Marc Singer <elf@buici.com>
In-Reply-To: <20050709011628.GA11253@buici.com> (Marc Singer's message of "Fri, 8 Jul 2005 18:16:28 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "MS" == Marc Singer <elf@buici.com> writes:

MS> I gather that the approved solution is to have complete replicas of
MS> the git master from Linus for each line of development.

Either symlink .git/objects together, or GIT_OBJECT_DIRECTORY
environment variable point at a shared repository, and just do
not run git-prune-script and you will be fine.
