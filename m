From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: [PATCH] Pickaxe fixes.
Date: Sat, 28 May 2005 12:59:14 +0200
Message-ID: <20050528105914.GA8467@cip.informatik.uni-erlangen.de>
References: <7vzmufwu8w.fsf@assigned-by-dhcp.cox.net> <7v7jhjy8uw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 28 12:58:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dbz0g-00067J-Oh
	for gcvg-git@gmane.org; Sat, 28 May 2005 12:57:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262696AbVE1K7W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 May 2005 06:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262697AbVE1K7W
	(ORCPT <rfc822;git-outgoing>); Sat, 28 May 2005 06:59:22 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:36771 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S262696AbVE1K7U (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 May 2005 06:59:20 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j4SAxES8028712
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 28 May 2005 10:59:14 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j4SAxErR028711;
	Sat, 28 May 2005 12:59:14 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vzmufwu8w.fsf@assigned-by-dhcp.cox.net> <7v7jhjy8uw.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,

> Also updates the documentation to describe the --pickaxe-all option.
> A typical orderfile for git project would probably look like this ...

I can't believe it. I began to support pickaxe this morning in my little
git frontend and thought about exactly these two questions (patch
ordering and show me all deltas in the matched changeset). Thanks for
the patches! Btw. When doing the.  'git-whatchanged drivers/ide' thing
... does that show only deltas which happened actually in this tree or
if a changeset contains deltas inside and outside?

	Thomas
