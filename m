Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C5471F453
	for <e@80x24.org>; Thu,  8 Nov 2018 01:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbeKHLIE (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Nov 2018 06:08:04 -0500
Received: from mail-pg1-f180.google.com ([209.85.215.180]:44100 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728164AbeKHLIE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Nov 2018 06:08:04 -0500
Received: by mail-pg1-f180.google.com with SMTP id w3-v6so8099683pgs.11
        for <git@vger.kernel.org>; Wed, 07 Nov 2018 17:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=REHSuiTnArgh/XC//V+ix4wsFdiUlbxja01BhCO3n0k=;
        b=EQeUoJwHzWj+9YDOP65+6b1jklRqoMH2GM3/0TKXILZEobinymzWTUnjCU8IMCAyQH
         W8E0HjZm7JrjerP85lB5RViq4UzACFA5bYY7T8cbYDodkC2GVQpb33jyGB9hRPD0pZTT
         0vE41Nk09dQE+xUpG1Gv2MBGUdisfT1TtIkemcDnT+0RTe6eKhvY2xQOV/FMn4OsQetX
         VUxICBmQ7MfYr1YHOdl57QrRznzwHPUj3x37Ef5DZh0DQdqrBc0fAnzuSjVk64KTwCS4
         0eyHamRV4JXgTTDZyKgRN/bzHlV9EOZ/u1LIu+V+STTiTz4vjXFlejh5U5haPapGDlWP
         kVtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=REHSuiTnArgh/XC//V+ix4wsFdiUlbxja01BhCO3n0k=;
        b=NLwFZpX7J2QJHusd5ebsLO57XBG4I4Fxf8R2NFVZp3NCEEHr7SDYdzuS4nDJnmYSlB
         20e4TiZXcADSxmWXOtEioIEuSUMCTS7XRtJONMqzr/ZicqIMlI5BGUGTMNaLem4/v2iO
         MlgKqM6h1YrbBWMkIf7J+ysp7fDd3ezRW6yC4CqD/KW3YDwIkCpUlZWY7kWredlLjR1+
         U8jpQJ4jlNHpSm1v80aAO5XOVDD1yVrJA5veacRapBzF436AwY80Il9Rh2+Q505H/TJ1
         0BuDn1VGhZ1NfqhZBi2tWqcCIBrPkX7lUfOMSqFZoKjpc9a/IhhDnXV66A9vwSVRpPXK
         KjJQ==
X-Gm-Message-State: AGRZ1gLsGe/+NIMbllfGXd9YbRYFaEMdaYfP090UWxzdn9WXm2uN++gj
        j8mGdsld7uRNndRCznWT+nP6S5Y2
X-Google-Smtp-Source: AJdET5emgcj99VXEDy3UAHBNDGRb0pd/105RU3BpFUfk63hkI3QDojUgravW2BhoxF+RyFxeq2hV3g==
X-Received: by 2002:aa7:8498:: with SMTP id u24-v6mr2625693pfn.220.1541640902786;
        Wed, 07 Nov 2018 17:35:02 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id n2-v6sm1894380pgg.86.2018.11.07.17.35.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 17:35:02 -0800 (PST)
Date:   Wed, 07 Nov 2018 17:35:02 -0800 (PST)
X-Google-Original-Date: Thu, 08 Nov 2018 01:34:57 GMT
Message-Id: <pull.69.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.69.git.gitgitgadget@gmail.com>
References: <pull.69.git.gitgitgadget@gmail.com>
From:   "Force.Charlie-I via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/3] http: add support selecting http version
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
fine without HTTP2. Adding HTTP2 support is a icing on the cake.

When http.version=20 is set, git will attempt to request the server using
HTTP2. If the remote server does not support HTTP2, it is no different.
Currently bitbucket supports HTTP2 and is available for testing.

example: 

GIT_CURL_VERBOSE=1 git2 -c http.version=20 ls-remote https://bitbucket.org/aquariusjay/deeplab-public-ver2.git

Force Charlie (3):
  http: add support selecting http version
  support force use http 1.1
  fix curl version to support CURL_HTTP_VERSION_2TLS

 http.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)


base-commit: 8858448bb49332d353febc078ce4a3abcc962efe
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-69%2Ffcharlie%2Fmaster-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-69/fcharlie/master-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/69

Range-diff vs v1:

 1:  4f5a935c43 = 1:  4f5a935c43 http: add support selecting http version
 -:  ---------- > 2:  06e9685d2b support force use http 1.1
 -:  ---------- > 3:  eee67d8356 fix curl version to support CURL_HTTP_VERSION_2TLS

-- 
gitgitgadget
