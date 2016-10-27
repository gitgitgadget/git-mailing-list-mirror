Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31BA220193
	for <e@80x24.org>; Thu, 27 Oct 2016 22:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034267AbcJ0WRm (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 18:17:42 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:37929 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034116AbcJ0WRe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 18:17:34 -0400
Received: by mail-wm0-f51.google.com with SMTP id n67so76737443wme.1
        for <git@vger.kernel.org>; Thu, 27 Oct 2016 15:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pelly-co.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=bsAki7xQjLx1DuZgK2T1dREZXZwXPtLOBy/L+mUZBe8=;
        b=1c83IOPVBZZXdDmb7ckoN6fGB6xnIrzOQSdn9+HkX4b1ONgMXcIrkbmOzVgKIigqVy
         +3Lf4luPfH+AJABK4yPJ9J+8JP+5H9tr8rB1iZPWB0cNHkxHq0M35+mwzPhyQEEG1saD
         jgwAgJCwxf5S+k7jtaLxJSAA+eWDNcgeNnxgu1syxr6b64Wnmv9PZIAw+RCDq91d1dUe
         IofvE0oJPzvDFF2W6QRH5K9dAa7l98tgKZEzErJlJTCqEkY4MfdLnQBGaWO57SOXc5lW
         4zU4DHYv78FN41sHuOX9/hP0a58Oym55ahs+9ApVuT2Mzsxi01/vFUIpHeSgnLXweNST
         dfOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=bsAki7xQjLx1DuZgK2T1dREZXZwXPtLOBy/L+mUZBe8=;
        b=ERO98SHvVL0/c4otbqGiORkwcdGq9BAjb/r4dM3UR33ofYCWrk44naQs92e1jqKTMm
         gsShkOAfQCXH9Sd0lO3oHsz0ru1MXUAtZuiJB4R6BlfVbEAJLrQl4BFtgqn+/j1lic0I
         oTWYNDg+H5NIXO64iAgFmVBb1CzTizRGxXUVsYxVkALRCuTjrLEywPi+/84SWPRMgyWK
         7N5rnwLh2mKGfrv5dGp3Kva2mg3xC6PGigW5CBRaEJSIMMR+LiO/dDpfoJqQiDltkNIy
         g5xvhRiFAtMUQk5GhmerHHtRxGf9d0J2GvlHtIOKk5nbyHR7sVj1FwjbWdQDNrngKOod
         fXYg==
X-Gm-Message-State: ABUngveVjcVVIffohv7L0ZVv/lc/988kvOSC6lZCxryAqfUQvrWta37YJCm6zR4tMJBbGw==
X-Received: by 10.194.22.34 with SMTP id a2mr8538560wjf.95.1477606651480;
        Thu, 27 Oct 2016 15:17:31 -0700 (PDT)
Received: from [10.3.1.6] ([49.50.252.82])
        by smtp.googlemail.com with ESMTPSA id 132sm5568139wmn.16.2016.10.27.15.17.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Oct 2016 15:17:31 -0700 (PDT)
Subject: Re: Expanding Includes in .gitignore
To:     Jeff King <peff@peff.net>
References: <80919456-7563-2c16-ba23-ce4fcc2777de@pelly.co>
 <20161027105026.e752znq5jv5a6xea@sigill.intra.peff.net>
 <b20b458c-440d-df09-d2c7-e510ac20492c@pelly.co>
 <20161027205508.vqw44zlbnqpj2cvd@sigill.intra.peff.net>
 <60a652f6-864e-bbda-7394-4751c92866b7@pelly.co>
Cc:     git@vger.kernel.org
From:   Aaron Pelly <aaron@pelly.co>
Message-ID: <91e0f377-ecfd-ab0a-4f4b-8c0f762228aa@pelly.co>
Date:   Fri, 28 Oct 2016 11:17:26 +1300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <60a652f6-864e-bbda-7394-4751c92866b7@pelly.co>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28/10/16 10:55, Aaron Pelly wrote:
> 2) I fetch a repo with a hostile ignore file. It includes files from
> $GIT_DIR/test-data/ssl/private or some such. Change. Don't pay
> attention. Commit. Push. Problems if my test data comes from production.
> 
> Is this mitigated currently?
> 
> Not that git should be an enabler, but surely it falls on the user of
> untrusted software to ensure their own security?

Balls, I meant $GIT_WORK_TREE not $GIT_DIR

