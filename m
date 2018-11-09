Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86BFA1F453
	for <e@80x24.org>; Fri,  9 Nov 2018 03:44:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbeKINWz (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Nov 2018 08:22:55 -0500
Received: from mail-pg1-f176.google.com ([209.85.215.176]:37182 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727378AbeKINWz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Nov 2018 08:22:55 -0500
Received: by mail-pg1-f176.google.com with SMTP id 80so269049pge.4
        for <git@vger.kernel.org>; Thu, 08 Nov 2018 19:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/9y73x7j/DgHHxI5m6PmcBdQL9PmUdb/nTS4bcYISh4=;
        b=HgyXdLA8vp1J3UIkw8l8N2ju58wHaC/+sAl1lHRgspe5TRFVXkdHNWfy+oXTnoSFHM
         tqtU1qm7FpYv1WmXvz8WNMsyfO6Js4+guW2q7ISUCYc/JxYwNAk3VtxHLu0VReTr8zZ0
         FFA+ejZvV1H/j5vEUxbotfiCuO0k5xHcDeWP5a1Y36rbXxveuwsZZNTTNHUpJq0yIMpe
         6atTznwbYGnG/R2Mw2SkBLG3GNRzrR1aQq93JU1J59830lPuF35OSB4t/7M5nFPMBy9L
         JFLb1IFHWljjtqUn4aT12kVsTuS+/RCg7TyTJ/R8cK3ovr8Gj+1x8mVegrjXWDonqn7T
         tufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/9y73x7j/DgHHxI5m6PmcBdQL9PmUdb/nTS4bcYISh4=;
        b=YUoI5MVs9486C5bOC0hdSrtUe4Uz4BF5ZX/OdSST74A5bEPvIoCpwYSQuAInSxJfah
         T4eGZAe+OiWVhz/TuoEMKpi2s3E8Y3t47guQDghRZEdV8UtJbzXB6VRDXt0OaLnIG/oW
         90Wd9QY+g03kQhNr9JlEtzDzWhJpu76mYfxDFrpxVI2tHNAMCW0BXQcEgE20cVmSZpAr
         qMjdRnm0AHX/TXt+p9Wq/kKrIDTNEAXGVQd2+US5krvVo4AGlH9UtvFnHpZPjTqs9S2T
         MqR6HQ2jEYi2Dqple4ReLclMoHQbTFZr3HHrSL8hC/a0rdDZ3JJJBN8fLF5KC1HekkXT
         AYGw==
X-Gm-Message-State: AGRZ1gIo7QZl9Zixnmj+sk+GMlX1SvZp/h4JaXgMvzGsN2hfhyZbKqfE
        5jCRHqK8017oSqH4kPJBAg9qpK4X
X-Google-Smtp-Source: AJdET5dAjxNmQ1V0nZ9M7RQBnvDhkEHoDxQ/KsA243sodcfukyx/bfb0jNhXCUwvGRqZWF9vNHB3og==
X-Received: by 2002:a63:fa46:: with SMTP id g6mr6155532pgk.18.1541735053966;
        Thu, 08 Nov 2018 19:44:13 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id y9-v6sm5378617pfe.152.2018.11.08.19.44.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 19:44:13 -0800 (PST)
Date:   Thu, 08 Nov 2018 19:44:13 -0800 (PST)
X-Google-Original-Date: Fri, 09 Nov 2018 03:44:10 GMT
Message-Id: <pull.69.v8.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.69.v7.git.gitgitgadget@gmail.com>
References: <pull.69.v7.git.gitgitgadget@gmail.com>
From:   "Force.Charlie-I via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v8 0/1] http: add support selecting http version
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

Usually we don't need to set libcurl to choose which version of the HTTP
protocol to use to communicate with a server. But different versions of
libcurl, the default value is not the same.

CURL >= 7.62.0: CURL_HTTP_VERSION_2TLS CURL < 7.62: CURL_HTTP_VERSION_1_1

In order to give users the freedom to control the HTTP version, we need to
add a setting to choose which HTTP version to use.

This patch support force enable HTTP/2 or HTTP/1.1. 

example: 

GIT_CURL_VERBOSE=1 git2 -c http.version=HTTP/2 ls-remote https://bitbucket.org/aquariusjay/deeplab-public-ver2.git

Force Charlie (1):
  http: add support selecting http version

 Documentation/config.txt |  9 +++++++++
 http.c                   | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)


base-commit: 8858448bb49332d353febc078ce4a3abcc962efe
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-69%2Ffcharlie%2Fmaster-v8
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-69/fcharlie/master-v8
Pull-Request: https://github.com/gitgitgadget/git/pull/69

Range-diff vs v7:

 1:  e26fc0d8c7 ! 1:  71f8b71b34 http: add support selecting http version
     @@ -78,6 +78,7 @@
      +		}
      +	}
      +
     ++	warning("unknown value given to http.version: '%s'", version_string);
      +	return -1; /* not found */
      +}
      +

-- 
gitgitgadget
