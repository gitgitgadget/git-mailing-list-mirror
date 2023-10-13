Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7521B281
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 15:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WeU8pYbE"
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2AF3BB
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 08:33:50 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40566f89f6eso26589005e9.3
        for <git@vger.kernel.org>; Fri, 13 Oct 2023 08:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697211229; x=1697816029; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AVpvnB9M753gGgNXaIn4ROnH1N0A3RS89bo8xKPtoaw=;
        b=WeU8pYbEWCSqxaTLw6e43kscfNoeh7Ka5quwmazEV5rMpy0N6ZU6KH7hh98fnU5k0O
         JVijfNF9J2Sv4CsaplOrECRFCFxy5BEkbDbmrAwdMePegkOWZpzsTJ/7sFjtrbFjjVei
         abTL9vsHccoZTn/Q8f9oNqMxDbPlPIKX+lNPWy50Hktsc3J+g73bpIweLyY/3M6pFrNa
         aL/FV4U/4pOeGsl51xHz6iExQff3aouhh2GtbKytOt7qGEn50Ii/N+TJkKmSp9mITA72
         596ZIGfPn+BRkNQdDQPBYekSM65L4o6Qe/Q7ZgnRyvHS+anX4e9QAqtzHJVlIHCkaC2R
         THCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697211229; x=1697816029;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AVpvnB9M753gGgNXaIn4ROnH1N0A3RS89bo8xKPtoaw=;
        b=BobPuAEML9km9KpCvJVLXfPduonaJmepE7zLkZzW+bWXMnFhM6Ut50yZuxTLg1XFuB
         tJ5bt9VCYkf0m2a9AeMgKMKU6rddfgKkGGGNI0jx1Bvg0kVNzCxucsW7egXwmtTRF33L
         pq12FnmrUODcxUKewhBhuV64nCF9Uyp13OmaIaI4Vb0/3NTxtCtcZSt0xSStNqB5nqDP
         A5cSeiFIViVvcsC+54isiqLlq0ZVM6uREK/Q9n1zbH+KPyzwc2p4lVOPNFXfkJWdbVUb
         1TtlCL+u0IcckG/BLw3ZI9u02oCTwjy27DVAtmh57rbndstCc/rOTtKgPSuw5kgz4vCS
         p2ZQ==
X-Gm-Message-State: AOJu0Yzb57BBEhhWj5Z4KYX8tku2+FCyr0DdtkvvKU3O+bDQMPWhOrxo
	8NdzXk+ZpsdOjRU17MYTUuKsLqMx91g=
X-Google-Smtp-Source: AGHT+IFWhw4iZVwf44cwKIj6o2HrF6Fj6mpdbP3JfTLYA8Ny1X5d7ScxJ1WH8UQ3dluiN3tQjc8U7g==
X-Received: by 2002:a05:600c:1c96:b0:401:c944:a4d6 with SMTP id k22-20020a05600c1c9600b00401c944a4d6mr12492128wms.28.1697211228865;
        Fri, 13 Oct 2023 08:33:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t15-20020a05600c450f00b0040651505684sm437037wmo.29.2023.10.13.08.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 08:33:48 -0700 (PDT)
Message-ID: <pull.1590.git.git.1697211227.gitgitgadget@gmail.com>
From: "Isoken June Ibizugbe via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 13 Oct 2023 15:33:45 +0000
Subject: [PATCH 0/2] [Outreachy][PATCH v2] branch.c: adjust error messages to coding guidelines
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
Cc: Isoken June Ibizugbe <isokenjune@gmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

As per the CodingGuidelines document, it is recommended that a single-line
message provided to error messages such as die(), error() and warning(),
should start with a lowercase letter and should not end with a period.

Signed-off-by: Isoken June Ibizugbe isokenjune@gmail.com

Isoken June Ibizugbe (2):
  branch.c: ammend error messages for die()
  branch.c: adjust error messages to coding guidelines

 builtin/branch.c | 66 ++++++++++++++++++++++++------------------------
 1 file changed, 33 insertions(+), 33 deletions(-)


base-commit: aab89be2eb6ca51eefeb8c8066f673f447058856
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1590%2FJunie06%2Famend-error-mesg-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1590/Junie06/amend-error-mesg-v1
Pull-Request: https://github.com/git/git/pull/1590
-- 
gitgitgadget
