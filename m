Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gw+dqwxb"
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F43EB
	for <git@vger.kernel.org>; Sun,  3 Dec 2023 09:20:23 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-5ab94fc098cso838082a12.1
        for <git@vger.kernel.org>; Sun, 03 Dec 2023 09:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701624022; x=1702228822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+algy0ElvXrsKHHJ4iZLzy5N/HX4WpmYP1J1FlKTUJo=;
        b=gw+dqwxbPKjb5Oe/s6euoBLmvTCJjh+WtGXSkE3F4D4FK39Q1NpqlEJNZs58Zy+DzK
         gXFybSYMkh62Qzt1Ctmh15Qo9CFdn5SYKyRMWL2jSU1x2H6m1vU5nRnpGtePgOSbLqRj
         uupYBE4cSlrp83N81yxTY70S5Ont/8imv3+x/Idn01PdLFRKWBYvS2Woz4xvjPQRBnjh
         WBOkfzDneElmiPDlP1eMOG7ewiFZvuRqU8OPaUlI02ezOBFp5xE6I+f70bDAYuSjvwN0
         8aDtYSDt25fkrgwgjmN7jngOCsvPPbYlHJ9GbmoXI+0zQrXy+6DRX8SOaaS8xZqibpjY
         Ix7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701624022; x=1702228822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+algy0ElvXrsKHHJ4iZLzy5N/HX4WpmYP1J1FlKTUJo=;
        b=lYkEe0qVkRMj22/KcfvFYmgp3R7Ux9tAdAOuVeYA8r5RSLzVv1IS/AmquogFYcAqvd
         mgM30XIuEaIJxAykn5nWLuy2F0pZD7tTViVYsaI9D02LnzKLNOEhArO0kmqrKH4KH/o+
         u2s5WDpUdfF45e3tvFctqvrVT56Mmj7idKC1050Ff+YmL++xB1UGdxoWjYHnMBWq8nwd
         1IMEZa4gbJJ/7WmPFRnyx4vOGYtwpWa2kvKZfNpklEMZfpNmEqBvXTWQgWZ16jrKM9rd
         a3reR267Ym1XyfUaBwawcSwKNcsYP8FKbmaEZv3VIqHNc49LTpuxZPD/jjXUxoRvuwza
         FOEw==
X-Gm-Message-State: AOJu0YyszEsQ97qjjn2GvbjZngWRg03Swsu2HsyyzVJyZd8LZPQQE9vk
	hwY+kNAXAJLFcHg67WYuAG812TiLKWs=
X-Google-Smtp-Source: AGHT+IF9gffZUqKPfVQ2bRjzzf4DMQNTptYO5kYHF00lAGaDOQSIHhomhxo76tiWy6bOIMpEWXdQ4w==
X-Received: by 2002:a05:6a20:42a0:b0:17d:f127:d435 with SMTP id o32-20020a056a2042a000b0017df127d435mr782388pzj.45.1701624022468;
        Sun, 03 Dec 2023 09:20:22 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:1f38:f8b:64f3:df46:3399:9fcc])
        by smtp.gmail.com with ESMTPSA id r10-20020a63ce4a000000b00588e8421fa8sm6383937pgi.84.2023.12.03.09.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 09:20:22 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: five231003@gmail.com,
	gitster@pobox.com,
	shreyp135 <shreyanshpaliwalcmsmn@gmail.com>,
	Shreyansh Paliwal <Shreyanshpaliwalcmsmn@gmail.com>
Subject: [PATCH v2] test-lib-functions.sh: fix test_grep fail message wording
Date: Sun,  3 Dec 2023 22:47:59 +0530
Message-ID: <20231203171956.771-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <CAPYXD64yCuMta_iGE+ZwgxrJn0U5shcwcB9jaiNkFhvff=R7MQ@mail.gmail.com>
References: <CAPYXD64yCuMta_iGE+ZwgxrJn0U5shcwcB9jaiNkFhvff=R7MQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: shreyp135 <shreyanshpaliwalcmsmn@gmail.com>

In the recent commit
2e87fca189 (test framework: further deprecate test_i18ngrep, 2023-10-31),
the test_i18ngrep() function was deprecated.

So if a test employing this function fails,
the error messages may be confusing due to wording issues.

It's important to address these wording changes to ensure smooth transitions
for developers adapting to the deprecation of test_i18ngrep,
and to maintain the effectiveness of the testing process.

Signed-off-by: Shreyansh Paliwal <Shreyanshpaliwalcmsmn@gmail.com>
---
 t/test-lib-functions.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 9c3cf12b26..8737c95e0c 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1277,7 +1277,7 @@ test_grep () {
 	if test $# -lt 2 ||
 	   { test "x!" = "x$1" && test $# -lt 3 ; }
 	then
-		BUG "too few parameters to test_i18ngrep"
+		BUG "too few parameters to test_grep"
 	fi
 
 	if test "x!" = "x$1"
-- 
2.43.0.1

