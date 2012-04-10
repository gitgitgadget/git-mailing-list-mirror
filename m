From: =?ISO-8859-1?Q?Gustav_H=E5llberg?= <gustav@gmail.com>
Subject: [StGit] Mostly-Emacs-mode merge request
Date: Tue, 10 Apr 2012 10:16:41 +0200
Message-ID: <CAFBaKAxKnDmNh1BPT1sfFA8k+-zyE9aRuV_5yV6zi62ieOGiew@mail.gmail.com>
References: <CAFBaKAzbYt4S8mK=yatCACBgyEDM3vuwjaM+KFXKT3fhvA2m1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 10 10:16:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHWFu-00085h-6P
	for gcvg-git-2@plane.gmane.org; Tue, 10 Apr 2012 10:16:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755601Ab2DJIQo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Apr 2012 04:16:44 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:42601 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753767Ab2DJIQl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Apr 2012 04:16:41 -0400
Received: by obbtb18 with SMTP id tb18so6941482obb.19
        for <git@vger.kernel.org>; Tue, 10 Apr 2012 01:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=FccFsY9x5JMsdNH5qO8RpYskQbncfNKO24+U0e53mGI=;
        b=kpk6Te1jM79xyQLAn0EdHpn1x6lC9z88WePoFjHFquvpAzVPPfjOlkPJ3fOfQtam29
         QcE1nNCLpYIezT9zpD2RZTCJbucb6cvtWe3xrygTGiYobfqW1II0sskw49fnYZBWbl4f
         X3PvN2va6YDea27Gf8CtMjWGwWp5m0jxTvy8yS81qlCmVXd73BAPNK3ORGbQJdRzgmi1
         lJelgQ1y1wXHRgq9E9YWgxSDEQjs1yeiwj2o79EpGZHznnN2+utmi15S2Zq4YexGsmBZ
         JIJVsXp1YKYaj9NiM/87GaQGI28hw5a1+xi3OBT7xHx4bW0cmGHdC1rz7Fvp/Od1NITY
         WGMg==
Received: by 10.60.32.210 with SMTP id l18mr14648228oei.1.1334045801268; Tue,
 10 Apr 2012 01:16:41 -0700 (PDT)
Received: by 10.182.1.1 with HTTP; Tue, 10 Apr 2012 01:16:41 -0700 (PDT)
In-Reply-To: <CAFBaKAzbYt4S8mK=yatCACBgyEDM3vuwjaM+KFXKT3fhvA2m1w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195075>

Catalin, can you please merge the following series from the
git://github.com/gustavh/stgit.git "proposed" branch.

Most (all but two) of the patches are incremental improvements to the E=
macs
mode.

4d2357d stgit.el: Make stgit-commit commit at most as many patches as
are available
55deb92 stgit.el: Set file names when calling smerge-ediff
fc6a66e stgit.el: Handle file names that must be quoted
5b2c8ad stgit.el: Stop stgit-rename from causing error on no change
7347eb8 stgit.el: Use truenames when finding an already-existing stgit =
buffer
9d9e179 stgit.el: Fix bug when displaying non-stgit branches
059f8e0 stgit.el: Catch errors in a better way in stgit-init
ffeee13 stgit.el: Make sure to set major mode in stgit-capture-output
aceb7d0 stgit.el: Change stgit-capture-output to return what its body r=
eturned
f46c584 stgit.el: Make \C-o create new patch at point
0e495dd stgit.el: Allow opening specific revisions of files
f19eb1f stgit.el: Fix problems with revert of unmerged files
0cc7509 stgit.el: Allow "U" to delete unknow/ignored files and director=
ies
6ed6218 stgit.el: Add and use stgit-assert-no-unmerged-changes
f282cf8 stgit.el: Add and use stgit-save-excursion
64b814f stgit.el: Make "i" set mark correctly when working on the entir=
e patch
ab228bc stgit.el: Change return value of stgit-goto-patch
970a74e stgit.el: Refactor: rewrite stgit-define-toggle-view
c6a5c10 stgit.el: Show human-friendly message when {expand,collaps}ing =
patches
2147794 stgit.el: Show human-friendly message when pressing =3D
2c1769c stgit.el: Add and use stgit-show-task-message to show messages
7246e70 stgit.el: Delay buffer reloads when setting customization varia=
bles
7e1b5aa stgit.el: Make stgit-previous-patch move to the current patch
if on a patched file.
6805d5c stgit.el: Unexpand all (normal) patches when switching branches
724dba9 stgit.el: Do not tab complete on current branch for stgit-branc=
h
f8c77f2 stgit.el: Make stgit-branch ask whether to merge uncommitted ch=
anges
5cabf6c branch: Add --merge flag when switching branches
9a60c57 ignore error return from git show-ref when reading ref cache
43f11d8 stgit.el: Make "\C-u !" run git even when no patches are select=
ed

Thanks,
=A0Gustav

PS. The documentation in=A0http://www.procode.org/stgit/doc/ needs to b=
e
updated to 0.16.
