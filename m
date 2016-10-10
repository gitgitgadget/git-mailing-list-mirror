Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C942B20989
	for <e@80x24.org>; Mon, 10 Oct 2016 19:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751708AbcJJT6l (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 15:58:41 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36522 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751609AbcJJT6k (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 15:58:40 -0400
Received: by mail-lf0-f65.google.com with SMTP id b75so11746562lfg.3
        for <git@vger.kernel.org>; Mon, 10 Oct 2016 12:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kAczJs5BzO/p3l1OrLQBCAHpxeJMxNrdSmIDSVyD7vk=;
        b=LrZqOw4FXsM2dHosJLoE3xnh80veidlLSLQokXYjSDjWZ6JM0Jves+sK9Dc3bqHi9b
         ztJmXNbue88hJOFBMbuQSkxERZG4XGj/baxuwMorIwq9wbsDpAOQe84Lns+hq4NGZe+b
         Cqr0oKjXTDgauAlFo/DUDYko+oiFO9DdmgcFkRxyjc33SVNAWBnmo+l54qeCNe1TD1Op
         ilSh7hy3W1wcMYaS+QU7OvxAG05PM7H0DMi9XFncRzKRAlNcjAKxyYTOGYU2M1P3RfWr
         nr7//WRqPl2IsUtu8UX7VQRRQYfd3lTrU6NcrxDnDAM8vvNW7oM/F2jLzqaj4TgNFEgD
         9xgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kAczJs5BzO/p3l1OrLQBCAHpxeJMxNrdSmIDSVyD7vk=;
        b=Q1i7+6ovUSIphUPNsQDKwUcC4fvZc0pyPo9XbKVqNjg1wb0QLEd3DD+7lrtmkiWLTI
         sLQFCSZlZtEOy7Y6wF+IZOFmoSNx++ApPbICyU9A94CMtgCR0QioT7gTMCiX76x7oaOs
         sRLz7b5n6P3xOip3zxDKCjrd1oorQh3U58gq8MGXhbRLklYY+f2uxfbIUhQb+2ufpRbS
         mpsCcZybKKLSeuduq1rLOhHMUpF/OYs02yI9v0tPK46EDHe/u44/aB3iOv+4aPf4tn4i
         Wmm0HN7VIsdJBMruitYqeimC5N7DMTYshyjpnpVWxy9sz0AV/9Bzrs8GqZU9A/jpJ+52
         kVow==
X-Gm-Message-State: AA6/9RkfGV7C/6VFxwnmqeQgfHfNlSq8m9KWP8zNbHtsjoDIMjTMYuNQPnXYh0IJJPfwlA==
X-Received: by 10.194.113.35 with SMTP id iv3mr31423136wjb.169.1476129518163;
        Mon, 10 Oct 2016 12:58:38 -0700 (PDT)
Received: from [10.42.1.91] ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id y2sm42689621wji.42.2016.10.10.12.58.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Oct 2016 12:58:37 -0700 (PDT)
Message-ID: <1476129516.7457.6.camel@kaarsemaker.net>
Subject: Re: [PATCH 1/2] submodule: ignore trailing slash on superproject URL
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     Stefan Beller <sbeller@google.com>, gitster@pobox.com
Cc:     git@vger.kernel.org, venv21@gmail.com
Date:   Mon, 10 Oct 2016 21:58:36 +0200
In-Reply-To: <20161010175611.1058-1-sbeller@google.com>
References: <20161010175611.1058-1-sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.0-2ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[And now with CC to the list, sorry Stefan]

On Mon, 2016-10-10 at 10:56 -0700, Stefan Beller wrote:
> Before 63e95beb0 (2016-04-15, submodule: port resolve_relative_url from
> shell to C), it did not matter if the superprojects URL had a trailing
> slash or not. It was just chopped off as one of the first steps
> (The "remoteurl=${remoteurl%/}" near the beginning of
> resolve_relative_url(), which was removed in said commit).
> 
> When porting this to the C version, an off-by-one error was introduced
> and we did not check the actual last character to be a slash, but the
> NULL delimiter.
> 
> Reintroduce the behavior from before 63e95beb0, to ignore the trailing
> slash.

Looks good to me, and fixes my simple testcase and cloning epiphany
with trailing slash. Thanks!

D.
