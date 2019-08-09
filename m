Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0A281F731
	for <e@80x24.org>; Fri,  9 Aug 2019 15:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407246AbfHIPAz (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Aug 2019 11:00:55 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33579 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbfHIPAz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Aug 2019 11:00:55 -0400
Received: by mail-wm1-f66.google.com with SMTP id p77so6377275wme.0
        for <git@vger.kernel.org>; Fri, 09 Aug 2019 08:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PhNLyW4/+Rk9kjIbSMb55Uah4Iw0LzEdy/Fu6W/SnY0=;
        b=EGcSxVvIBt2rVq5aNJVpkEv49qDxNCNbm892e5gR6avLuHMbMMT+4B7jRFyw9BdlK/
         gjcyNN2tl5HQROmwaputdhwBPWLRsg7rV0c/HXYeM9sdUcipKfOhVnv123XqpFmMLvAs
         6FRgYxnJL2CBHtEAQ5GCOYvDASfoawwvcPXnLb7Js0QqJz9yxSq2E55f6Ji+c1Tw8fDI
         NZRRoOrw5SHHnPybPZ4l5GMoDTzhTR+W0Lya0p6FV46az8Uqp7oqhJakhdqmvlTbE+9r
         rOwkQ0MlD7dYcEw7Y/z3RDCzimQ2zvQSq5wsluWukSvf+dyu5Fv+G3uoTrpuTVNj2MuA
         N0OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PhNLyW4/+Rk9kjIbSMb55Uah4Iw0LzEdy/Fu6W/SnY0=;
        b=WTfQK3FM0AdxrMcUOE5UvJYpS9Xz4CuXKX/MfxIz87/L900CPhurGgb70x03z5QxnT
         yJ838uT7lvOjXRIqJihIOGCY/tLaGrM3nFn68+SGU8FlOaN2NByhJ8M9v3NR5Hy4SRuN
         4vuyDsQf1rSmnwcHhTKgZPT3VKmDwLR1epziWyY0qaCL2Y4WlF/ocIJuEx0L9T4PFTtE
         xJjyobb++b6E6gM67GVpgCqXatqLTCvqfcLKOVgIH1NM+lw2GBb4y67ligaQkEUwWUxd
         8lfIAf1zvK9M1SPWY2+x5WsjnqFaQsVFDgSkGZ9LEF6UDJNJjROYakV3P2iW1vTL2Agp
         hdGA==
X-Gm-Message-State: APjAAAU2dqTIJ3fUNO1Wra4Jgb8r4JoQ4Gaoy6/B30mIgDJWWk9GAtFg
        V+YcVlB6pSETNNe5dkEkUDORPNrK
X-Google-Smtp-Source: APXvYqxMSKjSMoU5QZr/YsK7n1bevKUOfprb3uG1swGt8VmtOBf4x9JxPxxtBjnmvgO5fk6JEKIAjQ==
X-Received: by 2002:a7b:c4d2:: with SMTP id g18mr11509795wmk.79.1565362852718;
        Fri, 09 Aug 2019 08:00:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t63sm5645816wmt.6.2019.08.09.08.00.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 08:00:52 -0700 (PDT)
Date:   Fri, 09 Aug 2019 08:00:52 -0700 (PDT)
X-Google-Original-Date: Fri, 09 Aug 2019 15:00:44 GMT
Message-Id: <pull.298.v3.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.298.v2.git.gitgitgadget@gmail.com>
References: <pull.298.v2.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 0/7] trace2: clean up formatting in perf target format
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

V2 of this patch series cleans up some whitespace and column alignment
issues in the trace2 perf and normal formats. It also removes some dead
code.

Jeff Hostetler (7):
  trace2: cleanup column alignment in perf target format
  trace2: trim whitespace in region messages in perf target format
  trace2: remove dead code in maybe_add_string_va()
  trace2: trim trailing whitespace in normal format error message
  quote: add sq_append_quote_argv_pretty()
  trace2: cleanup whitespace in normal format
  trace2: cleanup whitespace in perf format

 quote.c                 | 18 ++++++++-
 quote.h                 |  1 +
 t/t0211-trace2-perf.sh  |  4 +-
 trace2/tr2_tgt_event.c  |  5 ---
 trace2/tr2_tgt_normal.c | 35 ++++++++--------
 trace2/tr2_tgt_perf.c   | 89 +++++++++++++++++++++++++++--------------
 6 files changed, 97 insertions(+), 55 deletions(-)


base-commit: 026dd738a6e5f1e42ef0f390feacb5ed6acc4ee8
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-298%2Fjeffhostetler%2Fupstream-2230-cleanup-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-298/jeffhostetler/upstream-2230-cleanup-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/298

Range-diff vs v2:

 1:  38b53da31f = 1:  38b53da31f trace2: cleanup column alignment in perf target format
 2:  db35099712 = 2:  db35099712 trace2: trim whitespace in region messages in perf target format
 3:  09dff12a7d = 3:  09dff12a7d trace2: remove dead code in maybe_add_string_va()
 4:  d5b5a70c1b = 4:  d5b5a70c1b trace2: trim trailing whitespace in normal format error message
 5:  5059776248 < -:  ---------- quote: add sq_quote_argv_pretty_ltrim
 -:  ---------- > 5:  2002108a30 quote: add sq_append_quote_argv_pretty()
 6:  bb64bb2513 ! 6:  d02a0608d7 trace2: cleanup whitespace in normal format
     @@ -2,7 +2,7 @@
      
          trace2: cleanup whitespace in normal format
      
     -    Make use of new sq_quote_argv_pretty_ltrim() to normalize
     +    Make use of new sq_append_quote_argv_pretty() to normalize
          how we handle leading whitespace in normal format messages.
      
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
     @@ -15,7 +15,7 @@
       
       	strbuf_addstr(&buf_payload, "start ");
      -	sq_quote_argv_pretty(&buf_payload, argv);
     -+	sq_quote_argv_pretty_ltrim(&buf_payload, argv);
     ++	sq_append_quote_argv_pretty(&buf_payload, argv);
       	normal_io_write_fl(file, line, &buf_payload);
       	strbuf_release(&buf_payload);
       }
     @@ -26,7 +26,7 @@
      -	strbuf_addf(&buf_payload, "alias %s ->", alias);
      -	sq_quote_argv_pretty(&buf_payload, argv);
      +	strbuf_addf(&buf_payload, "alias %s -> ", alias);
     -+	sq_quote_argv_pretty_ltrim(&buf_payload, argv);
     ++	sq_append_quote_argv_pretty(&buf_payload, argv);
       	normal_io_write_fl(file, line, &buf_payload);
       	strbuf_release(&buf_payload);
       }
     @@ -38,7 +38,8 @@
      +	strbuf_addf(&buf_payload, "child_start[%d]", cmd->trace2_child_id);
       
       	if (cmd->dir) {
     - 		strbuf_addstr(&buf_payload, " cd");
     +-		strbuf_addstr(&buf_payload, " cd");
     ++		strbuf_addstr(&buf_payload, " cd ");
       		sq_quote_buf_pretty(&buf_payload, cmd->dir);
      -		strbuf_addstr(&buf_payload, "; ");
      +		strbuf_addstr(&buf_payload, ";");
     @@ -54,7 +55,7 @@
      -		strbuf_addstr(&buf_payload, "git");
      -	sq_quote_argv_pretty(&buf_payload, cmd->argv);
      +		strbuf_addstr(&buf_payload, "git ");
     -+	sq_quote_argv_pretty_ltrim(&buf_payload, cmd->argv);
     ++	sq_append_quote_argv_pretty(&buf_payload, cmd->argv);
       
       	normal_io_write_fl(file, line, &buf_payload);
       	strbuf_release(&buf_payload);
     @@ -68,7 +69,7 @@
      -	sq_quote_argv_pretty(&buf_payload, argv);
      +		strbuf_addch(&buf_payload, ' ');
      +	}
     -+	sq_quote_argv_pretty_ltrim(&buf_payload, argv);
     ++	sq_append_quote_argv_pretty(&buf_payload, argv);
       	normal_io_write_fl(file, line, &buf_payload);
       	strbuf_release(&buf_payload);
       }
 7:  a6e5e7c70b ! 7:  9ab7393985 trace2: cleanup whitespace in perf format
     @@ -2,7 +2,7 @@
      
          trace2: cleanup whitespace in perf format
      
     -    Make use of new sq_quote_argv_pretty_ltrim() to normalize
     +    Make use of new sq_append_quote_argv_pretty() to normalize
          how we handle leading whitespace in perf format messages.
      
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
     @@ -33,7 +33,7 @@
       	struct strbuf buf_payload = STRBUF_INIT;
       
      -	sq_quote_argv_pretty(&buf_payload, argv);
     -+	sq_quote_argv_pretty_ltrim(&buf_payload, argv);
     ++	sq_append_quote_argv_pretty(&buf_payload, argv);
       
       	perf_io_write_fl(file, line, event_name, NULL, &us_elapsed_absolute,
       			 NULL, NULL, &buf_payload);
     @@ -44,7 +44,7 @@
      -	strbuf_addf(&buf_payload, "alias:%s argv:", alias);
      -	sq_quote_argv_pretty(&buf_payload, argv);
      +	strbuf_addf(&buf_payload, "alias:%s argv:[", alias);
     -+	sq_quote_argv_pretty_ltrim(&buf_payload, argv);
     ++	sq_append_quote_argv_pretty(&buf_payload, argv);
      +	strbuf_addch(&buf_payload, ']');
       
       	perf_io_write_fl(file, line, event_name, NULL, NULL, NULL, NULL,
     @@ -63,7 +63,7 @@
      +		if (cmd->argv[0])
      +			strbuf_addch(&buf_payload, ' ');
      +	}
     -+	sq_quote_argv_pretty_ltrim(&buf_payload, cmd->argv);
     ++	sq_append_quote_argv_pretty(&buf_payload, cmd->argv);
      +	strbuf_addch(&buf_payload, ']');
       
       	perf_io_write_fl(file, line, event_name, NULL, &us_elapsed_absolute,
     @@ -82,7 +82,7 @@
      +		if (argv[0])
      +			strbuf_addch(&buf_payload, ' ');
      +	}
     -+	sq_quote_argv_pretty_ltrim(&buf_payload, argv);
     ++	sq_append_quote_argv_pretty(&buf_payload, argv);
      +	strbuf_addch(&buf_payload, ']');
       
       	perf_io_write_fl(file, line, event_name, NULL, &us_elapsed_absolute,

-- 
gitgitgadget
