From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: cogito "origin" vs. HEAD
Date: Tue, 03 May 2005 13:24:19 +1000
Message-ID: <1115090660.6156.56.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue May 03 05:20:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSnxC-000668-T6
	for gcvg-git@gmane.org; Tue, 03 May 2005 05:20:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261342AbVECD0Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 May 2005 23:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261340AbVECD0Y
	(ORCPT <rfc822;git-outgoing>); Mon, 2 May 2005 23:26:24 -0400
Received: from gate.crashing.org ([63.228.1.57]:58026 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261342AbVECD0W (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 May 2005 23:26:22 -0400
Received: from gaston (localhost [127.0.0.1])
	by gate.crashing.org (8.12.8/8.12.8) with ESMTP id j433KXgJ003813
	for <git@vger.kernel.org>; Mon, 2 May 2005 22:20:34 -0500
To: Git Mailing List <git@vger.kernel.org>
X-Mailer: Evolution 2.2.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi !

So it's my understanding that linus only uses this HEAD that symlinks
to .git/refs/heads/master as his head of tree.

However, when using cogito, it creates another one here called "origin"
that matches the "origin" branch (I don't like "branch" here, it's more
like a source of objects than a branch...) locally. Is this actually the
content of the remote's HEAD or is git also looking for a remote
"refs/heads/origin" ?

So when I later do cg-pull or cg-update origin to update, my "origin"
pointer is updated I suppose to the new head of the remote repository,
does it also update my local "refs/heads/master" ? Or not ? What happens
to it ? does anything will use my local HEAD -> refs/heads/master/
ever ? If I want to publish my tree, what will remote cogito's try to
rsync down ? HEAD ? origin ?

Ben.


