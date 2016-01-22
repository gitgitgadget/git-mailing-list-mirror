From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 1/2] worktree.c: fix indentation
Date: Fri, 22 Jan 2016 15:35:48 +0700
Message-ID: <1453451749-10660-2-git-send-email-pclouds@gmail.com>
References: <1453116094-4987-1-git-send-email-pclouds@gmail.com>
 <1453451749-10660-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 22 09:36:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMXCS-0004qj-3a
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jan 2016 09:36:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751972AbcAVIgF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Jan 2016 03:36:05 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35138 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751599AbcAVIgC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2016 03:36:02 -0500
Received: by mail-pf0-f193.google.com with SMTP id 65so2975769pff.2
        for <git@vger.kernel.org>; Fri, 22 Jan 2016 00:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=gQgQHzSw4a4UTANATZpXUdW8GZestkeD2yjBiYN0JEc=;
        b=0Xn7Fr7r+DQdNGjdtYwIwhurdBRBon1+gzsn2PCc8etnd7NO5ptwfUOisRFndvnJtt
         wzMs50YB20vD6/1Up4YDglEU77UZStq9NbZU25LoDKx8GrA4LWSu8sLKkRcQ7b7lPcUM
         PBsPSsXdCXvcuLWJtplrpSrmwtwqQOSVWteM2TKQwStm/FJ/urfUyQP6kPpcE7Is8/Lp
         kiu+QNbWVONoj6IYIqOqQ9bUEy6T/KrVgJeKbzDv1bnSEW4vWC9/tUtdc+vDHbYKKYVr
         x5xjxtq1u7byfs5H02l+PhMv2xfyjLq3OPdT7YI0aXFwnP98ZhcYw/umamLmQG2xsU5f
         tgSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=gQgQHzSw4a4UTANATZpXUdW8GZestkeD2yjBiYN0JEc=;
        b=Q6ihYAN1vviIMM26o2q+OvmmN3m/MV8r1JMcntpjGWT/wRzi1FAr2wQ3jWutIyATHA
         +k8wL8/O/8zhIzY+gCNdZU4DxB2tNR6yprYUCue3kmDgJkyb/qWDemwhcIM0zRs0Skne
         zaxtXoMIvo0d3ztlMvKKtZD+4iWyh68e0FrlN7HdkNzfr2kBBC31jUMtW3FmaiChsrtm
         sVbS9J8Pfd0qeEz6Bx0tyhR7w+aBPcfEmHnC47D4g1IfkbdNJ9N7xSj5wfCqPOlLFDSb
         aHmbQ6HP1hfj1LZH/mJFqfEk5aYxTL4wh06n+0H0eAATM4XxCGaN5QkwFSj+3Dyczguj
         u4AQ==
X-Gm-Message-State: AG10YOQaEao7NwEFJpzFOSzGn3jV9iOPHdv2DRBVRxYcmiUE8khLTp+xHMk/Ub/doEeKKw==
X-Received: by 10.98.14.157 with SMTP id 29mr2617316pfo.35.1453451761339;
        Fri, 22 Jan 2016 00:36:01 -0800 (PST)
Received: from lanh ([115.72.43.83])
        by smtp.gmail.com with ESMTPSA id q27sm7753020pfi.80.2016.01.22.00.35.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jan 2016 00:36:00 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Fri, 22 Jan 2016 15:35:59 +0700
X-Mailer: git-send-email 2.7.0.125.g9eec362
In-Reply-To: <1453451749-10660-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284550>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 worktree.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/worktree.c b/worktree.c
index 981f810..6181a66 100644
--- a/worktree.c
+++ b/worktree.c
@@ -176,10 +176,10 @@ struct worktree **get_worktrees(void)
 			if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
 				continue;
=20
-				if ((linked =3D get_linked_worktree(d->d_name))) {
-					ALLOC_GROW(list, counter + 1, alloc);
-					list[counter++] =3D linked;
-				}
+			if ((linked =3D get_linked_worktree(d->d_name))) {
+				ALLOC_GROW(list, counter + 1, alloc);
+				list[counter++] =3D linked;
+			}
 		}
 		closedir(dir);
 	}
--=20
2.7.0.125.g9eec362
