Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DD051FF76
	for <e@80x24.org>; Sat, 17 Dec 2016 14:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754612AbcLQO2R (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Dec 2016 09:28:17 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35998 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752377AbcLQO2Q (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Dec 2016 09:28:16 -0500
Received: by mail-wm0-f65.google.com with SMTP id m203so10474053wma.3
        for <git@vger.kernel.org>; Sat, 17 Dec 2016 06:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Pvjs9AErOC72910fXZquA4B/ovQzU/b+IInD6LgzDKk=;
        b=WyfK+z0eyoJz5jKV7i0bjTKa6fZGmuxEu9oOcEOLJDdHPUc2a04reiXlKbZvNkQPx9
         EO1FHWXWwowUpOiQuSA0b/9OZw2p6VIUYc7LnUmBJEg0Jc6/olrhgUSJ18kdeEmdjfXF
         7Etjdp0T2nhpX3/PiBy+V8XHShFEIZyG8JQA8LuJz3Pgjrxz1zAlmkYpRKo2x2TU/MDr
         8ZHvSu5/8rwRW8sKxzSwoDsb5PFT3Cxr+47TLFY6PTcGVtDQC6fyCWTxR/kAuiZC/FOm
         1c1VZj+1xUXlKf5ot0kpw0yPEQpKXTMMinzu4T7+e/O+sIxekhnXzBmCvnVhgfX9JNXF
         UnyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Pvjs9AErOC72910fXZquA4B/ovQzU/b+IInD6LgzDKk=;
        b=C592mwvZZSpph6N9bWX5eV32Choe48Mk/nYgqWHxNxpQprT1a9OO+fypabfp283+EE
         YWkh9xT2J2fb/QI3PM30Pg0hgPjefIIuu7C/nr3tR//5e7w2qUBO44nUEInrCTEcNkOS
         LSU7Qf5UbnMVMFWnuwNVfGmShNWUMVb13/9VIKLQfpH0YBu/c8mc2ojsImt/HrheIELT
         q3MzRegCGYZQXeBfGYIdSxKOk1DRuVtXv56eLBnXTlzQ6ME/YXTaGU03dp30tgQIZDXd
         1EI6t/jVpjkwZA/oAJGoOB5fTtKmy8uEp86JJyZ85GbCqMnwx3T2XMHEMti++UFCGj45
         fVXg==
X-Gm-Message-State: AIkVDXJPPQXumyK4DbmnlKVaMy7d0cxuwtvGiwY1epmeSL7lZiOmbImxGttOHE2ovnC8WA==
X-Received: by 10.28.58.14 with SMTP id h14mr7609805wma.7.1481984894662;
        Sat, 17 Dec 2016 06:28:14 -0800 (PST)
Received: from slxbook4.fritz.box (p5DDB5290.dip0.t-ipconnect.de. [93.219.82.144])
        by smtp.gmail.com with ESMTPSA id y4sm11730580wjp.0.2016.12.17.06.28.13
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 17 Dec 2016 06:28:14 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: test failure
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <dd8decbc-f856-4f68-6d77-7ea9d5f9d126@ramsayjones.plus.com>
Date:   Sat, 17 Dec 2016 15:28:43 +0100
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <50C75781-FE3B-410F-9866-63342607707B@gmail.com>
References: <dd8decbc-f856-4f68-6d77-7ea9d5f9d126@ramsayjones.plus.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 16 Dec 2016, at 21:32, Ramsay Jones <ramsay@ramsayjones.plus.com> =
wrote:
>=20
> Hi Lars,
>=20
> For the last two days, I've noticed t0021.15 on the 'pu' branch has =
been failing intermittently (well it fails with: 'make test >ptest-out', =
but
> when run by hand, it fails only say 1-in-6, 1-in-18, etc.).
>=20
> [yes, it's a bit strange; this hasn't changed in a couple of weeks!]
>=20
> I don't have time to investigate further tonight and, since I had not
> heard anyone else complain, I thought I should let you know.
>=20
> See below for the output from a failing run. [Note: this is on Linux
> Mint 18, tonight's pu branch @7c7984401].

Thanks Ramsay!=20

I was able to reproduce the problem with this test:

	test_expect_success 'ramsay-report' '
		test_config_global filter.protocol.clean cat &&
		git init &&
		echo "*.r filter=3Dprotocol" >.gitattributes &&
		echo "bla" >test.r &&
		git add . &&
		GIT_TRACE=3D1 git commit -m "test commit 2" > trace 2>&1 =
&&
		grep "run_command" trace
	'

It looks like as if Git occasionally forgets to run the clean filter.
I bisected the problem and I think the problem starts with "diff: do not=20=

reuse worktree files that need "clean" conversion" (06dec439a3) which
definitively sounds related.

Back in June I reported that Git invokes the clean process 4 times if a
single file is added. Peff took a closer look and suggested the patch
mentioned above to remove one unnecessary invocation. I re-read his =
comments
and everything sounds still reasonable to me:
=
http://public-inbox.org/git/1469134747-26785-1-git-send-email-larsxschneid=
er@gmail.com/#t

Does anyone have a clue what is going on?=20
I keep digging...

Thanks,
Lars=20=
