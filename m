Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CB92201A0
	for <e@80x24.org>; Thu, 11 May 2017 19:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756277AbdEKTTj (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 15:19:39 -0400
Received: from mout.gmx.net ([212.227.17.22]:49618 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751588AbdEKTTi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 15:19:38 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lxgnf-1e6zRI1yw7-017A9I; Thu, 11
 May 2017 21:19:23 +0200
Date:   Thu, 11 May 2017 21:19:08 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Stefan Beller <sbeller@google.com>
cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 11/11] PREVIEW: remove support for .git/remotes/ and
 .git/branches/
In-Reply-To: <CAGZ79kaM30ExQT6m9k5F5FqhKc-RwP4gsH6AaW_YgDL_ixs1Qg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1.1705112115370.146734@virtualbox>
References: <cover.1494509599.git.johannes.schindelin@gmx.de> <c73881261cc3021410695126989c6f1596f638b0.1494509599.git.johannes.schindelin@gmx.de> <CAGZ79kaM30ExQT6m9k5F5FqhKc-RwP4gsH6AaW_YgDL_ixs1Qg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:vVL12p80TOSonMlm1xY+YZCm/fOyWxIs5eDryX7KLTX+jJL/y/l
 s4VG5i6HUXx96VymMD2gSF4QUsylcCorzMFGCrK3WUKKqzMLviTi0YMZf3Al9JVV0CmYkBr
 2uhIMeMlq76lgbcBBehQAN44zSp/x0INeok20ek/6XpMQEGaUgtGNGwQsULkNjiRGGCnx6j
 EU6SffXO1tIWO4a0p9GVw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fmO59ILnNJM=:X8lsvPM/VdKeCOiMvFUgaZ
 QibPZEhiK1706Np0hA2Uq4+5LF1QdwMiVnAD85JwNsiuWm1PqhBawuEMe/SOxoDxWvrIlIhU3
 0fmwtwDOjtqhecZ+uaXEpJxr/RORK4WyCGdIhny9FQcMrtSsv/NXUUqxBWgQpWq1OksDghO6r
 vg+I5EuBCr7KYctPhRAWKXFDVHqG8OpnU8FyyUetRKjeruP1XMkQsrZJxS61Ty6L9r4Y7Lcbk
 y/kpRicqyB1U+kbT4ePYShLPVWx++F8HrWDYqgTM2/K9OKfD5hkVpkpZ7e4tCwX7Py5nds6cx
 k5eImbSloyEisv8+XhM2R54eogrHCX+O3IV5NeEw7G5OIBcm5f6I7TXHxI4HZaxfswvikcuW5
 B437X3j/fIZ7pRwaU1rggL5Mgiw1I6Z+dhAj1idwkYBfqmAoUti13IzvTgv6Tq3hOUc91kX2O
 vLXyZi9t9gX9dcQv+nLEpXjkva8vPD0LJOZxoB/o1yH2tszkqF8Kj1o+sdvR5B5gDSmXXDdVq
 1sAVmhifi0CshsastqWsfM1nBkfqBGQ+AmITRN4OdG86Fs4fmG6Bv3qf6Xb43b7SZjIUfNLVd
 JGyR6+aa6NjG+ihBOEMPiNE7YYvJRDm7zNIQGASD1TR4wH/zm+hvQBZrLAi4UU9GWlnK4h9sK
 Hp8ohKuV5zLAarpw7rtptJWzZcuLpj2aGh4DB7yyoTou0cex+kDRbvHPcEOOwFRWjZ/qRlGCC
 rDZLnRxnOpZDJG+LdfYjgREgApgMY1Q6qMCjl+Yp+9SMrV4SvZt426TiapcHY7K06sX86wIEi
 2J+EC1Y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Thu, 11 May 2017, Stefan Beller wrote:

> On Thu, May 11, 2017 at 6:48 AM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> > At long last, after a cycle or three of warning users who *still* use
> > the ancient feature of .git/remotes/ and .git/branches/, it is time to
> > retire the code.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> 
> The PREVIEW patches also look good to me, though I just
> skimmed them and other may chime in on the timing of them.

Thanks for the review!

I agree that the PREVIEW part is not quite as important as the first half.
I only bothered with it because I did want to make sure that the first
half is correct, that it does cover all the places we will need to delete
in the end.

In other words: the PREVIEW part should become its own patch series, that
I hope Junio will carry in pu (or next) for a while, similar to the
changes that removed the historical wart of the funny argument order in
`git merge`.

Ciao,
Dscho
