Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB57D1FF76
	for <e@80x24.org>; Sat, 17 Dec 2016 16:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754218AbcLQQK5 (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Dec 2016 11:10:57 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33750 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752821AbcLQQK4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Dec 2016 11:10:56 -0500
Received: by mail-wm0-f68.google.com with SMTP id u144so10819259wmu.0
        for <git@vger.kernel.org>; Sat, 17 Dec 2016 08:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=7rcr9YQ3sTZGWtIwk9PR8lZDvDxhKfcg6bGazOWq5xw=;
        b=L4nMgbAoO132XyRsMX2tl6Fi/3xMp3yy0T1SXBM3Htm4UvYVPhYs4j45K75UCxPmJV
         Zphlm0Zv6YmDESgXhSyu7sl+ypzeA1mTn7sFgCo7w523SDRx8vo1WDyHzlq2CORidm9m
         IJPp6kg+B2EVD1iEcIWffPnY6BmcSDphtOP08zL/VNg8f5OCEgBn0hUjzTdqm68qm8f4
         Z1ghyC/jcaYb7lK/hMc4uBuXv6Npm1uwTDm9NQuAsaJgTLO+9z3S6pIEbArAR26EMvY2
         670OwBr+SHa9mia69pMu6mdCFjaJ71v8Lo56OWM/nJt3JUjFwAsXXdPFpl2qSdCooMkB
         M4ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=7rcr9YQ3sTZGWtIwk9PR8lZDvDxhKfcg6bGazOWq5xw=;
        b=VieCLspoUJBjdGsDSQhLDYk6nspteihapi0tGTEWoqz20O4E6m5OOATEOQ8q0fXjyS
         Pk8UD7k0Yuc5Sj4C6VtOKURhcuUcLR5rWE+JDiNeD3hZeVi4VFkXkNY5uo/eJSC1xQzO
         BqH7Fo8dXjtsuF4nvyf+gJL8x2VQaZqw86l8cYLXgqyYQwsrr1LfKsTadiHusugnIAn1
         IVT43ASnLnbuaPmou38QeAZHI4bkbumf5iiBvOgc9cyrTFMFHiQd5FU8KHviXN5uM0Bc
         GzB9Dso/SX/7Fql/b9YlpxuY6uJ9+bljxXznd7ECYBbol3GmRXZm3QQUS9pmjH5laght
         qmzQ==
X-Gm-Message-State: AIkVDXKanFa2mePCpi/SsUJoj6pPtIY/5PuxT+mu/ZTABVuX+ngSwr9S96+SlaKDX2fVwA==
X-Received: by 10.28.215.6 with SMTP id o6mr7215309wmg.5.1481991054722;
        Sat, 17 Dec 2016 08:10:54 -0800 (PST)
Received: from slxbook4.fritz.box (p5DDB5290.dip0.t-ipconnect.de. [93.219.82.144])
        by smtp.gmail.com with ESMTPSA id g17sm12069595wjs.38.2016.12.17.08.10.53
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 17 Dec 2016 08:10:53 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: test failure
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <50C75781-FE3B-410F-9866-63342607707B@gmail.com>
Date:   Sat, 17 Dec 2016 17:11:23 +0100
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B3D96792-047D-4C91-8DCC-60C800B2861B@gmail.com>
References: <dd8decbc-f856-4f68-6d77-7ea9d5f9d126@ramsayjones.plus.com> <50C75781-FE3B-410F-9866-63342607707B@gmail.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 17 Dec 2016, at 15:28, Lars Schneider <larsxschneider@gmail.com> =
wrote:
>=20
>=20
>> On 16 Dec 2016, at 21:32, Ramsay Jones <ramsay@ramsayjones.plus.com> =
wrote:
>>=20
>> Hi Lars,
>>=20
>> For the last two days, I've noticed t0021.15 on the 'pu' branch has =
been failing intermittently (well it fails with: 'make test >ptest-out', =
but
>> when run by hand, it fails only say 1-in-6, 1-in-18, etc.).
>>=20
>> [yes, it's a bit strange; this hasn't changed in a couple of weeks!]
>>=20
>> I don't have time to investigate further tonight and, since I had not
>> heard anyone else complain, I thought I should let you know.
>>=20
>> See below for the output from a failing run. [Note: this is on Linux
>> Mint 18, tonight's pu branch @7c7984401].
>=20
> Thanks Ramsay!=20
>=20
> I was able to reproduce the problem with this test:
>=20
> 	test_expect_success 'ramsay-report' '
> 		test_config_global filter.protocol.clean cat &&
> 		git init &&
> 		echo "*.r filter=3Dprotocol" >.gitattributes &&
> 		echo "bla" >test.r &&
> 		git add . &&
> 		GIT_TRACE=3D1 git commit -m "test commit 2" > trace 2>&1 =
&&
> 		grep "run_command" trace
> 	'
>=20
> It looks like as if Git occasionally forgets to run the clean filter.
> I bisected the problem and I think the problem starts with "diff: do =
not=20
> reuse worktree files that need "clean" conversion" (06dec439a3) which
> definitively sounds related.
>=20
> Back in June I reported that Git invokes the clean process 4 times if =
a
> single file is added. Peff took a closer look and suggested the patch
> mentioned above to remove one unnecessary invocation. I re-read his =
comments
> and everything sounds still reasonable to me:
> =
http://public-inbox.org/git/1469134747-26785-1-git-send-email-larsxschneid=
er@gmail.com/#t
>=20
> Does anyone have a clue what is going on?=20
> I keep digging...

Ugh. I stopped coding, started cleaning the house, and it hit me:
"git commit" shouldn't call the filter anyways. I suspect it is called =
in
my tests because I add and commit the file to the index right after its=20=

creation. All this usually happens within 1 second and therefore Git =
cannot
know if the file was modified between "add" and "commit". That's why it =
needs
to run "clean" again.

I will adjust the tests.

Cheers,
Lars=
