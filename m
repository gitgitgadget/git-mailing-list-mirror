Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32729205C9
	for <e@80x24.org>; Thu,  5 Jan 2017 13:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756081AbdAENt7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Jan 2017 08:49:59 -0500
Received: from mout.gmx.net ([212.227.17.22]:58636 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757505AbdAENt6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Jan 2017 08:49:58 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MRB8F-1bv74Y2ged-00UeaS; Thu, 05
 Jan 2017 14:49:37 +0100
Date:   Thu, 5 Jan 2017 14:49:35 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Lars Schneider <larsxschneider@gmail.com>
cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        =?UTF-8?B?66eI64iE7JeY?= <nalla@hamal.uberspace.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] asciidoctor: fix user-manual to be built by
 `asciidoctor`
In-Reply-To: <1D7C66EA-E87A-4154-ACAC-8045D28477D2@gmail.com>
Message-ID: <alpine.DEB.2.20.1701051444390.3469@virtualbox>
References: <cover.1483373021.git.johannes.schindelin@gmx.de> <3c160f81a88cf8697f2459bb7f2a3e27fb3e469c.1483373021.git.johannes.schindelin@gmx.de> <20170104080852.bmlmtzxhjx4qt74f@sigill.intra.peff.net> <1D7C66EA-E87A-4154-ACAC-8045D28477D2@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:oWPQtoqyVKuyX+PAETYvtCI4h6AnC7hTpqJH3indPppF7EhptLt
 qnwUPhvIho6+Se9Ygw+Fa8+jwYu9LhjtBYVKjHgdhX8ppzGbzopbLsPksl9G8GpBSZRIH0H
 tdIf98C6niSQ0/iHhTa6xa75LircEIRRap8jAQr5GCEj7SgoyNCUY2kBCS8z3fFoyQbBkyW
 A2/7r7th01Qtr+C8WBWxQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dohJwHPUsA8=:e0DGl7hh358K7fy6MTlKQm
 Iw4CTEFzVwqnJ9x58+CiBJoQe7gKyudhZECtadDpBBRKIlnlebkOdAsQv0GzKONgLCxomG9Bh
 eTRKm+AEJS6PVJzcerRfl5Ce6pyO3wM86QSb4BDv2HLhrYRcRNtu4JEZGY7d4t98QQIrEdcRF
 97CuN6xpOMsQ32rUjB8qWyJPGZYgLD/19Ajsl/j8OMwMgODfBtqwx2azZ05ze1YH+gvjP+m+x
 Ns9VxOJGTvkPXn1OhrsqniH4hEh7pLjtzQJ63iJ9X867fpVswtJVaL8aVr5eJ0S/cbnOD2ao2
 ID3nrfZlv2Zq/2bQeu3HQ3e8RRr79ZGul6R89cdA+jnfmyZMcelIUZ4hWksw8ThVQNtZE8BVA
 HeSSeFOLTCXd3q4fd+7mS9wLuMczeq4FOdUxrzLZePsFPkeVkkief/uCnwWDLuqwHDpxtg46d
 5d2cIPfqecVY/AKz+PYU6/Vf9IlLRQxS0fUV5XXJkBbkyBTaN9mlUdoCd+PTDnr91Ysmru+HI
 iXc1A1LoJNUYPYahv8WNDUUNaW+CxXehdSgJRo3lBHUJMKihK5/SnO2+x+inLqrGBES15EuNr
 mThHf/wUubHeC7T/bUil/lEyXc85fnCSoZ2A2071Q4TWTlf0aBhE/Fj6N1xpxewvt+WpBMSNE
 GtEuCcriqlEAsFD6rvz1fdY8Gp2CGg79qKLPWSqL8Lqn8XCBfbJN76SRK/uaWo1dBYIplnKnv
 BuDxILhu1A5zME3kJEd2DdepOcmAzR+DmQ5loga7bAocy+LDf4VqEfSh/E5PhStRKgR5bwopp
 ZZT1iu7wnA+V8GiBfOKaFlQYSRJuE1GFPrryI3A+LvmkPouRaPubnDNjH9TKS4slJ+Ikx02Yn
 ovoX+8XLgXG/i7RpgW1H71xNYMi8ZUoKMn39QdvXUWqTA5De++huawlhlVLUlCOaBkfDdGatW
 ochso/QldJIhDIIKHO2N84ONuRKdsRhGjUE070SaNNRK9qiGzzNhb1AVd41r3RCCSB/tddM3D
 Re+MrwU6oASyqXoNj1zurSI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Lars,

On Thu, 5 Jan 2017, Lars Schneider wrote:

> > On 04 Jan 2017, at 09:08, Jeff King <peff@peff.net> wrote:
> > 
> > On Mon, Jan 02, 2017 at 05:03:57PM +0100, Johannes Schindelin wrote:
> > 
> >> From: =?UTF-8?q?=EB=A7=88=EB=88=84=EC=97=98?= <nalla@hamal.uberspace.de>
> >> 
> >> The `user-manual.txt` is designed as a `book` but the `Makefile`
> >> wants to build it as an `article`. This seems to be a problem when
> >> building the documentation with `asciidoctor`. Furthermore the parts
> >> *Git Glossary* and *Appendix B* had no subsections which is not
> >> allowed when building with `asciidoctor`. So lets add a *dummy*
> >> section.
> > 
> > The git-scm.com site uses asciidoctor, too, and I think I have seen
> > some oddness with the rendering though. So in general I am in favor of
> > making things work under both asciidoc and asciidoctor.
> 
> I am not familiar with both tools but it sounds to me as if
> "asciidoctor" is kind of the "lowest common denominator". Is this true?
> If yes, would it make sense to switch TravisCI [1] to asciidocter if
> this change gets merged?

It is true that asciidoc typically parses whatever asciidoctor parses,
but not vice versa.

In that light, I would love to see our Travis runs to switch to
asciidoctor.

For the record, this is my local config.mak in the asciidoctor worktree:

-- snip --
ASCIIDOC=asciidoctor
ASCIIDOC_HTML=html5
ASCIIDOC_DOCBOOK=docbook45
ASCIIDOC_EXTRA="-alitdd=&\#45;&\#45;"
ASCIIDOC_CONF=-I"/mingw64/lib/asciidoctor-extensions" -rman-inline-macro
-- snap --

Please note that the extensions are required to build correctly (and we
require this patch, too, unfortunately:
https://github.com/git-for-windows/MINGW-packages/blob/master/mingw-w64-asciidoctor-extensions/0001-man-inline-macro-enable-linkgit-syntax.patch).

Ciao,
Dscho
