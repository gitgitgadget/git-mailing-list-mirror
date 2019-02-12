Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEFA21F453
	for <e@80x24.org>; Tue, 12 Feb 2019 00:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbfBLAJI (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 19:09:08 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34753 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727418AbfBLAJI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 19:09:08 -0500
Received: by mail-ed1-f65.google.com with SMTP id b3so676879ede.1
        for <git@vger.kernel.org>; Mon, 11 Feb 2019 16:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eh2mbznSCCkZMU2cQyFCSogsu9SDIcWXwShof/XRZUo=;
        b=NdUOuSuRVcH4nk/TJpSNT/RP0AFmxqCPofBDReXxiSgx5KI1S2I9cpWEpHvaCi5HOY
         648eVHYTJ27kTmWfZyO8HbYVX56R+ynis6FEcqizcttvCBUOwF6Kf8Zq9ch20OCUf2Dp
         02OQsylefWpo3yFxYiu7SUhuyScF9USqCk8VQpf7JTEiljAvw7xxF7bTkPWeCYzuvzZT
         2lIqY4KpKFOT7ylbOWR0r/vp/FXv4spgQB5/EXubXi79XEDUcvYqSYWL/edqs4hvUlM/
         l4xV70HsHk2G2AALHu6U9iMnPfizb68+AnkN57Oh+nbwpGSEaB3CTJLNZw0Mlc1Z0wQv
         GoBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eh2mbznSCCkZMU2cQyFCSogsu9SDIcWXwShof/XRZUo=;
        b=enUMJuN6l9V3QLbTz6c1vN5oMPmjHcnmFlRjn+nDgsm6AK3TAGjbJUfaXyMM27knU6
         Tiz9yIXxKxaIH3udw/PiSk60dXee2Lmi55b9vLWFgoOw5eWSVMvccW2bwuOed6b1RqHF
         dXsV7fFSTAI5kNko8XBF1k2p5Wii52F2u3+YDUGDlm+GSwN/pmuGNxQe3OM8P5UG55gN
         TPlBB/URPejmyfzLr+GLtTNf/VL5MkAGkF8SI2Ya9rjDY5HwpeYmG29eH9AaA4rW9efz
         m75dAiRf3SqqqAsvvQvr8fENh9oboCN9A/4Lqaik64Y/SVH2+DKZijM6/bQsqAWG1AHg
         Q1Dg==
X-Gm-Message-State: AHQUAuZSy5YoC11O4GdsK8dAughTbJKnl+OB70cfUlyqbhH0/Ozjws3m
        IK6sA/p2oeDdOKRkNmLmltTe16qPxJNzGpROrxo3eofs
X-Google-Smtp-Source: AHgI3IbKHGSFEqtDH6p1AdcAoyZ+MsO6hkawTuM/mPzPq7lQMgdhdvTTc19gYZusEaV+nYzV926PGpJ5nVylFFm0v0U=
X-Received: by 2002:a17:906:11c7:: with SMTP id o7mr519035eja.196.1549930146365;
 Mon, 11 Feb 2019 16:09:06 -0800 (PST)
MIME-Version: 1.0
References: <CAHd-oW4p6XUjF_j+XXwYWGt__L_5bTJGwxmgWhxJfpuAFac=dQ@mail.gmail.com>
In-Reply-To: <CAHd-oW4p6XUjF_j+XXwYWGt__L_5bTJGwxmgWhxJfpuAFac=dQ@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 12 Feb 2019 01:08:55 +0100
Message-ID: <CAP8UFD1_7kBcp1W1kg-C2DObMmYf=rb79MbXvzWhxH7fWf5GTQ@mail.gmail.com>
Subject: Re: [GSoC] Microproject on git-credential-cache
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, Feb 12, 2019 at 12:48 AM Matheus Tavares Bernardino
<matheus.bernardino@usp.br> wrote:
>
> Hi, everyone
>
> I've been contributing to the Linux Kernel for the past semester and
> I'm now looking to take my first steps in the git community. I'm also
> interested in GSoC 2019.

Thanks for your interest in Git!

> I started looking at https://git.github.io/SoC-2019-Microprojects/ and
> one that got my attention was "Move ~/.git-credential-cache to
> ~/.cache/git". But looking around at the code and the mailing list,
> this microproject seems to have been already solved at 60759ba
> ("credential-cache: use XDG_CACHE_HOME for socket", 2017-03-17),
> right?

Yeah, I think you are right. Sorry for not having the time to check by myself.

> For the microproject "Add configuration options for some commonly used
> command-line options", are there some options already known to be good
> for adding to configuration file?

Sorry, but I don't remember very well the previous discussions about
this, so I don't know if some presumably good have been mentioned yet.

> Finally, a non GSoC-related question. Just to confirm my understanding
> of Documentation/SubmittingPatches: I must send patches to the mailing
> list first and after some feedback from community, send to the
> maintainer with CC to the list, is that correct?

Yes, that's correct.

Best,
Christian.
