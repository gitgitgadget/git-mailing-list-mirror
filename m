Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0D9B2090A
	for <e@80x24.org>; Mon, 20 Mar 2017 21:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753860AbdCTV5k (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 17:57:40 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:35476 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753165AbdCTV5i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 17:57:38 -0400
Received: by mail-io0-f173.google.com with SMTP id z13so38533175iof.2
        for <git@vger.kernel.org>; Mon, 20 Mar 2017 14:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=X7XwDdgqGki3/SMYZppmp2yLI5vlfuCw/cdzsCnZp1A=;
        b=de4aO7xE6uQREj5V1fSVpLnNaifl7in25PC4CU9AdhJPamV1aLed3e0UhJm7XG8btW
         xRU9827cuKp+EECh8ozMpNPB7uAbdE/ZxyC+XeGvpB77lM8DlEr08GBK/ln/HsW4E6gQ
         UEhjDdoFX+bG1uN63mGXXfT+dqXUpKCkFuYAZHLozysL+pPMmzR4oRK4A7OysoDuMHAq
         WXdJwAK8YSQ4SAC9xSP65IAgt/he7/LsMlQxjhvKO3Y47Ebks69QiAdJYxYuSdffrIS1
         nWJPhs8GHrSO5m8F6vgbI0sbsM4o4ncdsfZFkn1xV5TBCt5/cYcA4iQ8KxNCkdUgyMhI
         +Prg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=X7XwDdgqGki3/SMYZppmp2yLI5vlfuCw/cdzsCnZp1A=;
        b=mjzZO4hq+p1WgGl/jdMIDAI5CUQnAOCyyqG1le6YguD0qDAYiaPOTa4zn348+2dgcV
         4aiza5Gw0ebumb7x/UZ7bgGhJgd3qgyZbaaBspfkqquHPuH2a+mH3sCsFIR85iVxc/fi
         lv+UfPNmoXHS1m1DxMaYsFOMAM8YTtJZVXVTg6pTvpnQ/4uEh/6GmqW89YOtFB6/6ILz
         j3qGsRYViIyFvENjrXBcP9XmKmECTLpV9NI9lIu9aisEfirggYz3G0UDDUPK2J6viatB
         pVQEyEH+ynmiWW+4JUb/Qgn37OiN07Z8JmEGfe/cuD9+xLrQUIemMAURUE1uHSkMmEeh
         EWeA==
X-Gm-Message-State: AFeK/H2YeuB1Q53oSyUBgJ9YJcJxD5f6xR0KnXVSNqiyue3fAnQHYgzyynPTkXRmbQMwImDYFChbMwiV1EwXmQ==
X-Received: by 10.107.200.139 with SMTP id y133mr3243419iof.147.1490047044304;
 Mon, 20 Mar 2017 14:57:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Mon, 20 Mar 2017 14:57:03 -0700 (PDT)
In-Reply-To: <xmqq7f3jwzdo.fsf@gitster.mtv.corp.google.com>
References: <CACsJy8Du+WWWkx3wqRJYA=cyTdro=OOD7GWaFi29=h1_9yC+LQ@mail.gmail.com>
 <vpqa88hlghm.fsf@anie.imag.fr> <20170319131845.tl6o3t2nwicj2rug@genre.crustytoothpaste.net>
 <CACBZZX4FksU6NujPZ_3GZ45EQ+KdJj5G2sajtRipE1wbaA3URA@mail.gmail.com>
 <CACsJy8CQzo9K8N3xH_HJq=NjJVOUG9wawC4Mg+UuyFRZCPBpFw@mail.gmail.com>
 <20170320173237.GA188475@google.com> <xmqq7f3jwzdo.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Mon, 20 Mar 2017 22:57:03 +0100
Message-ID: <CACBZZX59KXPOEjiUKtZLN6zjO_xpiWve7Xga6q-53J2LwvfZyw@mail.gmail.com>
Subject: Re: Add configuration options for some commonly used command-line options
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Duy Nguyen <pclouds@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 20, 2017 at 7:56 PM, Junio C Hamano <gitster@pobox.com> wrote:
> One thing we may want to consider is why we have to even worry about
> scripts getting broken.  It is because people script around
> Porcelain, and that is because we have been too eager to improve
> Porcelain while neglecting plumbing for too long, to the point that
> some things are only doable with Porcelain (or doing the same with
> plumbing while possible are made too cumbersome).  I find it quite
> disturbing that nobody brought that up as an issue that needs to be
> addressed in this entire thread.

I very much doubt this describes anything but a tiny number of cases
where people are using the porcelain as an API.

People aren't going through the process of trying to find out how to
do something with a plumbing command, and then failing and falling
back to a porcelain command because the plumbing isn't complete
enough. They just use the porcelain because they're familiar with it
and scripting it works for them.

E.g. I just looked at both major Emacs modes for git now, magit &
vc-git, neither use "mktag", they just shell out to "git tag" for
making tags. I just went to the git-scm.com website and looked at one
open source GUI client I could "git clone", Giggle. It just shells out
to e.g. "git commit" to make commits, not "git commit-tree". The other
commands they're using are porcelain too. If they've used some
plumbing it's probably by sheer accident. E.g. they use ls-tree which
is plumbing, but don't use for-each-ref.

What's that Google SRE-ism again? Something like "People use the
reliability you provide them with in practice, not what you
advertise". Our porcelain is very stable, and so people use it as a
stable API, and not just for trivial scripts.

Which I think has some big implications for how we maintain the
porcelain & plumbing. Since people *will* use the porcelain, probably
no matter what we advertise to them or how good the plumbing is.
