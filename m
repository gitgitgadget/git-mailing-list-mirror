Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9D1220C33
	for <e@80x24.org>; Thu,  7 Dec 2017 21:08:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752194AbdLGVIJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 16:08:09 -0500
Received: from mail-wr0-f171.google.com ([209.85.128.171]:42860 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750862AbdLGVII (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Dec 2017 16:08:08 -0500
Received: by mail-wr0-f171.google.com with SMTP id s66so8888459wrc.9
        for <git@vger.kernel.org>; Thu, 07 Dec 2017 13:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=RGAPMqRNNiaQQoNIsWVhMRETm7N99jZoNVvSG3yGf04=;
        b=awAnAGo0SWu56SXfpukOw0gHj9TxWaMJJrzY0HqwUGuLc0rMq+XHFi+jsW2om4U52E
         D0cUfkx2t5tbSFFStvDNcgkHH8+kzs+FnZJ1V0/Pn+EEpm+rg1aoTJpwx/S3lUvD4Tdz
         W2tfjcOvTdzTtZTYRLPK8QfalfjX50aD0HDlii+6ChMYyUeHL/sccZgtBKIbZ8ZcGcOV
         KYH3w3TZzfEXK5Sj2jdBdLhEizwxhA9mASqvP6orkTMJ7f6EiIMOHG1wLVTzX27zRnJG
         6moRVERfrQmlu73bhWjOaW1aGlcEGH1hgclJtlmFp20Qsds/mUiE8Zmu4DiVsBacZzWl
         H03A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=RGAPMqRNNiaQQoNIsWVhMRETm7N99jZoNVvSG3yGf04=;
        b=XukDIJiojDUMcvR4u2hbPCKJ1T7XeyDdYpdABZlmNg2VdsdnkvdkNpVqOkdNzJ/xXA
         /NxtmsKnhyKyc6IfKnubfyVOfRv6vt7oFuI1Ar02z4baZrMgH8FNsoBg5wJIV4YIhCxW
         +NSbdhq6rhnhJFCRwJDBBvhy3nTmNt9sITxpojtJv6nytTgdRzyQMVicUs4z+oJjRFRS
         rUF0Rte0M03hrGZgfZKX4hZ+ipF6kXY27SNsa6N8BRuj1Su5oLga4rOgL3j2zjv5p87B
         t5VsdfMf9+SlUPRcG1ucbkfI7MR9CaTR16GUQZ4xdpGeFCHfn+Hd+HuDHROupa4ZcMth
         BFFw==
X-Gm-Message-State: AJaThX7HHiTmF0YYAAjLbavMXXNktv6TSFJQzlLJ53aBXhQyh9upES7R
        j1vs9AqR8vBzRvV/p6mwAlI=
X-Google-Smtp-Source: AGs4zMa5NoKL/9u7plNCqelm3cp4FVLRX1NB4cmsezMfujlr5mfqxmQIt93KovY1k1uQhNSgYTwMqQ==
X-Received: by 10.223.195.22 with SMTP id n22mr27117431wrf.212.1512680887590;
        Thu, 07 Dec 2017 13:08:07 -0800 (PST)
Received: from slxbook4.fritz.box (p5DDB720E.dip0.t-ipconnect.de. [93.219.114.14])
        by smtp.gmail.com with ESMTPSA id q2sm66594wma.19.2017.12.07.13.08.06
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 Dec 2017 13:08:06 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: What's cooking in git.git (Dec 2017, #01; Mon, 4)
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqlgiecleo.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 7 Dec 2017 22:08:02 +0100
Cc:     Todd Zullinger <tmz@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <71F9850F-5D7F-4CDE-8408-E000ADD48406@gmail.com>
References: <xmqqmv2ykvy4.fsf@gitster.mtv.corp.google.com> <DA960DCE-0635-47CF-B3C4-8133021799F1@gmail.com> <alpine.DEB.2.21.1.1712071643410.4318@virtualbox> <20171207202201.GA3693@zaya.teonanacatl.net> <xmqqlgiecleo.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 07 Dec 2017, at 21:50, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> Todd Zullinger <tmz@pobox.com> writes:
>=20
>> Johannes Schindelin wrote:
>>> That is not the only thing going wrong:
>>>=20
>>> 	https://travis-ci.org/git/git/builds/312551566
>>>=20
>>> It would seem that t9001 is broken on Linux32, t5616 is broken on =
macOS,
>>> and something really kinky is going on with the GETTEXT_POISON text, =
as it
>>> seems to just abort while trying to run t6120.
>>=20
>> I thought the verbose logs from the test might be useful, but looking
>> at the travis output for that job[1], there's an unrelated problem
>> preventing the ci/print-test-failures.sh script from running =
properly:
>>=20
>>   $ ci/print-test-failures.sh
>>   cat: t/test-results/t1304-default-acl.exit: Permission denied
>>   =
------------------------------------------------------------------------
>>   t/test-results/t1304-default-acl.out...
>>   =
------------------------------------------------------------------------
>>   cat: t/test-results/t1304-default-acl.out: Permission denied
>>=20
>> [1] https://travis-ci.org/git/git/jobs/312551595#L2185
>>=20
>> I didn't see the same failure for other build targets at a glance, so
>> the permission issue might only be a problem for the linux32 builds.
>=20
> Curious. =20
>=20
> The acl stuff hasn't changed for a long time and I do not think of a
> reason offhand why the test should behave differently between say
> 'maint' and 'pu', yet 'maint' is passing while 'pu' is not...


My recent 657343a602 (travis-ci: move Travis CI code into dedicated =
scripts,=20
2017-09-10) change might have broken that somehow...

See this comment:

# If this script runs inside a docker container, then all commands are
# usually executed as root. Consequently, the host user might not be
# able to access the test output files.
# If a host user id is given, then create a user "ci" with the host user
# id to make everything accessible to the host user.

=
https://github.com/git/git/blob/95ec6b1b3393eb6e26da40c565520a8db9796e9f/c=
i/run-linux32-build.sh#L16-L20

- Lars=
