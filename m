From: Manuel Neubauer <neubauer@melosgmbh.de>
Subject: Problem with gitk since git-version 2.6, probably a problem with language/locale
Date: Tue, 17 Nov 2015 13:13:53 +0000 (UTC)
Message-ID: <loom.20151117T140439-132@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 17 14:20:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZygBL-0004eC-RT
	for gcvg-git-2@plane.gmane.org; Tue, 17 Nov 2015 14:20:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752666AbbKQNUR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2015 08:20:17 -0500
Received: from plane.gmane.org ([80.91.229.3]:60290 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752301AbbKQNUQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2015 08:20:16 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1ZygB2-0004Gu-U7
	for git@vger.kernel.org; Tue, 17 Nov 2015 14:20:05 +0100
Received: from p5B396776.dip0.t-ipconnect.de ([91.57.103.118])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 17 Nov 2015 14:20:04 +0100
Received: from neubauer by p5B396776.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 17 Nov 2015 14:20:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 91.57.103.118 (Mozilla/5.0 (X11; Linux x86_64; rv:41.0) Gecko/20100101 Firefox/41.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281406>

Hello everybody,

since git-version 2.6, I get the following error on all of the machines here
at work:

Error in startup script: bad menu entry index "Ansicht bearbeiten ..."
    while executing
".bar.view entryconf [mca "Edit view..."] -state normal"
    invoked from within
"if {$cmdline_files ne {} || $revtreeargs ne {} || $revtreeargscmd ne {}} {
    # create a view for the files/dirs specified on the command line
    se..."
    (file "/usr/bin/gitk" line 12442)

I'm using
- openSuSE 13.2
- $LANG=de_DE@euro
- $LC_ALL=de_DE@euro
- $LC_COLLATE=POSIX

The problem occurs when I', trying to use "gitk <FILENAME>" oder something
like "gitk ..origin/<BRANCHNAME>".
A normal call of "gitk" without any extra arguments works without any problems.

In git-version 2.5.3 this problem isn't present, it came along with version
2.6.x.

Any help very appreciated.
Thanks,
 Manuel
