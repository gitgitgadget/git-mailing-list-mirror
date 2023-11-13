Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E181D6AE
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 10:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L4vp9rpJ"
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD188135
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 02:24:30 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-4083ac51d8aso34464725e9.2
        for <git@vger.kernel.org>; Mon, 13 Nov 2023 02:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699871068; x=1700475868; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ywu1GD0bcFiXazAsX1oenp5ZSAPvDc198d9KjKr5MKw=;
        b=L4vp9rpJ7DjUTZVEt1UibENvekbmJEFT0qJE4JeMp5EoYjwtC+ypKA1f9U6BbzEid5
         7871U2oH2EpB+jfOs1I+Ko71uSIg1GYvk5UhyN+hRDZio2619E98yugwJFyHlajgS52/
         G75t7qpPb6CJjeGQWM7JDR5HDlmaDveYcbM6uiKOkbkjgaa2Fojg4vU0OUPIOVlPMpB1
         SyByzd5ddFQrv5ygdl7bjz/nG5lQ8JVF2zoXzEuRBw1xl34VjRz1JcbU8f1fdheZfPxJ
         /E8WrbE03i6tEu0ALwMZDo7nhJuhal6EXdnNXyqeSWvK8lOK8XhPIy7y294h+cd6ZZni
         bm1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699871068; x=1700475868;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ywu1GD0bcFiXazAsX1oenp5ZSAPvDc198d9KjKr5MKw=;
        b=Kw5IfJAzVT9Ie3kWgy6XbeyJaQIG9WeWMUG60fZxFUlQHE2eL6fxC9fPEX1v3yOjSk
         jXQ5ZcWTTPafVygImMk+e7BwpHzggda82ixBEtgCucr/bmRyW420Bq/bk1rMCmqaW6iN
         RLDSBXNQy+VMuKX69tUYf2n0O3ueKXiVxfHaCKajWbWteW1+SkDGAfpW2OCLivYqX6T8
         6AepIbzkixI2HPSCoqsrnd66UaCoi6AJIP+noy0OUWQIoCcfStUeOOT7mJDyDTEPP1xD
         yoNmc7Ut5kdt4s42/FszvaYsBpLVXacg9JZEsKdbpNml2AqcC+zoh/DVu2G25rtfxSBP
         9vOA==
X-Gm-Message-State: AOJu0YxUwDiPEYc1WHrYZeHp8XVGrrgQHQtTEBjb15PEtapdTeidiB0V
	HmoQU1NaYzD07P58zbM2YEIDNfEdpCQ=
X-Google-Smtp-Source: AGHT+IHxW4fILADjsVNUxP8ObPMZP5Xdhxf9Iaq3zY+FO+KrKQ57zJFCmnqG6Jj4Vo0mAezvqIidIA==
X-Received: by 2002:a05:600c:3b8b:b0:405:348e:aa43 with SMTP id n11-20020a05600c3b8b00b00405348eaa43mr5283502wms.12.1699871068617;
        Mon, 13 Nov 2023 02:24:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r21-20020a05600c35d500b00407efbc4361sm13391502wmq.9.2023.11.13.02.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 02:24:28 -0800 (PST)
Message-ID: <804624950aee9112b2ba88dd8f489b91a5392ad3.1699871056.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1537.git.git.1699871056.gitgitgadget@gmail.com>
References: <pull.1537.git.git.1699871056.gitgitgadget@gmail.com>
From: "Haritha D via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 13 Nov 2023 10:24:15 +0000
Subject: [PATCH 13/13] Handled git pipeline errors - z/OS enable
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Haritha  <harithamma.d@ibm.com>,
    Haritha D <harithamma.d@ibm.com>

From: Haritha D <harithamma.d@ibm.com>

This PR has fixes to enable build on z/OS

Signed-off-by: Harithamma D <harithamma.d@ibm.com>
---
 convert.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/convert.c b/convert.c
index 4c034bb714c..c66f5b3ecec 100644
--- a/convert.c
+++ b/convert.c
@@ -1315,7 +1315,6 @@ static struct attr_check *check;
 
 static void get_platform(char** result) {
 	struct utsname uname_info;
-	*result = NULL;
 
 	if (uname(&uname_info) < 0)
 		die(_("uname() failed with error '%s' (%d)\n"),
@@ -1346,11 +1345,10 @@ void convert_attrs(struct index_state *istate,
 {
 	struct attr_check_item *ccheck = NULL;
 	struct strbuf platform_working_tree_encoding = STRBUF_INIT;
-	char* result=NULL;
+	char* result="Unknown";
 	get_platform(&result);
 	strbuf_addf(&platform_working_tree_encoding, "%s-working-tree-encoding", result);
-	if (result != NULL)
-		free (result);
+	free (result);
 
 	if (!check) {
 		check = attr_check_initl("crlf", "ident", "filter",
-- 
gitgitgadget
