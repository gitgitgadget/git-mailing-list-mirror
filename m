Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C75A61FADF
	for <e@80x24.org>; Thu, 18 Jan 2018 14:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932352AbeAROrL (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 09:47:11 -0500
Received: from mail-wr0-f174.google.com ([209.85.128.174]:41052 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932257AbeAROrK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 09:47:10 -0500
Received: by mail-wr0-f174.google.com with SMTP id o7so22810228wro.8
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 06:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=4+fexLLGLgXxFBim1eCAY+sSYB1ZnV+YYEv4DKh40HY=;
        b=On8kQJHzgO5TAZa258nXuSAR3VD16UoeFLCvIEgauEoi+7PqbwjtnpYNml7oogEupy
         mjHp0gFAPKHYxwSdehpRDyVW8weUlsyzlotIfFRs4K0owM9G5Q6X1Lz3AVCJBi28BwyV
         Wz8chj8bSmA6nERMKOe71U3iTqkfjdOlnNctF2Se7263Hhix3MU7sBmX8srkMBw3C5sa
         8Y6ZMOxfR18p72st3JuekfSFteScZr19MoR1cBCZSuH43BN8JRnwjvidKXUoIblICzMu
         a5VXamZ5Z4Jsah1D7hcOo2YFYXf/j41/Q3MtNtrLWy8oc/Y8W3AEobHvvX7E1lk/d3zx
         qhvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=4+fexLLGLgXxFBim1eCAY+sSYB1ZnV+YYEv4DKh40HY=;
        b=QOb2uOgfaqGx/Fcr/7EccUFk3pROnnpYjUYOQIMjkt9zRd7WycxVliDzxWr1QRZv5e
         Roow0GK0v0guceoBVEVaj+JDj+DsJzaREXAx2EDxHL1PCivfOhFZ8nG748IhhMhbi2u/
         DvW5bXCG7azMRFiS5A/GaHdIzidMpeVDGehqcmVmMxuEMdG+73npmTpFz/i08iIr/Q66
         g0CnQdtnSHblouQ10k53p712NLmdchhExHtj4fPMJIPBlxZArHklP4oD9ZVjH7UfddM5
         ebhNhx8s7dD0eE7qVU5IFc/FxejGaVG1MKtynE0yjrn/vQsA3FsZq/+lQSHSanF9aNl1
         7YPw==
X-Gm-Message-State: AKwxyteZEnQEnEOCQ0F0G0TjSyc8mmc8HC6tox9Uqk3NhY8Aw+oi5T7q
        F2gFC0SkttFL9f8mUTmnjU0=
X-Google-Smtp-Source: ACJfBov/7vA5hErRQuWFeItGvIrsDHd333yNZnNCx0kLnlX4JGiUoI/fVwmQm0YH7pQKsX97qWBk+w==
X-Received: by 10.223.135.187 with SMTP id b56mr5381477wrb.164.1516286829701;
        Thu, 18 Jan 2018 06:47:09 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id m6sm7480784wmd.37.2018.01.18.06.47.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Jan 2018 06:47:08 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     raikrishna76@gmail.com
Cc:     git-packagers <git-packagers@googlegroups.com>,
        git@vger.kernel.org, Michael Felt <aixtools@gmail.com>,
        Thom May <thom@may.lt>
Subject: Re: Git For Aix 6 and 7
References: <157d942b-99a9-4a75-92b9-8eb8adb17032@googlegroups.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.0-alpha3
In-reply-to: <157d942b-99a9-4a75-92b9-8eb8adb17032@googlegroups.com>
Date:   Thu, 18 Jan 2018 15:47:07 +0100
Message-ID: <87d127i5qs.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jan 18 2018, raikrishna jotted:

> Hi Team,
>
> I have an urgent requirement to install Git client for Aix 6 and 7, could
> you please help send me or navigate me to the correct url.
> My present infrastructure comprise of Aix and Linux servers , I am
> successfully using Git on Linux however I am struggling to find correct
> package for AIX platform.
>
> Appreciate your quick response.

Hi raikrishna. The git-packagers list is a rather small list so perhaps
someone on the general git list (CC'd) knows the answer to this.

I'm not aware of anyone providing binary git packages for AIX, but I
don't use it so maybe they exist.

The last mention on the mailing list I could find of someone packaging
it was this from Michael Felt's (CC'd)
https://public-inbox.org/git/CANvxniXkbAKgjm+NZ0cyyCToEYp23Kd8s4yxSqUOsAUAHJSA7g@mail.gmail.com/

The last AIX-related patch to git is actually mine, but I haven't logged
into an AIX box in over a decade, see
https://github.com/chef/omnibus-software/commit/e247e36761#diff-3df898345d670979b74acc0bf71d8c47

So it looks like there's a chef build recipe for it, maybe that's
something you can use?

I would not be surprised if building git on AIX, particularly with a
non-GNU toolchain, fails in all sorts of interesting ways. People here
on the list would be happy to help you work through those failures,
we're keen to port git to whatever we can get our hands on, but these
platforms experience quite a bit of bitrot.
