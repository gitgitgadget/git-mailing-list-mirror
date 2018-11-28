Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F2601F609
	for <e@80x24.org>; Wed, 28 Nov 2018 09:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbeK1UEM (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Nov 2018 15:04:12 -0500
Received: from mout.gmx.net ([212.227.15.19]:60785 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727736AbeK1UEL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Nov 2018 15:04:11 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lhwt0-1ff8kH3HIg-00n89U; Wed, 28
 Nov 2018 10:03:11 +0100
Date:   Wed, 28 Nov 2018 10:03:11 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH] advice: don't pointlessly suggest --convert-graft-file
In-Reply-To: <20181127201255.3529-1-avarab@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1811281001411.41@tvgsbejvaqbjf.bet>
References: <82ccde9ed8a390133852a5d9e07ef471f94db263.1524955439.git.johannes.schindelin@gmx.de> <20181127201255.3529-1-avarab@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-856360490-1543395793=:41"
X-Provags-ID: V03:K1:3EHdxIDqux6joYoD8HB2UYNuqThry+W6WFTRTZMhPzeHy/K0NPA
 S6woobIitzdGREmaxm2HMbBGQZ8mjBmV27qNceJNFkdkj/25+4qFljS8AH4Tf8EQg1QUi58
 25a9Wv5Ja3NX3cJWBqPfFSLFzg/UJr6VIgN5uzylz3UEWKV8rlvfBJ9quz3Zu9FMdeMkQ0H
 PGHD6y4qPao9w66InlmeQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CWxnKMgi2QY=:rO4bVq/HnsvSkHTdafgWKL
 XMsKbZxvukPH23kE5/FSlKl+6G1u+sZRRNS+s3o1x94txuWwpEe5b267UrVQzWB4dCWp5KzUa
 mZiAaTqVYiWLAn/n8VyCBGO8SlWsHUFsPIoLpxWdiQKlXA0RSr24DFapkaxxVzMrVP8kZQscC
 DB8S9eZNNUjO8m1P50/JGuMWOPn0yGdCO49LJZkYRWdjIj9KvwcupgZt/J5+mHqAu3uplygkY
 tTMbwvohyxjx3+VQuksCN4VYCBg9pJ7oiH0uMR+BYWilImwogtPITkLLdBJUvycoh+ku2NBi7
 7zbzLoiUQN4zPRN3GuFlhTmZ9xifAFwR65YPYj72HqObYAYNmRhy9V6Mlv8m3zndxmqWlK48Q
 qcAkDPSwxC1PwDk7oAUBp+7Zxh7q6nuDosysn/h42XVmUvZ3fwURMmQekIxZWfZwWNpmNHyvt
 wAWbYC7dju/oRCYDiUjBCHsE8eAMlfY0LI9odI5tNrl/g+bTnZf+RjaqX7Hqm09hkLWsv4MzA
 Eh3LLkL/q1HHYgaF+WDItDMlomUHy+wc9oWHyWo1QGj25OeQnhqosQ5HRnjjacne7THzdgJA3
 XVvycYhRoKEatgKNYKDmQFg27/ZxaFhwo4puCpssIH/O7ZMFXlO9IUI5B0tRdz1WIeqjGMyP0
 XoIZ+QZYSdgFwiYcqtxb5iPOrhko4KzthQeIPyA+0MD1gny8xnRfY1W8iGPVbjxefNjXoeknF
 Dr7ADbZC6kxfIdxHv2zYTsZi1JKwMMBvXd/cSQcZO1OGM3qA0TtQgb18sgRmQOYiHlxYWHzzT
 cUsymIaQsEZj/vLRyAo5BK6JdrPsyeavORek4fg3AbzJf4MdYQEFMxewIAEeEjE0LZG8xbvMC
 VfPRw2NDg5gvVxWr/c8gVQwqmCf0fIu7keUoYQJcoq7AvAkkQtlRcDicYq+sgc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-856360490-1543395793=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Ævar,

On Tue, 27 Nov 2018, Ævar Arnfjörð Bjarmason wrote:

> The advice to run 'git replace --convert-graft-file' added in
> f9f99b3f7d ("Deprecate support for .git/info/grafts", 2018-04-29)
> didn't add an exception for the 'git replace --convert-graft-file'
> codepath itself.
> 
> As a result we'd suggest running --convert-graft-file while the user
> was running --convert-graft-file, which makes no sense. Before:
> 
>     $ git replace --convert-graft-file
>     hint: Support for <GIT_DIR>/info/grafts is deprecated
>     hint: and will be removed in a future Git version.
>     hint:
>     hint: Please use "git replace --convert-graft-file"
>     hint: to convert the grafts into replace refs.
>     hint:
>     hint: Turn this message off by running
>     hint: "git config advice.graftFileDeprecated false"
> 
> Add a check for that case and skip printing the advice while the user
> is busy following our advice.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  builtin/replace.c  | 1 +
>  t/t6050-replace.sh | 5 ++++-
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/builtin/replace.c b/builtin/replace.c
> index a58b9c6d13..affcdfb416 100644
> --- a/builtin/replace.c
> +++ b/builtin/replace.c
> @@ -495,6 +495,7 @@ static int convert_graft_file(int force)
>  	if (!fp)
>  		return -1;
>  
> +	advice_graft_file_deprecated = 0;
>  	while (strbuf_getline(&buf, fp) != EOF) {
>  		if (*buf.buf == '#')
>  			continue;

As long as we keep this code in the one-shot code path, it is probably
okay. Otherwise we'd have to save the original value and restoring it
before returning from this function.

But then, we might never move `convert_graft_file()` into `libgit.a`.

Thanks,
Dscho

> diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
> index 86374a9c52..5d6d3184ac 100755
> --- a/t/t6050-replace.sh
> +++ b/t/t6050-replace.sh
> @@ -461,7 +461,10 @@ test_expect_success '--convert-graft-file' '
>  	printf "%s\n%s %s\n\n# comment\n%s\n" \
>  		$(git rev-parse HEAD^^ HEAD^ HEAD^^ HEAD^2) \
>  		>.git/info/grafts &&
> -	git replace --convert-graft-file &&
> +	git status 2>stderr &&
> +	test_i18ngrep "hint:.*grafts is deprecated" stderr &&
> +	git replace --convert-graft-file 2>stderr &&
> +	test_i18ngrep ! "hint:.*grafts is deprecated" stderr &&
>  	test_path_is_missing .git/info/grafts &&
>  
>  	: verify that the history is now "grafted" &&
> -- 
> 2.20.0.rc1.379.g1dd7ef354c
> 
> 
--8323328-856360490-1543395793=:41--
