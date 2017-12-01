Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87DC820954
	for <e@80x24.org>; Fri,  1 Dec 2017 12:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752456AbdLAMwV (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Dec 2017 07:52:21 -0500
Received: from mail-wr0-f170.google.com ([209.85.128.170]:44304 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752348AbdLAMwU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Dec 2017 07:52:20 -0500
Received: by mail-wr0-f170.google.com with SMTP id l22so9993692wrc.11
        for <git@vger.kernel.org>; Fri, 01 Dec 2017 04:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Lc0VtPJgM5s8g88bAuqEL14nVnOdOsusx4Izrs8Z3fU=;
        b=IgDcPkQI2st68lCFcOalLbAmKEkZNk5dss5Lh4RI/F64Z2J2f9Yd8Ex+XD42BhAqFY
         b4Waspz5dQiDj4jnzTa2EaTlJ6CLc5R4UTn6dOQg0CVl0G4tnqNXqPVzV0n1f3j14qaB
         JdHcpm2rbhLcf/pJOxMzi+qDuM1+BA/KWAKpRnzTiDPqVijPjl9CXi30Pxi4/73uWJ3C
         jKRclPoAEL/hcLqnzfd+Xu5denpG0TlZdj5IcBV1jKfQto74jaRknoNfiCoLh6DcJTDC
         pWptNL/1L68rmPcF675eHk0Utk8Mgzfqmba043Htxa8NU7kDXdFsbzULlH1UAANj+UA/
         W+Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Lc0VtPJgM5s8g88bAuqEL14nVnOdOsusx4Izrs8Z3fU=;
        b=U0TUia8nrJ8Q3Ecsz3MG7ECdmNkA/4kyLDwIp+oZn2o6BoT1wHLGCURDuRDedP37K+
         uOgaQWHxO+QfAvYOU4wpzx8wlaqxEY3t1drbRKyLuCTwjicil3C6VaQLsENA/1vjITcT
         PM+vws1AcdGJR1GPQY9M/ufeTkWp3FFPWNTaMoEclqoPeS87fCBRWMYPfXAnXHhcMklV
         y+pWssD5k6N/wL6lMw/1WisYVnVtbsWVAhI9A7qqVFe4D+EYLR3qFGIBknApqzIEqhJ6
         40Re3UeLybJB8FqD5ivWPO08iR8640Thl+eErwSaGPrgeYXltRRlyXQ+6jIvxESI0jvx
         6iGw==
X-Gm-Message-State: AJaThX7nZEsniSoZrvM14KwWQsQh5timucUL27t5LiOGRwRldnhh3r3O
        RiAuFw2/aOZTpY6ii4TYERg=
X-Google-Smtp-Source: AGs4zMYi5pwrTtPRZW8sWLkrtqWZPf2D8D5JFvaGJLmgG6ZEnEAuK0K3zhvJwlmAbXkp0TPYdnAH6A==
X-Received: by 10.223.186.197 with SMTP id w5mr4948695wrg.201.1512132739252;
        Fri, 01 Dec 2017 04:52:19 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id w76sm10895658wrc.79.2017.12.01.04.52.16
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 01 Dec 2017 04:52:18 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v4 2/2] launch_editor(): indicate that Git waits for user input
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20171130205137.GC3313@sigill.intra.peff.net>
Date:   Fri, 1 Dec 2017 13:52:14 +0100
Cc:     lars.schneider@autodesk.com, git@vger.kernel.org,
        gitster@pobox.com, sbeller@google.com, sunshine@sunshineco.com,
        kaartic.sivaraam@gmail.com, sandals@crustytoothpaste.net
Content-Transfer-Encoding: quoted-printable
Message-Id: <BB878570-F214-4BAA-AB58-4A9C0F8F80AB@gmail.com>
References: <20171129143752.60553-1-lars.schneider@autodesk.com> <20171129143752.60553-3-lars.schneider@autodesk.com> <20171130205137.GC3313@sigill.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 30 Nov 2017, at 21:51, Jeff King <peff@peff.net> wrote:
>=20
> On Wed, Nov 29, 2017 at 03:37:52PM +0100, lars.schneider@autodesk.com =
wrote:
> ...
>> The standard advise() function is not used here as it would always =
add
>> a newline which would make deleting the message harder.
>=20
> I tried to think of ways this "show a message and then delete it" =
could
> go wrong. It should work OK with editors that just do curses-like
> things, taking over the terminal and then restoring it at the end.
>=20
> It does behave in a funny way if the editor produces actual lines of
> output outside of the curses handling. E.g. (I just quit vim
> immediately, hence the aborting message):
>=20
>  $ GIT_EDITOR=3D'echo foo; vim' git commit
>  hint: Waiting for your editor input...foo
>  Aborting commit due to empty commit message.
>=20
> our "foo" gets tacked onto the hint line, and then our deletion does
> nothing (because the newline after "foo" bumped us to a new line, and
> there was nothing on that line to erase).
>=20
> An even worse case (and yes, this is really reaching) is:
>=20
>  $ GIT_EDITOR=3D'echo one; printf "two\\r"; vim' git commit
>  hint: Waiting for your editor input...one
>  Aborting commit due to empty commit message.
>=20
> There we ate the "two" line.
>=20
> These are obviously the result of devils-advocate poking at the =
feature.
> I doubt any editor would end its output with a CR. But the first case =
is
> probably going to be common, especially for actual graphical editors. =
We
> know that emacsclient prints its own line, and I wouldn't be surprised
> if other graphical editors spew some telemetry to stderr (certainly
> anything built against GTK tends to do so).

True! However, if a Git user is not bothered by a graphical editor that
spews telemetry to stderr, then I think the same user wouldn't be
bothered by one additional line printed by Git either, right?


> The patch itself looks fine, as far as correctly implementing the
> design.

Thanks for the review :-)

- Lars

