From: Zack Brown <zbrown@tumblerings.org>
Subject: questions about cg-update, cg-pull, and cg-clone.
Date: Fri, 29 Apr 2005 17:53:22 -0700
Message-ID: <20050430005322.GA5408@tumblerings.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Apr 30 02:50:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRgBj-0006F4-Bk
	for gcvg-git@gmane.org; Sat, 30 Apr 2005 02:50:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263108AbVD3A4C (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 20:56:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263104AbVD3A4C
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 20:56:02 -0400
Received: from dsl092-000-086.sfo1.dsl.speakeasy.net ([66.92.0.86]:22202 "EHLO
	tumblerings.org") by vger.kernel.org with ESMTP id S263111AbVD3Azl
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2005 20:55:41 -0400
Received: from zbrown by tumblerings.org with local (Exim 4.50)
	id 1DRgEU-0001WG-CO
	for git@vger.kernel.org; Fri, 29 Apr 2005 17:53:22 -0700
To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

I'm trying to figure out the new Cogito syntax. What is the difference between
cg-update and cg-pull? Here is my take so far, please correct me:

'cg-update branch-name' grabs any new changes from the upstream repository and
merges them into my local repository. If I've been editing files in my local
repository, the update attempts to merge the changes cleanly.

Now, if the update is clean, a cg-commit is invoked automatically, and if the
update is not clean, I then have to resolve any conflicts and give the cg-commit
command by hand. But: what is the significance of either of these cg-commit
commands? Why should I have to write a changelog entry recording this merge? All
I'm doing is updating my tree to be current. Why should I have to 'commit' that
update?

Now I look at 'cg-pull'. What does this do? The readme says something about
printing two ids, and being useful for diffs. But can't I do a diff after a
cg-update and get the same result? I'm very confused about cg-pull right now.

Also, the README says that cg-clone and cg-init are identical, except that
cg-clone creates a new directory for the repository. Is that really the only
difference? Why do we have cg-clone then?

Be well,
Zack

-- 
Zack Brown
