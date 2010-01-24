From: Frank Li <lznuaa@gmail.com>
Subject: [ANNOUNCE] TortoiseGit 1.3.2.0 Release
Date: Sun, 24 Jan 2010 18:25:13 +0800
Message-ID: <1976ea661001240225t48513d6fx953dca67e51c63f3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org,
	tortoisegit-dev <tortoisegit-dev@googlegroups.com>,
	tortoisegit-users@googlegroups.com,
	tortoisegit-announce@googlegroups.com, tortoisegit@googlegroups.com
X-From: git-owner@vger.kernel.org Sun Jan 24 11:31:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYzkp-0005Zu-HX
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jan 2010 11:31:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753449Ab0AXKbf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2010 05:31:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753399Ab0AXKbf
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jan 2010 05:31:35 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:45098 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752044Ab0AXKbe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2010 05:31:34 -0500
Received: by yxe17 with SMTP id 17so2102060yxe.33
        for <git@vger.kernel.org>; Sun, 24 Jan 2010 02:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=NyjPwKPOl4ghTD5KP5BxusK6Wkv+YQmFO0MYBlcw218=;
        b=s8in3b5zUtjm1BCKOId2NBsy76aBnFbUoXkg9mkVMRAwlCl3ZOQRyEFzPXWafNkIRX
         wlG/abz00coGtyys793C50r0jUkwIXlYbLz9v9CuuVgMOW4unY6iweMjssAF6WJg1VSW
         VPErzZTtsiE5RU+W9Sv8+73ogUD0gofK/dMrY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=HFHKVG+J1TbPFJar8qogztGpEmwFfOJ3/ivrfhOMpo/pueKegKIBoSQwhmqFfCMmIm
         +r0v6gX2L7mQzkdhFM6BVJsoFhsPOjipfuaSQeHcPUHExJXN87io5gbVAmBi1S6Qp6Ww
         MgJpSFulgWOHuO+8vlx5xfzhFtZjy73Xxg6PY=
Received: by 10.150.251.41 with SMTP id y41mr6715091ybh.247.1264328714775; 
	Sun, 24 Jan 2010 02:25:14 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137890>

Download:

http://tortoisegit.googlecode.com/files/TortoiseGit-1.3.2.0-32bit.msi
http://tortoisegit.googlecode.com/files/TortoiseGit-1.3.2.0-64bit.msi

This release build Git source as a DLL. LogDialog will call gitdll to
fetch log instead of capture git.exe output.
Improve refresh and all branch user experience. refresh can abort
runing fetch log commit.

KNOWN ISSUE:
gitdll.dll will miss if install on the 1.2.1.0 or previous version.
work around: Remove previous version before install 1.3.2.0, or launch
1.3.2.0 setup and repair it.
I am sorry for this issue.

= Release 1.3.2.0 =
== Bug Fix ==
 * Fixed issue #276: Crash on seeing diff with previous version
 * Fixed issue #275: Load gitweb for 'Browse' button
 * Fixed issue #265: Log dialog: Date picker throws multiple error
messages when date is before 1.1.1970
 * Fix RefLogDlg crash

= Release 1.3.1.0 =
== Features ==
 * Improve Log Dialog. Speed up log fetch speed.
   Build Git source as a DLL. LogDialog will call gitdll to fetch log
instead of capture git.exe output.
   Improve refresh and all branch user experience. refresh can abort
runing fetch log commit.

 * Improve icon-overlay
   Give up igit.exe and use tgit which build from git source by VS.
   use tgit.exe statusex to get file status.
   Don't list all untracked files.

 * Improve commit and checkout modify dialog
   Don't show file that is only time stamp change and no context change.
   Run git-update-index first when open commit and checkout out modify dialog.

== Bug Fix ==
 * Fixed issue #234: First log(first commit in history) was missing...
 * Fixed issue #232: "No Commit" Option always acitve
 * Fix Issue 236:	CGit::GetRemoteList uses bad regular expression
 * Fix blame show wrong when first char is '^'
 * Workaround show "fail" even git run success at sometime by remove
"fail" message.
 * Issue 265:	Log dialog: Date picker throws multiple error messages
when date is before 1.1.1970
