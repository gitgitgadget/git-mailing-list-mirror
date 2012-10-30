From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 0/4] fast-export: general fixes
Date: Tue, 30 Oct 2012 20:06:23 +0100
Message-ID: <1351623987-21012-1-git-send-email-felipe.contreras@gmail.com>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 30 20:06:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTH9F-0002YK-SJ
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 20:06:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934036Ab2J3TGh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 15:06:37 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:52686 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755158Ab2J3TGg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 15:06:36 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so340997bkc.19
        for <git@vger.kernel.org>; Tue, 30 Oct 2012 12:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=qZzlSyU7BkKL2jUcHOflKYM1UZClp2RHasShw2Zhd+Y=;
        b=gefyZEjXRdfCHAy4dKqgAzlrRaFjjnyaZCylhxy7/wJsEVrsZUh1ohcVnC0z5joJYr
         XmC6T8yHoAywVpozeXdVuzwfTpLOYlKgUPR6AX5b6wTyXeCmpKW3riQ+/e+xzkB/TKtH
         GGFfDGnbjg5/I9FvevcAK4+qCZ49yhE8WMDcWLo0zXukYFC41+0zMnhEgtIFJoohG+IV
         3SBI2l39T4+TA09KNhfl3mQRRIyEvCeTX1/luMoIHVg/HlzvBeThWXKY35I3ILrElmZl
         7GW+troSJyg2vv4ebl7pgd0o6NM27eMJTWpdM1BZ4BH2YrtrnWdD4giLgNHxELV45U+N
         pzpQ==
Received: by 10.204.8.215 with SMTP id i23mr10242625bki.44.1351623995149;
        Tue, 30 Oct 2012 12:06:35 -0700 (PDT)
Received: from localhost (ip-109-43-0-40.web.vodafone.de. [109.43.0.40])
        by mx.google.com with ESMTPS id r15sm1970070bkw.9.2012.10.30.12.06.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 30 Oct 2012 12:06:34 -0700 (PDT)
X-Mailer: git-send-email 1.8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208726>

Hi,

Note: sorry for the noise, the first try (v2) was silently eaten by the mailing
list handler.

First patches are general cleanups and fixes, the last patch fixes a real issue
that affects remote helpers.

Changes since v2:

 * Actually send it to the ml

Changes since v1:

 * Improved commit messages
 * Use /dev/null in tests
 * Add test for remote helpers

Felipe Contreras (4):
  fast-export: trivial cleanup
  fast-export: fix comparisson in tests
  fast-export: don't handle uninteresting refs
  fast-export: make sure refs are updated properly

 builtin/fast-export.c     | 16 +++++++++++-----
 t/t5800-remote-helpers.sh | 11 +++++++++++
 t/t9350-fast-export.sh    | 26 +++++++++++++++++++++++---
 3 files changed, 45 insertions(+), 8 deletions(-)

-- 
1.8.0
