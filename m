Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1735620958
	for <e@80x24.org>; Thu, 23 Mar 2017 19:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751554AbdCWT0U (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 15:26:20 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:38834 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751105AbdCWT0T (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 15:26:19 -0400
Received: by mail-wm0-f41.google.com with SMTP id t189so4798274wmt.1
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 12:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=B8Ai4LrQX/4Hj0kODTmUFYJdooloxWXgb12Wxyv+HQM=;
        b=OahsafZr+zvO9zr/WnmaPYMiIEJMzWrc3S56tqAAVe8rMLpYLMKw53AfEuDHa+UlmB
         Zt/twmkmhkNN2u8ElsKzEX5i7uTfXf6hjS5BEI7j2qZkS0awiIa+swFuUvoVMXyZuTVQ
         6neE12hD07NVwNWbJ6sAEqvWOnT4A547wzgyoH1nKrx5NL1bVqu+zpGmmc4ETCdFiyg5
         1R2x1Cg9HGUjBfbw5SlvViCjBTzfjcH2qCU9/QmVPuVLKjYKYkQEVHMwQ+R6LS8bFTqp
         UWkULjIgO36hoCCVH6NqTby7o42xUOkDEBFnQGNoM8RNINH8dbT1K6/ecEo+GTMjxq08
         gjjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=B8Ai4LrQX/4Hj0kODTmUFYJdooloxWXgb12Wxyv+HQM=;
        b=heIFUcefci/Cdv9+oWPHC9Z+9OAPXCEBMA+yKcDcn88RsXZTK6loP/uBTTQSJXMerE
         BPxgh0mB7UpKcnJLFYmItvrbA/Mt1q6RwdUYEyMCHkFVZ2ZdZ46XVULUUyS7wJdfbZXf
         uqsJVLMSzys7xZ5isPhvAHnPMmmsodv/b+C/NnHEtZJZxldigB9L34dtU5HKOxgPpeGN
         ojdFAfzOvXzPQKCVhXzmz98L7usNE8PHMzt+YuJOWAyyXBhXXfwfL0Z+eheZAADlLrhh
         CvrwVeCJNQGpoaQKfi6szfjUzYUmt37J4q+kDpRIqGfYUQwBRWDM8oENVbhyNGEflO8L
         amyA==
X-Gm-Message-State: AFeK/H33atrUmUDVggE42cvtNA4jdKX1VRTDZXMjzv/FXcoGOdyKzWvvrME7goRF1r7VOw==
X-Received: by 10.28.74.28 with SMTP id x28mr15009070wma.131.1490297177307;
        Thu, 23 Mar 2017 12:26:17 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB47D6.dip0.t-ipconnect.de. [93.219.71.214])
        by smtp.gmail.com with ESMTPSA id 32sm7037360wrr.64.2017.03.23.12.26.16
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 Mar 2017 12:26:16 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v1] travis-ci: build and test Git on Windows
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20170323191721.7r5vrixtnx3cngdc@sigill.intra.peff.net>
Date:   Thu, 23 Mar 2017 20:26:15 +0100
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <FE4A3F88-0B86-4069-B141-2DFB9C4E269E@gmail.com>
References: <20170322065612.18797-1-larsxschneider@gmail.com> <xmqqwpbhjej6.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1703231716320.3767@virtualbox> <20170323180134.geoyvq7qbm5vujo6@sigill.intra.peff.net> <xmqqbmsrdcz4.fsf@gitster.mtv.corp.google.com> <20170323191721.7r5vrixtnx3cngdc@sigill.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 23 Mar 2017, at 20:17, Jeff King <peff@peff.net> wrote:
>=20
> On Thu, Mar 23, 2017 at 12:12:15PM -0700, Junio C Hamano wrote:
>=20
>> Jeff King <peff@peff.net> writes:
>>=20
>>> For instance, if it's in the environment, can I push up a branch =
that
>>> does "set | grep GFW_CI_TOKEN", open a PR, and see it? I don't know =
the
>>> answer.
>>=20
>> I think the documentation said
>>=20
>>    Variables defined in repository settings are the same for all
>>    builds, and when you restart an old build, it uses the latest
>>    values. These variables are not automatically available to
>>    forks.
>>=20
>> so we should be safe as long as we do not build against PRs.
>=20
> I think we do build against PRs now. E.g.:
>=20
>  https://travis-ci.org/git/git/builds/213896051
>=20
> But it looks like we can turn that off.

When we add a secret variable, then TravisCI will not build Pull =
Requests
for git/git anymore:

"[...] we do not provide these values to untrusted builds,=20
triggered by pull requests from another repository."

See: =
https://docs.travis-ci.com/user/environment-variables/#Defining-Variables-=
in-Repository-Settings

However, I don't think that is a big deal because git/git doesn't
support Pull Requests anyways. Plus, if a contributor is interested
in TravisCI results, then the contributor can setup TravisCI for
their own fork easily.


>> On the other hand, perhaps a contributor may want to build and test
>> his own PR that may affect Windows platform, and such a contributor
>> may be helped if the main repository sets things up to build against
>> PRs.
>>=20
>> I personally think it is a separate issue and we shouldn't set it up
>> to build against PRs.  If Windows CI wants to help these
>> contributors, it can give out the token to them, without relying on
>> the travis setup for the main repository.
>=20
> Hrm, it does mean that people have no way to test on Windows until the
> branch hits pu. Which is not ideal.

I agree it's not ideal. But I think it is an improvement to check
pu/next/master/maint continuously :-)


Cheers,
Lars=
