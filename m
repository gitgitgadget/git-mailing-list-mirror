From: Jan Nieuwenhuizen <janneke@gnu.org>
Subject: Re: MinGW binary installer available
Date: Thu, 08 Feb 2007 20:58:28 +0100
Organization: lilypond-design.com
Message-ID: <87abzoh15n.fsf@peder.flower>
References: <45C9E470.7030609@xs4all.nl>
	<Pine.LNX.4.63.0702071552470.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<45CA4E68.6070308@xs4all.nl>
	<Pine.LNX.4.63.0702080051420.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Han-Wen Nienhuys <hanwen@xs4all.nl>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 08 21:05:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFFWD-00089R-Lp
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 21:05:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423297AbXBHUFH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 15:05:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423300AbXBHUFG
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 15:05:06 -0500
Received: from smtp-vbr3.xs4all.nl ([194.109.24.23]:2263 "EHLO
	smtp-vbr3.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423297AbXBHUFE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 15:05:04 -0500
X-Greylist: delayed 374 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 Feb 2007 15:05:04 EST
Received: from peder.flower (peder.xs4all.nl [82.93.198.126])
	by smtp-vbr3.xs4all.nl (8.13.8/8.13.8) with ESMTP id l18JwkvT080409;
	Thu, 8 Feb 2007 20:58:47 +0100 (CET)
	(envelope-from janneke@gnu.org)
Received: by peder.flower (Postfix, from userid 1000)
	id 8F0D1177407A; Thu,  8 Feb 2007 20:58:28 +0100 (CET)
In-Reply-To: <Pine.LNX.4.63.0702080051420.22628@wbgn013.biozentrum.uni-wuerzburg.de> (Johannes Schindelin's message of "Thu\, 8 Feb 2007 00\:52\:28 +0100 \(CET\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.90 (gnu/linux)
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39083>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>  http://lilypond.org/git/binaries/mingw/git-1.4.9993-2.mingw.exe

Yes, much better.  There's still the bash script problem, maybe
these should be replaced with python?

$ ./git-1.4.9993-2.mingw.exe /S
20:48:11 root@Abbicci:~
$ PATH=/cygdrive/c/Program\ Files/Git/usr/bin/:$PATH
20:48:46 root@Abbicci:~
$ which git
/cygdrive/c/Program Files/Git/usr/bin/git
20:48:49 root@Abbicci:~
$ mkdir -p vc/test.git
20:49:03 root@Abbicci:~
$ cd vc/test.git/
20:49:05 root@Abbicci:~/vc/test.git
$ git init 
Initialized empty Git repository in .git/
warning: templates not found /usr/share/git-core/templates/
20:52:31 root@Abbicci:~/vc/test.git
$ git status
git: 'status' is not a git-command

The most commonly used git commands are:
    add            Add file contents to the changeset to be committed next
    apply          Apply a patch on a git index file and a working tree
    archive        Creates an archive of files from a named tree
    bisect         Find the change that introduced a bug by binary search
    branch         List, create, or delete branches
    checkout       Checkout and switch to a branch
    cherry-pick    Apply the change introduced by an existing commit
    clone          Clones a repository into a new directory
    commit         Record changes to the repository
    diff           Show changes between commits, commit and working tree, etc
    fetch          Download objects and refs from another repository
    grep           Print lines matching a pattern
    init           Create an empty git repository or reinitialize an existing one
    log            Show commit logs
    merge          Join two or more development histories together
    mv             Move or rename a file, a directory, or a symlink
    prune          Prunes all unreachable objects from the object database
    pull           Fetch from and merge with another repository or a local branch
    push           Update remote refs along with associated objects
    rebase         Forward-port local commits to the updated upstream head
    reset          Reset current HEAD to the specified state
    revert         Revert an existing commit
    rm             Remove files from the working tree and from the index
    show           Show various types of objects
    show-branch    Show branches and their commits
    status         Show the working tree status
    tag            Create, list, delete or verify a tag object signed with GPG
(use 'git help -a' to get a list of all installed git commands)
[1]20:52:36 root@Abbicci:~/vc/test.git
$ git-status
# On branch master
#
# Initial commit
#
# Changes to be committed:
#   (use "git rm --cached <file>..." to unstage)
#
#       new file: boo
#
20:53:19 root@Abbicci:~/vc/test.git
$ git-commit -a -m initial

*** Your name cannot be determined from your system services (gecos).

Run

  git config user.email "you@email.com"
  git config user.name "Your Name"

To set the identity in this repository.
Add --global to set your account's default

fatal: empty ident  <> not allowed
[128]20:53:25 root@Abbicci:~/vc/test.git
$ git-config  user.email "you@email.com"
20:54:06 root@Abbicci:~/vc/test.git
$ git-config user.name "Your Name"
20:54:13 root@Abbicci:~/vc/test.git
$ git-commit -a -m initial
Created initial commit 7278148bc4ddc1c5d6cbb88a874b377f9813ec83
 0 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 boo
20:54:24 root@Abbicci:~/vc/test.git
$ git-show head
commit 7278148bc4ddc1c5d6cbb88a874b377f9813ec83
Author: Your Name <you@email.com>
Date:   Thu Feb 8 20:54:24 2007 +0100

    initial

diff --git a/boo b/boo
new file mode 100644
index 0000000..e69de29
20:54:28 root@Abbicci:~/vc/test.git

-- 
Jan Nieuwenhuizen <janneke@gnu.org> | GNU LilyPond - The music typesetter
http://www.xs4all.nl/~jantien       | http://www.lilypond.org
