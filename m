From: Junio C Hamano <junkio@cox.net>
Subject: Re: (rework) [PATCH 3/4] Accept commit in some places when tree is
 needed.
Date: Wed, 20 Apr 2005 17:43:35 -0700
Message-ID: <7vk6mxgds8.fsf@assigned-by-dhcp.cox.net>
References: <7vvf6hgeqj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 02:39:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOPiw-00052T-DZ
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 02:39:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261862AbVDUAni (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 20:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261864AbVDUAni
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 20:43:38 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:45514 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S261862AbVDUAnh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2005 20:43:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050421004335.LHDT1497.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 20 Apr 2005 20:43:35 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vvf6hgeqj.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Wed, 20 Apr 2005 17:23:00 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "JCH" == Junio C Hamano <junkio@cox.net> writes:

JCH> Updates ls-tree.c to use read_tree_with_tree_or_commit_sha1()
JCH> function.  The command can take either tree or commit IDs with
JCH> this patch.

Sorry, but the numbering is wrong this should have been [4/5]
not [3/4].  The contents should be fine, though.

