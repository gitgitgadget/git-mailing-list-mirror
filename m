From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 07/22] builtin/update-index.c: mark strings for translation
Date: Sat, 27 Feb 2016 13:41:58 +0700
Message-ID: <1456555333-5853-8-git-send-email-pclouds@gmail.com>
References: <1456555333-5853-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 27 07:42:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZYaZ-0003A5-7a
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 07:42:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756019AbcB0Gmr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Feb 2016 01:42:47 -0500
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33887 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751408AbcB0Gmr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2016 01:42:47 -0500
Received: by mail-pa0-f47.google.com with SMTP id fy10so62458878pac.1
        for <git@vger.kernel.org>; Fri, 26 Feb 2016 22:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M7Vn0V+MJqTw/OCUIghxhXvXc2T3JVTSqQoz3xRbmqM=;
        b=NY1Gft02VrPnRLlm10k6CW549Pzb/lySKNfuKoRzfK0GOoebk73+Xf1Zrfbxt0Pj13
         Lm5uwO+KR6vcyI3vkLLvi4AeNBCyGnMkibmgencJE3xVPmypdh2cH8IysLWNUS2BEIe0
         9uRDsmwd4/2lva5Pgq7SBF/2Q+eM2iv8M7TeExWwtB08Pb8aq1pgc/f9iV4GG/rV13Fd
         zKRY6KLVF53NsorcUzwUmUH+neqolcOxVYw0Cr2pqqbOcU8yaJwSU0n+jDv+jLYyLlf+
         I9Wj0d6h1HW8KvFpRi60uqIYDpD5NibKEQO//zyshycyQNK5wbNj0BPPqM+bi0IQNTzd
         M6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M7Vn0V+MJqTw/OCUIghxhXvXc2T3JVTSqQoz3xRbmqM=;
        b=QBq25K9ip+1A/cUPUKL4hFyathSO1B+WTZjtxC/EP0/BBprBJzhrv7pZdD7B2SG2PD
         UQXqBHRVHLHxfk5zdrkMFY7zGNiQTKcE0bw/vAI9W8RZ8RqOLhx/iTZf8d/UhD7iAAwD
         7YH26svUVjQYshFjxY4DB2/58QGZs3duHFP9/r6cJGrFc6Pt3t54HrFp6fn1iPRdYVU4
         fJWO4lVEfdbe6sJhNIQ2eBUgsNWGwGqgeKSoxd7LZYo3lPMX/ywluMPTeGrG77JfdaXU
         UFq7pBQyP5ARusB/QeM8VMDf9WfVELb7nADVe6+nmMpapLyHz/56OV1lS+zu1FUOQdp2
         gYZQ==
X-Gm-Message-State: AD7BkJIKqBLRtMsQsmNl3rLQwze+0WR3slZ12dulCN8XvNrm8UheAM+fVHVldqSlmH7tpA==
X-Received: by 10.66.251.65 with SMTP id zi1mr7625113pac.133.1456555366293;
        Fri, 26 Feb 2016 22:42:46 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id cs14sm23540776pac.10.2016.02.26.22.42.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Feb 2016 22:42:44 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 27 Feb 2016 13:43:18 +0700
X-Mailer: git-send-email 2.8.0.rc0.205.g7ec8cf1
In-Reply-To: <1456555333-5853-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287668>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/update-index.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 1c94ca5..21e38a8 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1127,9 +1127,9 @@ int cmd_update_index(int argc, const char **argv,=
 const char *prefix)
 		break;
 	case UC_DISABLE:
 		if (git_config_get_untracked_cache() =3D=3D 1)
-			warning("core.untrackedCache is set to true; "
-				"remove or change it, if you really want to "
-				"disable the untracked cache");
+			warning(_("core.untrackedCache is set to true; "
+				  "remove or change it, if you really want to "
+				  "disable the untracked cache"));
 		remove_untracked_cache(&the_index);
 		report(_("Untracked cache disabled"));
 		break;
@@ -1139,9 +1139,9 @@ int cmd_update_index(int argc, const char **argv,=
 const char *prefix)
 	case UC_ENABLE:
 	case UC_FORCE:
 		if (git_config_get_untracked_cache() =3D=3D 0)
-			warning("core.untrackedCache is set to false; "
-				"remove or change it, if you really want to "
-				"enable the untracked cache");
+			warning(_("core.untrackedCache is set to false; "
+				  "remove or change it, if you really want to "
+				  "enable the untracked cache"));
 		add_untracked_cache(&the_index);
 		report(_("Untracked cache enabled for '%s'"), get_git_work_tree());
 		break;
@@ -1156,7 +1156,7 @@ int cmd_update_index(int argc, const char **argv,=
 const char *prefix)
 			unable_to_lock_die(get_index_file(), lock_error);
 		}
 		if (write_locked_index(&the_index, lock_file, COMMIT_LOCK))
-			die("Unable to write new index file");
+			die(_("Unable to write new index file"));
 	}
=20
 	rollback_lock_file(lock_file);
--=20
2.8.0.rc0.205.g7ec8cf1
