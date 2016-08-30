Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C7201F6C1
	for <e@80x24.org>; Tue, 30 Aug 2016 20:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756549AbcH3U6x (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 16:58:53 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:35720 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755391AbcH3U6v (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2016 16:58:51 -0400
Received: by mail-qt0-f193.google.com with SMTP id q11so1064035qtb.2
        for <git@vger.kernel.org>; Tue, 30 Aug 2016 13:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OoC22LJUfd03XOb5Hy7qTvuu8aZWzDalEq8N5HlaUGo=;
        b=ow00vnUkj+pbXd5uaIYzuCvvnWVHrwBsGbrF2WHaUnRTcpRmuZUbp2SFCmOb3vSLNe
         a8EfGolPA8g6ZHr0mWsc7yWlYiiT4Vvlzwx7H/7otELzWfvW4XMhITGf4qZErQVNaPiS
         SPig81Uy64Jtfwr+N7CMX9WVvKLjRmtNRc7Jc29/dZ19S0/F3EJluRCJwmcX8Ikc+rgz
         K1Lwgi1mUnI6VO9gxa3ziDLYNm/JrbZ79L7IXwgXdMnimtdp24fzIu+tX6nez4kt2RyW
         J3dtIT3ZradfvA4qPefR7pimOf5k7T1/5JJJisuiEg29X9BPskfdIO1nkPPM//ZO4iR+
         q41g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OoC22LJUfd03XOb5Hy7qTvuu8aZWzDalEq8N5HlaUGo=;
        b=gDvN/rX01CzWc2kIC7MR3wUmI7nl36Btqc5V1nDr5sJ3QEoeAMg9qhi4ibFbBYm7La
         HYO3h+w4INCwe+NL77La6br4lNIfWBafbDejHG0kUmA3hfIw10vu8HkrV72fL4LB3spb
         /94gv1MzfnH31dLtjAOfc3+zvdXaD9/VjOqGTdRGMXAbwD/boP8PK0R0HqXnYiXSRtYn
         rahRrA+hY2piOUTx/f6yl0pbF58crEl6lERSjADx3tfwdSg0RiVCHNqU96WubmWjdU4N
         JjgXWIhufsVQkgOqO6iyoVUp28JRvz8mI7/QCSP0Ty/nYf5x+RUWY3w/ZU+w+0vZMCdS
         ahhw==
X-Gm-Message-State: AE9vXwN0mr7DfJPyCVlRqkEDIB7BOKnyjKU+IxXqWdXdnS4uSoeQ2YvS6asmiGB3aCb2MUD3ZdsiCyDZmaUvzg==
X-Received: by 10.237.36.252 with SMTP id u57mr6913095qtc.39.1472590730495;
 Tue, 30 Aug 2016 13:58:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.87.193 with HTTP; Tue, 30 Aug 2016 13:58:30 -0700 (PDT)
In-Reply-To: <20160830205151.k6ufhfzl6gh4uuog@sigill.intra.peff.net>
References: <b2d016e44fa04e8a318967c43762d6933faf7956.1467183740.git.johannes.schindelin@gmx.de>
 <0dfa96b17edfe84ba19c7e57fe0b017c77943e0c.1472478285.git.johannes.schindelin@gmx.de>
 <CACBZZX6iEmbb68tzRKNAryp5qmt=iU9FMuOe2ONV=2ojcazoEg@mail.gmail.com> <20160830205151.k6ufhfzl6gh4uuog@sigill.intra.peff.net>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 30 Aug 2016 22:58:30 +0200
Message-ID: <CACBZZX4NyjkK0Nf1JVGFRhc0xnLYg2YX6ctO5OxK3Pi60r5KaA@mail.gmail.com>
Subject: Re: [PATCH v2] t/Makefile: add a rule to re-run previously-failed tests
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 30, 2016 at 10:51 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Aug 30, 2016 at 10:48:19PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> >  -failed: $(patsubst trash,,$(patsubst directory.%,%.sh,$(wildcard tra=
sh\ directory.t[0-9]*)))
>> >  +failed:
>> >  +      @failed=3D$$(cd '$(TEST_RESULTS_DIRECTORY_SQ)' && \
>> >  +              grep -l '^failed [1-9]' $$(ls -t *.counts | \
>> >  +                      sed 'G;h;/^\(t[^.]*\)-[0-9]*\..*\n\1-[0-9]*\./=
d;P;d') | \
>> >  +              sed -n 's/-[0-9]*\.counts$$/.sh/p') && \
>> >  +      test -z "$$failed" || $(MAKE) $$failed
>> >
>> >   prove: pre-clean $(TEST_LINT)
>> >         @echo "*** prove ***"; $(PROVE) --exec '$(SHELL_PATH_SQ)' $(GI=
T_PROVE_OPTS) $(T) :: $(GIT_TEST_OPTS)
>>
>> I don't at all mind this solution to the problem, if it works for that's=
 cool.
>>
>> But FWIW something you may have missed is that you can just use
>> prove(1) for this, which is why I initially patched git.git to support
>> TAP, so I didn't have to implement stuff like this.
>
> Heh. I think each iteration of this patch will be destined to have
> somebody[1] point Johannes at prove. ;)
>
> (But I really do recommend prove if you can use it).
>
> -Peff
>
> [1] http://public-inbox.org/git/20160630063725.GC15380@sigill.intra.peff.=
net/

Sorry about that, I see it's been mentioned already. My only excuse is
that I don't know how to operate my E-Mail client :)
