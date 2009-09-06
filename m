From: Frank Li <lznuaa@gmail.com>
Subject: [ANNOUNCE]TortoiseGit 1.0.2.0 release
Date: Sun, 6 Sep 2009 13:27:57 +0800
Message-ID: <1976ea660909052227t762c91d1xe60e23ffeaeda49c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: tortoisegit-dev <tortoisegit-dev@googlegroups.com>,
	tortoisegit-users@googlegroups.com,
	tortoisegit-announce@googlegroups.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 06 07:29:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkAJD-0003dZ-Mt
	for gcvg-git-2@lo.gmane.org; Sun, 06 Sep 2009 07:29:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753674AbZIFF17 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Sep 2009 01:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753428AbZIFF16
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Sep 2009 01:27:58 -0400
Received: from qw-out-2122.google.com ([74.125.92.27]:39007 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753050AbZIFF1z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Sep 2009 01:27:55 -0400
Received: by qw-out-2122.google.com with SMTP id 8so506851qwh.37
        for <git@vger.kernel.org>; Sat, 05 Sep 2009 22:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=o6JtD4gRMJzrzTQxpmv65ednqDSbPuvo5/C8FbPjA1s=;
        b=dYwZkW4ROd4kG1F7c1wQgzuz5YzDvw4M3eiSexkkH4d++fxZAASisPKcE3FddIS9H/
         qXiuT7XAci5LkTRh16wtJ5sqMMwmyZRBG8cyu7HAbTv6qE1uZgxJ/futIexblW5hvS7x
         QT4yLk+T2Yln1YuVLTqZtV+U8npjVId5pHLsk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=L4eKeeUYpG0itFalx/DynF7ksu/lHzAnnnRWGjkbaDzXmMkOXTfV3qBEJODGukz541
         wJBWwnKaack5FcdxiV7kJZ2VSNN+YEBN4MYZtRMCdNOcCRNp6MQWwpf4jiRCSCdZjx/R
         RQzfFkTktr07+X0xFQezISFIa7//jV9QH89qU=
Received: by 10.224.8.84 with SMTP id g20mr8371449qag.306.1252214877773; Sat, 
	05 Sep 2009 22:27:57 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127833>

Download:
http://tortoisegit.googlecode.com/files/TortoiseGit-1.0.2.0-64bit.msi
http://tortoisegit.googlecode.com/files/TortoiseGit-1.0.2.0-32bit.msi

= Release 1.0.2.0 =
== Bug Fix ==
 * Fixed issue #155: Fix SVN Rebase sets upstream as remotes/trunk
 * Fixed issue #157: Move progress dlg before rebase dialog SVN Rebase
doesn't fast-forward

= Release 1.0.1.0 =
== Features ==

 * Improve Commit Dialog
   Show line and column number
   Add view/hide patch windows

 * Improve Log Dialog
   Bolad subject at log dialog

 * Setting Config Dialog
   Add core.autocrlf and core.safecrlf

 * Add more option to resolve conflict
   Add Resolve "Their" and Resolve "Mine" at conflict item.

 * Improve Merge dialog
   Add message box to allow input message when merge

 * Improve Stash
   Add Stash pop.
   Add delete stash at logview.

== Bug Fix ==
 * Fix don't show "push" after commit
 * Fixed issue #133: Command fails on folder with leading dash And --
to separate file and git options
 * Fixed issue #133: (mv\rename  problem) Command fails on folder with
leading dash And -- to separate file and git options
 * Fixed issue #140: Incorrect treatment of "Cancel" action on "Apply
patch serial" command
 * Fixed Issue #135:  Taskbar text says "TortoiseSVN"
 * Fix Issue #142:  TortoiseGit Clone of SVN repo does not use PuTTY
session for non-standard SSH port
 * Fixed Issue #138:  "Format patch" in "Show log" dialog doesn't work
 * Fixed Issue #141:  Bizarre ordering in commit dialog
 * Fixed Issue #137:  Proxy Authentification fails
 * Fixed issue #131: Missing SVN DCommit Command
 * Fixed issue #139: "Format patch" with a range of revisions doesn't
export the first revision in the range
 * Fix Pathwatcher thread can't stop when commitdlg exit.
 * Fixed issue #150: When pushing, 'remote' should default to the
tracked branch, or empty
