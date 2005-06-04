From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: git-rev-list: proper lazy reachability
Date: Sat, 4 Jun 2005 17:09:35 +0200
Message-ID: <20050604150935.GB5120@cip.informatik.uni-erlangen.de>
References: <Pine.LNX.4.58.0505301847120.1876@ppc970.osdl.org> <17052.21846.816147.370354@cargo.ozlabs.ibm.com> <Pine.LNX.4.58.0505310735260.1876@ppc970.osdl.org> <Pine.LNX.4.58.0505310813540.1876@ppc970.osdl.org> <7vekbigo8q.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 04 17:07:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DeaEL-0008Uq-7v
	for gcvg-git@gmane.org; Sat, 04 Jun 2005 17:06:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261379AbVFDPJv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Jun 2005 11:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261380AbVFDPJv
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Jun 2005 11:09:51 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:18143 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261379AbVFDPJs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Jun 2005 11:09:48 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j54F9cS8006173
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 4 Jun 2005 15:09:38 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j54F9chJ006170;
	Sat, 4 Jun 2005 17:09:38 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vekbigo8q.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello Junio,
I pull the REMOTE_HEAD including objects but don't merge. After that I
run:

system("git-rev-tree HEAD REMOTE_HEAD | sed -e 's/^[0-9]* //' | git-diff-tree --stdin -v ");

for bitkeeper I used the merge base approach (but at that time I only
knew that this gives me any deltas in the current tree not in the remote
tree, but didn't know how it worked).

bkparentdiff is aliased to `bk rset -hr`bk repogca`,+ | grep -v ^BitKeeper | bk gnupatch -du -e -h -T'

	Thomas
