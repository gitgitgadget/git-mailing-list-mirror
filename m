From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/4] git-apply.txt: remove a space
Date: Thu, 24 Mar 2016 18:56:16 +0700
Message-ID: <1458820579-31621-2-git-send-email-pclouds@gmail.com>
References: <CACsJy8CTix-ZwN04MwYTB+JEtDCV27QVf7_0vWmhUSVCwU29Jg@mail.gmail.com>
 <1458820579-31621-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, sbeller@google.com,
	mehul.jain2029@gmail.com, sandals@crustytoothpaste.net,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 24 12:57:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aj3tN-00019Q-04
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 12:57:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751577AbcCXL5W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Mar 2016 07:57:22 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:35493 "EHLO
	mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751340AbcCXL5V (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 07:57:21 -0400
Received: by mail-pf0-f169.google.com with SMTP id n5so55199280pfn.2
        for <git@vger.kernel.org>; Thu, 24 Mar 2016 04:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y4lvUTFdlvgcXb9zEiJtbdo8DRWiVaZHOKoVlqWypVs=;
        b=fZefaQA86p/K/YR9nsNpwfeMpNawS0MavqAX3vq4Ftu7auFyUXG9dfTLqW3t1uhpnt
         EAMz7rPHGI8XUpdTuD0L5XCEmBBPyzIXJnOOzDaGctbwdasicMPu7L3psm53dCq7TWNH
         1XkIaW79wud6O7mmKXIQkarA+EkBatHpSzoemQUBHWB63t/JrXSlPV6263KIL1qBvDLs
         QPAz36rrwP9RjfaJdDFGjIjudnt5x9b47cmMr+X/5L2CEAy8QSRbmtqLr3sKEDss3Sxg
         4MWOGE48IpzNii96u3As1Ig2aY65xHKkAORsJ7ePmglMEil/6FyzM8fkOY82jMG+6QId
         ZrTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y4lvUTFdlvgcXb9zEiJtbdo8DRWiVaZHOKoVlqWypVs=;
        b=mry7u9ya4Gto2e0dA3putJ2WPOuPKgcOtK1PBL/5ykLkRPySv3/l0nuYxRYXVNs3ED
         ILTD8QH6h39j7dP41D7uXLWbOh3hQ3TLpTVBHdG00smy4KP0JzjPr7l29W2f/0x/O6xh
         oAThC061jurPylWBVzAaOxtQM7UpG3U/Z8oPhCAn0vwbJsyNOxqdKWgFWOwG0uyBadv0
         JDQjc2WnpOfEMQKzptooeP4sxtu04xj9uMVabMT01Pi1i8LaedbQHphcWmzEj/G11xiD
         ds5fKoQzfQE15uFYLYfhekS9knKBxuBqAwlQ1HXpe617cI4gfPlHmZX46azSwFCA/OUa
         lxbA==
X-Gm-Message-State: AD7BkJKHRTEl9z6wJEBOlWs/MUcdVf+44b4wqmzMdYkfBgIGdA93hdhrIXboOet/T30Nyg==
X-Received: by 10.98.71.86 with SMTP id u83mr12101621pfa.156.1458820640397;
        Thu, 24 Mar 2016 04:57:20 -0700 (PDT)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id f65sm9989033pfd.47.2016.03.24.04.57.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Mar 2016 04:57:19 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Thu, 24 Mar 2016 18:57:33 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1458820579-31621-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289738>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-apply.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index d9ed6a1..5444d2f 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 	  [--apply] [--no-add] [--build-fake-ancestor=3D<file>] [-R | --rever=
se]
 	  [--allow-binary-replacement | --binary] [--reject] [-z]
 	  [-p<n>] [-C<n>] [--inaccurate-eof] [--recount] [--cached]
-	  [--ignore-space-change | --ignore-whitespace ]
+	  [--ignore-space-change | --ignore-whitespace]
 	  [--whitespace=3D(nowarn|warn|fix|error|error-all)]
 	  [--exclude=3D<path>] [--include=3D<path>] [--directory=3D<root>]
 	  [--verbose] [--unsafe-paths] [<patch>...]
--=20
2.8.0.rc0.210.gd302cd2
