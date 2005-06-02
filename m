From: =?utf-8?q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: Origin handling
Date: Thu, 02 Jun 2005 08:12:00 +0200
Message-ID: <877jhdthhr.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Jun 02 08:09:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ddit4-0005yc-Ug
	for gcvg-git@gmane.org; Thu, 02 Jun 2005 08:09:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261578AbVFBGL6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Jun 2005 02:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261586AbVFBGL6
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jun 2005 02:11:58 -0400
Received: from ifae-s0.ifae.es ([192.101.162.68]:2993 "EHLO ifae-s0.ifae.es")
	by vger.kernel.org with ESMTP id S261578AbVFBGL5 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Jun 2005 02:11:57 -0400
Received: from bela (ifae-s1.ifae.es [192.101.162.148])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id j526BtZ12784
	for <git@vger.kernel.org>; Thu, 2 Jun 2005 08:11:56 +0200
To: Git Mailing List <git@vger.kernel.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


I propose that the origin of a branch comes from a file in
.git/branches/ of the same name. So the origin of default branch
master is the content of the file .git/branches/master that in
the current practice would be "origin". But we could have the
remote branch "git", being the origin of the local branch
"git_dirs" (the content of .git/branches/git_dirs = "git").

What do you think?

     Santi

