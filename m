From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-diff-tree -z HEAD | git-diff-helper -z fails for me
Date: Mon, 23 May 2005 09:38:21 -0700
Message-ID: <7vwtpp6goy.fsf@assigned-by-dhcp.cox.net>
References: <20050523090206.GJ23388@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: torvalds@osdl.org, GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 23 18:38:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DaFvL-0000MC-Rx
	for gcvg-git@gmane.org; Mon, 23 May 2005 18:37:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261911AbVEWQi2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 May 2005 12:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261910AbVEWQi2
	(ORCPT <rfc822;git-outgoing>); Mon, 23 May 2005 12:38:28 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:56510 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S261911AbVEWQiZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2005 12:38:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050523163822.CYNX22430.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 23 May 2005 12:38:22 -0400
to: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
In-Reply-To: <20050523090206.GJ23388@cip.informatik.uni-erlangen.de> (Thomas
 Glanzmann's message of "Mon, 23 May 2005 11:02:06 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "Tg" == Thomas Glanzmann <sithglan@stud.uni-erlangen.de> writes:

Tg> Hello,
Tg> this fails:

Tg> 	(faui00u) [~/work/git/yagf] git-diff-tree -z HEAD | git-diff-helper -z
Tg> 	03c70739ae572ea9832b97dfcf9ca2594702efe8 (from 30e756ea8569bb429b7073b304acd8a960f77e4b)
Tg> 	:100755 100755 f2e04c3b45b2a5ab5cf53228025158902c9de5be b93fd0310e51eea4d48d42c6ad83399cff8ab56egitgit(faui00u) [~/work/git/yagf]

Tg> What I am doing wrong here?

Nothing.  I'm an idiot.

Linus, do you mind if I say with "-z" git-diff-tree should not
do _any_ header thing?


