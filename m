Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 152792047F
	for <e@80x24.org>; Sun, 17 Sep 2017 13:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751365AbdIQNnS (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Sep 2017 09:43:18 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:44565 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750861AbdIQNnR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Sep 2017 09:43:17 -0400
Received: by mail-pf0-f173.google.com with SMTP id e1so3580338pfk.1
        for <git@vger.kernel.org>; Sun, 17 Sep 2017 06:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:in-reply-to:references:date:mime-version
         :content-transfer-encoding;
        bh=BBbTui8s6wWgA6eB8Wl5XfK0nzvBZhmGJ1kwCF7GKQQ=;
        b=b2zrI5Xyquce9mFivzh1A2PDGpWXQruw3BZJ/ZTrfdzZEA1gJPWfMS9AnCYoJQmKzS
         IKQQmgbRVG6ygNqQuAuwO/KVFSGLQZqKo1dJW7xsKbqKb0ogxZGiUaamgKwQ4A0QAFXH
         gNazKqW1yh37r1tmq8yMQEueUigzPo5SIh02dWU/eq3pobFYAUt2DSn7DAcZl1Lv0RDJ
         ZdtE2XQwZcKHZhizHLXINjr7hL3txrM8zHEBlMQotmSCelbjCbuQU2MvSwOrQkg7BAx2
         04iDTPpOyMN7nEJv0VGz3qjgs6kQQ2lovTQdznqQt5CJNQidAjZUbJS7PgtHdKR2SSsJ
         6XTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=BBbTui8s6wWgA6eB8Wl5XfK0nzvBZhmGJ1kwCF7GKQQ=;
        b=YmWfH6YtUOM8vQeF4kyPUckqo+1m7+52fVAMr1smm5Oka8rkkKzLacg9K4M9Eznq2U
         s0w4iTdFCRu3G3krXdYCF1209TeYvUrUCIidjZkN102l98Fr26T3mH0pymBJIR+RpBTf
         EF63oA9jAS1RIsXxlnnFOmpoXxE2Aq2U5FkW76ZSofamFMjRuj7q+ESdC0KrnSRbtjzN
         aJJ2GPNMWLLupmVMrE3K06uyYAqRoOykW8046eMaSSATGvu8CBoLMB/1tx/y+zfr93p2
         KggCVgZyN+AbE6JrxObMQp9jx63SStGM06S6q0vOvlUkfmg3LqPEzXZOl7IZVI1ebLr+
         RNEg==
X-Gm-Message-State: AHPjjUg8HOOJBNbWMi0w2fvYd3+bOuhRqA8Da71gp5ZBoOgbeDW5AdXt
        t8yNsKVHt+mAvUu2ivk=
X-Google-Smtp-Source: ADKCNb5KX3M0TU4tav4mcbGNoCsBosbrH2E8HPWcQRizrCNAZDS56/uaW3BkMXfObqi12opFrPZiQw==
X-Received: by 10.98.224.143 with SMTP id d15mr29400925pfm.170.1505655796830;
        Sun, 17 Sep 2017 06:43:16 -0700 (PDT)
Received: from unique-pc ([14.102.72.146])
        by smtp.googlemail.com with ESMTPSA id j13sm11158739pfk.107.2017.09.17.06.43.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 17 Sep 2017 06:43:16 -0700 (PDT)
Message-ID: <1505655777.14232.3.camel@gmail.com>
Subject: Re: [PATCH] doc: update information about windows build
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     phillip.wood@dunelm.org.uk, git@vger.kernel.org
In-Reply-To: <80afe093-aceb-9478-f0d2-d69f7f75eaab@talktalk.net>
References: <0102015e8e4f7e75-dfec22a3-bb1a-4208-a069-450275d52b6d-000000@eu-west-1.amazonses.com>
         <80afe093-aceb-9478-f0d2-d69f7f75eaab@talktalk.net>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Sun, 17 Sep 2017 19:12:57 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1 
Content-Transfer-Encoding: 8bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 2017-09-17 at 14:24 +0100, Phillip Wood wrote:
> 
>  From that commit:
> diff --git a/ci/run-windows-build.sh b/ci/run-windows-build.sh
> new file mode 100755
> index 000000000..4e3a50b60
> --- /dev/null
> +++ b/ci/run-windows-build.sh
> @@ -0,0 +1,74 @@
> +#!/usr/bin/env bash
> +#
> +# Script to trigger the a Git for Windows build and test run.
> +# Set the $GFW_CI_TOKEN as environment variable.
> +# Pass the branch (only branches on https://github.com/git/git are
> +# supported) and a commit hash.
> +#
> 
> so only git/git from github gets built on windows, not other peoples 
> trees. One cannot use travis to test ones changes on windows before 
> submitting them
> 

Thanks for pointing it out didn't notice it. I have been confused by
the presence of the build named 'Windows' that I see even on my tree. I
 always see a green check mark near it which tricked me into believing
that they were running successfully. I didn't know they were being
skipped all these days! 

May be the Windows build exit with failure on other repos rather than
saying it passes?

---
Kaartic
