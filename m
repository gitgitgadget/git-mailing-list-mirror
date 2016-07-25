Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56949203C1
	for <e@80x24.org>; Mon, 25 Jul 2016 07:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751801AbcGYHvT (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 03:51:19 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34825 "EHLO
	mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750855AbcGYHvR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2016 03:51:17 -0400
Received: by mail-lf0-f65.google.com with SMTP id l89so10714538lfi.2
        for <git@vger.kernel.org>; Mon, 25 Jul 2016 00:51:16 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AurMD9FZoqN64/oi+NlBHD+D8u5qetK1Wmdfa2fbWLU=;
        b=gfgAmhQ1T3aETtimQ+ioMnX4ayZLJUjZ6yxKMZEIF2nYxv6vbirFavY0EkynWMKf3j
         z1JMkksnFjJ4S8wAjonzES+ePY+ed5TX4tuqcdXzYy4lSo2KoE6Qw6D3NHMy/W7HWNbt
         MIR/UTWDnl3kKsmYDa2cUeT/Ex8lTH2FArdqU1LLW15eFM/CAtD9EYlRMcaw2pIqlcyn
         narL6D6mwPz14UAl5C+kyTPsWnWCUfHzqdjq/73MSimltKc1ANeZDWNz/lxDdSmdi0fv
         kDYtCyzDtke6GHy4KRP6IlFz6yYkEDbO8ec16cMo4Dzgp87MFulm70tBTqTFdSqZyRDZ
         MucQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:user-agent
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=AurMD9FZoqN64/oi+NlBHD+D8u5qetK1Wmdfa2fbWLU=;
        b=PJK+6VPJWdRu6tR6GVjGvxLAqOyyBeWtOQsQxyWDvxo/yhB8AoFl50VtG14Gb6GJ/M
         NUC/3Sh4LYwVQHqHUdnbmVGUrtuHszEbsEeXqldiIRvsPFX4QnMwNhcFsYrRP0eIkeUL
         ZDFhlAvguhawLUW2dkeiQdf8FBcPzh8yIsm9AQj2EPMJ+U/H1pf3bsmt7/Dls/8QEBCs
         oxkyybdB7RKLs25z6MBYL9NOuKQqOeNbNtotEE9I6Du5uoF2BFzWFnk6A9vQ3Cnl6Bk7
         N8zSUyzjKdvHLidmnwDfehjGp2MPWoVOTUR8PmXj/XHJC0Nx4hqggC0GHOrv+zbARZi2
         oe5Q==
X-Gm-Message-State: AEkoous9xHhoFK2xCuzg12EAco2oTLTCinyKrejMQR/X0Xwati5TbClc5JlyBQ5fLbQP0g==
X-Received: by 10.25.91.149 with SMTP id p143mr6223021lfb.39.1469433075899;
        Mon, 25 Jul 2016 00:51:15 -0700 (PDT)
Received: from photon.localnet ([81.177.127.104])
        by smtp.googlemail.com with ESMTPSA id j64sm5351828lfb.31.2016.07.25.00.51.14
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Jul 2016 00:51:15 -0700 (PDT)
From:	Ilya Tumaykin <itumaykin@gmail.com>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	git@vger.kernel.org
Subject: Re: Bug: "git log --format='format:%+s%+b'" doesn't insert newline before body
Date:	Mon, 25 Jul 2016 10:51:13 +0300
Message-ID: <1693749.WYZjdcdZj5@photon>
User-Agent: KMail/4.14.10 (Linux/4.7.0-ACER-1830T; KDE/4.14.22; x86_64; ; )
In-Reply-To: <alpine.DEB.2.20.1607250926320.14111@virtualbox>
References: <8915446.47C9zkNvuX@photon> <alpine.DEB.2.20.1607250926320.14111@virtualbox>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Monday 25 July 2016 09:33:00 Johannes Schindelin wrote:
> Hi Ilya,
> 
> On Sun, 24 Jul 2016, Ilya Tumaykin wrote:
> > Steps to reproduce:
> > $ git init
> > $ >123
> > $ git add 123
> > $ git commit -v -m 'This is subject' -m 'And this is body'
> > $ git --no-pager log -1 --format='format:%+s%+b'
> > 
> > Actual results:
> > ```
> > 
> > This is subject
> > And this is body
> > ```
> > 
> > Expected results:
> > ```
> > 
> > This is subject
> > 
> > And this is body
> > ```
> 
> The empty line between commit subject and body is neither part of the
> subject nor of the body. That means that the above-mentioned expectation
> was incorrect.

According to 'git-log' man page '%+b' should insert linefeed "immediately 
before the expansion if and only if the placeholder expands to a non-empty 
string." Here "%b" expands to a non-empty string, thus I expect a linefeed 
before it. Or am I misinterpreting man page somehow?

> Unless you somehow allow empty commit messages (Git does not, unless you
> play games with low-level commands), the second '+' is unnecessarily
> conditional. Therefore "%s%n%+b" *might* do what you intended (I would not
> know, because that information was missing from the report).

I want to display '%B', but add colours to '%s'. Thus I have to separately 
include '%s' and '%b', and not just '%B'. I was using '%+s%n%+b' with extra 
colour formatting as a workaround for some time now.

> Ciao,
> Johannes

-- 
Best regards.
Ilya Tumaykin.
