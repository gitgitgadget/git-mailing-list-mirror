From: Junio C Hamano <junkio@cox.net>
Subject: Re: tool to diff cache <-> working directory
Date: Thu, 05 May 2005 18:33:53 -0700
Message-ID: <7vhdhhf88u.fsf@assigned-by-dhcp.cox.net>
References: <20050506002347.GU20994@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 06 03:28:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTrdR-0000Zx-5i
	for gcvg-git@gmane.org; Fri, 06 May 2005 03:28:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262128AbVEFBeW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 May 2005 21:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbVEFBeV
	(ORCPT <rfc822;git-outgoing>); Thu, 5 May 2005 21:34:21 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:30195 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S262136AbVEFBeC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2005 21:34:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050506013352.GQNC7629.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 5 May 2005 21:33:52 -0400
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
In-Reply-To: <20050506002347.GU20994@cip.informatik.uni-erlangen.de> (Thomas
 Glanzmann's message of "Fri, 6 May 2005 02:23:47 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "TG" == Thomas Glanzmann <sithglan@stud.uni-erlangen.de> writes:

TG> Is there a tool to compare cache with working directory
TG> similiar to diff-tree, diff-cache and diff-files?

    git-diff-tree tree1 tree2           two trees
    git-diff-cache --cached tree1	cache and tree
    git-diff-cache tree1		tree and working directory
    git-diff-files                      cache and working directory

So git-diff-files is not just similar to but exactly is what you
want if I read your question correctly.

TG> Or is there a way to find out the SHA checksum of a file in
TG> a working directory without adding it to a temporary cache?

Yes there is a way, git-write-blob, but why would you want to do
that?


