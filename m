From: "Lars Hjemli" <hjemli@gmail.com>
Subject: [ANNOUNCE] cgit v0.6
Date: Tue, 4 Sep 2007 12:42:11 +0200
Message-ID: <8c5c35580709040342j3306725fy93313344b575b959@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 04 12:42:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISVrP-0003VM-LP
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 12:42:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752860AbXIDKmO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 06:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752773AbXIDKmO
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 06:42:14 -0400
Received: from wa-out-1112.google.com ([209.85.146.182]:40290 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752780AbXIDKmN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 06:42:13 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2187052wah
        for <git@vger.kernel.org>; Tue, 04 Sep 2007 03:42:12 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Ui4p5ykOWn4CzAy7/5xI7De9sfl6lJAj36LNbhbMAhccDk86Wcf4+5cg5aqJaxEV/hB4tCnVB12SnYmrjTmPVNOH1KmFF1R/nKDb+UzygS9oTCU4mzeduG6ny5BnZ/WYet2e89hPw05qhPH2qaOQfL1iVZbpef/OXghEBXw3zu8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=No4rHauhBgxgNxTK6xan90WTD+LvmsS8ErxkBj/VvCMwn1Eu5VXCITvaVaWaXfYLCJoEBHHw8UNU/MfOclolWHxZ9/2J+VT9Ph7W3aWYZPmpw+b27wPf88UadR4o+0bfRNbOK2DwTKvrRZktmVxycni//Nbylj/qC3tneKm0Yew=
Received: by 10.115.93.16 with SMTP id v16mr4381018wal.1188902531818;
        Tue, 04 Sep 2007 03:42:11 -0700 (PDT)
Received: by 10.115.73.2 with HTTP; Tue, 4 Sep 2007 03:42:11 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57548>

cgit v0.6 (a fast web interface for git) is now available for download:

tarballs - http://hjemli.net/git/cgit
cloning - git://hjemli.net/pub/git/cgit

It's been a while since the last release, so here's a summary of the changes:
* improved site navigation
* improved tree/source browser
* support for shortlog on summary page
* support for multiple snapshot formats (tar.gz, tar.bz, zip)
* support for specifying configfile via environment (great for testing)
* uses git 1.5.3 as a submodule
* bug-fixes

Note: Please take a look at the README
(http://hjemli.net/git/cgit/tree/README) for build instructions,
especially regarding the git subdirectory. And if you've built a
previous version of cgit and provided an override for "prefix" in
cgit.conf, please s/prefix/CGIT_SCRIPT_PATH/ in your cgit.conf before
running "make install".
-- 

Shortlog since v0.5:

Jeffrey C. Ollie (1):
      Rename dirlink to gitlink.

Lars Hjemli (34):
      ui-diff: emit table/tr/td at better locations
      ui-diff: close td/tr/table properly
      cgit.css: make it validate
      ui-tree: unify with ui-view, use path to select tree/blob
      ui-tree: make blob viewer generate valid html
      Add and use cgit_tree_link()
      ui-shared: use strcmp() to compare strings
      ui-tree: html/css cleanup
      Add git_log_link() and fix bug in generic repolink function
      Add cgit_commit_link() + support for id=sha1 to commit view
      ui-log: honor id=sha1 on querystring
      ui-commit: use cgit_commit_link() for parent links
      Add cgit_diff_link()
      Add more menuitems on repo pages
      Add version info from git-describe
      Include querystring as part of cached filename for repo summary page
      Change "files" to "tree"
      Change S/L/T to summary/log/tree
      Add setting to enable/disable extra links on index page
      Do not include current path in the "tree" menu link
      Add trim_end() and use it to remove trailing slashes from repo paths
      Add ofs argument to cgit_log_link and use it in ui-log.c
      Add ui-tag.c
      cgit_print_snapshot_links: use url to specify snapshot name
      Add support for line number in url fragment
      Make ui-tag.c generate valid xhtml
      ui-snapshot: whitespace/formatting cleanup
      Rewrite the makefile + gen-version.sh
      Makefile: add target "get-git"
      Delete submodules.sh and prepare for using git-submodule
      Use git-1.5.3 as submodule
      Set xdemitconf_t.findfunc=NULL
      Update README
      cgit v0.6

Michael Krelin (14):
      make config adjustable via env variable CGIT_CONFIG
      make gen-version.sh run even if . is not in PATH
      add support for snapshot tarballs
      css: adjust vertical-align of commit info th cells
      added a chk_non_negative check
      compress .tar.gz using gzip as a filter
      introduced .tar.bz2 snapshots
      add plain uncompressed tar snapshort format
      added snapshot filename to the link
      introduce cgit_repobasename
      shorten snapshot names to repo basename
      allow selective enabling of snapshots
      fix: changed view link to blob in summary.
      link raw blob from tree file view

Ondrej Jirman (6):
      Fixed unexpected tags in html output.
      Use &amp; instead of & in URLs.
      Handle single-line and empty commit subjects
      Add option to disable pager to cgit_print_log().
      Check for NULL commit buffer in cgit_parse_commit()
      Implemented configurable HEAD shortlog on summary page.
