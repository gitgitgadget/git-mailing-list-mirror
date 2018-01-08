Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2B391FADF
	for <e@80x24.org>; Mon,  8 Jan 2018 20:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756412AbeAHUtE (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 15:49:04 -0500
Received: from mail-qk0-f169.google.com ([209.85.220.169]:38293 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751597AbeAHUtD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 15:49:03 -0500
Received: by mail-qk0-f169.google.com with SMTP id j185so5077723qkc.5
        for <git@vger.kernel.org>; Mon, 08 Jan 2018 12:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8yz5/clVP50PWUTAeRtq45YQk5VyPvrh+zMKs962OFU=;
        b=WiQGlb9bO8m09rJItg4DpC6nCR3VM84GqxPu9/9mP506Hf1zBHjedj/C/LAuK0MDYF
         IjtdZhvLOKZGKVzv3mR+i9EC5SB43klrgok6G5rlOIvhluCecuEtqwPTizVO9XEI8EKG
         u0lVQlvAdmgCwgL0U89eyj3rbzGRpDZOcc7KAWjMfWhFYzDA9QNxxps6gD6XhkGyOBHQ
         tcJ8tHt1z6xLYf6+1bQgqzp8n5fybe2KIuubCQNlSdOtjw2mPqInGw334eNRoPkR6ocp
         HXGR4k85Qh4HE8nOcZcraWo9H7A9MvwsH67CqMzC0W7Eo3SxcXKtaOej2L0lIIcYHhUs
         8wXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8yz5/clVP50PWUTAeRtq45YQk5VyPvrh+zMKs962OFU=;
        b=WS++wu2hoWiyjClEO6hn0WUE01X042rO2ZELsUHjXP4ZcH21INDOyI5nK1i7/kRvAo
         Yy/lKiNd/s+SBde2MUgqP2c5UTbRLMuLrwv4MTJZVp4Erul6/XKhf4iMtkQpGRp756Ad
         BT018ivDEZpY6bJHdYM39XI2eQRXBjRb0Xtvocf9Wekg4LbzX66hFjl/wUZUmREbREQW
         vTNhW8Ch2yYuxkU4zq78z7/rP7JmjPdOTvCu11VLYKNQG2o96tQIHZxp5f7pQyGPEepN
         oOoq0UeTcNYXJJSv1AeQK/9pJZPMcipU6Wq7e/CLFKtCOUXYiWitERbvo0zwEOLQUlL5
         cM0g==
X-Gm-Message-State: AKwxytebKfopPzqyO7KB8s2NNivmeAH2fCBhXJI6t/CZksY5I8Uok054
        2ZLWUgCzuuYCTPync8+nOaUr80numQPeTP2dqaBLZA==
X-Google-Smtp-Source: ACJfBove/FBvrioIU4UWe9pbWkJgvwq4PufOoOK2OQi+JJ5Wa5+igQ14uOn0KiIixpZ1yXSAScffBzUA7gTVvJDX6ug=
X-Received: by 10.55.41.40 with SMTP id p40mr14268682qkh.133.1515444541913;
 Mon, 08 Jan 2018 12:49:01 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Mon, 8 Jan 2018 12:49:01 -0800 (PST)
In-Reply-To: <20180108204029.m42qyezojak4kohh@LykOS.localdomain>
References: <1515442320.3241451.1228399576.66D7DA96@webmail.messagingengine.com>
 <20180108204029.m42qyezojak4kohh@LykOS.localdomain>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 8 Jan 2018 12:49:01 -0800
Message-ID: <CAGZ79kZ8AXezcX1_5WJsUJMHiHCzj2B=Uj8+4K3VF+cC6mTCqA@mail.gmail.com>
Subject: Re: upstreaming https://github.com/cgwalters/git-evtag ?
To:     Santiago Torres <santiago@nyu.edu>
Cc:     Colin Walters <walters@verbum.org>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 8, 2018 at 12:40 PM, Santiago Torres <santiago@nyu.edu> wrote:
> Hi,
>
> I personally like the idea of git-evtags, but I feel that they could be
> made so that push certificates (and being hash-algorithm agnostic)
> should provide the same functionality with less code.
>
> To me, a git evtag is basically a signed tag + a data structure similar
> to a push certificate embedded in it. I wonder if, with the current
> tooling in git, this could be done as a custom command...

In that case, why not migrate Git to a new hash function instead
of adding a very niche fixup?

See Documentation/technical/hash-function-transition.txt
for how to do it.

Personally I'd dislike to include ev-tags as it might send a signal
of "papering over sha1 issues instead of fixing it".

push certificates are somewhat underdocumented, see the
git-push man page, which contains
       --[no-]signed, --signed=(true|false|if-asked)
           GPG-sign the push request to update refs on the
           receiving side, to allow it to be checked by the
           hooks and/or be logged. If false or --no-signed, no
           signing will be attempted. If true or --signed, the
           push will fail if the server does not support signed
           pushes. If set to if-asked, sign if and only if the
           server supports signed pushes. The push will also
           fail if the actual call to gpg --sign fails. See git-
           receive-pack(1) for the details on the receiving end.

Going to receive-pack(1), there is an excerpt:

      When accepting a signed push (see git-push(1)), the
       signed push certificate is stored in a blob and an
       environment variable GIT_PUSH_CERT can be consulted for
       its object name. See the description of post-receive hook
       for an example. In addition, the certificate is verified
       using GPG and the result is exported with the following
       environment variables:
...


Stefan
