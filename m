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
	by dcvr.yhbt.net (Postfix) with ESMTP id E82211F4BE
	for <e@80x24.org>; Mon,  7 Oct 2019 16:17:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728980AbfJGQRn (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 12:17:43 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54808 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbfJGQRn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 12:17:43 -0400
Received: by mail-wm1-f65.google.com with SMTP id p7so108245wmp.4
        for <git@vger.kernel.org>; Mon, 07 Oct 2019 09:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jg6srfuoHtgANTmjdbSfbnR3/cxI49b9GUmg8tqXiOY=;
        b=VZ+Y3fsDWsK7KblE5Y3DHahb/zA4TcwfCrUv16sGeKIwhCESy9UWBNMu5vesuzqFyH
         lcKVOLbIDAajAUhDxOcTKUB7fL0MYNdKj7JxwWYdNCJlTreHoEU8OHuzfZ+tWuzK3+Uq
         dSU7F5UJ/RBAGx4Ijq0HjO25s8+jGZH9eNsp4zHmIdHpPHZErngWhvdy9PTUtwkV/NHw
         sxVyEWfwkEJVdgcaItCLZQT8jnukKfYZJl1C8hyr/hnRBGvg6v//Sfn0JJvz8m+/ZaJY
         Yfg29wLdyonHd+zlaOy1mbYhvUh6X3GqzEEon97sJg5keWYavs76mrWEWGo5l5g5vNKF
         q5iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jg6srfuoHtgANTmjdbSfbnR3/cxI49b9GUmg8tqXiOY=;
        b=AbjJhfKb647RrmVBRMJgpsFN1sMo3EpyruIImO1q/TidA/3w12zR+Vfgi5XIy2EbbU
         NNAQsZ/ks8Dsbz9cTFUzS0qdykQpS7JHEznBjsxd7HEuURLSMo2uu/fpTPJpFZy7e+Dp
         1iyjF3m97vljke4x+LOe2gzqpP5QDFxYIPfpe5gK8GXaZPiAIuYUb+kAx4EIlPWafnus
         rbIlmnJRn2efEh1ZKkKZeNYPY3qT+6DG7I2QC0JKnOZ3eAPBb1yzlo/B9L69h8+WHLbe
         04Wv4SF7mAFdorAUqSq3ip+ImIFJxo1smvStJIl3jnK7P2q0Vpn2aNoNag6f0q7PT/xo
         R7zg==
X-Gm-Message-State: APjAAAV5qCyUjBAcv2gK2muwjKWbZ2P6PNvl9PKfV49hOpeWzEtxPt58
        u2ly4E2PM9jdhbugyXOb9d4VGEJd
X-Google-Smtp-Source: APXvYqxg77+qjmNVQrWQC3v0tARuQvv9rcKla4EfT5cTKGzVYpGwLkDk21QuMoSPxCi/lD31HUuiQQ==
X-Received: by 2002:a1c:8189:: with SMTP id c131mr30361wmd.151.1570465060750;
        Mon, 07 Oct 2019 09:17:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z5sm27907405wrs.54.2019.10.07.09.17.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2019 09:17:40 -0700 (PDT)
Date:   Mon, 07 Oct 2019 09:17:40 -0700 (PDT)
X-Google-Original-Date: Mon, 07 Oct 2019 16:17:37 GMT
Message-Id: <pull.314.v3.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.314.v2.git.gitgitgadget@gmail.com>
References: <pull.314.v2.git.gitgitgadget@gmail.com>
From:   "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 0/1] quote: handle null and empty strings in sq_quote_buf_pretty()
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

The sq_quote_buf_pretty() function does not emit anything when the incoming
string is empty, but the function is to accumulate command line arguments,
properly quoted as necessary, and the right way to add an argument that is
an empty string is to show it quoted, i.e. ''.

Looking forward to your review. Cheers! Garima Singh

Reported by: Junio Hamano gitster@pobox.com [gitster@pobox.com] in
https://public-inbox.org/git/pull.298.git.gitgitgadget@gmail.com/T/#m9e33936067ec2066f675aa63133a2486efd415fd

Garima Singh (1):
  quote: handle numm and empty strings in sq_quote_buf_pretty

 quote.c          | 10 ++++++++++
 t/t0014-alias.sh |  7 +++++++
 2 files changed, 17 insertions(+)


base-commit: 5fa0f5238b0cd46cfe7f6fa76c3f526ea98148d9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-314%2Fgarimasi514%2FcoreGit-fixQuote-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-314/garimasi514/coreGit-fixQuote-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/314

Range-diff vs v2:

 1:  b9a68598d7 ! 1:  399fe02cb1 quote: handle null and empty strings in sq_quote_buf_pretty()
     @@ -1,13 +1,13 @@
      Author: Garima Singh <garima.singh@microsoft.com>
      
     -    quote: handle null and empty strings in sq_quote_buf_pretty()
     +    quote: handle numm and empty strings in sq_quote_buf_pretty
      
     -    The sq_quote_buf_pretty() function does not emit anything when
     -    the incoming string is empty, but the function is to accumulate
     -    command line arguments, properly quoted as necessary, and the
     -    right way to add an argument that is an empty string is to show
     -    it quoted, i.e. ''. We warn the caller with the BUG macro if they
     -    pass in a NULL.
     +    The sq_quote_buf_pretty() function does not emit anything
     +    when the incoming string is empty, but the function is to
     +    accumulate command line arguments, properly quoted as
     +    necessary, and the right way to add an argument that is an
     +    empty string is to show it quoted, i.e. ''. We warn the caller
     +    with the BUG macro is they pass in a NULL.
      
          Reported by: Junio Hamano <gitster@pobox.com>
          Signed-off-by: Garima Singh <garima.singh@microsoft.com>
     @@ -21,11 +21,9 @@
       
      +	/* In case of null tokens, warn the user of the BUG in their call. */
      +	if (!src) 
     -+		BUG("BUG can't append a NULL token to the buffer");
     ++		BUG("Cannot append a NULL token to the buffer");
      +	
     -+	/* In case of empty tokens, add a '' to ensure they 
     -+	 * don't get inadvertently dropped. 
     -+	 */
     ++	/* Avoid dropping a zero-length token by adding '' */
      +	if (!*src) {
      +		strbuf_addstr(dst, "''");
      +		return;
     @@ -43,11 +41,10 @@
       #'
       
      +test_expect_success 'run-command parses empty args properly, using sq_quote_buf_pretty' '
     -+	cat >expect <<-EOF &&
     -+	fatal: cannot change to '\''alias.foo=frotz foo '\'''\'' bar'\'': No such file or directory
     -+	EOF
     -+	test_expect_code 128 git -C "alias.foo=frotz foo '\'''\'' bar" foo 2>actual &&
     -+	test_cmp expect actual
     ++    GIT_TRACE=1 git frotz a "" b " " c 2>&1 |
     ++    sed -ne "/run_command:/s/.*trace: run_command: //p" >actual &&
     ++    echo "git-frotz a '\'''\'' b '\'' '\'' c" >expect &&
     ++    test_cmp expect actual
      +'
      +
       test_done

-- 
gitgitgadget
