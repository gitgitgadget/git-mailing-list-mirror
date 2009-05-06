From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] t4029: use sh instead of bash
Date: Thu,  7 May 2009 00:33:34 +1000
Message-ID: <1241620414-31317-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 07 02:49:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1rnK-0002e0-6S
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 02:49:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757501AbZEGAsJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 May 2009 20:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757388AbZEGAsH
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 20:48:07 -0400
Received: from wf-out-1314.google.com ([209.85.200.174]:12972 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753795AbZEGAsF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2009 20:48:05 -0400
Received: by wf-out-1314.google.com with SMTP id 26so415537wfd.4
        for <git@vger.kernel.org>; Wed, 06 May 2009 17:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=cYIDgVcFLhJjUx3i/tV7ZZ5oKEl/bx1JxV/4nqEDSns=;
        b=tU7ErYE4qIZHSw1OyXMKE7rQctKF9lg/2XdsVvU0ge+CfuomEyUFsY5Y46dGGWRvlQ
         x2M/sSypzNoZGKFM6o3DmqyAymG7WGgep6YjvWs9wcbR+2bvM06MujXG9vIx1TCDLahl
         mg0aQWaSdW7fWkVx5+DJ4a9oFH0RKrDY4mQXI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=o2tir/Ugze/NxKjkCFmAFV7ZunLex/1B1eRZiQiVbwFLelEx42X7gW913yfVYDx1lp
         8v+1CYm+VxH3E+NnLjRvIw//GJhM+Ru3YYEuJgwJvGSStPrSVOuhzwlyAp1O1dOXV6an
         352uabrjRM91c/e2AGa2l4Qn3sPzviIb7DMVI=
Received: by 10.142.51.4 with SMTP id y4mr731150wfy.303.1241657285019;
        Wed, 06 May 2009 17:48:05 -0700 (PDT)
Received: from dektop (dektec.lnk.telstra.net [203.45.32.221])
        by mx.google.com with ESMTPS id 22sm2104895wfd.39.2009.05.06.17.48.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 06 May 2009 17:48:04 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Thu,  7 May 2009 00:33:39 +1000
X-Mailer: git-send-email test
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118416>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t4029-diff-trailing-space.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t4029-diff-trailing-space.sh b/t/t4029-diff-trailing-spa=
ce.sh
index 9ddbbcd..3ccc237 100755
--- a/t/t4029-diff-trailing-space.sh
+++ b/t/t4029-diff-trailing-space.sh
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/bin/sh
 #
 # Copyright (c) Jim Meyering
 #
--=20
test
