From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Heitzmann?= 
	<frederic.heitzmann@gmail.com>
Subject: [PATCH] Disambiguate duplicate t9160* tests
Date: Fri, 16 Sep 2011 21:55:03 +0200
Message-ID: <1316202903-5085-1-git-send-email-frederic.heitzmann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, bjacobs@woti.com, rchen@cs.umd.edu,
	=?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Heitzmann?= 
	<frederic.heitzmann@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 16 21:55:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4eVj-0002K5-0a
	for gcvg-git-2@lo.gmane.org; Fri, 16 Sep 2011 21:55:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754387Ab1IPTz1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Sep 2011 15:55:27 -0400
Received: from mail-wy0-f180.google.com ([74.125.82.180]:63287 "EHLO
	mail-wy0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752668Ab1IPTz1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Sep 2011 15:55:27 -0400
Received: by wyj26 with SMTP id 26so5133690wyj.11
        for <git@vger.kernel.org>; Fri, 16 Sep 2011 12:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=mVW5CinBWd3bEA7QI/2uP+LE2NqGToRZmAg3CzXmb2o=;
        b=SMBJuT3xQ5UPDcSPaPM3KN5V25M2xbkjp0ZTTPJWgHGrWZdooPS+uLB4U7u3hOrj9g
         ZWlc568JGjxAXXS3HQUdJjuBPi80lHCFLiUxgCglBfGO/lH2RfpOTAej7DvK21Qt+JiY
         +ZlPn6lfirwiQ/vKmUKJL+0KpaeGHxAIHI5I4=
Received: by 10.227.11.132 with SMTP id t4mr1747209wbt.93.1316202925441;
        Fri, 16 Sep 2011 12:55:25 -0700 (PDT)
Received: from localhost.localdomain (dra38-7-88-179-84-80.fbx.proxad.net. [88.179.84.80])
        by mx.google.com with ESMTPS id ex16sm13961539wbb.4.2011.09.16.12.55.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 16 Sep 2011 12:55:24 -0700 (PDT)
X-Mailer: git-send-email 1.7.7.rc0.200.g2f9e2e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181548>

1e5814f created t9160-git-svn-mergeinfo-push.sh on 11/9/7
40a1530 createds t9160-git-svn-preserve-empty-dirs.sh on 11/7/20
The former test script is renumbered to t9161.

Signed-off-by: Fr=C3=A9d=C3=A9ric Heitzmann <frederic.heitzmann@gmail.c=
om>
---

  I did not find any explicit objection in t/README but it looks odd.

 ...nfo-push.sh =3D> t9161-git-svn-mergeinfo-push.sh} |    0
 1 files changed, 0 insertions(+), 0 deletions(-)
 rename t/{t9160-git-svn-mergeinfo-push.sh =3D> t9161-git-svn-mergeinfo=
-push.sh} (100%)

diff --git a/t/t9160-git-svn-mergeinfo-push.sh b/t/t9161-git-svn-mergei=
nfo-push.sh
similarity index 100%
rename from t/t9160-git-svn-mergeinfo-push.sh
rename to t/t9161-git-svn-mergeinfo-push.sh
--=20
1.7.7.rc0.200.g2f9e2e
