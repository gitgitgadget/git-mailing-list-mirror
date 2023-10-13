Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FAC224D4
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 17:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uo2zWXHZ"
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4646E3
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 10:39:34 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-406650da82bso23394355e9.3
        for <git@vger.kernel.org>; Fri, 13 Oct 2023 10:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697218772; x=1697823572; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Of14H8aaTA1vS9rFc7lVMyDUyHbOKSRPO29CF12VKc=;
        b=Uo2zWXHZka3M7jQ7/hEOzfKTt9teJlmHuYLci3BqBrLCT5DlxVcP5Pvx7N/InHdWbm
         rdLoWqyD6NXw/UDiHIAq3rO/u/t0DOviYdsHV3WPIIQikD0iUVZbpAyAET4U8OgU83uq
         ouzBtKILnIvAS0fqd06NrLSe3sFSyed7SqLiJOqpKryzsf/49LloJdYV4FYJ6izEMHaY
         JdpIQscUmyovlSDrJ7WhafLJUsDc3EPuVFy/6M5nZiQXE4jfd6Lz8AIoR1qOO5wd9oP/
         E504ZcHSgqgv8ESrcXiyR102+9GsNyz1DVlFSR7aEivz10jE48rVxyM7fZhbrYyBTyUt
         52zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697218772; x=1697823572;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Of14H8aaTA1vS9rFc7lVMyDUyHbOKSRPO29CF12VKc=;
        b=a/oA8hIrXrxUkHNeuicnXdkJdWZxzY7WwOxuhLDPgM5KoKn1/pS3NlMS55qRBT/vdd
         3B/RiVnrzPXLKGGgIfucekN5ESlSS4ZWbAvItPc0iA4HkayYA996tr6RT+OEjMl/owSm
         sSY5rL2YA/rBnZLzAgBCPDDy/bkP8VxDxpHleVTwTVem4N6RERtXHk/FCvKFWtaQKdML
         wj2SQJcEE2xCP5NLkIdz2+pMGPQML++k2CZBjy30FG48ZmYZvvyUPPG1MgRsKJxB6aEG
         d1eGiMHyBM5egtJzCn+2joi2wn7UgrvzmgQCeXgc25NC6WynhXfmAEpnzFLJAjdfJWxE
         aKbQ==
X-Gm-Message-State: AOJu0YwNDLiHsin4yySb9iDAHsrElxBQor9grsF8tA/1mIBWtsU5vHdE
	owEgtrYXNjg6+AJwe9GVNNe0GSEKpzQ=
X-Google-Smtp-Source: AGHT+IE6iLzQzLLbuCPuJ3gI9kyD5bM5sKuEtXCuwU8Al21Gd2d2urCIf9Sxdr9ebiUqfzKiWBRfVA==
X-Received: by 2002:a05:600c:4e0f:b0:406:4a32:1919 with SMTP id b15-20020a05600c4e0f00b004064a321919mr24492894wmq.29.1697218772045;
        Fri, 13 Oct 2023 10:39:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id fl20-20020a05600c0b9400b0040648217f4fsm686448wmb.39.2023.10.13.10.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 10:39:31 -0700 (PDT)
Message-ID: <pull.1577.v5.git.git.1697218770.gitgitgadget@gmail.com>
In-Reply-To: <pull.1577.v4.git.git.1697044422.gitgitgadget@gmail.com>
References: <pull.1577.v4.git.git.1697044422.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 13 Oct 2023 17:39:28 +0000
Subject: [PATCH v5 0/2] attr: add attr.tree config
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
Cc: Jeff King <peff@peff.net>,
    Jonathan Tan <jonathantanmy@google.com>,
    Eric Sunshine <sunshine@sunshineco.com>,
    John Cai <johncai86@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

44451a2e5e (attr: teach "--attr-source=" global option to "git", 2023-05-06)
provided the ability to pass in a treeish as the attr source. When a
revision does not resolve to a valid tree is passed, Git will die. At
GitLab, we server repositories as bare repos and would like to always read
attributes from the default branch, so we'd like to pass in HEAD as the
treeish to read gitattributes from on every command. In this context we
would not want Git to die if HEAD is unborn, like in the case of empty
repositories.

Instead of modifying the default behavior of --attr-source, create a new
config attr.tree with which an admin can configure a ref for all commands to
read gitattributes from. Also make the default tree to read from HEAD on
bare repositories.

Changes since v4:

 * removed superfluous test

Changes since v3:

 * clarified attr logic around ignoring errors if source set by attr.tree is
   invalid
 * refactored tests by using helpers
 * modified test to check for precedence between --attr-source, attr.tree,
   GIT_ATTR_SOURCE

Changes since v2:

 * relax the restrictions around attr.tree so that if it does not resolve to
   a valid treeish, ignore it.
 * add a commit to default to HEAD in bare repositories
 * remove commit that adds attr.allowInvalidSource

Changes since v1:

 * Added a commit to add attr.tree config

John Cai (2):
  attr: read attributes from HEAD when bare repo
  attr: add attr.tree for setting the treeish to read attributes from

 Documentation/config.txt      |  2 +
 Documentation/config/attr.txt |  7 ++++
 attr.c                        | 19 ++++++++-
 attr.h                        |  2 +
 config.c                      | 16 ++++++++
 t/t0003-attributes.sh         | 72 +++++++++++++++++++++++++++++++++++
 t/t5001-archive-attr.sh       |  2 +-
 7 files changed, 118 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/config/attr.txt


base-commit: 1fc548b2d6a3596f3e1c1f8b1930d8dbd1e30bf3
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1577%2Fjohn-cai%2Fjc%2Fconfig-attr-invalid-source-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1577/john-cai/jc/config-attr-invalid-source-v5
Pull-Request: https://github.com/git/git/pull/1577

Range-diff vs v4:

 1:  eaa27c47810 = 1:  eaa27c47810 attr: read attributes from HEAD when bare repo
 2:  749d8a8082e ! 2:  df4b3f53309 attr: add attr.tree for setting the treeish to read attributes from
     @@ t/t0003-attributes.sh: test_expect_success 'bare repository: check that .gitattr
      +	)
      +'
      +
     -+test_expect_success 'attr.tree points to non-existing ref' '
     -+	test_when_finished rm -rf empty &&
     -+	git init empty &&
     -+	(
     -+		cd empty &&
     -+		echo "f/path: test: unspecified" >expect &&
     -+		git -c attr.tree=refs/does/not/exist check-attr test -- f/path >actual 2>err &&
     -+		test_must_be_empty err &&
     -+		test_cmp expect actual
     -+	)
     -+'
     -+
      +test_expect_success 'bad attr source defaults to reading .gitattributes file' '
      +	test_when_finished rm -rf empty &&
      +	git init empty &&

-- 
gitgitgadget
