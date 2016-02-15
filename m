From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/4] .gitignore, reinclude rules, take 2
Date: Mon, 15 Feb 2016 16:03:35 +0700
Message-ID: <1455527019-7787-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 15 10:03:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVF4A-00060R-2V
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 10:03:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752496AbcBOJD2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Feb 2016 04:03:28 -0500
Received: from mail-pa0-f51.google.com ([209.85.220.51]:36588 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752389AbcBOJDX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 04:03:23 -0500
Received: by mail-pa0-f51.google.com with SMTP id yy13so82772023pab.3
        for <git@vger.kernel.org>; Mon, 15 Feb 2016 01:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=y1xWxLcdZdeSzyrrZOdqSeRcy4/8qhhpsd8Po1U4DzU=;
        b=OstI7ns/IcmaC3GoF+c+t0xzG3MoZZycO+WUABFKSB6OHq78ruVi+hYd4ZAcC29fMn
         VCjcllfGMgmwXEkd5z6j7ClcYdjx2i9IR9OeOycLPg0NUJ+jLqUYcnH/04ya6cfzP0mW
         O50Y/3J6CH/TVtaywuQmZPzJGC+6pASn/wUt+lD//7M+JmHAKo2Yhbw7lIzzk5u1aeve
         cvT2ljuDqqbPTesPKxmbPmAO3x3rD3BbEHXaUt11DSZbbxxsnTDkKQMlgZXQbcuFjJE/
         JGF1Z6z37bDOGUUhvs/XSupopm8B+qn7lqys+QgpF7bCfl+eJfQYbvVTggyvYouUzxG5
         Yh6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=y1xWxLcdZdeSzyrrZOdqSeRcy4/8qhhpsd8Po1U4DzU=;
        b=gKsejXrtII3ucunZuZVoIqmADA3S2296g6scYOP+ME+riRwTcrZ99WAhDMFJWSiIc/
         fo2kpEfQdsUfeeBCHAOXu1gq/fghabkR/3C3qWzibn5cx1BXrageLLRoumst9v1zEyKL
         EtHR2/Fxd1vo8u6VuBS2wHHWmhwULey0EfL0/nPXr/lRoUBBIz5dlsFItYH3/JTlR2AM
         T/zX0VOqmu3b9SpEXvrXnp+cODCa9qPg2HhXHIn0IrhWXpy6z4MIaUb/1DubtgAL+lsV
         DNQuuGXK+RwVvsEGxEmwu2A0zC4gD3ZG4GyDpWH4NiTpalWpVpwHymFwxGaBWgzesxWx
         nocA==
X-Gm-Message-State: AG10YOTuY2fRmu2tKH4WYyj/IKxduLuCauHgyLQa7pu/chc68fOzJHiDe+p0Khf/ktFMyw==
X-Received: by 10.66.159.136 with SMTP id xc8mr21877601pab.71.1455527003017;
        Mon, 15 Feb 2016 01:03:23 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id z7sm36754899pfi.19.2016.02.15.01.03.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Feb 2016 01:03:21 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 15 Feb 2016 16:03:45 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286184>

Take one was bad and reverted in commit 8c72236. Take two provides a
more complete solution to the pair of rules

  exclude/this
  !exclude/this/except/this

3/4 should do a better job at stopping regressions in take 1. 4/4
provides the solution. I think I have tested (and wrote tests) for all
the cases I can imagine.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (4):
  dir.c: fix match_pathname()
  dir.c: support tracing exclude
  dir.c: support marking some patterns already matched
  dir.c: don't exclude whole dir prematurely

 Documentation/git-check-ignore.txt          |   1 +
 Documentation/git.txt                       |   5 +
 Documentation/gitignore.txt                 |  17 ++-
 dir.c                                       | 204 ++++++++++++++++++++=
+++++++-
 dir.h                                       |   3 +
 t/t3001-ls-files-others-exclude.sh          |   7 +-
 t/t3007-ls-files-other-negative.sh (new +x) | 153 ++++++++++++++++++++=
+
 7 files changed, 378 insertions(+), 12 deletions(-)
 create mode 100755 t/t3007-ls-files-other-negative.sh

--=20
2.7.0.377.g4cd97dd
