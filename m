Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13ACA1F576
	for <e@80x24.org>; Wed, 28 Feb 2018 08:20:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751646AbeB1IU2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 03:20:28 -0500
Received: from mout.web.de ([212.227.15.3]:40463 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751464AbeB1IU1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 03:20:27 -0500
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Mf0qf-1f6aAo3Aoj-00OZ7K; Wed, 28
 Feb 2018 09:20:07 +0100
Date:   Wed, 28 Feb 2018 09:20:05 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Jeff King <peff@peff.net>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <lars.schneider@autodesk.com>,
        git <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v7 0/7] convert: add support for different encodings
Message-ID: <20180228082005.GA16857@tor.lan>
References: <20180216165815.GA4681@tor.lan>
 <19EDC192-0D83-4762-AC6A-81F7D693475A@gmail.com>
 <xmqqbmgfvf2y.fsf@gitster-ct.c.googlers.com>
 <xmqq7er3tqjq.fsf@gitster-ct.c.googlers.com>
 <FDF4DEB8-E71A-4BFC-9437-678C8F65BBDC@gmail.com>
 <20180226014445.GB8677@sigill.intra.peff.net>
 <20180226173533.GA7877@tor.lan>
 <20180226204635.GB12598@sigill.intra.peff.net>
 <20180227210517.GA17555@tor.lan>
 <20180227212537.GA6899@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180227212537.GA6899@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K0:fntWQNGFa1p+qFaQZvD1lwyU4NqUwW6FtvAqZ8LIbnHr+zIyGkw
 zAruybO/XrQR1+TPdnZlmuXw2yJsgde6uOeGz2G3dUeMhOn2fcE9sFDxPrB4LBm8qCSH+ea
 +BY4Ks/LczhPR/Fbti1tPIEZUn93PnGT2+kfDOyR5TVmxH51P8n3vIvmYOPgph4iln9sz84
 adf6iKRoOt3m7BbSboUlw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yriRD1CtNAw=:LMiJaIgzD5cLzTWKlvGTC+
 MxbX/bKdnPhf6jgh6SzGKYRpxcVvF1NVil3h+VFhwo9PFSLyp0BTOcPKHq9+mVc8LEUXZQBSS
 JzWwHnTJHdjHgwdVIINt5gnE7w9Vyk0w62jFuhGjhPiEisPBoXK3Gz195yaIRBoHFWmWV2dmc
 adrpMEMcHTI5Btt6eNDGj9/Z/GCUeT1DA1dhKG9pPWcv66tXr36TcqlPgZrgBEzw0pfABdWdX
 Qo72g+PjxIWy981aDFfGthfEuEE8pZDlwzBnQuG5unNsWWEWgQno0LAOxWAiz6VvV7Gu8SAeF
 BGMG1krThY751NYpqSOGKIhjgqfW7EehB7qTNiITkSu6SP0cdWoj2qwpSm1uztUnNHi9N/xcU
 pghN8yKzBQN80zpIGirhyPdQ1FEHoO/WsiPnSxwzuyp7I7NWtgUjR+BiLuCGPU3nQv01dTLy6
 fVcDjYpcIobdjAMDiGUeO5Jl+bp2bg7ntdbWkb1O3k+DWvfdLetG7gYUITKmR0YDb+FRJfdD6
 Ex9joXMZDNs3ikBwhfhgcuIRJRVd4SyXWvwTd6SP+mkrMK0FtXgzlvF/eosMF7bA36x5nijdb
 3iYQYcTcAomFp8xFhIblLzMuP408jVLwknZwRRDjwHbr+7J04XwdES9PnkQ4AnzctpvWNVMy8
 Lmvk41cLIEBuMT+PiGgIBUV4edUr1uoI8f8PAn0oMjEdWrRIqXWfZpuCLMSdsDlofk9pwD0px
 LbBUt0GL7M3eypRJeA3iXUxmU8TelADunP5eHdKZmP9tWo0aBkock/wU2uKay3n68wsoUR2J0
 O6YY82CgbSKiNWLqAqai3gsFuohEg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 27, 2018 at 04:25:38PM -0500, Jeff King wrote:
> On Tue, Feb 27, 2018 at 10:05:17PM +0100, Torsten Bögershausen wrote:
> 
> > The other question is:
> > Would this help showing diffs of UTF-16 encoded files on a "git hoster",
> > github/bitbucket/.... ?
> 
> Almost. There's probably one more thing needed. We don't currently read
> in-tree .gitattributes when doing a diff in a bare repository. And most
> hosting sites will store bare repositories.
> 
> And of course it would require the users to actually set the attributes
> themselves.
> 
> > Or would the auto-magic UTF-16 avoid binary patch that I send out be more helpful ?
> > Or both ?
> > Or the w-t-e encoding ?
> 
> Of the three solutions, I think the relative merits are something like
> this:
> 
>   1. baked-in textconv (my patch)
> 
>      - reuses an existing diff feature, so minimal code and not likely to
>        break things
> 
>      - requires people to add a .gitattributes entry
> 
>      - needs work to make bare-repo .gitattributes work (though I think
>        this would be useful for other features, too)
> 
>      - has a run-time cost at each diff to do the conversion
> 
>      - may sometimes annoy people when it doesn't kick in (e.g.,
>        emailed patches from format-patch won't have a readable diff)
> 
>      - doesn't combine with other custom-diff config (e.g., utf-16
>        storing C code should still use diff=c funcname rules, but
>        wouldn't with my patch)
> 
>   2. auto-detect utf-16 (your patch)
>      - Just Works for existing repositories storing utf-16
> 
>      - carries some risk of kicking in when people would like it not to
>        (e.g., when they really do want a binary patch that can be
>        applied).

The binary patch is still supported, but that detail may need some more explanation
in the commit message. Please see  t4066-diff-encoding.sh
  test_expect_success 'diff --binary against local change' '
         cp file2 file &&
         test_tick &&
         cat >expect <<-\EOF &&
         diff --git a/file b/file
         index 26acf09b0aad19fb22566956d1a39cb4e2a3b420..e98d27acfb90cfcfc84fcc5173baa4aa7828290f 100644
         GIT binary patch
         literal 28
         ecmezW?;ArgLn;Fo!ykquAe{qbJq3!C0BHb{ln3Pi

         literal 32
         icmezW?+HT@Lpnn$kmO?c#!w7oaWVX1NCMJ1Ko$VA_z0~4

  EOF
         git diff --binary file >actual &&
         test_cmp expect actual

> 
>        I think it would probably be OK if this kicked in only when
>        ALLOW_TEXTCONV is set (the default for porcelain), and --binary
>        is not (i.e., when we would otherwise just say "binary
>        files differ").

The user can still use "git diff" (Where auto-detection of UTF-16 kicks in
and replaces "binary files differ" with an UTF-8 diff.
When the user wants a patch, "git diff --binary" will generate a binary patch,
as before.
The only thing which is missing is the line "binary files differ", which may be a
regression. I can re-add it in V2.

> 
>      - similar to (1), carries a run-time cost for each diff, and users
>        may sometimes still see binary diffs
> 
>   3. w-t-e (Lars's patch)
> 
>      - requires no server-side modifications; the diff is plain vanilla
> 
>      - works everywhere you diff, plumbing and porcelain
> 
>      - does require people to add a .gitattributes entry
> 
>      - run-time cost is per-checkout, not per-diff
> 
> So I can see room for (3) to co-exist alongside the others. Between (1)
> and (2), I think (2) is probably the better direction.
> 
> -Peff
