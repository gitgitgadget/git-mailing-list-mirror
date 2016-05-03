From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] remote.c: specify correct plural form in "commit diverge" message
Date: Tue,  3 May 2016 07:12:30 +0700
Message-ID: <1462234350-30902-1-git-send-email-pclouds@gmail.com>
References: <2A734D896A45164C887E476E942BF4F9B5F721@CINMBCNA09.e2k.ad.ge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: ernesto.alfonsogonzalez@ge.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 02:13:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axNyC-0006Z3-Gp
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 02:13:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932727AbcECANi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 May 2016 20:13:38 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:34966 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932454AbcECANe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2016 20:13:34 -0400
Received: by mail-pa0-f65.google.com with SMTP id zy2so283524pac.2
        for <git@vger.kernel.org>; Mon, 02 May 2016 17:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OhCTfbbhbZEBgId1zjeaU2k2IulwozRL0aC4iwyKz5I=;
        b=yOCc9MWHFHfCu9+VFbE70ct1mt3xzXPLSIKpHf2dx5PoXTavVEm0WlfNIFN+i+PFLm
         6iAOKk7fBFjwFxWnbDlJbodmDa+gHvYiWrkJUxuUSfNangSQPbdMht4rnRsCkRub0JTj
         /QvXCdFajz70jdL+RABetZI0b+Yu/Kutkezb0V1tjhMlaDCyKVmgu1vM5a6Ylbk9x0ib
         ZVBDotFUllIVDok1jRrFQ1THspqesYl8PUl9A1caEseMp6bHVIapy7KFC4lPjYXihr+Q
         L0kgGlOUrCZObLo06GRtTg+sJ5aMagBZksxCR3HUNPgNkOMGZN2B3g6e59iP2YiecLlL
         SDEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OhCTfbbhbZEBgId1zjeaU2k2IulwozRL0aC4iwyKz5I=;
        b=V1RhCWb69WXP8+olJBmF0cYIfm29wdD9jxtBey5wfS5zAWZ5uumcUyN5dnm5GVBFHn
         IXDTn4yiCaws5aX7p8r7SFQWN2OXtysBuhscTSqo+wbrfDL0m1wMEgMTgSK2+SmGX9G+
         v5FQghG/AFs4eDA3t7Udafk6ld9P8ON65PlZoq0tSe+27jGwhX6M810LaVQN8YJxeYGJ
         LlQghqWXIyOiH0VDdxQL3GOvAyFZbrLUJtV1+B9znwpl4gKwfDzenwFxGuwhW1zjtvyj
         N1lixZTszdsSsdZkmHblehin0dgQgAhvfFX34XzLyd7bhfyTCstMPMJL9oZclXmVLJN4
         V+ZA==
X-Gm-Message-State: AOPr4FWewExULG6kEGLpygRr3ukWWEXq2IaB8jA2raJ68uj2siBHuf1sgOnfaVDuZoiWAw==
X-Received: by 10.66.140.17 with SMTP id rc17mr40979301pab.129.1462234413354;
        Mon, 02 May 2016 17:13:33 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id 88sm617702pfj.20.2016.05.02.17.13.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 May 2016 17:13:32 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 03 May 2016 07:13:29 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <2A734D896A45164C887E476E942BF4F9B5F721@CINMBCNA09.e2k.ad.ge.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293309>

We need to count both "ours" and "theirs" commits when selecting plural
form for this message. Note that even though in this block, both ours
and theirs must be positive (i.e. can't be in singular form), we still
keep Q_(singular, plural) because languages other than English may have
more than one plural form.

Reported-by: Alfonsogonzalez, Ernesto (GE Digital) <ernesto.alfonsogonz=
alez@ge.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 remote.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/remote.c b/remote.c
index 28fd676..212426e 100644
--- a/remote.c
+++ b/remote.c
@@ -2108,7 +2108,7 @@ int format_tracking_info(struct branch *branch, s=
truct strbuf *sb)
 			   "Your branch and '%s' have diverged,\n"
 			       "and have %d and %d different commits each, "
 			       "respectively.\n",
-			   theirs),
+			   ours + theirs),
 			base, ours, theirs);
 		if (advice_status_hints)
 			strbuf_addf(sb,
--=20
2.8.0.rc0.210.gd302cd2
