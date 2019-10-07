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
	by dcvr.yhbt.net (Postfix) with ESMTP id 526DC1F4BE
	for <e@80x24.org>; Mon,  7 Oct 2019 19:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728846AbfJGTi7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 15:38:59 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39776 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728325AbfJGTi6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 15:38:58 -0400
Received: by mail-wm1-f66.google.com with SMTP id v17so691492wml.4
        for <git@vger.kernel.org>; Mon, 07 Oct 2019 12:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BkqkPKjAtIphEqiNx5k3kmCK4M48cTy4kxWQnQwI9rY=;
        b=M87izIAF6sXOrFVENHsE+rf3dV8U6WpO7FQln3IGeh7X+vm9m3fbrcSo8Q46iFjWzu
         YgMuC1SL0oGrMFzNUS4s+uZ4uJ3nYaQjWKVgt/w2E5llIqM8SHcLij30C6THrcpkDQ5P
         zgiw1/v6iGUmZ9dfC6b1bWmY0f85Hzmm5KW2bv1TiF0UaInmF0eTWHcxf9k9BdtoU1Eh
         G50giZ2qWK3Hjw69sWAa31fSv3K5J5cGXMatcjBjelq92Z2oSWjGjn5GCugtoRDHc0D5
         9FpHvj3A9Ne4zQ7iDwCI9Iy0G+pcuysSwUDibqQpERwiEHeXz3aSqKmUTMkL01Xzb+cJ
         jdDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BkqkPKjAtIphEqiNx5k3kmCK4M48cTy4kxWQnQwI9rY=;
        b=j8zf0vIWRdal7CJ8/+zhxkQ+vMDmY2gMwFxhYqGFlVVjK2CTrdsJaIy28YCpSTgdWl
         eiCgHUUvVQew1LKgNEiDrAXy2r617PpVjqaGpUEd4sJVtlmvRg3PtjqGrRXaZIsDZF8b
         U+b+d/K2s4H5zW5wMaecUuZt+FpwHp28eCSPx7xzr1hceq0lJAWy9o9e8qWG0eadDtG6
         l5wl71wrYrrlDfeEtqpfPK3yPdkSqJS7U1ht/zlzbGISbJirLsTuk+IFZ58bx9qN37bg
         7C+qHBDUO5TaoAxkthwBFl5camKekcqdQdCOX3bFyV4bhd6WCNjgdnS0O5kf9qcCbGCK
         WOQg==
X-Gm-Message-State: APjAAAV1arbHQ0O0grgEIZ6Eve4cxPjZstKavLQhrK08h694TmfYTT8E
        vJMsdgalnJ2RyBKB3uhrreHWuEX8
X-Google-Smtp-Source: APXvYqwVdRGWSEfEuYswMhKJ+OF6gTD8kt+oa4Bwzd/werNlaY7BkJvbo8VUbx/irHffOeXyn57ZPg==
X-Received: by 2002:a1c:2e50:: with SMTP id u77mr744646wmu.64.1570477136506;
        Mon, 07 Oct 2019 12:38:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u10sm588175wmm.0.2019.10.07.12.38.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2019 12:38:56 -0700 (PDT)
Date:   Mon, 07 Oct 2019 12:38:56 -0700 (PDT)
X-Google-Original-Date: Mon, 07 Oct 2019 19:38:53 GMT
Message-Id: <pull.314.v4.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.314.v3.git.gitgitgadget@gmail.com>
References: <pull.314.v3.git.gitgitgadget@gmail.com>
From:   "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 0/1] quote: handle null and empty strings in sq_quote_buf_pretty()
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

 quote.c          | 9 +++++++++
 t/t0014-alias.sh | 7 +++++++
 2 files changed, 16 insertions(+)


base-commit: 5fa0f5238b0cd46cfe7f6fa76c3f526ea98148d9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-314%2Fgarimasi514%2FcoreGit-fixQuote-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-314/garimasi514/coreGit-fixQuote-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/314

Range-diff vs v3:

 1:  399fe02cb1 ! 1:  a6a0217ce6 quote: handle numm and empty strings in sq_quote_buf_pretty
     @@ -1,13 +1,11 @@
      Author: Garima Singh <garima.singh@microsoft.com>
      
     -    quote: handle numm and empty strings in sq_quote_buf_pretty
     +    sq_quote_buf_pretty: don't drop empty arguments
      
     -    The sq_quote_buf_pretty() function does not emit anything
     -    when the incoming string is empty, but the function is to
     -    accumulate command line arguments, properly quoted as
     -    necessary, and the right way to add an argument that is an
     -    empty string is to show it quoted, i.e. ''. We warn the caller
     -    with the BUG macro is they pass in a NULL.
     +    Empty arguments passed on the command line can be a represented by
     +    a '', however sq_quote_buf_pretty was incorrectly dropping these
     +    arguments altogether. Fix this problem by ensuring that such
     +    arguments are emitted as '' instead.
      
          Reported by: Junio Hamano <gitster@pobox.com>
          Signed-off-by: Garima Singh <garima.singh@microsoft.com>
     @@ -19,11 +17,10 @@
       	static const char ok_punct[] = "+,-./:=@_^";
       	const char *p;
       
     -+	/* In case of null tokens, warn the user of the BUG in their call. */
      +	if (!src) 
      +		BUG("Cannot append a NULL token to the buffer");
      +	
     -+	/* Avoid dropping a zero-length token by adding '' */
     ++	/* Avoid losing a zero-length string by adding '' */ 
      +	if (!*src) {
      +		strbuf_addstr(dst, "''");
      +		return;
     @@ -40,7 +37,7 @@
       #	test_i18ngrep "^fatal: alias loop detected: expansion of" output
       #'
       
     -+test_expect_success 'run-command parses empty args properly, using sq_quote_buf_pretty' '
     ++test_expect_success 'run-command formats empty args properly' '
      +    GIT_TRACE=1 git frotz a "" b " " c 2>&1 |
      +    sed -ne "/run_command:/s/.*trace: run_command: //p" >actual &&
      +    echo "git-frotz a '\'''\'' b '\'' '\'' c" >expect &&

-- 
gitgitgadget
