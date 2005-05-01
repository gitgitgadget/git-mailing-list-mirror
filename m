From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Really fix git-merge-one-file-script this time.
Date: Sun, 01 May 2005 14:32:02 -0700
Message-ID: <7v64y2skdp.fsf@assigned-by-dhcp.cox.net>
References: <7vd5sbz436.fsf@assigned-by-dhcp.cox.net>
	<7vzmveu6zs.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505011312080.2296@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 23:34:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSM3n-0001K8-RT
	for gcvg-git@gmane.org; Sun, 01 May 2005 23:33:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262695AbVEAVhm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 May 2005 17:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262691AbVEAVd7
	(ORCPT <rfc822;git-outgoing>); Sun, 1 May 2005 17:33:59 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:15759 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S262713AbVEAVcE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2005 17:32:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050501213203.OMKM8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 1 May 2005 17:32:03 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505011312080.2296@ppc970.osdl.org> (Linus
 Torvalds's message of "Sun, 1 May 2005 13:29:59 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> In particular, I think the "apply the patch forward" (that cogito does) is
LT> as wrong with the "local modifications" as it is for the merge itself, and
LT> that a truly good merge would actually have _another_ three-way merge on
LT> the working file - the "original" is the version in our old HEAD branch,
LT> with the two branches being merged are "working copy before the merge" and
LT> "merge results".

Funny that I realize that is exactly how I've been doing my
merges with you.

