Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 218DC1F87F
	for <e@80x24.org>; Sun, 11 Nov 2018 01:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbeKKLMY convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sun, 11 Nov 2018 06:12:24 -0500
Received: from mail-qk1-f179.google.com ([209.85.222.179]:39821 "EHLO
        mail-qk1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbeKKLMY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Nov 2018 06:12:24 -0500
Received: by mail-qk1-f179.google.com with SMTP id e4so8027866qkh.6
        for <git@vger.kernel.org>; Sat, 10 Nov 2018 17:25:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=svOslq9k/ZTbC/aIfSyOSDZHCqZXYJSI/u17MYgy5kM=;
        b=CMfCG91Pzq11mohLLZhbnYWw+GIdFnqBrjdqoQkDlsr1OA/HBdBwixWbJ4Z1m924KF
         J1k72bO8RauXCfEwgqp4InrDaCqzUJLCn5iyQflTjo/WIwoZi0tgNPc26pwe3X4ywtNS
         K9Dp6F/8f2ULwZldwtgR4TWVTvfN+BXGW8hjEz2w0QO64iQCeXTuzngw+S0d7nsDIrCz
         LkMf0UHpDM9/gt8BFAPBgNZPjnZKyBVJfhHSBeoS1Eg4law6aPw/yUdO9XDqh30andFc
         QeHrjZNCk+njyP1QKEyIMNKswZGGp2qDoXFTutZKcOfSgJNH1g2z+gJZe374ERrqot87
         /m9A==
X-Gm-Message-State: AGRZ1gITjihlQgtm3x/SFj9mt+tcEdeJwwi86/jba/w7JCD0QcbxwGNl
        ECZN5l032aP7p6haBigbiDOTk6NOTmgdqxwD0XQ=
X-Google-Smtp-Source: AJdET5fjJEOg4rDxedtqIuvktMKwE9fq+ylkYzuy9uZF8kWbTkinjwwi7Bv/0GPU3YmdkIca7ldqHkxSuJFh9pMQrxY=
X-Received: by 2002:a37:5e42:: with SMTP id s63mr13152382qkb.220.1541899526815;
 Sat, 10 Nov 2018 17:25:26 -0800 (PST)
MIME-Version: 1.0
References: <CAEv5rCuQM_6ch3KX1ji9nY0hW9eFVomO3svg79D67PqR1uY1tg@mail.gmail.com>
In-Reply-To: <CAEv5rCuQM_6ch3KX1ji9nY0hW9eFVomO3svg79D67PqR1uY1tg@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 10 Nov 2018 20:25:16 -0500
Message-ID: <CAPig+cTi424HcvV29NmeS3t+VV1mEmQx=pdgSpkXs5QX4HAd5w@mail.gmail.com>
Subject: Re: Git Reference Manual enhance
To:     inredikawb@gmail.com
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 10, 2018 at 7:21 PM Fredi Fowler <inredikawb@gmail.com> wrote:
> Is there any way to create pull request to git man (https://git-scm.com/docs)?

That website is maintained as a project separate from Git, so you can
report issues specific to the website, or create pull requests, at its
project page (https://github.com/git/git-scm.com), however...

> I found there some inconsistencies. For example, almost in all pages
> are using [no-], but at https://git-scm.com/docs/git-merge each
> command (with [no-] or without) write separately.
>
> There are some same inconsistencies that a easy to fix. So, if I can
> sent a pull-request for such fix – inform me.

Those manual pages are generated from documentation sources in the Git
project, thus those fixes should be submitted to Git itself, not to
the website project. Changes to Git are sent to this mailing list as
patches (see Documentation/SubmittingPatches), although see
gitgitgadget[1], which acts as a Github
pull-request-to-Git-mailing-list gateway, as a possible alternative.

[1]: https://github.com/gitgitgadget/gitgitgadget/blob/master/README.md
