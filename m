From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [ANNOUNCE] Stacked Git 0.15-rc3
Date: Sun, 13 Sep 2009 17:01:41 +0100
Message-ID: <b0943d9e0909130901n7655db7av71471148117711d3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Karl Wiberg <kha@treskal.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 13 18:01:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmrWO-0005jO-B9
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 18:01:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754668AbZIMQBk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Sep 2009 12:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754645AbZIMQBj
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 12:01:39 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:38667 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750947AbZIMQBi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Sep 2009 12:01:38 -0400
Received: by fxm17 with SMTP id 17so378701fxm.37
        for <git@vger.kernel.org>; Sun, 13 Sep 2009 09:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=y8BKZgRAnJIHw6lKKi1c/d1Xo92Kp7FKkjel9gWxxmo=;
        b=ahTBof4yXagcwPGFkuzh7NGcSopVPvBbDqFlcXjfB2bkqkR90C0tpuHrCp5j52uEbn
         seRa3W/bOMKGX5s2CQgijZPin8ZzXa0UrXLNQnvV7oaBraPAB5Om2KZECBsvPB6Lk/KC
         V839UV+9JQ8JoDCGwGLx/jFvXD2ROxhKCpFlo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=CpkQDCt6FecCtiPmzfJjB1pfInQYZ3bK93ZmBTVxGxE8nQ0u298DChJB1nw++VelsN
         V5xtklxSiGBjWnCs9jjoiH+ol3K3ka6ZoTGMZdwoDHBnU817blApsSK82ahZQkjmfDY8
         M35rQbyp4v70/LVf9GwVqcT/Jm5kb90Azxyeg=
Received: by 10.223.3.137 with SMTP id 9mr1911500fan.45.1252857701216; Sun, 13 
	Sep 2009 09:01:41 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128370>

The third release candidate for StGit 0.15 is available from the
git://repo.or.cz/stgit.git or http://download.gna.org/stgit/. Bugs can
be reported on the Git mailing list or via the project bugs page
(https://gna.org/bugs/?group=3Dstgit).

StGit is a Python application providing similar functionality to Quilt
(i.e. pushing/popping patches to/from a stack) on top of Git. These
operations are performed using Git commands and the patches are stored
as Git commit objects, allowing easy merging of the StGit patches into
other repositories using standard Git functionality.

Unless there are major issues, the aim is for this to be the last
release candidate before 0.15.

The main changes since release 0.15-rc2:

- 'stg import' command fixes to allow the importing of 'git show' outpu=
t
  and also support the -pN option for stripping leading slashes from
  diff paths. The author date when importing e-mails is also preserved
- Generate binary diffs by default when exporting patches
- Other bug-fixes

Acknowledgements:

Catalin Marinas (7):
      Add stg-build, stg-dbg and RELEASENOTES to the MANIFEST.in file
      Merge commit 'kha/safe'
      Import git show output easily
      Merge commit 'kha/safe'
      Add import -p option
      Preserve the given author date during import
      Generate binary diffs by default

David K=E5gedal (1):
      Escape patch name when creating regexp

Karl Wiberg (2):
      When reading a config value, pick the last value, not the first
      squash: Make commit message editing more convenient

--=20
Catalin
