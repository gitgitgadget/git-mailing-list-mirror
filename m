From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (stable)
Date: Sun, 06 Jul 2008 03:04:14 -0700
Message-ID: <7vr6a7fhwh.fsf@gitster.siamese.dyndns.org>
References: <7vtzibbjxn.fsf@gitster.siamese.dyndns.org>
 <7vwsn75pmv.fsf@gitster.siamese.dyndns.org>
 <7vy77gapkl.fsf@gitster.siamese.dyndns.org>
 <7vmynqfeab.fsf@gitster.siamese.dyndns.org>
 <7vwsmjj0js.fsf@gitster.siamese.dyndns.org>
 <7vhcdchr80.fsf@gitster.siamese.dyndns.org>
 <7vhcd0jyyp.fsf@gitster.siamese.dyndns.org>
 <7vod6wpjvr.fsf@gitster.siamese.dyndns.org>
 <7vod6nikuw.fsf@gitster.siamese.dyndns.org>
 <7viqws6zaz.fsf@gitster.siamese.dyndns.org>
 <7vfxrhwspw.fsf@gitster.siamese.dyndns.org>
 <7vwsknyz9m.fsf@gitster.siamese.dyndns.org>
 <7vlk0z9k5f.fsf@gitster.siamese.dyndns.org>
 <7vej6oipea.fsf@gitster.siamese.dyndns.org>
 <7vabh93lk6.fsf@gitster.siamese.dyndns.org>
 <7vwsk4g5py.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 06 12:06:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFR7Z-00062R-7z
	for gcvg-git-2@gmane.org; Sun, 06 Jul 2008 12:05:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752969AbYGFKEb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2008 06:04:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753115AbYGFKEb
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jul 2008 06:04:31 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45493 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752969AbYGFKE3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2008 06:04:29 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id EF8731E178;
	Sun,  6 Jul 2008 06:04:27 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id DC8C21E177; Sun,  6 Jul 2008 06:04:25 -0400 (EDT)
X-maint-at: 78e3118685bc2050b4ee9ab754dcd79eb2ed4fb7
X-master-at: 44701c67fd1d5d771b440c8646b7b268d4f1402d
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: EB5D87CC-4B42-11DD-BE5E-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87512>

With accumulated fixes, the latest maintenance release 1.5.6.2 is out.

On the 'master' front, port to MinGW has now been merged, and the next
major release 1.6.0 is already taking shape.

----------------------------------------------------------------
* The 'master' branch has these since the last announcement
  in addition to what is in maint.

Adam Brewster (1):
  Move read_revisions_from_stdin from builtin-rev-list.c to revision.c

Brian Gernhardt (1):
  Documentation: Point to gitcli(7) from git(1)

Brian Hetro (5):
  builtin-log.c: Use 'git_config_string' to get 'format.subjectprefix' and
    'format.suffix'
  convert.c: Use 'git_config_string' to get 'smudge' and 'clean'
  diff.c: Use 'git_config_string' to get 'diff.external'
  http.c: Use 'git_config_string' to clean up SSL config.
  builtin-commit.c: Use 'git_config_string' to get 'commit.template'

Christian Couder (2):
  Fix "config_error_nonbool" used with value instead of key
  Fix "config_error_nonbool" used with value instead of key

Johannes Schindelin (2):
  Windows: always chmod(, 0666) before unlink().
  git fetch-pack: do not complain about "no common commits" in an empty
    repo

Johannes Sixt (35):
  Add compat/regex.[ch] and compat/fnmatch.[ch].
  Compile some programs only conditionally.
  Add target architecture MinGW.
  Windows: Use the Windows style PATH separator ';'.
  setup.c: Prepare for Windows directory separators.
  Windows: Treat Windows style path names.
  Windows: Handle absolute paths in safe_create_leading_directories().
  Windows: Strip ".exe" from the program name.
  Windows: Implement a wrapper of the open() function.
  Windows: A minimal implemention of getpwuid().
  Windows: Work around misbehaved rename().
  Make my_mktime() public and rename it to tm_to_time_t()
  Windows: Implement gettimeofday().
  Windows: Fix PRIuMAX definition.
  Windows: Implement setitimer() and sigaction().
  Windows: Wrap execve so that shell scripts can be invoked.
  Windows: A pipe() replacement whose ends are not inherited to children.
  Windows: Implement start_command().
  Windows: A rudimentary poll() emulation.
  Windows: Disambiguate DOS style paths from SSH URLs.
  Windows: Implement asynchronous functions as threads.
  Windows: Work around incompatible sort and find.
  Windows: Implement wrappers for gethostbyname(), socket(), and connect().
  Windows: Implement a custom spawnve().
  Windows: Add a custom implementation for utime().
  Windows: Use a customized struct stat that also has the st_blocks member.
  Turn builtin_exec_path into a function.
  Windows: Compute the fallback for exec_path from the program invocation.
  Windows: Use a relative default template_dir and ETC_GITCONFIG
  When installing, be prepared that template_dir may be relative.
  Windows: Make the pager work.
  Windows: Work around an oddity when a pipe with no reader is written to.
  Windows: Make 'git help -a' work.
  Windows: TMP and TEMP environment variables specify a temporary
    directory.
  t4127-apply-same-fn: Avoid sed -i

Jonathan Nieder (15):
  git-format-patch(1): fix stray \ in output
  Documentation: fix gitlinks
  manpages: fix bogus whitespace
  git(1): add comma
  git-commit(1): depersonalize description
  Documentation: rewrap to prepare for "git-" vs "git " change
  Documentation: more "git-" versus "git " changes
  gitdiffcore(7): fix awkward wording
  manpages: italicize command names in synopses
  manpages: italicize command names
  manpages: italicize git command names (which were in teletype font)
  manpages: italicize gitk's name (where it was in teletype font)
  manpages: italicize nongit command names (if they are in teletype font)
  manpages: italicize git subcommand names (which were in teletype font)
  manpages: use teletype font for sample command lines

Junio C Hamano (3):
  fast-export --export-marks: fix off by one error
  attribute documentation: keep EXAMPLE at end
  clone -q: honor "quiet" option over native transports.

Marius Storm-Olsen (1):
  Windows: Add a new lstat and fstat implementation based on Win32 API.

Matthew Ogilvie (1):
  Documentation cvs: Clarify when a bare repository is needed

Miklos Vajna (6):
  Retire 'stupid' merge strategy
  INSTALL: Update section about git-frotz form.
  hg-to-git: avoid raising a string exception
  hg-to-git: abort if the project directory is not a hg repo
  hg-to-git: rewrite "git-frotz" to "git frotz"
  hg-to-git: use git init instead of git init-db

Nikolaus Schulz (1):
  Documentation: be precise about which date --pretty uses

Ramsay Allan Jones (1):
  Fix some warnings (on cygwin) to allow -Werror

Steffen Prohaska (2):
  Windows: Fix ntohl() related warnings about printf formatting
  compat/pread.c: Add a forward declaration to fix a warning

Thomas Rast (2):
  git-send-email: Do not attempt to STARTTLS more than once
  Fix apply --recount handling of no-EOL line
