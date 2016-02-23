From: "=?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?=" 
	<felipeg.assis@gmail.com>
Subject: [PATCH 3/3] t3034: test deprecated interface
Date: Tue, 23 Feb 2016 01:38:45 -0300
Message-ID: <1456202325-6037-4-git-send-email-felipegassis@gmail.com>
References: <1456202325-6037-1-git-send-email-felipegassis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes.Schindelin@gmx.de, gitster@pobox.com,
	sunshine@sunshineco.com,
	=?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?= 
	<felipegassis@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 23 05:41:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aY4mm-0007XC-08
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 05:41:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757295AbcBWElL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Feb 2016 23:41:11 -0500
Received: from mail-vk0-f51.google.com ([209.85.213.51]:35945 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757283AbcBWElH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 23:41:07 -0500
Received: by mail-vk0-f51.google.com with SMTP id c3so150690971vkb.3
        for <git@vger.kernel.org>; Mon, 22 Feb 2016 20:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=X2fw5PsNlwRijPvy7jgi8Coim+UMeZTy6j+CUKxJewg=;
        b=GrPsJ+cBd3Pc3JWjy4iAxE5YqXbJpCpPoMmRhbF+XIbKTswFnzxLqdhSMeCIaMtqic
         MBjEIVCp7QTeWkj9ySQnNK+2j3vRuTQY098eLHh090emFqNrkSrVZVgqI03m1PyCF+jT
         34lJY+574I5XAYqHBmFtIdZTEfqFb71ghL0Igb3eNnSmCmo3KLcsLFAvrW1CRvhyaxS/
         I4dOXcxAUeYaKyLMKjAwoytEcUa9eTKYF/30rxO3D0rXKWey4WT3vLvQbR+qVFipdHXP
         c5+Dre51b8RZSjfSpZBBR32e6hIulqHhByPQ4I1reaRBhTQ8xZnUwiY3yVj/qbbuUNPP
         abow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=X2fw5PsNlwRijPvy7jgi8Coim+UMeZTy6j+CUKxJewg=;
        b=SPTZFwVDf2MQxw/BV/5XAJ3q2G7o8WQBs6P7VHgAJ0Ej7W/JgPpG7qGN+lt7rT8pYa
         eolrQDMd9kC6MTwseQlfSXlBMha5+Qhh72+GTWcmn1FpCe5ThwkTP25S2VMT92V6/2Sr
         w5XFkLvnJW6O9xFVDL449NX02Hs/tZc3VxDsVzUmpGRRL90cncWRGgFvnSC/vMenn3F4
         wmdXJwEsq+d8TmHpT9eizUOjRvloOy4X3+vJHSP9zO3CANYhspemcVRiBseELwv1J/5w
         3ABdFHD4cp7OudiFnfjiWbRTZ9jnt5+7AV6hs32pFpjQRDbLlLFn0S5TH2SYmiTHEuL2
         YEIg==
X-Gm-Message-State: AG10YOQys9VBazXZiD5Bhhutd3omds1GnksTVZbYOCWywY8f3QlLfdgZ/qfD5XSVZLA74Q==
X-Received: by 10.31.132.140 with SMTP id g134mr26960823vkd.94.1456202466545;
        Mon, 22 Feb 2016 20:41:06 -0800 (PST)
Received: from traveller.moon (201-43-158-89.dsl.telesp.net.br. [201.43.158.89])
        by smtp.gmail.com with ESMTPSA id o141sm3772201vkd.19.2016.02.22.20.41.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Feb 2016 20:41:05 -0800 (PST)
X-Google-Original-From: =?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?= <felipegassis@gmail.com>
X-Mailer: git-send-email 2.7.1.492.gd821b20
In-Reply-To: <1456202325-6037-1-git-send-email-felipegassis@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287013>

--find-renames=3D and --rename-threshold=3D should be aliases.

Signed-off-by: Felipe Gon=C3=A7alves Assis <felipegassis@gmail.com>
---
 t/t3034-merge-recursive-rename-options.sh | 46 +++++++++++++++++++++++=
++++++++
 1 file changed, 46 insertions(+)

diff --git a/t/t3034-merge-recursive-rename-options.sh b/t/t3034-merge-=
recursive-rename-options.sh
index 03ce77c..59599ec 100755
--- a/t/t3034-merge-recursive-rename-options.sh
+++ b/t/t3034-merge-recursive-rename-options.sh
@@ -260,4 +260,50 @@ test_expect_success '--find-renames rejects non-nu=
mbers' '
 	git diff --quiet --cached
 '
=20
+test_expect_success 'rename-threshold=3D<n> is a synonym for find-rena=
mes=3D<n>' '
+	git read-tree --reset -u HEAD &&
+	test_must_fail git merge-recursive --rename-threshold=3D${th[0]} $tai=
l &&
+	check_threshold_0
+'
+
+test_expect_success 'last wins in --no-renames --rename-threshold=3D<n=
>' '
+	git read-tree --reset -u HEAD &&
+	test_must_fail git merge-recursive --no-renames --rename-threshold=3D=
${th[0]} $tail &&
+	check_threshold_0
+'
+
+test_expect_success 'last wins in --rename-threshold=3D<n> --no-rename=
s' '
+	git read-tree --reset -u HEAD &&
+	git merge-recursive --rename-threshold=3D${th[0]} --no-renames $tail =
&&
+	check_no_renames
+'
+
+test_expect_success '--rename-threshold=3D<n> rejects negative argumen=
t' '
+	git read-tree --reset -u HEAD &&
+	test_must_fail git merge-recursive --rename-threshold=3D-${th[0]} \
+		HEAD -- HEAD HEAD &&
+	git diff --quiet --cached
+'
+
+test_expect_success '--rename-threshold=3D<n> rejects non-numbers' '
+	git read-tree --reset -u HEAD &&
+	test_must_fail git merge-recursive --rename-threshold=3D0xf \
+		HEAD -- HEAD HEAD &&
+	git diff --quiet --cached
+'
+
+test_expect_success 'last wins in --rename-threshold=3D<m> --find-rena=
mes=3D<n>' '
+	git read-tree --reset -u HEAD &&
+	test_must_fail git merge-recursive \
+		--rename-threshold=3D${th[0]} --find-renames=3D${th[2]} $tail &&
+	check_threshold_2
+'
+
+test_expect_success 'last wins in --find-renames=3D<m> --rename-thresh=
old=3D<n>' '
+	git read-tree --reset -u HEAD &&
+	test_must_fail git merge-recursive \
+		--find-renames=3D${th[2]} --rename-threshold=3D${th[0]} $tail &&
+	check_threshold_0
+'
+
 test_done
--=20
2.7.1.492.gd821b20
