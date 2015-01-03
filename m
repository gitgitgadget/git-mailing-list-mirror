From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/3] nd/multiple-work-trees updates
Date: Sat,  3 Jan 2015 16:41:24 +0700
Message-ID: <1420278087-14613-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Max Kirillov <max@max630.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 03 10:42:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y7LDf-0001wX-4B
	for gcvg-git-2@plane.gmane.org; Sat, 03 Jan 2015 10:42:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750947AbbACJlq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Jan 2015 04:41:46 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:47709 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917AbbACJlp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Jan 2015 04:41:45 -0500
Received: by mail-pa0-f46.google.com with SMTP id lf10so25228747pab.5
        for <git@vger.kernel.org>; Sat, 03 Jan 2015 01:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=End6NVdFDJyZUL38HWL5/AXQ/eDpAeU8v+TdBPwbIl4=;
        b=xrqLG+FLVqbRG2GB7QkmyiBe7NuaSPZgkKZ9493oTaVai46vjK6wULMpq9Ml4zHvjA
         AAVlf4dqYp9tp384Le29KODCGYW5sq+BaAJ4ROYocEWfIC9qZQivfA6NJsD343UJibvO
         u5idapqZ69iDgzy7ZdtKJsxcHr3WD9u2jflI7DjLZ+QcF7tcb4oyj+yZHgicls/md4f8
         f8yJ1T/DnJdS6HBkDPvE/B0gXlnamDngJQZsRm7q9tdxl4lqeZS8rn9uL0586V2IRfg4
         Gn7MW2iP5/3Dv39tsGS742wZ8tuf1LsLo3J3+hG9rvq+QiQcAsP+IgWvX2d9ZnlYqu2f
         zA2Q==
X-Received: by 10.66.55.104 with SMTP id r8mr100026310pap.75.1420278104661;
        Sat, 03 Jan 2015 01:41:44 -0800 (PST)
Received: from lanh ([115.73.231.124])
        by mx.google.com with ESMTPSA id nk6sm48733009pdb.89.2015.01.03.01.41.41
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Jan 2015 01:41:43 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 03 Jan 2015 16:41:45 +0700
X-Mailer: git-send-email 2.2.0.84.ge9c7a8a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261990>

These patches are on top of what's in 'pu'. They add
--ignore-other-worktrees and make a note about current submodule
support status. I don't think submodule support is ready yet even
with Max Kirillov's series [1]. His 03/03 is already fixed in 'pu'
though, so only 01/03 and 02/03 are new.

[1] http://thread.gmane.org/gmane.comp.version-control.git/261107

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (3):
  checkout: pass whole struct to parse_branchname_arg instead of indivi=
dual flags
  checkout: add --ignore-other-wortrees
  git-checkout.txt: a note about multiple checkout support for submodul=
es

 Documentation/git-checkout.txt |  9 +++++++++
 builtin/checkout.c             | 19 +++++++++++--------
 t/t2025-checkout-to.sh         |  7 +++++++
 3 files changed, 27 insertions(+), 8 deletions(-)

--=20
2.2.0.84.ge9c7a8a
