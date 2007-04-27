From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git (stable)
Date: Fri, 27 Apr 2007 01:34:53 -0700
Message-ID: <1177662893872-git-send-email-junkio@cox.net>
References: <7v7is3inbw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 27 10:35:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhLvD-0007UC-S8
	for gcvg-git@gmane.org; Fri, 27 Apr 2007 10:35:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755475AbXD0Ie5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 27 Apr 2007 04:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755478AbXD0Ie4
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Apr 2007 04:34:56 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:61284 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755475AbXD0Iey (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2007 04:34:54 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070427083454.OSIJ1235.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>
          for <git@vger.kernel.org>; Fri, 27 Apr 2007 04:34:54 -0400
Received: from localhost.localdomain ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id s8at1W00G1kojtg0000000; Fri, 27 Apr 2007 04:34:54 -0400
X-Mailer: git-send-email 1.5.2.rc0.758.g0818
X-maint-at: 71e2e5993b6f2afdfda0cc92e0d55e84c9f876b0
X-master-at: 4342572600f446b9f8db553df03d458229f944dd
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45702>

We've accumulated quite a bit of fixes on 'maint', so I need to
do a 1.5.1.3 release soonish, as we will go into feature freeze
on 'master' shortly in preparation for 1.5.2.

On the 'master' front, things have been stabilizing.  Modulo
documentation updates and bugfixes, I expect what we have here
tonight will be pretty much what the final 1.5.2 would look
like.  I already know Shawn has plans to feed git-gui 0.6.6
updates, which should also be included in the final one.

But I might have missed or dismissed patches we have seen and
reviewed on the list recently that deserve to be in 1.5.2, so
please raise hand if you see something missing.  After that,
I'll tag v1.5.2-rc1 and from there we will do the usual "no new
features, options, commands -- only fixes", which hopefully will
happen on Monday.

----------------------------------------------------------------

* The 'maint' branch has these fixes since the last announcement.

 Adam Roben (3):
  Remove usernames from all commit messages, not just when using svmpro=
ps
  git-svn: Don't rely on $_ after making a function call
  git-svn: Ignore usernames in URLs in find_by_url

 Alex Riesen (1):
  Fix handle leak in write_tree

 Andrew Ruder (8):
  Removing -n option from git-diff-files documentation
  Document additional options for git-fetch
  Update git-fmt-merge documentation
  Update git-grep documentation
  Update -L documentation for git-blame/git-annotate
  Update git-http-push documentation
  Update git-local-fetch documentation
  Update git-http-fetch documentation

 Brian Gernhardt (2):
  Reverse the order of -b and --track in the man page.
  Ignore all man sections as they are generated files.

 Gerrit Pape (1):
  Documentation/git-reset.txt: suggest git commit --amend in example.

 Johannes Schindelin (1):
  dir.c(common_prefix): Fix two bugs

 Josh Triplett (2):
  Fix typo in git-am: s/Was is/Was it/
  Create a sysconfdir variable, and use it for ETC_GITCONFIG

 Junio C Hamano (3):
  Build RPM with ETC_GITCONFIG=3D/etc/gitconfig
  applymbox & quiltimport: typofix.
  Start preparing for 1.5.1.3

 Robin H. Johnson (10):
  Document --dry-run parameter to send-email.
  Prefix Dry- to the message status to denote dry-runs.
  Debugging cleanup improvements
  Change the scope of the $cc variable as it is not needed outside of s=
end_message.
  Perform correct quoting of recipient names.
  Validate @recipients before using it for sendmail and Net::SMTP.
  Ensure clean addresses are always used with Net::SMTP
  Allow users to optionally specify their envelope sender.
  Document --dry-run and envelope-sender for git-send-email.
  Sanitize @to recipients.

 Shawn O. Pearce (1):
  Actually handle some-low memory conditions


* The 'master' branch has these since the last announcement
  in addition to the above.

 Alex Riesen (3):
  Avoid excessive rewrites in merge-recursive
  Add a test for merging changed and rename-changed branches
  Ignore merged status of the file-level merge

 Andy Parkins (3):
  post-receive-email example hook: fastforward should have been fast_fo=
rward
  post-receive-email example hook: detect rewind-only updates and outpu=
t sensible message
  post-receive-email example hook: sed command for getting description =
was wrong

 Johannes Schindelin (1):
  t4201: Do not display weird characters on the terminal

 Josh Triplett (1):
  Add clean.requireForce option, and add -f option to git-clean to over=
ride it

 Junio C Hamano (9):
  Move index-related variables into a structure.
  Make read-cache.c "the_index" free.
  Document "diff=3Ddriver" attribute
  t5302: avoid using tail -c
  t6030: grab commit object name as we go
  Diff between two blobs should take mode changes into account now.
  t/test-lib.sh: Protect ourselves from common misconfiguration
  gitattributes documentation: clarify overriding
  Add --date=3D{local,relative,default}

 Luiz Fernando N. Capitulino (5):
  remove_subtree(): Use strerror() when possible
  entry.c: Use const qualifier for 'struct checkout' parameters
  read_cache_from(): small simplification
  core-tutorial: minor fixes
  init_buffer(): Kill buf pointer

 Martin Koegler (5):
  Add S_IFINVALID mode
  add get_sha1_with_mode
  add add_object_array_with_mode
  store mode in rev_list, if <tree>:<filename> syntax is used
  use mode of the tree in git-diff, if <tree>:<file> syntax is used

 Nicolas Pitre (1):
  add file checkout progress

 OGAWA Hirofumi (1):
  git-fetch: Fix "argument list too long"

 Sami Farin (1):
  fast-import: size_t vs ssize_t

 Shawn O. Pearce (1):
  Don't repack existing objects in fast-import

 Uwe Kleine-K=C3=B6nig (1):
  fix importing of subversion tars
