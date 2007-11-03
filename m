From: "Lars Hjemli" <hjemli@gmail.com>
Subject: [ANNOUNCE] cgit v0.7
Date: Sat, 3 Nov 2007 12:08:40 +0100
Message-ID: <8c5c35580711030408n658eb11fk19d554f0fa3b17@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "git list" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Nov 03 12:08:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoGs5-0000Kd-Ko
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 12:08:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752935AbXKCLIn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 07:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752782AbXKCLIm
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 07:08:42 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:35452 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752538AbXKCLIl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 07:08:41 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1257770wah
        for <git@vger.kernel.org>; Sat, 03 Nov 2007 04:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=6VWo05cRtgd/nFDoGnE4G+vPI6eGrB4Xq2mspk3IndQ=;
        b=a8ocoaSulPstdQ7c8k2havWiGWoxrIuFdi7swwz7ZAEMHb8lkYIoBCP8X79Jnm1A3+nBWF/ktaNc2/hH/KnkPltrX5wCuEUKquG1Ck7lGCF7RhR8GrYixoCT7VqD18rR/aC5JKjwEOFuKO1YOHv2V7bSC0iXzcPNlALXEA14O6Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=LMZpiiAYSbNVeit4NcsgEx8wmSZzJwT0PmqfXXYjm5lZPHoZZiYICTtJpX/TbKIgqbS96BcG9U5XZFI5cN+iD4Np9Vh5pMq+NLdLAMdQKNtb9TVKxLdPOmKutoozgUhU0Hm8h+bUaNhTU+1RX2/Rosy5saFQw6S/YemE6p0R0uI=
Received: by 10.115.106.7 with SMTP id i7mr2914960wam.1194088120881;
        Sat, 03 Nov 2007 04:08:40 -0700 (PDT)
Received: by 10.114.235.4 with HTTP; Sat, 3 Nov 2007 04:08:40 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63231>

cgit v0.7 (a fast webinterface for git) is now available at

     git://hjemli.net/pub/git/cgit

This release includes better search capabilities, better diff,
filtered and sorted branch/tag lists on the summary page, a simple way
to switch between branches and finally a much needed restructuring of
the user interface. There is even a brand new logo, and a number of
bugfixes.

The latest version can be seen in action on http://hjemli.net/git/
(disclaimer: I'm not a web/user interface designer, and should not be
held responsible for any eyeball-related damages).

Big thanks to everyone who submitted patches and feedback!

---
Sortlog since v0.6


Chris Pickel (3):
      Makefile: add support for DESTDIR
      Make cgit honor CACHE_ROOT as defined in Makefile
      Improve the sample cgitrc file

Lars Hjemli (47):
      Makefile: add missing references to DESTDIR
      cgit v0.6.1
      Revert "Makefile: add missing references to DESTDIR"
      Revert part of "Makefile: add support for DESTDIR"
      cgit v0.6.2
      ui-tree: specify parameter position for all htmlf formats
      ui-tree: show last line of blob
      Add cgit.conf to .gitignore, remove *~
      Remove a few compiler warnings
      Use trim_end() to remove trailing slashes
      Upgrade to GIT 1.5.3.2
      cgit v0.6.3
      Add support for a renamelimit option in cgitrc
      Add prefix parameter to cgit_diff_tree()
      Add prefix parameter to cgit_print_diff()
      ui-commit.c: link to diff instead of tree from diffstat
      css: remove the annoying tr:hover rule for diffstat
      gen-version.sh: don't sed the output from git describe
      ui-diff: add links to pre- and postversion of blobs
      cgit.css: make diff headers more visible
      Use git-1.5.3.3
      Skip unknown header fields when parsing tags and commits
      Add functions and types for ref lists
      Use reflist to print branch info
      Use reflist to print tag info
      Sort tags by age
      Add support for config param summary-tags
      Move logic for age comparision from cmp_tag_age into cmp_age()
      Add support for config param summary-branches
      Add descriptions of summary-branches and summary-tags to cgitrc
      Make cgit_print_branches()/cgit_print_tags() external
      Add support for refs view
      Add links to the new refs page from summary page
      Cleanup code introduced by the filter-refs topic
      cgit_parse_commit(): Add missing call to xstrdup()
      Add html_option() function
      Teach log search about --grep, --author and --committer
      Make print_branch() handle refs not pointing at commits
      Teach cgit_object_link() about tag objects
      Add config param 'index-info'
      Change the cgit layout
      Add search parameters to cgit_log_link
      Fix search form action/hidden fields
      Don't include current path in menu links
      Don't include current SHA1 in 'log' menu-item
      Use GIT-1.5.3.5
      CGIT 0.7

Michael Krelin (2):
      fixed typo in cgitrc
      correct typo in CSS

Shunichi Fuji (1):
      Fix typo in css
