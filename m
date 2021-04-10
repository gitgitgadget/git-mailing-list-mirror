Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C46A7C433B4
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 01:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 921986100A
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 01:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbhDJBm2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 21:42:28 -0400
Received: from out2.migadu.com ([188.165.223.204]:26992 "EHLO out2.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229665AbhDJBm1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 21:42:27 -0400
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cmpwn.com; s=key1;
        t=1618018933;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+JlauDyKJLe9UaSXdU00zx0W2VCbVSgq7QhpN3lPC14=;
        b=rrG060Grs+8hpE8YYzo14xme47K2G9uJ9u1sf72QkZlKk0Kf7QH+17CvYkr0KQuqGqNHPw
        3sTqetCzOi9TQtv7wHQqIUq1EXNqp10MydhFc7hhQTGGK+esD8F3g/BkBW51XZXLBL2avV
        DcXyupL10O/B6/Y9V+5CYErp9Nabq4M44i21WT8Uxflb5wS1FSAERhCKEtrWUjTTEQtrIu
        4E5aJv1Zv/I7i/zrjpwmQZCfT+Zpfjb/qi2sWSWOByK/tD2j2wcUtS4+CI1DjApMNOTQ+G
        YHzQl5s3vej+RS2JFmPiKzRqnyEYRdIPPe8jQy0G5XJ/of+NFXv2uLIMTIenuQ==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 09 Apr 2021 21:42:11 -0400
Message-Id: <CAJNUBUZNAXE.283NJ968IDN2X@taiga>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>
Subject: Re: [PATCH] send-email: clarify SMTP encryption settings
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Drew DeVault" <sir@cmpwn.com>
References: <20210409211812.3869-1-sir@cmpwn.com>
 <YHEB1ClofnD6nQWA@camp.crustytoothpaste.net>
In-Reply-To: <YHEB1ClofnD6nQWA@camp.crustytoothpaste.net>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: sir@cmpwn.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri Apr 9, 2021 at 9:39 PM EDT, brian m. carlson wrote:
> Since I agree that "ssl/tls" may be a bit confusing, maybe we could call
> that option "wrapped" or "tunneled"? Other names are possible, of
> course.

I would prefer to name the options after the terms we can expect the
user to find in their mail service provider's documentation, hence
SSL/TLS and STARTTLS. Though I can see the confusion in including the
slash, I'll figure something else out.
