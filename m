From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 01/22] credential-cache--daemon: enable localized messages
Date: Sat, 27 Feb 2016 13:41:52 +0700
Message-ID: <1456555333-5853-2-git-send-email-pclouds@gmail.com>
References: <1456555333-5853-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 27 07:42:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZYZi-0002f2-Ra
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 07:41:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752907AbcB0Gly convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Feb 2016 01:41:54 -0500
Received: from mail-pf0-f180.google.com ([209.85.192.180]:35231 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752675AbcB0Glx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2016 01:41:53 -0500
Received: by mail-pf0-f180.google.com with SMTP id w128so16202118pfb.2
        for <git@vger.kernel.org>; Fri, 26 Feb 2016 22:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k//yEdK+WsgjmAdseFW4g6KdzL4cjAW2KWeN/Jipmn8=;
        b=fZji7pjjCc5eyt+YfuygJXjKMxRMz4xEseKJU2h6GN8f23T1BYhX4/zDjB1eiyyzUT
         +zSySvTQWACfnKkoehVbq/lmFz/ECrgxjbI5VjX8adiCW8G8PfqMQeEEMIKSmO8huzX3
         WuHwY/BTqyEf4mJ8lLYDhI4/k/uQxkN50FLeSsqqtFDtLKiCNw5dLZcRyl1w5J/8NF5q
         nS9t35in/RPXRBJDHsoAF4E3oV7CqMM4z5neDDmDBkmwoZ9aOp2l0NRXmm6/k2+xPu7q
         ReHqdR+13HVR6U34zqakCAco3YSatOddM3U8u5lY8U1ElxCcqgikfANX6qEoM6Sz5kvG
         xt6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k//yEdK+WsgjmAdseFW4g6KdzL4cjAW2KWeN/Jipmn8=;
        b=GYaaJkampJZVT5wpMc6B1GW4rjT7gCisVsG+DrLsffqWxV+Wy+Gp5sc4xUyRtJeDdl
         sD61Elm60tQlU1IuVCOnU7ZeBBoKjSg6RaUdm8yTNqLOb2qE0/4fw7V6ftDWpidwjAzC
         XnYV7YrIB0w3N8li8DYgp/ssvGlmw/xCH1CJYtB7zMJJpdvQ+7y1Wra9OMjiVqikj7OW
         oa/zm52n6byzhOPf/C98XqSOIethep7rFLXj/i2LwMTrhLnUeRHsq0Sbo0TpQulDVABf
         TTPJ63jPo1NR2vSTzOVr66+Z0GCZeMumQvA7q2oMiSu3we3enR6uJO4+cOvTZg7F/ENS
         yb6Q==
X-Gm-Message-State: AD7BkJKYVX4Z9ymKHUKknHqqPYX4nwgI3QrsJde5FRehJZGamweDCaIGHPmjALqjbtqgwQ==
X-Received: by 10.98.7.219 with SMTP id 88mr7593237pfh.49.1456555312415;
        Fri, 26 Feb 2016 22:41:52 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id o184sm23483403pfo.36.2016.02.26.22.41.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Feb 2016 22:41:50 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 27 Feb 2016 13:42:25 +0700
X-Mailer: git-send-email 2.8.0.rc0.205.g7ec8cf1
In-Reply-To: <1456555333-5853-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287662>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 credential-cache--daemon.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/credential-cache--daemon.c b/credential-cache--daemon.c
index caef21e..63ca7c8 100644
--- a/credential-cache--daemon.c
+++ b/credential-cache--daemon.c
@@ -263,6 +263,8 @@ int main(int argc, const char **argv)
 		OPT_END()
 	};
=20
+	git_setup_gettext();
+
 	git_config_get_bool("credentialcache.ignoresighup", &ignore_sighup);
=20
 	argc =3D parse_options(argc, argv, NULL, options, usage, 0);
--=20
2.8.0.rc0.205.g7ec8cf1
