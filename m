From: "Lars Hjemli" <hjemli@gmail.com>
Subject: [ANNOUNCE] cgit 0.8
Date: Sun, 5 Oct 2008 22:10:17 +0200
Message-ID: <8c5c35580810051310u60859afcvf38845244308cd23@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Oct 05 22:12:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmZxi-00050I-EL
	for gcvg-git-2@gmane.org; Sun, 05 Oct 2008 22:12:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754256AbYJEUKU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Oct 2008 16:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754204AbYJEUKU
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Oct 2008 16:10:20 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:2456 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754159AbYJEUKS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Oct 2008 16:10:18 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1237192wah.21
        for <git@vger.kernel.org>; Sun, 05 Oct 2008 13:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=EamQLdzRP6P25EY6vbWTyVWZJ18Myq4BQS9ZsBmzH1U=;
        b=k8YaF+hkpN/f0rp4mdbAOp/Sy5qrsILQZROycYK6QwzIvNjFQv5OOGzukVAd+vXXHK
         ffRcQHqPfoDgbTUaD5jj/iu2r5ZnNJeqrZe6qYAx/j0J2jkguSExQwbWxaCDQc12pLF6
         BL8+/9Kx8AtmCvt3Y/KUsy+Pq1T/rHPBqIsvM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=EzwKnUyf+AT+W5f5vGbBKpa5bxqSBQGxN4qPB2wRhSDrjzR6Sotvis8QhlK8QYoiL6
         AfZykuAXHV00KOXEl9Tsg/RSnASOfngLtlCM9j2ZbkYRVrev/qJWuTaaudhLfNjGoUUd
         AChdiY29pIJY0TSAZai9D5gcLo1krLM7O7s6E=
Received: by 10.115.89.1 with SMTP id r1mr4525666wal.12.1223237417741;
        Sun, 05 Oct 2008 13:10:17 -0700 (PDT)
Received: by 10.114.166.20 with HTTP; Sun, 5 Oct 2008 13:10:17 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97533>

cgit-0.8, another webinterface for git, is now available.

clone:   git://hjemli.net/pub/git/cgit
browse:  http://hjemli.net/git/cgit

Some of the new features since 0.7.2:
* atom feeds for branch and/or path (http://hjemli.net/git/cgit/atom)
* builtin clone/fetch (git clone http://hjemli.net/git/cgit)
* commit messages with 'encoding' attribute gets converted to utf-8
* commit view includes full diff (http://hjemli.net/git/cgit/commit/)
* limited number of entries in cache (no need for manual cleanup)
* new plain blob view (http://hjemli.net/git/cgit/plain/cgitrc.5.txt)
* new plain patch view (http://hjemli.net/git/cgit/patch/)
* searchable, paginated project list
* support for PATH_INFO (no need for url rewriting)


Big thanks to everyone who submitted patches and feedback!

---
Sortlog since v0.7.2

Eric Wong (1):
      use Host: header to generate cgit_hosturl

Harley Laue (3):
      Print an error if filename is not found in html_include.
      Added root-desc to default configuration.
      Add LDFLAGS to makefile.

Hiroki Hattori (1):
      Fix segfault

Jonathan Bastien-Filiatrault (4):
      Add commit->msg_encoding, allocate msg dynamicly.
      Set msg_encoding according to the header.
      Add iconv_msg function.
      Convert subject and message with iconv_msg.

Lars Hjemli (142):
      Use utf8::reencode_string from git
      Show lines changed as -n/+m in shortlogs
      Makefile: link with libiconv if NEEDS_LIBICONV is defined
      Minor css tweaks
      Create initial testsuite
      Fix html error detected by test-suite
      Set commit date on snapshot contents
      Generate valid html for "downloads" menu header
      Add support for "robots" meta-tag
      Gimp my logo
      Use tables for page layout
      Add cell-spacing in html
      Add support for automatic and custom clone urls
      Add plain patch view
      Handle missing default branch and error out on invalid branch names
      Check for NULL-subject in patch view
      Use GIT-1.5.4.rc4
      Use GIT-1.5.4.rc5
      Use GIT-1.5.4
      Use GIT-1.5.4.1
      Introduce struct cgit_context
      Add all config variables into struct cgit_context
      Move cgit_repo into cgit_context
      Improve initialization of git directory
      Add regression-test for description-less repos
      Brown paper bag: don't use `grep -v`
      Make output from `make test` more readable
      t0010-validate.sh: return on cgit errors
      tests/setup.sh: cleanup test script output and logging
      Use GIT-1.5.4.4
      Fix segfault in patch view for root commit
      Introduce html.h
      Use GIT-1.5.5.rc1
      Add struct cgit_page to cgit_context
      Remove obsolete cacheitem parameter to ui-functions
      Add command dispatcher
      Refactor snapshot support
      Add separate header-files for each page/view
      Add ui-shared.h
      Move non-generic functions from shared.c to cgit.c
      Initial Makefile cleanup
      Makefile: autobuild dependency rules
      Move cgit_version from shared.c to cgit.c
      Makefile: copy the QUIET constructs from the Makefile in git.git
      Remove global and obsolete cgit_cmd
      Add cache.h
      Move function for configfile parsing into configfile.[ch]
      Use GIT-1.5.5-rc2
      Move cgit_parse_query() from parsing.c to html.c as
http_parse_querystring()
      Reset ctx.repo to NULL when the config parser is finished
      Don't specify mimetype in ui-blob.c
      Use GIT-1.5.5
      Replace sidebar/logo
      Include diff in commit view
      Add fixed link to index page from repo header
      Reintroduce the branch switcher
      Minor fixup in tree-view css
      More layout fixes
      Implement minimal freetext search in the repolist
      Remove 'patch' link from tab, add to commit view
      Make repository search case insensitive
      Fix css font-family
      cgit.css: set form margins
      Fix more css ugliness
      Make branches, tags and log play better together in the summary view
      Make a few more columns in repolist and log view clickable
      Fix search in repo index even if caching is enabled
      Cleanup page header
      Fix commitdiff annoyance
      Integrate diffstat with diff
      ui-diff: remove test on object type
      Redesign the caching layer
      Add page 'ls_cache'
      Prepare for 'about repo' page
      Move included header-file out of repolist table
      Re-enable 'index-info' and add support for 'root-desc' in cgitrc
      Make it possible for a single cmd to work both with and without a repo
      Prepare for 'about site' page / add 'root-readme' option to cgitrc
      Add 'about site' and 'about repo' pages
      Add cgit_index_link() function with support for offset
      Add a pager on the repolist
      Add footer with page creation time and cgit version on all pages
      Add link to index page from repo header, remove page name
      ui-commit: handle root commits
      Include commit-id in link from diff-stat
      Use GIT-1.5.5.1
      cache.c: read(2) returns -1 on error, not 0
      cache.c: make all io-related functions return errno on error
      cache.c: use xread()/xwrite() from libgit
      cache.c: do not ignore errors from print_slot()
      cache.c: fix error checking in print_slot()
      ui-tree.c: avoid peeking at GITLINK objects
      Use GIT-1.5.6
      Add support for including a footer on all pages
      Add a favicon option to cgitrc
      Use GIT-1.6.0-rc0
      Adjust to new calling convention for read_tree_recursive()
      tests/Makefile: not everyone has `.` in $PATH
      Makefile: fix git dependency rules
      Makefile: do not touch the git objects with `make clean`
      Makefile: remove the `distclean` and `emptycache` targets
      ui-summary: show clone urls
      ui-shared: show repo owner along with description
      Be prepared for empty repositories
      Modify default value for a few cgitrc options
      Makefile: another take on git dependency rules
      Add atom-support
      Add support for cloning over http
      Implement plain view
      ui-tree: link to plain view instead of blob view
      Makefile: Git dependency, take 3
      Use GIT-1.6.0.rc1
      Supply status description to html_status()
      cache.c: use %zd for off_t argument
      Use GIT-1.6.0
      ui-plain: handle subdirectories
      Use GIT-1.6.0.1
      Update Makefile to use GIT-1.6.0.1
      parsing.c: be prepared for unexpected content in commit/tag objects
      ui-tag: show the taggers email
      Teach cgit how to use PATH_INFO
      Add support for --scan-tree=<path> option to cgit
      ui-repolist: enable filtering of repos by path
      ui-diff: fix links from diffstat
      ui-diff: make diffstat header a link to the full diff
      html.c: add html_url_arg
      ui-shared.c: use html_url_arg()
      ui-snapshot.c: specify archiver_args.baselen
      html.c: add html_url_path
      ui-shared.c: use html_url_path() in repolink()
      ui-shared.c: add cgit_summary_link()
      ui-repolist + ui-shared: Use cgit_summary_link()
      Replace cgitrc with cgitrc.5.txt
      ui-shared: do not print repo name on the "summary" tab
      ui-shared: reword the standard page footer
      Use GIT-1.6.0.2
      ui-shared: use html_url_path() to get properly escaped url in form action
      ui-shared: generate proper links in cgit_object_link()
      ui-shared: add cgit_tag_link()
      ui-refs: use cgit_tag_link()
      ui-summary: use html_url_path()
      CGIT 0.8

Michael Krelin (2):
      allow blob extract blobs by head/path combination
      allow specification of directly linked blobs mimetypes

Stefan Naewe (2):
      Added `local-time` option to cgitrc
      cgitrc: explain new local-time option
