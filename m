Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97C611F453
	for <e@80x24.org>; Thu,  8 Nov 2018 06:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbeKHPr4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Nov 2018 10:47:56 -0500
Received: from mail-pg1-f178.google.com ([209.85.215.178]:33649 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbeKHPrz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Nov 2018 10:47:55 -0500
Received: by mail-pg1-f178.google.com with SMTP id q5-v6so8413556pgv.0
        for <git@vger.kernel.org>; Wed, 07 Nov 2018 22:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qHSrqiOg+tc8uffRngyKy5ZfG4g/9orgFRMmlkjMhSQ=;
        b=Bep9bk+CfOIfrJHficqnbwEJ0hYCUSLwj9bqdf7jHa3E9wyeFXxGClVKIVPS+GQ7p5
         6y73ouLcocGZs0psXtEGzZGyVeBkfYEz5QPgILD2rKSqDsXzl2uMqPF9pJxChwv3/Upc
         z+oKYI9yTqY2TC0EtzcH2nwXAMZsoPMqtWxOwNBwLjLoBn7fPL7+C+f/GiWVAfvahYCi
         /po5J5qHnXr0iKKJPVDghoYY3kdbyPp8lYiiJ7Vm+kJbvJAAXhAKhLcUmV5qHwAEYhAN
         fYYT3INtN6Z/atdndmf7UyesmQ2QHF2Jjy0kY+o5xIE9u9F+fNpnFs0krSR3i/g9Fw/J
         S/Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qHSrqiOg+tc8uffRngyKy5ZfG4g/9orgFRMmlkjMhSQ=;
        b=WlGGQZQlUevUXquUYeW3nmRa9NunwJaM4rP4ogOEjYTn51utA23g/ZdGesm/V5OQ8v
         hY7pm2Q70QF38dNb1dXtG//N7zLtNZi8FKKAFbF/Y19K2nGf5C+H7Vzpr308EWsZ0TUu
         40beOAglM9RgUe4N9C2FQKFyfPu7hi96W+KM0B70kcyRHUutFSufQA32Fc1bmb/K6Qxz
         zGhfElUgJkaR6cxerZPN6hWcnd1ki649YYnUjNHmZ6PUp/F1mPvse/iONWOdk2hNT5qZ
         ThdvMAcaFq2M+CWoYmRFKKRUqP+8XKBIHjzOhidfbOKPrDep/cDu/soNTSiqlFPubvuS
         xmgA==
X-Gm-Message-State: AGRZ1gLVGlWawvDq5HpUw/XqxD96W11JtvhVEcUnLWxp4mqj7th3bn8C
        UK/L1XYHdsYjlACNgfzQG4efpvFb
X-Google-Smtp-Source: AJdET5djCTIMHqgKJESYogof3HZTWUPWqJDqhthAV2o7vOcyPGVCMBHd7Oa3DI3JELOmhp8SkbOdaw==
X-Received: by 2002:a65:4b82:: with SMTP id t2mr2805478pgq.189.1541657643242;
        Wed, 07 Nov 2018 22:14:03 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id u19-v6sm3629790pfj.115.2018.11.07.22.14.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 22:14:02 -0800 (PST)
Date:   Wed, 07 Nov 2018 22:14:02 -0800 (PST)
X-Google-Original-Date: Thu, 08 Nov 2018 06:13:56 GMT
Message-Id: <pull.69.v4.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.69.v3.git.gitgitgadget@gmail.com>
References: <pull.69.v3.git.gitgitgadget@gmail.com>
From:   "Force.Charlie-I via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 0/4] http: add support selecting http version
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

Force Charlie (4):
  http: add support selecting http version
  support force use http 1.1
  fix curl version to support CURL_HTTP_VERSION_2TLS
  http: change http.version value type

 http.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)


base-commit: 8858448bb49332d353febc078ce4a3abcc962efe
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-69%2Ffcharlie%2Fmaster-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-69/fcharlie/master-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/69

Range-diff vs v3:

 1:  4f5a935c43 = 1:  4f5a935c43 http: add support selecting http version
 2:  06e9685d2b = 2:  06e9685d2b support force use http 1.1
 3:  eee67d8356 = 3:  eee67d8356 fix curl version to support CURL_HTTP_VERSION_2TLS
 4:  ef975b6093 ! 4:  0a7794722b http: change http.version value type
     @@ -67,10 +67,12 @@
      -		curl_easy_setopt(result, CURLOPT_HTTP_VERSION,CURL_HTTP_VERSION_2TLS);
      -    } else if (curl_http_version == 11) {
      -		curl_easy_setopt(result, CURLOPT_HTTP_VERSION,CURL_HTTP_VERSION_1_1);
     -+    long opt=-1;
     -+    if (curl_http_version &&!get_curl_http_version_opt(curl_http_version, &opt)) {
     -+		/* Set request use http version */
     -+		curl_easy_setopt(result, CURLOPT_HTTP_VERSION,opt);
     ++    if (curl_http_version) {
     ++		long opt;
     ++		if (!get_curl_http_version_opt(curl_http_version, &opt)) {
     ++			/* Set request use http version */
     ++			curl_easy_setopt(result, CURLOPT_HTTP_VERSION,opt);
     ++		}
           }
       #endif
       

-- 
gitgitgadget
