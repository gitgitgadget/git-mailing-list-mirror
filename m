From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 0/2] gitignore, re-inclusion fix
Date: Sun, 13 Sep 2015 08:18:59 +0700
Message-ID: <1442107141-24265-1-git-send-email-pclouds@gmail.com>
References: <1440334214-32131-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 13 03:19:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zavws-0006rW-0i
	for gcvg-git-2@plane.gmane.org; Sun, 13 Sep 2015 03:19:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754936AbbIMBSt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Sep 2015 21:18:49 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33916 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754884AbbIMBSs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2015 21:18:48 -0400
Received: by padhy16 with SMTP id hy16so108824441pad.1
        for <git@vger.kernel.org>; Sat, 12 Sep 2015 18:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=9WXU3QBPTX/EUqVTM4gMiBLm2t5V6lxwdcw4lRqKh40=;
        b=rbPaVr3g6a1U6dDNRVE/Ui+SwDdDQraOlhrpjgc8+gogVh+0Ke4YGHzxQ/YNyrN4+c
         d10jkNPrOUzZnrYJPVHYEn4Bha4qWXTESYh7cajqUoaLHOy3SxlmpKwlSizZVewLxfzh
         3r/ryWHl5otEIR8iRvM7lhdpZCoxauji5Kn9bpTrbv2HrbRgjHWo0HsOUNDRx/JFwxZw
         vjmM4T0718DsbYdZK/GcLe8LTL+++VVdSzONSo17jQVggFJ09FQ4efpyqQMVJR0Ro8Q5
         FbMdgqINBX8NOUEMvFbJe5aVghpjEwxlGsbApDpjRCo7+Rn+GR95eFK4GjkOIhtryFPX
         SaOw==
X-Received: by 10.66.235.4 with SMTP id ui4mr16190984pac.119.1442107127820;
        Sat, 12 Sep 2015 18:18:47 -0700 (PDT)
Received: from lanh ([171.233.230.25])
        by smtp.gmail.com with ESMTPSA id xi1sm8002730pac.48.2015.09.12.18.18.44
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Sep 2015 18:18:46 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 13 Sep 2015 08:19:06 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1440334214-32131-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277750>

No code change. Explain why 1/2 is needed in the commit message.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (2):
  dir.c: make last_exclude_matching_from_list() run til the end
  dir.c: don't exclude whole dir prematurely if neg pattern may match

 Documentation/gitignore.txt        | 21 ++++++---
 dir.c                              | 89 ++++++++++++++++++++++++++++++=
+++++---
 t/t3001-ls-files-others-exclude.sh | 20 +++++++++
 3 files changed, 118 insertions(+), 12 deletions(-)

--=20
2.3.0.rc1.137.g477eb31
