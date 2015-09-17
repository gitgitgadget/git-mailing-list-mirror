From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v2.5.3
Date: Thu, 17 Sep 2015 15:16:43 -0700
Message-ID: <xmqqy4g4het0.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 18 00:17:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZchUA-0005WE-KO
	for gcvg-git-2@plane.gmane.org; Fri, 18 Sep 2015 00:16:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752529AbbIQWQr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Sep 2015 18:16:47 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33991 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752483AbbIQWQp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2015 18:16:45 -0400
Received: by padhy16 with SMTP id hy16so30685939pad.1;
        Thu, 17 Sep 2015 15:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=FfncfNo09uRJNhXcOfNZLGX75HtbTP1QBOdJsaPbfcs=;
        b=TAD/uRGSiBc6Kh2MkXJvEVblq5K2C18xtLd4OmJj3W+frYeqqFnLUCrwzHN4hLnL1L
         ezc+6LRIJQgqTdCouBSz6IdebRZHocV+Knk2TlGJD2YS4jL+iHWjdoQ5EjK/svio4bMB
         PV3yzHX+npwGMEofj83zrCzP/IlsUIiJAsh/iVAlBQAvIRLxDS139gcqOzJt6LBqGSer
         EDDq6bV9fbz0f9IyOhTFP9H+GFu7Gh7IwdzcEUN86vYFYPMhL3RXmKC293DY5gOhVnj9
         Xlm2mjj03lZwMRJsg4jNnHn5XAkTi5+du645oXMSZEVoQ9hLHRumdxkUwqr0kQvcg6iI
         KPyA==
X-Received: by 10.68.181.130 with SMTP id dw2mr3037924pbc.70.1442528204793;
        Thu, 17 Sep 2015 15:16:44 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:25ac:307e:6383:2d03])
        by smtp.gmail.com with ESMTPSA id bz1sm5217358pad.36.2015.09.17.15.16.44
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 17 Sep 2015 15:16:44 -0700 (PDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278174>

The latest maintenance release Git v2.5.3 is now available at
the usual places.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.5.3'
tag and the 'maint' branch that the tag points at:

  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

----------------------------------------------------------------

Git v2.5.3 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

=46ixes since v2.5.2
------------------

 * The experimental untracked-cache feature were buggy when paths with
   a few levels of subdirectories are involved.

 * Recent versions of scripted "git am" has a performance regression
   in "git am --skip" codepath, which no longer exists in the
   built-in version on the 'master' front.  Fix the regression in
   the last scripted version that appear in 2.5.x maintenance track
   and older.

Also contains typofixes, documentation updates and trivial code
clean-ups.

----------------------------------------------------------------

Changes since v2.5.2 are as follows:

Alex Henrie (1):
      git-submodule: remove extraneous space from error message

Brett Randall (1):
      git-svn doc: mention "svn-remote.<name>.include-paths"

David Turner (2):
      untracked-cache: support sparse checkout
      untracked-cache: fix subdirectory handling

Johannes Schindelin (1):
      am --skip/--abort: merge HEAD/ORIG_HEAD tree into index

Junio C Hamano (1):
      Git 2.5.3

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (2):
      t7063: use --force-untracked-cache to speed up a bit
      untracked cache: fix entry invalidation
