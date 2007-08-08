From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] cmd-list.perl: Alphabetize command list
Date: Wed, 08 Aug 2007 13:44:44 -0700
Message-ID: <7v8x8l3geb.fsf@assigned-by-dhcp.cox.net>
References: <588192970708081230y76520dak857261e96eae317a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git mailing list" <git@vger.kernel.org>
To: "Steve Hoelzer" <shoelzer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 08 22:44:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIsOi-0008Ey-Ap
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 22:44:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757728AbXHHUoq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Aug 2007 16:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757694AbXHHUoq
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 16:44:46 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:44272 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755165AbXHHUop (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2007 16:44:45 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070808204445.HIIQ2095.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Wed, 8 Aug 2007 16:44:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id ZYkk1X00U1kojtg0000000; Wed, 08 Aug 2007 16:44:45 -0400
In-Reply-To: <588192970708081230y76520dak857261e96eae317a@mail.gmail.com>
	(Steve Hoelzer's message of "Wed, 8 Aug 2007 14:30:44 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55360>

I'll commit this instead.  It does not match your patch, but I
think this is more logical.

-- >8 --
Reorder the list of commands in the manual.

The basic idea was proposed by Steve Hoelzer; in order to make
the list easier to search, we keep the command list in the
script that generates it with "sort -d".

Signed-off-by: Junio C Hamano <gitster@pobox.com>

diff --git a/Documentation/cmd-list.perl b/Documentation/cmd-list.perl
index 2143995..4ee76ea 100755
--- a/Documentation/cmd-list.perl
+++ b/Documentation/cmd-list.perl
@@ -68,6 +68,8 @@ for my $cat (qw(ancillaryinterrogators
 	}
 }
 
+# The following list is sorted with "sort -d" to make it easier
+# to find entry in the resulting git.html manual page.
 __DATA__
 git-add                                 mainporcelain
 git-am                                  mainporcelain
@@ -80,9 +82,9 @@ git-blame                               ancillaryinterrogators
 git-branch                              mainporcelain
 git-bundle                              mainporcelain
 git-cat-file                            plumbinginterrogators
-git-checkout-index                      plumbingmanipulators
-git-checkout                            mainporcelain
 git-check-attr                          purehelpers
+git-checkout                            mainporcelain
+git-checkout-index                      plumbingmanipulators
 git-check-ref-format                    purehelpers
 git-cherry                              ancillaryinterrogators
 git-cherry-pick                         mainporcelain
@@ -91,6 +93,7 @@ git-clean                               mainporcelain
 git-clone                               mainporcelain
 git-commit                              mainporcelain
 git-commit-tree                         plumbingmanipulators
+git-config                              ancillarymanipulators
 git-convert-objects                     ancillarymanipulators
 git-count-objects                       ancillaryinterrogators
 git-cvsexportcommit                     foreignscminterface
@@ -98,9 +101,9 @@ git-cvsimport                           foreignscminterface
 git-cvsserver                           foreignscminterface
 git-daemon                              synchingrepositories
 git-describe                            mainporcelain
+git-diff                                mainporcelain
 git-diff-files                          plumbinginterrogators
 git-diff-index                          plumbinginterrogators
-git-diff                                mainporcelain
 git-diff-tree                           plumbinginterrogators
 git-fast-import				ancillarymanipulators
 git-fetch                               mainporcelain
@@ -130,13 +133,13 @@ git-ls-remote                           plumbinginterrogators
 git-ls-tree                             plumbinginterrogators
 git-mailinfo                            purehelpers
 git-mailsplit                           purehelpers
+git-merge                               mainporcelain
 git-merge-base                          plumbinginterrogators
 git-merge-file                          plumbingmanipulators
 git-merge-index                         plumbingmanipulators
-git-merge                               mainporcelain
 git-merge-one-file                      purehelpers
-git-merge-tree                          ancillaryinterrogators
 git-mergetool                           ancillarymanipulators
+git-merge-tree                          ancillaryinterrogators
 git-mktag                               plumbingmanipulators
 git-mktree                              plumbingmanipulators
 git-mv                                  mainporcelain
@@ -157,9 +160,8 @@ git-rebase                              mainporcelain
 git-receive-pack                        synchelpers
 git-reflog                              ancillarymanipulators
 git-relink                              ancillarymanipulators
-git-repack                              ancillarymanipulators
-git-config                              ancillarymanipulators
 git-remote                              ancillarymanipulators
+git-repack                              ancillarymanipulators
 git-request-pull                        foreignscminterface
 git-rerere                              ancillaryinterrogators
 git-reset                               mainporcelain
