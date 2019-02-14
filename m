Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F51C1F453
	for <e@80x24.org>; Thu, 14 Feb 2019 20:17:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390400AbfBNURZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 15:17:25 -0500
Received: from mail-vk1-f202.google.com ([209.85.221.202]:50300 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728119AbfBNURY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 15:17:24 -0500
Received: by mail-vk1-f202.google.com with SMTP id v193so2951653vkd.17
        for <git@vger.kernel.org>; Thu, 14 Feb 2019 12:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=14j/m4QemE7+a52sUaplrvmwiC86FY07AtLLLtlg8Nk=;
        b=r4CyRLLesm6ZT1sErlEGc7cW3TwpAjz7kHwMuGdkMeS8aDqGVmwNI/aa4gxbIEawF6
         LE9i02w2z08VgsUcLocAvKdXX2UCpK7g5U4Qq/TdujnpJlwl60kgcfJNVp/S88YyI4Kc
         bfzrhXKDKUpFueu4vjoVTi9me3iIOXCfTSFEfbz3r/HnfFo+Q5WFn7mWh6j/C3ac42D9
         UTfpxk3Ri3/s61n7bxDum35d0CqGLg3OuhPac8Ab5gKydhTXGGsNG0gtSMHUZnf8+e3N
         6nWxE0b5CH8CsxFunDkDfQjxKqzmKd6rM6zJmYMpJSZu0qdP/Z9MY3K4UDF9zp3mtDiw
         XZbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=14j/m4QemE7+a52sUaplrvmwiC86FY07AtLLLtlg8Nk=;
        b=Hue4zTe43Saql5eaCRcAjvbpRhNO+HKLtLRwP3s4xzKSDIiijK2HdC9v8Y2fpcSsAf
         gfQwI93/DQ+DiqrYeuFXq/cZ5blyFUZdRJGnhWkXBLoXL/Nm6xZdjx28zSVoR4J5CD2R
         QayMNIbBPlbTkjRY+hWEKnua5T/5bAsCK5FrInxh4FNPcy10iZKJEpVV6jXtx0UfDx5m
         hl4jU3bt7QGrwdr70PuLWof/zf+T/7vEx+w32OBZrgMQWUkHtyjLvOyfMqha3mI6Dz1k
         ag+a19jJcygKqqdEseFoHJoasWpkhNiqKmRh9JBFez4WKPyP+daHmPaacBOROpSHVlZo
         PHIA==
X-Gm-Message-State: AHQUAuZ7Sl11FpeQ1R+ndr2FjkVlyiJkO6Gn0D3deMyDZVry+rAXqbAa
        9F/tRZDf8Lpl2CYKpkyW7MA1A5i6q4/khGxxhMKT
X-Google-Smtp-Source: AHgI3IZ2+Mum+Q9YJQRwRwBGE0f8OuRMRkA7Uvc0gjGcuNAlSZxS/3vzq649TJSa4x82jRyHUWOgjaucIprAiUk0jHXH
X-Received: by 2002:ab0:7103:: with SMTP id x3mr3566967uan.14.1550175443371;
 Thu, 14 Feb 2019 12:17:23 -0800 (PST)
Date:   Thu, 14 Feb 2019 12:17:11 -0800
In-Reply-To: <20190214063513.32041-1-tmz@pobox.com>
Message-Id: <20190214201711.130216-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20190214063513.32041-1-tmz@pobox.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [PATCH] t/lib-httpd: pass GIT_TEST_SIDEBAND_ALL through Apache
From:   Jonathan Tan <jonathantanmy@google.com>
To:     tmz@pobox.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com, gitster@pobox.com,
        peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> 07c3c2aa16 ("tests: define GIT_TEST_SIDEBAND_ALL", 2019-01-16) added
> GIT_TEST_SIDEBAND_ALL to the apache.conf PassEnv list.  Avoid warnings
> from Apache when the variable is unset, as we do for GIT_VALGRIND* and
> GIT_TRACE, from f628825481 ("t/lib-httpd: handle running under
> --valgrind", 2012-07-24) and 89c57ab3f0 ("t: pass GIT_TRACE through
> Apache", 2015-03-13), respectively.
> 
> Signed-off-by: Todd Zullinger <tmz@pobox.com>
> ---
> I missed this with rc0, but poking through build logs I noticed a number
> of 'AH01506: PassEnv variable GIT_TEST_SIDEBAND_ALL was undefined'
> warnings.
> 
> I think exporting this in lib-httpd.sh like we do for GIT_VALGRIND* and
> GIT_TRACE is the way to go, as opposed to in test-lib.sh, as we do for
> things like GNUPGHOME.  But I could easily be wrong about that.

Thanks for looking into this. I think this is the right way to do it
too.

Previous discussion here [1] but I don't think any patches came out of
that.

[1] https://public-inbox.org/git/20190129232732.GB218214@google.com/
