From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v3 0/3] Make 'git help everyday' work
Date: Mon, 29 Sep 2014 17:41:44 +0100
Message-ID: <1412008907-3988-1-git-send-email-philipoakley@iee.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: GitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 29 18:41:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XYe0o-0006vc-F7
	for gcvg-git-2@plane.gmane.org; Mon, 29 Sep 2014 18:41:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754876AbaI2QlS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2014 12:41:18 -0400
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:24786 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754059AbaI2QlR (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Sep 2014 12:41:17 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AlobAEOKKVROl3pTPGdsb2JhbABggw0BAR8zVwGJLrBnj1oaBQqHSAQCgRMXAQEFAQEBATg5hGAjGBpoCgwOiFUJv0eQHoI+D0SBQQWGKI93iGuXXzwwAQGCRwEBAQ
X-IPAS-Result: AlobAEOKKVROl3pTPGdsb2JhbABggw0BAR8zVwGJLrBnj1oaBQqHSAQCgRMXAQEFAQEBATg5hGAjGBpoCgwOiFUJv0eQHoI+D0SBQQWGKI93iGuXXzwwAQGCRwEBAQ
X-IronPort-AV: E=Sophos;i="5.04,620,1406588400"; 
   d="scan'208";a="1313650"
Received: from host-78-151-122-83.as13285.net (HELO localhost) ([78.151.122.83])
  by out1.ip02ir2.opaltelecom.net with ESMTP; 29 Sep 2014 17:41:13 +0100
X-Mailer: git-send-email 1.9.4.msysgit.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257627>

Here's version three of my patches to make 'git help everyday' work.

It's taken awhile. Previous patches at [1] and [2].

Junio has provided guidance on modernisation of the text, which has
been integrated into patch 1.

Patch 2 regularises the OBSOLETE_HTML method in the make file, in line
with the currently queued version on pu.

Finally patch 3 swaps over the everyday.txt to the giteveryday.txt accessible
through the regular help system, and changes over all the links.

This follows from :
>Subject: What's cooking in git.git (Sep 2014, #06; Wed, 24)
[...]
> * po/everyday-doc (2014-01-27) 1 commit
> - Make 'git help everyday' work
> 
> This may make the said command to emit something, but the source is
> not meant to be formatted into a manual pages to begin with, and
> also its contents are a bit stale.  It may be a good first step in
> the right direction, but needs more work to at least get the
> mark-up right before public consumption.
> 
> Waiting for a reroll (thread ending at $gmane/254746)
> 

Philip

[1] http://thread.gmane.org/gmane.comp.version-control.git/240286
 [PATCH 0/6] Make 'git help everyday' work
[2] http://thread.gmane.org/gmane.comp.version-control.git/240354
 [PATCH v2] Make 'git help everyday' work

Philip Oakley (3):
  doc: modernise everyday.txt wording and format in man page style
  doc: Makefile regularise OBSOLETE_HTML list building
  Make 'git help everyday' work

 Documentation/Makefile             |   6 +-
 Documentation/everyday.txt         | 413 ----------------------------------
 Documentation/everyday.txto        |   9 +
 Documentation/git-push.txt         |   2 +-
 Documentation/git.txt              |   4 +-
 Documentation/gitcore-tutorial.txt |   2 +-
 Documentation/gitcvs-migration.txt |   2 +-
 Documentation/giteveryday.txt      | 447 +++++++++++++++++++++++++++++++++++++
 Documentation/gitglossary.txt      |   2 +-
 Documentation/gittutorial-2.txt    |   4 +-
 Documentation/gittutorial.txt      |   4 +-
 README                             |   2 +-
 builtin/help.c                     |   1 +
 13 files changed, 472 insertions(+), 426 deletions(-)
 delete mode 100644 Documentation/everyday.txt
 create mode 100644 Documentation/everyday.txto
 create mode 100644 Documentation/giteveryday.txt

-- 
1.9.4.msysgit.0
