From: Jason McMullan <jason.mcmullan@timesys.com>
Subject: [PATCH] One Git To Rule Them All
Date: Wed, 1 Jun 2005 01:58:33 -0400
Message-ID: <20050601055833.GA14231@port.evillabs.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Jun 01 07:56:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdMCl-0001Kg-25
	for gcvg-git@gmane.org; Wed, 01 Jun 2005 07:55:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261277AbVFAF6k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Jun 2005 01:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbVFAF6k
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jun 2005 01:58:40 -0400
Received: from c-67-163-246-116.hsd1.pa.comcast.net ([67.163.246.116]:9416
	"EHLO port.evillabs.net") by vger.kernel.org with ESMTP
	id S261277AbVFAF6h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2005 01:58:37 -0400
Received: by port.evillabs.net (Postfix, from userid 500)
	id 144434001; Wed,  1 Jun 2005 01:58:34 -0400 (EDT)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The following three patches (two prep and one 'real') fold all the
git-* commands into one 'git' command. This is useful for:

	* Setting up git on a new machine - just one file to send
	* Porcelain that customizes git (ie cogito) can have a
	  'cg-git' instead of trouncing on the default Plumbing git.
	* Quick-ref help on all the Plumbing commands for free!
	* git-<mumble> symlinks to git work as expected
	* Documentation is now enforced for building
          (bug? feature? you decide)

$ git help
GIT Commands:

	local-pull              Duplicates another GIT repository on a local system
	http-pull               Downloads a remote GIT repository via HTTP
	rpull                   Pulls from a remote repository over ssh connection
	rpush                   Helper "server-side" program used by git-rpull
	rev-tree                Provides the revision tree for one or more commits
	rev-list                Lists commit objects in reverse chronological order
	export                  Exports each commit and a diff against each of its parents
	read-tree               Reads tree information into the directory cache
	checkout-cache          Copy files from the cache to the working directory
	update-cache            Modifies the index or directory cache
	ls-tree                 Lists the contents of a tree object.
	ls-files                Information about files in the cache/working directory
	cat-file                Provide content or type information for repository objects
	unpack-file             Creates a temporary file with a blob's contents
	diff-files              Compares files in the working tree and the cache
	diff-cache              Compares content and mode of blobs between the cache and repository
	diff-tree               Compares the content and mode of blobs found via two tree objects
	merge-base              Finds as good a common ancestor as possible for a merge
	merge-cache             Runs a merge for files needing merging
	apply                   Apply a patch against the current index cache/working directory
	check-files             Verify a list of files are up-to-date
	write-tree              Creates a tree from the current cache
	commit-tree             Creates a new commit object
	mktag                   Creates a tag object
	init-db                 Creates an empty git object database
	fsck-cache              Verifies the connectivity and validity of the objects in the database
	convert-cache           Converts old-style GIT repository
	mkdelta                 Creates a delta object
	tar-tree                Creates a tar archive of the files in the named tree
	get-tar-commit-id       Show the commit ID embedded in a git-tar-tree file.
	write-blob              Creates a blob from a file
	diff-helper             Generates patch format output for git-diff-*
	stripspace              Strip space from stdin


-- 
Jason McMullan, Embedded Systems Engineer
412.481.5021 tel, 412.656.3519 cell, 208.694.9206 fax
jason@evillabs.net
