Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E42EF1F4BD
	for <e@80x24.org>; Wed,  2 Oct 2019 21:10:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729337AbfJBVKt (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Oct 2019 17:10:49 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36599 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728055AbfJBVKt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Oct 2019 17:10:49 -0400
Received: by mail-wm1-f67.google.com with SMTP id m18so365379wmc.1
        for <git@vger.kernel.org>; Wed, 02 Oct 2019 14:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=ttgxvH/NTECr1phJaVF6RUP4waob6Q9AX5WzptwQdB4=;
        b=Vz8RiUf+yFG+hRnexWtybR53DmG7LuCqCn7Ibxdpv1qdLoUYlXbIW7j7qk/y+AldOE
         HAIJrqZsbPP6NFDEu3iDI21ADug+RXVD+nxsIqqs9LnpJbGa1lKtq/aRE+7FrIHltcyI
         dXEX5ZVcG8UiQoUc8TioFyhrvn/ufEmdzYiv3VX+tCG/4R7DXwfj5vmuvo0AIOyinnzO
         EhzBqkRpFSRf/4wNXVB+VpiKU0AtzSGrwiIpzvmTEI9eXAAyBLqJzKDBNVPUAmmxZbYG
         aSSFwyHJjE+xzXENg5MxKBn3uGp6rdH5sNbzo67D9f7zMWlYBUXJB+zWhuuguRwZ+YUO
         LEwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=ttgxvH/NTECr1phJaVF6RUP4waob6Q9AX5WzptwQdB4=;
        b=At2dTmZPfQz7U0JXuhedXEUFrFfYxAs7rnwO2Db8P5k64Aq2cUAm3eplfyi1ziIjyK
         UfW9jIcfk4HOaSQ4u0YqKlDY74pq7yX43KN0U5u04Onj5dWrkgQkY8KoagH8kW21W+Ui
         ZwBQi28DIHzm5N2SikY9X7Ly9FsTgZNB6VLhrH3O3mIr6bZZluraAvtrDKg06t9HmQZU
         VDlJzRDvyoc9AHvM01/P3OWEcY45tWqmsgeIcIsWWsNDGaOSgFyOC5R6DA3DiaPzlBFT
         hV/MEX7wvp8hK5Q30kPIB39CsQVgJIVc/hhmD3hUCZUdyZxE6FoYAcO83613bALBO0h7
         sFww==
X-Gm-Message-State: APjAAAUJ7BbhvOh9Lm7fzvoFhkzZ/WPt1qSIzVRTLBoJ0BlGybUamWIV
        lSl6Y3k/UhsWkWcZbFgTxHgLkYOW
X-Google-Smtp-Source: APXvYqzJQwtUAEPrL4jjZoXfk+Jv4onswcZeCzkvii04PsSeEAhw16fj8Qgn9Yw1h5dDxZociL7GMA==
X-Received: by 2002:a1c:5f0b:: with SMTP id t11mr4445298wmb.76.1570050647106;
        Wed, 02 Oct 2019 14:10:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h17sm287375wmb.33.2019.10.02.14.10.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Oct 2019 14:10:46 -0700 (PDT)
Date:   Wed, 02 Oct 2019 14:10:46 -0700 (PDT)
X-Google-Original-Date: Wed, 02 Oct 2019 21:10:44 GMT
Message-Id: <pull.373.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.373.git.gitgitgadget@gmail.com>
References: <pull.373.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/1] Avoid segmentation fault in git range-diff when diff.noprefix=true
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Michal =?UTF-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This PR was inspired by this bug report: 
https://public-inbox.org/git/20191002141615.GB17916@kitsune.suse.cz/T/#me576615d7a151cf2ed46186c482fbd88f9959914

Changes since v1:

 * Use a command-line option instead of a command-line config setting.
 * Instead of forcing a prefix, force no prefix (and adjust the strip
   level).
 * Fix typo "all" -> "call" in the commit message (and adjust it to reflect
   the other changes since v1, too).

Johannes Schindelin (1):
  range-diff: internally force `diff.noprefix=true`

 range-diff.c          | 3 ++-
 t/t3206-range-diff.sh | 4 ++++
 2 files changed, 6 insertions(+), 1 deletion(-)


base-commit: bc12974a897308fd3254cf0cc90319078fe45eea
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-373%2Fdscho%2Frange-diff-requires-diff-prefix-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-373/dscho/range-diff-requires-diff-prefix-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/373

Range-diff vs v1:

 1:  1f84f92846 ! 1:  9993a607be range-diff: internally force `diff.noprefix=false`
     @@ -1,6 +1,6 @@
      Author: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     -    range-diff: internally force `diff.noprefix=false`
     +    range-diff: internally force `diff.noprefix=true`
      
          When parsing the diffs, `range-diff` expects to see the prefixes `a/`
          and `b/` in the diff headers.
     @@ -9,25 +9,33 @@
          `diff.noprefix=true`. As `range-diff` is not prepared for that
          situation, this will cause a segmentation fault.
      
     -    Let's avoid that by forcing `diff.noprefix=false` just for that all to
     -    `git log` that generates the diffs that `range-diff` wants to parse.
     +    Let's avoid that by passing the `--no-prefix` option to the `git log`
     +    process that generates the diffs that `range-diff` wants to parse.
     +    And of course expect the output to have no prefixes, then.
      
     -    Noticed-by: Michal Suchánek <msuchanek@suse.de>
     +    Reported-by: Michal Suchánek <msuchanek@suse.de>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       diff --git a/range-diff.c b/range-diff.c
       --- a/range-diff.c
       +++ b/range-diff.c
      @@
     - 	int offset, len;
     - 	size_t size;
       
     --	argv_array_pushl(&cp.args, "log", "--no-color", "-p", "--no-merges",
     -+	argv_array_pushl(&cp.args, "-c", "diff.noprefix=false",
     -+			"log", "--no-color", "-p", "--no-merges",
     + 	argv_array_pushl(&cp.args, "log", "--no-color", "-p", "--no-merges",
       			"--reverse", "--date-order", "--decorate=no",
     ++			"--no-prefix",
       			/*
       			 * Choose indicators that are not used anywhere
     + 			 * else in diffs, but still look reasonable
     +@@
     + 			if (!util->diff_offset)
     + 				util->diff_offset = buf.len;
     + 			line[len - 1] = '\n';
     +-			len = parse_git_diff_header(&root, &linenr, 1, line,
     ++			len = parse_git_diff_header(&root, &linenr, 0, line,
     + 						    len, size, &patch);
     + 			if (len < 0)
     + 				die(_("could not parse git header '%.*s'"), (int)len, line);
      
       diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
       --- a/t/t3206-range-diff.sh

-- 
gitgitgadget
