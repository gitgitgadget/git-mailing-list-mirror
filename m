Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C111799D
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 07:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IfHw/TYI"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-336755f1688so1128794f8f.0
        for <git@vger.kernel.org>; Tue, 19 Dec 2023 23:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703056002; x=1703660802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tcMYlHqsoeFI15dIVHcKU4Atjpb5o3O28qCoUIX+7+0=;
        b=IfHw/TYImsNZ9PmqD4BWIby71IL+r5QWIvI0f/1GC9HDzcWzGHHaUJT7yHJThDPKuQ
         jtBu/5VV5UjLDI3wWubScMBdZNSHzfh1xx/iZ3Tm96QFwgPOHgBGjA7JpSFZFPBmR3l/
         4tM7m9ow1tE1oFzVnPms1wafBR3ruDSdsWtwSZkizLyqhDz/1xX7HsWGP6RuFPpU2Cpp
         P3QDbMfzKkC5TpuxMkJyksZ7Z65Y7JM1Btv9Br1TDNtbwAtvi2OXInVHfXpNTa71KuKq
         RH4FecQhHVTkqbOsBhn3Qbsl0pr7GpbgKNMjNQBpuAZheeeuaqJ30WOVSHhkky42rDzL
         Cmbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703056002; x=1703660802;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tcMYlHqsoeFI15dIVHcKU4Atjpb5o3O28qCoUIX+7+0=;
        b=Lpqwiy1Q5vmTqAc0vG5AA1CDHI5wjBi2+udRdZAQL6J3u+f3T0bAKdK1YqNgphBb9E
         0jToVFLlXWnvlYdtYZ0hzFF7vr8a84mloOV0XKEx5PaDDhYlXVq1jMx5hKXxG+fjSVq8
         bhmbVU0ElKdcJKJrTf6zrO0t0hUaTsnf1f4ejWp8NLAU4S3SFj1sSwIlkcxPAJW4HTMW
         7EHX/7XFmrGVi6s/ZeMYBCpRUbkgJcozIo4dMDb/fXGMQEFCzgzF0HVtbjJQO7QqE7GM
         Q+wYkQlknPI6YCGX3a55u1Sgak1acdON3oQp8W+Ie9o8bOEN0fZ19zjy/0vK9mf9zK8F
         W5bA==
X-Gm-Message-State: AOJu0YzOpwCdxJIrp2CgFX7e8QGtDFrLIh/3h06VC1Mv9kRzxlQgc/Fc
	qBCE4sttkZ7Mzr3/nYgLNSCUw+06SRgxHg==
X-Google-Smtp-Source: AGHT+IHIVIvNwoWXaZ60bo1edCthf1mGZoBnakQYoT+yuRzkzeCTJau/5SLIbNLE3A3tXLaLLpflGw==
X-Received: by 2002:a05:600c:2048:b0:40c:692f:3413 with SMTP id p8-20020a05600c204800b0040c692f3413mr4727503wmg.77.1703056001412;
        Tue, 19 Dec 2023 23:06:41 -0800 (PST)
Received: from Michaels-MBP.fritz.box (2001-4dd7-e0bf-0-e5b0-3039-5d18-ec57.ipv6dyn.netcologne.de. [2001:4dd7:e0bf:0:e5b0:3039:5d18:ec57])
        by smtp.gmail.com with ESMTPSA id g3-20020a05600c310300b0040c6b2c8fa9sm6107373wmo.41.2023.12.19.23.06.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 19 Dec 2023 23:06:31 -0800 (PST)
From: Michael Lohmann <mial.lohmann@gmail.com>
X-Google-Original-From: Michael Lohmann <mi.al.lohmann@gmail.com>
To: git@vger.kernel.org
Cc: Michael Lohmann <mi.al.lohmann@gmail.com>
Subject: [PATCH] Documentation/git-merge.txt: fix reference to synopsys
Date: Wed, 20 Dec 2023 08:05:28 +0100
Message-Id: <20231220070528.8049-1-mi.al.lohmann@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

437591a9d738 changed the synopsys from two separate lines for `--abort`
and `--continue` to a single line (and it also simultaneously added
`--quit`). That way the "enumeration" of the syntax for `--continue` is
no longer valid. Since `--quit` is now also part of the same syntax
line, a general statement cannot be made any more. Instead of trying to
enumerate the synopsys, be explicit in the limitations of when
respective actions are valid.

This change also groups `--abort` and `--continue` together when
explaining the circumstances under which they can be run in order to
avoid duplication.

Signed-off-by: Michael Lohmann <mi.al.lohmann@gmail.com>
---
 Documentation/git-merge.txt | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index e8ab340319..d8863cc943 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -46,21 +46,20 @@ a log message from the user describing the changes. Before the operation,
     D---E---F---G---H master
 ------------
 
-The second syntax ("`git merge --abort`") can only be run after the
-merge has resulted in conflicts. 'git merge --abort' will abort the
-merge process and try to reconstruct the pre-merge state. However,
-if there were uncommitted changes when the merge started (and
-especially if those changes were further modified after the merge
-was started), 'git merge --abort' will in some cases be unable to
-reconstruct the original (pre-merge) changes. Therefore:
+It is possible that a merge failure will prevent this process from being
+completely automatic. "`git merge --continue`" and "`git merge --abort`"
+can only be run after the merge has resulted in conflicts.
+
+'git merge --abort' will abort the merge process and try to reconstruct
+the pre-merge state. However, if there were uncommitted changes when the
+merge started (and especially if those changes were further modified
+after the merge was started), 'git merge --abort' will in some cases be
+unable to reconstruct the original (pre-merge) changes. Therefore:
 
 *Warning*: Running 'git merge' with non-trivial uncommitted changes is
 discouraged: while possible, it may leave you in a state that is hard to
 back out of in the case of a conflict.
 
-The third syntax ("`git merge --continue`") can only be run after the
-merge has resulted in conflicts.
-
 OPTIONS
 -------
 :git-merge: 1
-- 
2.39.3 (Apple Git-145)

