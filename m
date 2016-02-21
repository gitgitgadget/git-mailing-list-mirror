From: "=?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?=" 
	<felipeg.assis@gmail.com>
Subject: [PATCH 2/5] merge-strategies.txt: fix typo
Date: Sun, 21 Feb 2016 12:09:15 -0300
Message-ID: <1456067358-19781-3-git-send-email-felipegassis@gmail.com>
References: <1456067358-19781-1-git-send-email-felipegassis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes.Schindelin@gmx.de, gitster@pobox.com,
	sunshine@sunshineco.com,
	=?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?= 
	<felipegassis@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 21 19:12:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXYUM-0001P2-Og
	for gcvg-git-2@plane.gmane.org; Sun, 21 Feb 2016 19:12:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbcBUSMG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Feb 2016 13:12:06 -0500
Received: from mail-qg0-f41.google.com ([209.85.192.41]:34354 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751166AbcBUSMF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2016 13:12:05 -0500
Received: by mail-qg0-f41.google.com with SMTP id b67so97245325qgb.1
        for <git@vger.kernel.org>; Sun, 21 Feb 2016 10:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=aiYoXDRiiOAf13dR2gLQaSR09H1r8QSnTgyco68grJI=;
        b=GTB6bEa39MPhjPbScTgEwrsx3dCQNf/O/VKrWgJNKGVSR59I+6Hn2INFxc2u4leRUK
         zWUV55IC/CEmT0n6ib35atQl9yRgBBcig8vKLCyHd1OvtbtwlrPIRj9NheR8hdjrZpfc
         l77I9uaZotjK3MQpXHDllrh6Wpx+WiMK4CMwrDgIMUAg/HAwljMEkRTaIQtypuSVnluw
         22CcuwAqMzp91upQtthyJL630KXniYOqrt2MrLPMNqjMCdAzkN/ceBduwcF6NSMvLGKL
         1uYHjEwnxafB3/3Mzp3JOL01baczgBqmUFaqYDsrSTQ6SIDMJ+DCiAId1FjNsGE3f7wk
         MEQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=aiYoXDRiiOAf13dR2gLQaSR09H1r8QSnTgyco68grJI=;
        b=BnQCP7yYzOxsWMOyedfiJ7lVRVu/AueA/DFRqL4KOXcjH8HVHWrP0yhS1bIvBA53vq
         d/uMFXBNFOcycDvhVGwegEIqCM15WT3rBuaD6FUEtI5zGWnwEBXoIch8TVcWxMq/MPZ2
         VSk7vYdkmrUNt6PBYzLGcie04pARcgNSQEMg5oCrJC5PLf49fnPN9waC7MELsuT3yxiL
         bOAO4QbXQzhynHK7fQuDm7j019tDDXM2DUOQPnABulLgDdTMV0J1OO67QyM+ZTDZVjEg
         ySFUsCCX1s5sW1J7PQGkQ7dhuxnJ9WiegWdyh4AtSC8XAJNZYORfcgf6x4Iky4WPHcST
         6Axg==
X-Gm-Message-State: AG10YOTcnHqGg9T759s12pdZ4RGWvJlKMGKbERseeE+R1Ng8L/wyQqAa0yUCHi+G61TVtw==
X-Received: by 10.140.92.181 with SMTP id b50mr29192795qge.44.1456067470855;
        Sun, 21 Feb 2016 07:11:10 -0800 (PST)
Received: from traveller.moon ([177.94.146.172])
        by smtp.gmail.com with ESMTPSA id o203sm8467389qho.15.2016.02.21.07.11.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Feb 2016 07:11:10 -0800 (PST)
X-Google-Original-From: =?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?= <felipegassis@gmail.com>
X-Mailer: git-send-email 2.7.1.492.gc9722f8
In-Reply-To: <1456067358-19781-1-git-send-email-felipegassis@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286820>

Signed-off-by: Felipe Gon=C3=A7alves Assis <felipegassis@gmail.com>
---
 Documentation/merge-strategies.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-s=
trategies.txt
index ff359b6..2eb92b9 100644
--- a/Documentation/merge-strategies.txt
+++ b/Documentation/merge-strategies.txt
@@ -86,8 +86,8 @@ no-renames;;
 	See also linkgit:git-diff[1] `--no-renames`.
=20
 find-renames[=3D<n>];;
-	Turn on rename detection, optionally setting the the similarity
-	threshold. This is the default.
+	Turn on rename detection, optionally setting the similarity
+	threshold.  This is the default.
 	See also linkgit:git-diff[1] `--find-renames`.
=20
 rename-threshold=3D<n>;;
--=20
2.7.1.492.gc9722f8
