From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: [PATCH 0/3] Make the output of 'git' nicer
Date: Thu, 9 Mar 2006 17:17:22 +0100
Message-ID: <20060309161722.GA4484@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net
X-From: git-owner@vger.kernel.org Thu Mar 09 17:18:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHNpX-0004Lw-HW
	for gcvg-git@gmane.org; Thu, 09 Mar 2006 17:17:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239AbWCIQRc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Mar 2006 11:17:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932282AbWCIQRc
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Mar 2006 11:17:32 -0500
Received: from 85.8.31.11.se.wasadata.net ([85.8.31.11]:9604 "EHLO
	mail6.wasadata.com") by vger.kernel.org with ESMTP id S932239AbWCIQRb
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 9 Mar 2006 11:17:31 -0500
Received: from c165 (85.8.2.189.se.wasadata.net [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 9E1BD40FF; Thu,  9 Mar 2006 17:32:57 +0100 (CET)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1FHNpK-000624-00; Thu, 09 Mar 2006 17:17:22 +0100
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17420>

Hi,

This series makes the output of 'git' easier to read (IMHO). With this
patch the output will look like this:


Usage: git [--version] [--exec-path[=GIT_EXEC_PATH]] [--help] COMMAND [ ARGS ]

The most commonly used git commands are:
    add            Add files to the index file
    apply          Apply patch on a git index file and a work tree
    bisect         Find the change that introduced a bug
    branch         Create a new branch, or remove an old one
    checkout       Checkout and switch to a branch
    cherry-pick    Apply the change introduced by an existing commit
    clone          Clones a repository
    commit         Record your changes
    diff           Show changes between commits, commit and working tree, etc
    fetch          Download objects and a head from another repository
    grep           Print lines matching a pattern
    init-db        Creates an empty git repository
    log            Show commit logs
    merge          Grand Unified Merge Driver
    mv             Move or rename a file, directory or symlink
    prune          Prunes all unreachable objects from the object database
    pull           Pull and merge from another repository
    push           Update remote refs along with associated objects
    rebase         Rebase local commits to new upstream head
    reset          Reset current HEAD to the specified state
    revert         Revert an existing commit
    rm             Remove files from the working tree and from the index
    show-branch    Show branches and their commits
    status         Show working tree status
    tag            Create a tag object signed with GPG
    verify-tag     Check the GPG signature of tag
    whatchanged    Show logs with difference each commit introduces
(use 'git help -a' to get a list of all installed git commands)

- Fredrik
