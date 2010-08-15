From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC] Questions for "Git User's Survey 2010" - features used, features wanted
Date: Sun, 15 Aug 2010 23:57:28 +0200
Message-ID: <201008152357.29889.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 15 23:57:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OklCX-0000OM-0X
	for gcvg-git-2@lo.gmane.org; Sun, 15 Aug 2010 23:57:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106Ab0HOV4u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Aug 2010 17:56:50 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:59595 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751094Ab0HOV4t (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Aug 2010 17:56:49 -0400
Received: by bwz3 with SMTP id 3so2309963bwz.19
        for <git@vger.kernel.org>; Sun, 15 Aug 2010 14:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=+B1xrE9wJ3x00oWtL36jcTASc3ePJILveC7G6rewWN0=;
        b=qUozLzD84vUPtbAkU96lnGE2Kr5OARxOBDHUEf/fghqadvEgPsHdwn2JSm8XNSEkMJ
         ehTePtkS7a0nwUKGZ7BW4R2NXqYhK7XeWPOBzFNz7XjhYT8eCeL6CvJpWu85lhJ9ea4O
         o0BSoXsfGiVtPaRXU7JpyopdLWlhSKOxj67Kc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        b=PSkZQcF2lrYLrB6qsrpcFzwlwahecG7Lmt1QtPqrgJhG3MuwWJfkZ1dsSsdXVWjh6P
         9aX0gcpDS9h4G2nkm7jXMzTL4W9b9OaxbgfIx2pmA9Ep6ZBkO1hGXhRV1JogFfYo4gex
         bLr73KCzKCp6veBMnpBBl/dWc+KR2ALJHtVK8=
Received: by 10.204.115.203 with SMTP id j11mr2734363bkq.147.1281909407499;
        Sun, 15 Aug 2010 14:56:47 -0700 (PDT)
Received: from [192.168.1.13] (abvw76.neoplus.adsl.tpnet.pl [83.8.220.76])
        by mx.google.com with ESMTPS id y19sm3744012bkw.18.2010.08.15.14.56.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 15 Aug 2010 14:56:46 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153622>

In the upcoming "Git User's Survey 2010" (tentatively planned to start 
on 1 September 2010) there are two questions about Git features: one 
about features one use, and one about features one would like to see in 
Git.

Below there is excerpt of "Git User's Survey 2010" draft with those 
questions.  Do you have any comments (any features to add, or any 
features to remove in proposed answers in multi-choice) about them?

TIA


-----------

15. Which of the following features do you use?

(multiple choice, with other)

 + git bundle (off-line transport)
 + "smart" HTTP support
 + eol conversion (crlf)
 + custom diff/merge driver
 + textconv
 + gitattributes (other than above)
 + submodules (subprojects)
 + subtree merge (optionally git-subtree)
 + partial (sparse) checkout
 + assume-unchanged bit
 + separate worktree / core.worktree
 + multiple worktrees (git-new-worktree)
 + alternates mechanism (sharing object database)
 + stash (optionally "git stash --keep-index")
 + shallow clone (e.g. "git clone --depth=<n>")
 + detaching HEAD (e.g. "git checkout HEAD^0")
 + interactive rebase (small scale history editing)
 + interactive commit / per-hunk comitting / partial commit
 + commit message templates
 + git-filter-branch or equivalent (large history rewriting)
 + bisect (optionally "git bisect run <script>")
 + committing with dirty tree (keeping some changes uncommitted)
 + non-default hooks (from contrib/hooks/ or other)
 + shell completion of commands
 + git-aware shell prompt
 + git aliases, shell aliases for git, or own git scripts
 + one-way interaction with other SCMs (from SCM to git)
 + two-way interaction with other SCMs (git as fat client)
 + git cvsserver
 + git notes

 + Other, please specify


16. Which of the following features would you like to see implemented
    in git?

(multiple choice)

 + better support for big files (large media)
 + resumable clone/fetch (and other remote operations)
 + GitTorrent Protocol, or git-mirror
 + lazy clone / on-demand fetching of object
 + subtree clone
 + support for tracking empty directories
 + environmental variables in config, expanding ~ and ~user
 + better undo/abort/continue, and for more commands
 + '-n' like option for each command, which describes what would happen
 + warn before/when rewriting published history
 + side-by-side diffs and/or color-words diff in gitweb
 + admin and/or write features in gitweb
 + graphical history view in gitweb
 + GUI for rebase in git-gui
 + GUI for creating repository in git-gui
 + graphical diff/merge tool integrated with git-gui
 + syntax highlighting in git-gui
 + filename encoding (in repository vs in filesystem)
 + git push --create
 + localization of command-line messages (i18n)
 + wholesame directory rename detection
 + union checkouts (some files from one branch, some from other)
 + advisory locking / "this file is being edited"
 + "commands issued" (or "command equivalents") in git-gui / gitk
 + built-in gitjour/bananajour support
 + better support for submodules

 + other (describe below)


17. Describe what features would you like to have in Git, 
    if it is not on the list above?

(free form, essay length)

-- 
Jakub Narebski
Poland
