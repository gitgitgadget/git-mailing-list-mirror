From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [ANNOUNCE] Stacked GIT 0.9
Date: Fri, 07 Apr 2006 23:05:57 +0100
Message-ID: <4436E245.7010503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sat Apr 08 00:06:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FRz5i-0000n5-FL
	for gcvg-git@gmane.org; Sat, 08 Apr 2006 00:06:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964983AbWDGWGD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 7 Apr 2006 18:06:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964989AbWDGWGD
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Apr 2006 18:06:03 -0400
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:31771 "EHLO
	mtaout02-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S964983AbWDGWGB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Apr 2006 18:06:01 -0400
Received: from aamtaout03-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout02-winn.ispmail.ntl.com with ESMTP
          id <20060407220559.TABW29040.mtaout02-winn.ispmail.ntl.com@aamtaout03-winn.ispmail.ntl.com>;
          Fri, 7 Apr 2006 23:05:59 +0100
Received: from [192.168.1.100] (really [81.101.128.125])
          by aamtaout03-winn.ispmail.ntl.com with ESMTP
          id <20060407220559.RNYL16286.aamtaout03-winn.ispmail.ntl.com@[192.168.1.100]>;
          Fri, 7 Apr 2006 23:05:59 +0100
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
To: git <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18507>

Stacked GIT 0.9 release is available from http://www.procode.org/stgit/

StGIT is a Python application providing similar functionality to Quilt
(i.e. pushing/popping patches to/from a stack) on top of GIT. These
operations are performed using GIT commands and the patches are stored
as GIT commit objects, allowing easy merging of the StGIT patches into
other repositories using standard GIT functionality.

The main features in this release:

  # Faster three-way merge by using 'git-read-tree --aggressive' and
    dealing with conflicts internally (gitmergeonefile.py removed)
  # StGIT repositories are now 'git prune'-safe
  # 'show' command for displaying a given patch
  # 'uncommit' command for reversing the effects of 'commit'
  # '--series' option added to the 'import' command
  # '--merged' option added to the 'push' and 'pull' commands to check
    for patches merged upstream
  # '--undo' option added to 'refresh'
  # Patch refreshing can be done for individual files only
  # '--stdout' option added to 'export'
  # '--mbox' option added to 'mail'
  # 'smtpdelay' configuration option for delays between messages sendin=
g
  # $PAGER or the 'pager' configuration option used for the 'show' and
    'diff' commands
  # '--force' option removed from the 'new' command
  # Bug fixes

Acknowledgements (generated with 'git shortlog'):

Catalin Marinas:
      Fix the clone command failure
      Fix the 'status --reset' for individual files
      Remove the --force option for new
      Allow patch refreshing for some files only
      Use the GIT-specific environment as default
      Check whether the file exists in the fold command
      Add prune-safety to StGIT
      Allow tag objects to be passed on the command line
      Add --stdout option to export
      Add --mbox option to the 'mail' command
      Fix the e-mail address escaping
      Fix the reset command to set HEAD to a proper id
      Allow stg to be loaded in pydb and not run main()
      Print a shorter usage message with the --help option
      Add a merged upstream test for pull and push
      Add --series to import
      Cache the base_dir value for subsequent calls
      Pass the --aggressive flag to git-read-tree
      gitmergeonefile.py should use git.get_base_dir()
      Deal with merge conflicts directly
      Add the --patch option to export
      Add the --strip option to import
      Fix the patch name stripping in import
      Update the TODO file
      The gitmergeonefile config section is deprecated
      Add the "smtpdelay" config option
      Create stgit/basedir.py for determining the .git directory
      Remove the checking for the default configuration values
      Add extra headers to the e-mail messages
      Add the '--undo' option to 'refresh'
      Add a 'show' command
      Remove the basedir exception throwing
      Use a pager for diff and show commands
      Use 'git-*' instead of 'git *'
      Release 0.9

Chuck Lever:
      "stg pull" says "popping all patches" even when it doesn't
      Use a separate directory for patches under each branch subdir
      Add an option to "stg branch" to convert the internal format

Karl Hasselstr=F6m:
      [PATCH 2/2] Add 'stg uncommit' command
      Use --refid option even when sending a cover mail
      Change the signature start string to "-- \n"
      Update .git/refs/heads/base after patch deletion

Kirill Smelkov:
      [trivial]  fix spelling typos

Paolo 'Blaisorblade' Giarrusso:
      Stgit - gitmergeonefile.py: handle removal vs. changes
      Pass --directory to git-ls-files for stg status

Pavel Roskin:
      stgit: typo fixes
      Make tutorial a valid asciidoc article.
      stg export: check if there are any patches to export
      Treat "stg --help cmd" and "stg help cmd" like "stg cmd
      Improve "stg uncommit" help text.

Sam Vilain:
      common: parse 'email (name)' correctly

--
Catalin
