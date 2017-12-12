Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD0FD1F406
	for <e@80x24.org>; Tue, 12 Dec 2017 18:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752307AbdLLSnU (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Dec 2017 13:43:20 -0500
Received: from mail-ua0-f181.google.com ([209.85.217.181]:38733 "EHLO
        mail-ua0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752102AbdLLSnT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Dec 2017 13:43:19 -0500
Received: by mail-ua0-f181.google.com with SMTP id i4so15073454uab.5
        for <git@vger.kernel.org>; Tue, 12 Dec 2017 10:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gdPXHX2PaLMaQhHviNHWt5ui1NLo9H9LNkLsQev3LRQ=;
        b=AJb2cpZmB37MEopYt3ZjC7DoQZTvAaJ3gMWSJvhA25L/VXG3Cb8jhUFpY7wwdWGg3Q
         Hw8fMBF/JVM6m3O/Jb0Ai3J49yIX6o2ymGDatUBOyrqTB3w8Vt9ebbOW5nOtVTlxq9AX
         W6D9bTGfF1ryPF53HTIuJFdURrvT3e3xjaDxB7k/I52C5PWANc9xYrT0kMU+LsgREIUg
         gyM7HUQeMThqVT4HG4NG5M5SDKxh7sdKa5a9msOrqB6oqSMDZ0Tw5t9tGEQ/aq1k/do9
         KzzpUfmyqUrCwyjYXjQjB8LNiAleiIYSmb6relROatCQXezxW5n5/g3xVydvT/A+lTgC
         Fb9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gdPXHX2PaLMaQhHviNHWt5ui1NLo9H9LNkLsQev3LRQ=;
        b=fcD7qcZWnqHK++fGb+iS3cUgwPG/cS9R4+EWnoh9998b6HrvoCPtFFQOy9oU8aC73R
         SFstuAss62VpmAih6Yu5jDNnwjDcOQ4QNbnBxNTTN4EvOiXe90Ovu25A+WCHMYrYxNOl
         p555bUzLrQrtKeh+t0tTMB2X2MaL5I7CxV2urArlQvqwxBgI2Cf43KkBCTTbhzK3nZuZ
         LIfRIFs5g9lRLoLp0DSxVXu83u0nC+nm2tDtKeaUc8HHXtln7TEhkqmZLHeoaOnEUyfX
         t9U37wF58aM4QWQgi6J10NvZa8L4MMYvTrXpgrwihCl2e7SGuVwPQzLxtvumuofDevtp
         ejgw==
X-Gm-Message-State: AKGB3mKiB3tSmiib5bK8CG1p6M/g7xfNrPY38lJ1k7r/VgKLD+fskAuT
        Ckx5rMvSBRbxjN1QOOIJIdjnvlAFy5OOEN2mpxU=
X-Google-Smtp-Source: ACJfBos95oT+qetd3Rqn7nr3KVZdMwfa26s+VVrI82JtZNG1B8MSL9g7j35aEdKtzJRyZZP50MVhYX/CEA1tLjG8bDU=
X-Received: by 10.176.0.73 with SMTP id 67mr5350123uai.132.1513104198842; Tue,
 12 Dec 2017 10:43:18 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.73.240 with HTTP; Tue, 12 Dec 2017 10:43:18 -0800 (PST)
In-Reply-To: <9AAC2BCC-AA06-46F9-8E6E-1D99CD959FDD@gmail.com>
References: <20171101115535.15074-1-szeder.dev@gmail.com> <20171211233446.10596-1-szeder.dev@gmail.com>
 <20171211233446.10596-2-szeder.dev@gmail.com> <9AAC2BCC-AA06-46F9-8E6E-1D99CD959FDD@gmail.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Tue, 12 Dec 2017 19:43:18 +0100
Message-ID: <CAM0VKjkVw8QeDErDg9aXcQ1sAgY34eBEeA0QJGamvEEBOG8y9w@mail.gmail.com>
Subject: Re: [PATCH 1/4] travis-ci: use 'set -x' in 'ci/*' scripts for extra
 tracing output
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 12, 2017 at 7:00 PM, Lars Schneider
<larsxschneider@gmail.com> wrote:
>
>> On 12 Dec 2017, at 00:34, SZEDER G=C3=A1bor <szeder.dev@gmail.com> wrote=
:
>>
>> While the build logic was embedded in our '.travis.yml', Travis CI
>> used to produce a nice trace log including all commands executed in
>> those embedded scriptlets.  Since 657343a60 (travis-ci: move Travis CI
>> code into dedicated scripts, 2017-09-10), however, we only see the
>> name of the dedicated scripts, but not what those scripts are actually
>> doing, resulting in a less useful trace log.  A patch later in this
>> series will move setting environment variables from '.travis.yml' to
>> the 'ci/*' scripts, so not even those will be included in the trace
>> log.
>>
>> Use 'set -x' in 'ci/lib-travisci.sh', which is sourced in most other
>> 'ci/*' scripts, so we get trace log about the commands executed in all
>> of those scripts.
>
> I kind of did that intentionally to avoid clutter in the logs.
> However, I also agree with your reasoning. Therefore, the change
> looks good to me!

Great, 'cause I'm starting to have second thoughts about this change :)

It sure helped a lot while I worked on this patch series and a couple of
other Travis CI related patches (will submit them later)...  OTOH it
definitely creates clutter in the trace log.  The worst offender might
be 'ci/print-test-failures.sh', which iterates over all
't/test-results/*.exit' files to find which tests failed and to show
their output, and 'set -x' makes every iteration visible.  And we have
about 800 tests, which means 800 iterations.  Yuck.

Perhaps we should use other means to show what's going on instead, e.g.
use more 'echo's and '--verbose' options, or just avoid using '--quiet'.
And if some brave souls really want to tweak '.travis.yml' or the 'ci/*'
scripts, then they can set 'set -x' for themselves during development...
as the patch below shows it's easy enough, just a single character :)


G=C3=A1bor


>>
>> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
>> ---
>> ci/lib-travisci.sh | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/ci/lib-travisci.sh b/ci/lib-travisci.sh
>> index ac05f1f46..a0c8ae03f 100755
>> --- a/ci/lib-travisci.sh
>> +++ b/ci/lib-travisci.sh
>> @@ -23,7 +23,7 @@ skip_branch_tip_with_tag () {
>>
>> # Set 'exit on error' for all CI scripts to let the caller know that
>> # something went wrong
>> -set -e
>> +set -ex
>>
>> skip_branch_tip_with_tag
>>
>> --
>> 2.15.1.421.gc469ca1de
>>
>
