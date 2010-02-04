From: Avery Pennarun <apenwarr@gmail.com>
Subject: [Announce] git-subtree v0.3
Date: Thu, 4 Feb 2010 14:55:02 -0500
Message-ID: <32541b131002041155v23a4c8cbje2cafdb1ec28da81@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 04 20:55:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nd7nV-0003W6-V9
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 20:55:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932677Ab0BDTzY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2010 14:55:24 -0500
Received: from mail-yw0-f189.google.com ([209.85.211.189]:35064 "EHLO
	mail-yw0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758429Ab0BDTzX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2010 14:55:23 -0500
Received: by ywh27 with SMTP id 27so2649466ywh.1
        for <git@vger.kernel.org>; Thu, 04 Feb 2010 11:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:content-type;
        bh=q3wEtqErzsuVTw2Ig7jsXGjGwW4G9NDk5NC+EDZ8+x8=;
        b=RopieKwTZz8BYMEXdc5bmQDhjVK5VOU74HMU4aUN1Jyphd+mDGX5aMI7h0VqTpIrd1
         3dfCFKFnr3kN3Ofjq/9vAHxU/ccn4Q7KtrqYNMWeBmFex6EQ0qCBwrPEKHI82hml/dP6
         IlI6ZF38jm7zyh5IalBG+2zJ9TYDtw8aOTVHw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=Lsz1UFfp5aSKVjRX2HiQkssfovDCI4FMsaBITSXvyDD2D5Ubq5ywZtjMPCbPzB1Hro
         PRP90sAkX/IdgO9mzo+YDSTw52Ji5zfhpgQznKWSJYx8TeV22JHXO03SkZJxS5RAIgnV
         0LFZ0OjRM6OksBjMhCSEzjcICK2I/QwpDFpWE=
Received: by 10.150.8.10 with SMTP id 10mr2760587ybh.125.1265313322125; Thu, 
	04 Feb 2010 11:55:22 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138999>

Hi all,

git-subtree is an alternative to git submodules.  It makes it easier
to use git's "subtree" merge strategy, and also provides a "split"
operation to do the opposite (extracting a subtree back into the
parent project) so you can go back and forth.

It's been awhile since I made an actual official release, so I just
tagged v0.3.  You can find it at
http://github.com/apenwarr/git-subtree.

Main changes in this version:

- a new 'git subtree pull' command to complement 'git subtree merge'
- improvements to docs and license notices
- various bugfixes.

Jakub Suder has also written a new tutorial on how to use git-subtree:
http://psionides.jogger.pl/2010/02/04/sharing-code-between-projects-with-git-subtree/

git-subtree appears to be gaining in popularity (it how has 94
followers on github, and people are obviously using it enough to
submit patches).  Thoughts about whether (and how) to submit it for
inclusion into core git are welcome.

Amiel Martin (2):
      fixed order of assertion in tests
      sort assertion to make it more generic

Arlen Cuss (1):
      Fix refspecs in given example for git subtree pull.

Avery Pennarun (13):
      Docs: when pushing to github, the repo path needs to end in .git
      Improve patch to use git --exec-path: add to PATH instead.
      Fix behaviour if you have a branch named the same as your --prefix
      Add a README that says to email me instead of using github mail.
      Merge branch 'master' of git://github.com/voxpelli/git-subtree
      If someone provides a --prefix that ends with slash, strip the slash.
      Fix a minor problem in identifying squashes vs. normal splits.
      cmd_pull didn't support --squash correctly.
      Add some tips for how to install.
      Oops, forgot a COPYING file.  It's GPLv2.
      Weird, I forgot to have 'make test' call test.sh.
      Merge branch 'master' of git://github.com/psionides/git-subtree
      Jakub's changes broke the progress message slightly.

Ben Walton (2):
      add installation support to Makefile
      make git version dynamic when building documentation

Jakub Suder (9):
      added -p alias for --prefix
      added -m/--message option for setting merge commit message
      allow using --branch with existing branches if it makes sense
      fix for subtree split not finding proper base for new commits
      changed alias for --prefix from -p to -P
      fixed bug in commit message for split
      added tests for recent changes
      added temporary test dirs to gitignore
      improved rev_is_descendant_of_branch() function

Pelle Wessman (1):
      Check that the type of the tree really is a tree and not a commit

kTln2 (1):
      Add explicit path of git installation by 'git --exec-path'.


Have fun,

Avery
