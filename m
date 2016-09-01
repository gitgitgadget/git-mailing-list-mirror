Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BB891F6BF
	for <e@80x24.org>; Thu,  1 Sep 2016 16:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754608AbcIAQZ3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 12:25:29 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:36121 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750957AbcIAQZ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 12:25:29 -0400
Received: by mail-wm0-f45.google.com with SMTP id c133so86929891wmd.1
        for <git@vger.kernel.org>; Thu, 01 Sep 2016 09:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=3EzDO/7Nqbt9w4ZTJwAvTh5nCm/TJbOh3Qt31jGob84=;
        b=CJQ2qLaSQS65rSVlN7Mtb0f/YlmOXzhySCnSlg7z0wZPm5Q4LDgCK86P4Gspgyg9sg
         TvXAqwnrYjeLW8vx06T9oNAVHv4NNCAKCcDBpeTYPzj96sVpTz7tZv+f1WBDCe2b69Qk
         cnU2TS51mFfBOzixPiq7jbH/PknlpKifdI3f5XLsYmbSPREf/5yvfFgfSTcfEDHlu24A
         6OQhy3D1yjUwWIMDeOF3cO+GQgQOxUg7mzIg2l4RIGSdxQSXKwnlWJrzM+FLciuMKhCJ
         ib6Lr05hZa3f9pKp0bs/arxWnrRzriwk8R8bbJvBavHkZ9N3vz+5nnob47Ziulw/NbM4
         DC4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3EzDO/7Nqbt9w4ZTJwAvTh5nCm/TJbOh3Qt31jGob84=;
        b=OWgFM94mQIvBI4ERxUT3CaYKxjtHWCdyPzZ+pV3L2bWcXOS3bBY+oWDuzE3uewNh1F
         4uTQLarJEFA3KZCNiWyYFKJ+E/nnxAijKIraI4/iiXeje00WjtFP5nPwe+Idf4PyIvWn
         n8fStthIyVAIEqg4MZwEmnhCFZrx3OiP/yOKFR5EhhyCpnKPtfkbkNGb8E/7OOBVpGaP
         3f4ROagD46IW5cCLSRyv5FvrXSszZJX4w/NNCXjoc0mxr35YbDfX7fNopRct0eVWQIfd
         bpGPIQYAj3VnFiuK8t1RBB39LeTYvgpAXACMiqAUhSdcRohQtSbvIWPH/P8FnEttH7TO
         VfdQ==
X-Gm-Message-State: AE9vXwPkf1l40iZhd8HYm7rE/8rr7LyqnOV0gqAeaT2oaahSVQwMjIIh6IfZV2eR0Gw8Ew==
X-Received: by 10.28.182.84 with SMTP id g81mr29147205wmf.20.1472747127304;
        Thu, 01 Sep 2016 09:25:27 -0700 (PDT)
Received: from [10.42.1.91] ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id c139sm29944880wme.4.2016.09.01.09.25.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Sep 2016 09:25:26 -0700 (PDT)
Message-ID: <1472747125.4680.38.camel@kaarsemaker.net>
Subject: Re: `make profile-install` fails in 2.9.3
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     Jan Keromnes <janx@linux.com>, git@vger.kernel.org
Date:   Thu, 01 Sep 2016 18:25:25 +0200
In-Reply-To: <CAA6PgK7C18F1WGyZMTEUAWEVsUWqiZND5Ne_0SH-rUEm8u5dNg@mail.gmail.com>
References: <CAA6PgK7C18F1WGyZMTEUAWEVsUWqiZND5Ne_0SH-rUEm8u5dNg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On do, 2016-09-01 at 18:08 +0200, Jan Keromnes wrote:

> However, this fails (and has failed in previous versions), because it
> runs the whole test-suite to get the profile, but bails out if there
> were test failures (which happens often).

Working around failing tests is fixing a symptom, not the root cause. I
run the testsuite for master, next and pu very regularly and test
failures on master are extremely rare. I think I've seen one or so in
the last year, might even be 0. So let's focus on that instead.

> Related problem: `t3700-add.sh` currently fails in 2.9.3. I can
> provide more debug information if you don't already know this problem.

It should not fail, and for me does not fail on ubuntu 16.04. Please
run that test in verbose mode and share its output, as well as your
build configuration.

D.
