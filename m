Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1C491F453
	for <e@80x24.org>; Thu,  1 Nov 2018 11:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbeKAUZW (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Nov 2018 16:25:22 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:50184 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727644AbeKAUZV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Nov 2018 16:25:21 -0400
Received: by mail-wm1-f48.google.com with SMTP id h2-v6so1067155wmb.0
        for <git@vger.kernel.org>; Thu, 01 Nov 2018 04:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=UsJ/yYeY7e9/xBlOW1xQuYBFJQOUVWHS0vlGJUR51jQ=;
        b=UsTSkDa9Zl6eRAUMBqxuYX+eVUDvyGqYV+/8wpxG6PrvaO9IjCx1yiwCjOEGsQtGoq
         PNuN1kIcSP5e25k40b+61nG8Iul4iKaNTqPXd15gf0p6QwlcxFGsTSnhymKkop0Ax35x
         ywXgoOnhWQanj5724p20B1R9k/6ws4lKcBCTHzgeR69TX/VpzC+aKUusDPbDdRZIp65T
         m5AN2DXm1rSfxpgpwNF4IfgMEh7PO/5pW5nCjqZhy3TubWU3eRC/vmYmL0Zx+g0S9yte
         3pJ2Nx+/qBQEaGafqoxr9aHUJ6DrmSLk5VEJVmVqWF6OSoabsr+vwqsJwARwpvZF6VU8
         YWJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=UsJ/yYeY7e9/xBlOW1xQuYBFJQOUVWHS0vlGJUR51jQ=;
        b=JYn9JBj6P0xH7VjxwwXHm3AOnt/HTaXqQMsoSQKUrYueQLyFBglkqfe/OJ/3v7SILY
         HNx4EhY5OY3ZA9kY1gE7SY0t7vVBeXWOMX2NBubjFUK/n1WqJ19I5H1YvH2KK427Azml
         YDvOm2kp9TiRbfrkKc9CbIVpjguLC80IX9a2QJTr4nxyk+/X/pNpir2LJHCKmcaPT+uO
         VC7KJVAx7R45EVbSahqwPJ5cqZNgFy+mA9s8kQ1UNpeKm1Q/b35LdquigtVTWay9Y3jD
         Rn0IHgPK5uJShuW3JkFh44nUJb5BqGz4i0L3lWs52U8DdooSicreNX4hG0cUyROvsabO
         9+FQ==
X-Gm-Message-State: AGRZ1gJ3SgyU78M4xbtMmGZUuN3wqq91kOgZXOAjv5JP7Tsm1QGymozy
        y3o1eZJPiBu4TbFThE7J1q+X76yILaw=
X-Google-Smtp-Source: AJdET5ewyEnJ/d6rvCycIbFD2ZqZYyTLGtbswxtTrs3jQrVorc8zyh5Dtb82FRMbhAP1l6I+Cn8wWQ==
X-Received: by 2002:a1c:ce0e:: with SMTP id e14-v6mr2301081wmg.45.1541071368997;
        Thu, 01 Nov 2018 04:22:48 -0700 (PDT)
Received: from evledraar ([2001:981:2f6f:1:6765:91b4:348a:a673])
        by smtp.gmail.com with ESMTPSA id z18-v6sm18726478wrh.33.2018.11.01.04.22.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 04:22:48 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Nicolas Mailhot <nicolas.mailhot@laposte.net>
Cc:     git@vger.kernel.org
Subject: Re: [RFE] Please add name and email to git credentials
References: <6d8ef01ad9eb08d90cb9848eeaeabe6784b7b3e3.camel@laposte.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <6d8ef01ad9eb08d90cb9848eeaeabe6784b7b3e3.camel@laposte.net>
Date:   Thu, 01 Nov 2018 12:22:46 +0100
Message-ID: <87zhutjb3t.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 01 2018, Nicolas Mailhot wrote:

> A dev persona is not just a username, please add email (and probably
> also name) support to git credentials so the correct set for a repo url
> is automatically picked up by git

The "git-credential" helper needs to look at a URL like
git@github.com:git/git.git and decide that protocol=ssh, username=git,
host=github.com, path=git/git.git etc, because that's the credential we
need to lookup to push to.

Where would we get an E-Mail to lookup to pass to the helper? Are you
just asking that the helper git the result of $(git config user.name &&
git config user.email)? If so why can't it just look this up itself?
