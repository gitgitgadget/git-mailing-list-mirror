Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E64761F4BD
	for <e@80x24.org>; Tue,  8 Oct 2019 16:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbfJHQkm (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Oct 2019 12:40:42 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35166 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfJHQkm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Oct 2019 12:40:42 -0400
Received: by mail-wr1-f65.google.com with SMTP id v8so20217517wrt.2
        for <git@vger.kernel.org>; Tue, 08 Oct 2019 09:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MEG5Xhyo7BvY2G1FNT9+MqCFsbbuFxpOzdrYKPZ/xqQ=;
        b=huqDaOdWLuMX2oYpiPd8QEl1O5wlcdEj/gDG3kHiyVaZY/mHTnh9YvbtyYEPXp+1A7
         KHxf3PKO3nq4nf0Ydk3JuXbzNjOqrd/0uQhvR8nNt08fQ06OwO44OhXLEmE6MGaMbJD0
         ZkEw3PWTey69oqI+xOYV5cYsTKlpNl6ndbDNPk08IWJWEgdxNNgriFKvYGKS0qfrmDkk
         9uMHtQx+w3YLNEdekcNajGTc73anr7g2puUwoGBHdWy88wYPy68R2lIrWUzfhhuQKqGb
         N9GqFPzJI6yxwBd/PTuU/b18cUQSo5Yf9pgspS4DUnc5F8YjFf85imy4UieMGyfmjOZF
         7ksA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MEG5Xhyo7BvY2G1FNT9+MqCFsbbuFxpOzdrYKPZ/xqQ=;
        b=hdFf78lt5PavP4agM+fnQgBSQTPQZXSOF1/E81gZsYE7VpNMN62AuFFi03uqltVG3o
         9J0MXlZEak3RaStxWusqDXs4LCHASQx0e7tKtWByhxPUbPLsRm5LVAr9eORTSrHxme5M
         hXvbZYwAaiAILODcCuJzXLtJ+Bwewac2PVvDEWqehJUz8579euNtUIboJvd9V0BpFN0E
         9/mrBnXQrEow1zT3HBVD+M1Cz+Aym5PC2pp7sDgLWTC35DX0w9h3vTr5C4LLhcDyI+QZ
         6SoZsW/cu3Q2Yuob2XRco3HpNlg1uq4qd20g3xx7n9vG6FZR52J2TE2HTgXPKCKL1g74
         nzmA==
X-Gm-Message-State: APjAAAW2SO+oK2Z9e2R5zu60RKZsqev3UUT7/zeQIixukbj9Zyn8tONY
        iMW4K9oYDmRNwSv8BAywR0Kk2rH8
X-Google-Smtp-Source: APXvYqxWe4Z8Ffi/09ajstWBcbWFXdkvGfhyy9v8dwejIU54FjMVKQfgoi30YSY8fbNLUMbNGpdbDA==
X-Received: by 2002:adf:f7c3:: with SMTP id a3mr15148812wrq.275.1570552839816;
        Tue, 08 Oct 2019 09:40:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s13sm3769574wmc.28.2019.10.08.09.40.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Oct 2019 09:40:39 -0700 (PDT)
Date:   Tue, 08 Oct 2019 09:40:39 -0700 (PDT)
X-Google-Original-Date: Tue, 08 Oct 2019 16:40:37 GMT
Message-Id: <pull.314.v5.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.314.v4.git.gitgitgadget@gmail.com>
References: <pull.314.v4.git.gitgitgadget@gmail.com>
From:   "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 0/1] quote: handle null and empty strings in sq_quote_buf_pretty()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     garimasigit@gmail.com, jeffhost@microsoft.com, stolee@gmail.com,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey,

Empty arguments passed on the command line can be a represented by a '',
however sq_quote_buf_pretty was incorrectly dropping these arguments
altogether. Fix this problem by ensuring that such arguments are emitted as
'' instead.

Looking forward to your review. Cheers! Garima Singh

Reported by: Junio Hamano gitster@pobox.com [gitster@pobox.com] in
https://public-inbox.org/git/pull.298.git.gitgitgadget@gmail.com/T/#m9e33936067ec2066f675aa63133a2486efd415fd

Garima Singh (1):
  sq_quote_buf_pretty: don't drop empty arguments

 quote.c          | 6 ++++++
 t/t0014-alias.sh | 7 +++++++
 2 files changed, 13 insertions(+)


base-commit: 5fa0f5238b0cd46cfe7f6fa76c3f526ea98148d9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-314%2Fgarimasi514%2FcoreGit-fixQuote-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-314/garimasi514/coreGit-fixQuote-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/314

Range-diff vs v4:

 1:  a6a0217ce6 ! 1:  412626ccf9 sq_quote_buf_pretty: don't drop empty arguments
     @@ -17,9 +17,6 @@
       	static const char ok_punct[] = "+,-./:=@_^";
       	const char *p;
       
     -+	if (!src) 
     -+		BUG("Cannot append a NULL token to the buffer");
     -+	
      +	/* Avoid losing a zero-length string by adding '' */ 
      +	if (!*src) {
      +		strbuf_addstr(dst, "''");

-- 
gitgitgadget
