Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DAAF1F454
	for <e@80x24.org>; Thu,  8 Nov 2018 06:18:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbeKHPwf (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Nov 2018 10:52:35 -0500
Received: from mail-pg1-f180.google.com ([209.85.215.180]:41545 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbeKHPwe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Nov 2018 10:52:34 -0500
Received: by mail-pg1-f180.google.com with SMTP id 70so2833161pgh.8
        for <git@vger.kernel.org>; Wed, 07 Nov 2018 22:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8QnCwBArXvgSXH2mo1ZMDqjN2auSNwX2drs1aYfozqU=;
        b=oRYz6WBnnt1hYXudeEFhUiqAn0SOpcUBvvAW+qVdBaB0gYjB9f9jk2H2CCbR8QwzYk
         OOiRx+9z3TrBKeKJ1EIxRv01gNjdN995b94axICMimCkDaG9CgkR1ot958dyCxE46Z//
         yXuihH18Y/lS78veyGD7HbPklv72MwVHil6sBuxKKKc0qtiNzIt36sJVoA68t0/JOytp
         y+AytNWEuMNe8vMU01J3A2j2nBD9nwFZCTtZpvkc6b0PV6DAp4E+moRhobf0id26xx7/
         mbwRm51VMvRwBe9SlxqaUzoVh5FEqJg/RPmYZnxAEqQg7+S1WyFLZW5pA3I8N5i/IQLm
         /xig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8QnCwBArXvgSXH2mo1ZMDqjN2auSNwX2drs1aYfozqU=;
        b=e0c3nb+4PDG4/lQx8tblnr/7QjSyUfKYgTi/YPD9/a2VeOX8H5p10Dh3BNWrG+yKrw
         AQ1rQVQLg1qBvseLpevzuX9Zy8rQ1oiiNMffioRzFJQtnSYkIfHyU2NuWMOCrNZuG0fF
         YnExTg1gLSMIzOmIBNRkP0QsUk8xQKabbegg1X9XjUTNvX18MZhjbOJqsy8VD/PfqqR6
         TsEjfSJJwSNGGZbUzA/4dkqhmbLr5LG21uOQfYINwkhug85Z9+qHXCFsu5ES1TqnKbRs
         dbytI87JnjCH7PlU8K8ZZopd9zPgO3RGbiNztBcEfDaqeAns3BP9Kc8BOYxt9qzW2jUB
         4geA==
X-Gm-Message-State: AGRZ1gJKeR+xRI9FkQcmFQwSamUTObGQoY/N+n+XRMfA/gsCN5DKSj9n
        qaBjXnCB2QKvf6UvgW/8/kS/w4jG
X-Google-Smtp-Source: AJdET5d8zkVvIBWah5dCpq8YhF/VmMiykhTcMUZ1dGctI0OSOkQBSsz63ffTz+GrDJUHmVb+tUomeg==
X-Received: by 2002:a63:a30a:: with SMTP id s10mr2639342pge.234.1541657921387;
        Wed, 07 Nov 2018 22:18:41 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id i189-v6sm4949338pfc.16.2018.11.07.22.18.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 22:18:40 -0800 (PST)
Date:   Wed, 07 Nov 2018 22:18:40 -0800 (PST)
X-Google-Original-Date: Thu, 08 Nov 2018 06:18:38 GMT
Message-Id: <pull.69.v5.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.69.v4.git.gitgitgadget@gmail.com>
References: <pull.69.v4.git.gitgitgadget@gmail.com>
From:   "Force.Charlie-I via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 0/1] http: add support selecting http version
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

Normally, git doesn't need to set curl to select the HTTP version, it works
fine without HTTP/2. Adding HTTP/2 support is a icing on the cake.

This patch support force enable HTTP/2 or HTTP/1.1. 

example: 

GIT_CURL_VERBOSE=1 git2 -c http.version=HTTP/2 ls-remote https://bitbucket.org/aquariusjay/deeplab-public-ver2.git

Force Charlie (1):
  http: add support selecting http version

 http.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)


base-commit: 8858448bb49332d353febc078ce4a3abcc962efe
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-69%2Ffcharlie%2Fmaster-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-69/fcharlie/master-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/69

Range-diff vs v4:

 1:  4f5a935c43 < -:  ---------- http: add support selecting http version
 2:  06e9685d2b < -:  ---------- support force use http 1.1
 3:  eee67d8356 < -:  ---------- fix curl version to support CURL_HTTP_VERSION_2TLS
 4:  0a7794722b ! 1:  cdd93048ba http: change http.version value type
     @@ -1,6 +1,6 @@
      Author: Force Charlie <charlieio@outlook.com>
      
     -    http: change http.version value type
     +    http: add support selecting http version
      
          Signed-off-by: Force Charlie <charlieio@outlook.com>
      
     @@ -11,21 +11,20 @@
       
       static int curl_ssl_verify = -1;
       static int curl_ssl_try;
     --static int curl_http_version = 0;
      +static const char *curl_http_version = NULL;
       static const char *ssl_cert;
       static const char *ssl_cipherlist;
       static const char *ssl_version;
      @@
     + 
       static int http_options(const char *var, const char *value, void *cb)
       {
     - 	if (!strcmp("http.version",var)) {
     --		curl_http_version=git_config_int(var,value);
     --		return 0;
     ++	if (!strcmp("http.version",var)) {
      +		return git_config_string(&curl_http_version, var, value);
     - 	}
     ++	}
       	if (!strcmp("http.sslverify", var)) {
       		curl_ssl_verify = git_config_bool(var, value);
     + 		return 0;
      @@
       }
       #endif
     @@ -58,21 +57,19 @@
       {
       	CURL *result = curl_easy_init();
      @@
     + 		curl_easy_setopt(result, CURLOPT_SSL_VERIFYHOST, 2);
       	}
       
     - #if LIBCURL_VERSION_NUM >= 0x072f00 // 7.47.0
     --    // curl_http_version 0 is default.
     --    if (curl_http_version == 20) {
     --		/* Enable HTTP2*/
     --		curl_easy_setopt(result, CURLOPT_HTTP_VERSION,CURL_HTTP_VERSION_2TLS);
     --    } else if (curl_http_version == 11) {
     --		curl_easy_setopt(result, CURLOPT_HTTP_VERSION,CURL_HTTP_VERSION_1_1);
     ++#if LIBCURL_VERSION_NUM >= 0x072f00 // 7.47.0
      +    if (curl_http_version) {
      +		long opt;
      +		if (!get_curl_http_version_opt(curl_http_version, &opt)) {
      +			/* Set request use http version */
      +			curl_easy_setopt(result, CURLOPT_HTTP_VERSION,opt);
      +		}
     -     }
     ++    }
     ++#endif
     ++
     + #if LIBCURL_VERSION_NUM >= 0x070907
     + 	curl_easy_setopt(result, CURLOPT_NETRC, CURL_NETRC_OPTIONAL);
       #endif
     - 

-- 
gitgitgadget
