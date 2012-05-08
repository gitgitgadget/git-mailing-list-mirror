From: Linus Tolke Tigris <linus@tigris.org>
Subject: git-svn should transform svn:ignore to .gitignore and .gitignore to
 svn:ignore automatically
Date: Tue, 8 May 2012 22:26:18 +0200
Message-ID: <CAPumN3twcHtTtBxDBsw1e+SopGyzAkZKoTMFwOtEexfdmXiuFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 08 22:26:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRqzc-0003lQ-Kl
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 22:26:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757017Ab2EHU0k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 May 2012 16:26:40 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:38468 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756954Ab2EHU0j convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 May 2012 16:26:39 -0400
Received: by mail-yx0-f174.google.com with SMTP id m10so5275431yen.19
        for <git@vger.kernel.org>; Tue, 08 May 2012 13:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:from:date:x-google-sender-auth:message-id
         :subject:to:content-type:content-transfer-encoding;
        bh=a+Ek+bLDnK2OsKMr6aVTvzocmcwFAv21F2+lQLAtqCg=;
        b=B1W7wMCNvwupG+LOroBBds+NnJNhb95vGWWKJbcj8HNj6NMxoaVRZWaP9VMGjVIcDa
         F2+6JKH2Zs2aKBkFq6z2yPiMj/NPZ8xmYGWFtRxE70saiFstUwdghNVSPa4cICzVq5wC
         DeRej3c65AAZ7TcPkBss795QsdYt9tHr8VUMW5p8tsoFXM2AtT/wsQWq1AH3S9yQMZW3
         CEc0vQ3r8Ny2LZkYpvEhHaqX1r+vp25bFYeU4gZQhks6NxAA33KdrkOCozOLJ7JZDShr
         /hh++ebKjWZFUzajsfCePCz7WYbq1rnrsr2YHNNrWrnoMF+aNbwr+hLO8A6m9QBSc9C1
         Qskw==
Received: by 10.236.200.230 with SMTP id z66mr3298181yhn.82.1336508798891;
 Tue, 08 May 2012 13:26:38 -0700 (PDT)
Received: by 10.236.109.50 with HTTP; Tue, 8 May 2012 13:26:18 -0700 (PDT)
X-Google-Sender-Auth: _kwlmnE3rBhcf10T0t1nRuhmemc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197420>

Hello!

I am attempting to use git as a local repository to manage the work
before checking into the master subversion repository.=A0gerrit is
involved in this. I consider the git repository as a mirror of the
subversion repository so changes in the subversion repository are
fetched using 'git rebase" and changes in the git repository are sent
upstream with "git svn dcommit".

I find it inconvenient that the=A0svn:ignore properties are not mirrore=
d
into .gitignore files by "git svn fetch", "git rebase", and I assume
that changes in .gitignore files do not cause "git svn dcommit" to
modify the svn:ignore property.

I would like this feature to be added to git-svn.

As a workaround, I have run "git svn create-ignore" and committed the
=2Egitignore files. This means that I will have to try to remember to d=
o
this again whenever any svn:ignore property changes and changes that
are done in .gitignore files in the downstream "git repository" will
not be considered by svn.

Thanks!

=A0 =A0 =A0 =A0 /Linus
