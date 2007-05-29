From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git (stable)
Date: Tue, 29 May 2007 03:12:44 -0700
Message-ID: <7vejl0546b.fsf@assigned-by-dhcp.cox.net>
References: <7v4pmgqrut.fsf@assigned-by-dhcp.cox.net>
	<7vhcqccnbm.fsf@assigned-by-dhcp.cox.net>
	<7vveepz8pr.fsf@assigned-by-dhcp.cox.net>
	<7vmyzv1acz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 29 12:13:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsyhE-0004Aq-Gi
	for gcvg-git@gmane.org; Tue, 29 May 2007 12:12:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754126AbXE2KMv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 29 May 2007 06:12:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754407AbXE2KMv
	(ORCPT <rfc822;git-outgoing>); Tue, 29 May 2007 06:12:51 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:65387 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754126AbXE2KMt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 May 2007 06:12:49 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070529101249.GWBI2758.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Tue, 29 May 2007 06:12:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 4yCo1X00C1kojtg0000000; Tue, 29 May 2007 06:12:49 -0400
X-maint-at: a192a909c0cdb8ea09b6513c4839fd6762989cb1
X-master-at: 322bcd9a9a2c0081c66414bde64e0d443c9ec922
In-Reply-To: <7vmyzv1acz.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 23 May 2007 14:46:52 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48679>

Time for 1.5.2.1 perhaps.

The second batch of random changes are in 'master' now.  This is
a rather large-ish looking one.  Handle it with care.

----------------------------------------------------------------

* The 'maint' branch has these fixes since the last announcement.

 Andy Parkins (2):
  Fix mishandling of $Id$ expanded in the repository copy in convert.c
  Add test case for $Id$ expanded in the repository

 Carlos Rica (1):
  fix memory leak in parse_object when check_sha1_signature fails

 Eric Wong (1):
  git-svn: avoid md5 calculation entirely if SVN doesn't provide one

 Frank Lichtenheld (3):
  cvsserver: Correct inetd.conf example in asciidoc documentation
  cvsserver: Note that CVS_SERVER can also be specified as method varia=
ble
  cvsserver: Fix some typos in asciidoc documentation

 Jakub Narebski (3):
  Documentation: Clean up links in GIT Glossary
  Replace the last 'dircache's by 'index'
  Documentation: Add definition of "evil merge" to GIT Glossary

 James Bowes (1):
  Documentation: fix git-config.xml generation

 James Y Knight (1):
  Fix git-svn to handle svn not reporting the md5sum of a file, and tes=
t.

 Jeff King (2):
  git-am: use printf instead of echo on user-supplied strings
  More echo "$user_message" fixes.

 Johan Herland (1):
  Fix stupid typo in lookup_tag()

 Jonas Fonseca (1):
  Update bash completion to ignore some more plumbing commands

 Junio C Hamano (3):
  name-rev: tolerate clock skew in committer dates
  git-commit: use printf '%s\n' instead of echo on user-supplied string=
s
  Add tests for the last two fixes.

 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (1):
  Makefile: Remove git-fsck and git-verify-pack from PROGRAMS

 Shawn O. Pearce (12):
  git-gui: Tighten internal pattern match for lib/ directory
  Refactor fast-import branch creation from existing commit
  Fix possible coredump with fast-import --import-marks
  Hide the plumbing diff-{files,index,tree} from bash completion
  Teach bash completion about git-shortlog
  Remove a duplicate --not option in bash completion
  Update bash completion header documentation
  Teach bash completion about 'git remote update'
  Teach bash completion about recent log long options
  Update bash completion for git-config options
  Correct key bindings to Control-<foo>
  git-gui: Guess our share/git-gui/lib path at runtime if possible

 Simon Hausmann (2):
  fast-import: Fix uninitialized variable
  fast-import: Fix crash when referencing already existing objects

 Steffen Prohaska (1):
  user-manual: fixed typo in example


* The 'master' branch has these since the last announcement
  in addition to the above.

 Alex Riesen (6):
  Add run_command_v_opt_cd: chdir into a directory before exec
  Add ability to specify environment extension to run_command
  Allow environment variables to be unset in the processes started by r=
un_command
  Verbose connect messages to show the IP addresses used
  Add another verbosity level to git-fetch
  Add a configuration option to control diffstat after merge

 Dana L. How (7):
  Alter sha1close() 3rd argument to request flush only
  git-repack --max-pack-size: new file statics and code restructuring
  git-repack --max-pack-size: write_{object,one}() respect pack limit
  git-repack --max-pack-size: split packs as asked by write_{object,one=
}()
  git-repack --max-pack-size: add option parsing to enable feature
  pack-objects: clarification & option checks for --max-pack-size
  Ensure git-repack -a -d --max-pack-size=3DN deletes correct packs

 Daniel Barkalow (5):
  Move remote parsing into a library file out of builtin-push.
  Move refspec parser from connect.c and cache.h to remote.{c,h}
  Add handlers for fetch-side configuration of remotes.
  Update local tracking refs when pushing
  Move refspec pattern matching to match_refs().

 Fernando J. Pereda (1):
  Teach mailsplit about Maildir's

 Frank Lichtenheld (5):
  t9400: Add test cases for config file handling
  t9400: Add some more cvs update tests
  t9400: Add some basic pserver tests
  t9400: Work around CVS' deficiencies
  cvsserver: Handle 'cvs login'

 Junio C Hamano (4):
  pack-objects: pass fullname down to add_object_entry()
  Teach "delta" attribute to pack-objects.
  builtin-pack-objects: remove unnecessary code for no-delta
  mailsplit: fix for more than one input files

 Linus Torvalds (2):
  Make "git gc" pack all refs by default
  Make the pack-refs interfaces usable from outside

 Mark Levedahl (1):
  gitweb.perl - Optionally send archives as .zip files

 Nicolas Pitre (3):
  fixes to output of git-verify-pack -v
  improve delta long block matching with big files
  update diff-delta.c copyright

 Robin Rosenberg (1):
  Add option to cvs update before export

 Shawn O. Pearce (1):
  Allow contrib new-workdir to link into bare repositories
