From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/5] i18n-ize relative dates, git-help and parseopt
Date: Thu,  8 Mar 2012 16:16:33 +0700
Message-ID: <1331198198-22409-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 08 10:17:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5ZTK-00089I-VQ
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 10:17:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755250Ab2CHJRM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Mar 2012 04:17:12 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:54679 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755825Ab2CHJRK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 04:17:10 -0500
Received: by dajr28 with SMTP id r28so259341daj.19
        for <git@vger.kernel.org>; Thu, 08 Mar 2012 01:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=xM55/9Y5HwSbT092tfLq68NV62BniMdtL64uSXX0Q5Y=;
        b=0SKHoRRDuZqXumm3UmPykSeqpVnzX58yOL88bsrJnccHjt6Yfu/RA37KoGlA4D1PDw
         7mQ1OPUsu+EVrXJv1eXKdk1SmwVZufXpBMBFJ3Hl4xybkyINT2IamM0zA7OZaFsz6NJt
         s8qMvbymCX7idQUHS4wP/HfbfiUT52aO+t7TS5qjrRoFq7tWjWbLBbp/DC5DhW99Ozp8
         DugaQYp0rzVlkvtKPjt10d6mgV+M2vkMEEcVVR3hqdNJFV5m3MFVrtzKsWzFBxAe3Pmg
         UVwCy7JyCYp6hoGKFnIzQdYQ2d2obafI+zZvXxzTPvWPLIYTI4LhfawIJRTE8I8GyPjI
         0Fbw==
Received: by 10.68.136.71 with SMTP id py7mr8448359pbb.76.1331198229982;
        Thu, 08 Mar 2012 01:17:09 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id b7sm2321321pba.2.2012.03.08.01.17.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 08 Mar 2012 01:17:08 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 08 Mar 2012 16:16:39 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192540>

Except "git log --date=3Drelative", the focus of this series is "git
help" and "git blah -h" (only "git help -h" for the latter because
other commands need a lot of N_() additions). I think I got everything
from "git help [options]" fully translatable.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (5):
  i18n: keep the last \n even when text is poisoned
  i18n: mark relative dates for translation
  i18n: parseopt: lookup help and argument translations when showing
    usage
  i18n: help: mark parseopt strings for translation
  i18n: help: mark strings for translation

 Makefile            |    2 +-
 builtin/help.c      |   58 +++++++++++++++++++++++++------------------=
-------
 date.c              |   46 +++++++++++++++++++++++++---------------
 generate-cmdlist.sh |    2 +-
 gettext.c           |   10 ++++++++
 gettext.h           |    6 +++-
 git.c               |    2 +-
 help.c              |   34 ++++++++++++++++++-----------
 parse-options.c     |   15 ++++++-------
 9 files changed, 103 insertions(+), 72 deletions(-)

--=20
1.7.3.1.256.g2539c.dirty
