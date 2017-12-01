Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45AFC20954
	for <e@80x24.org>; Fri,  1 Dec 2017 17:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751254AbdLARNI (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Dec 2017 12:13:08 -0500
Received: from mout.gmx.net ([212.227.17.21]:53674 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750854AbdLARNH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Dec 2017 12:13:07 -0500
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MXqV1-1eZVk21TCZ-00WmNM; Fri, 01
 Dec 2017 18:13:01 +0100
Date:   Fri, 1 Dec 2017 18:13:00 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Johannes Sixt <j6t@kdbg.org>
cc:     Dan Jacques <dnj@google.com>, git@vger.kernel.org,
        gitster@pobox.com, avarab@gmail.com
Subject: Re: [PATCH v4 1/4] Makefile: generate Perl header from template
 file
In-Reply-To: <3c897f4c-0cb5-ca44-f144-598a623c1dc3@kdbg.org>
Message-ID: <alpine.DEB.2.21.1.1712011812250.98586@virtualbox>
References: <20171129155637.89075-1-dnj@google.com> <20171129155637.89075-2-dnj@google.com> <3c897f4c-0cb5-ca44-f144-598a623c1dc3@kdbg.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:hSa/6Tc5Ckz8lIpnvjcPD6iAMj7Bs70kiRjg691HPmAUtYR7SYc
 zia/wd3oBVzhkS6VWlgVsAnjgwcmXSOn0iFDBpoXBZa6G/OsqDKPYtYk7qnb75gt00rtA4d
 ei4p2MZHwFVqdXVS6vFrTD6Uwoo5G40tozWZjf72BxtX915VZswcMuwjrQhKyqaKmIZf60/
 phcMN3f67sb8kRHd5k9CQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:64Kngpipnw0=:CwRS4ZXWVPW9T7soj1vs4V
 g7ZFXCHUToGBKOwUQTC/KN/+YPFv5km/+oKbRdU2FXgiR0LYC5y0sgpENRj0p/nQ2RRnJETd/
 C+9af/T5u30dj4E787vCNzrozFZhijsFe7JkHnwf0j6FQbdmNM5F6yzV48rYI34JrxANVYjuF
 rayWDqh8V20yRJKRBRMRC9lw5dumx4AGo9Wi5F9EAc4gO9FZw/a9dFgPL0bkuDv/SpDqpeUTT
 tILKXrLoIGth0TpzSF0BY6lXmz/nGPX+jQLWd+s+zxobK5gfgFmLpZix3kPd/QS/QDb3dMYvA
 UyjLg1B8fqe5onAmP91G/vywCzKSln6MmZbqRi8MvT+dBpjZvdJ15EyeOJD/c81as1FqLkBgP
 1JsHCkKo3k68oLjoA3YKfnmHQYCm9912O3Lrb86rqMEiY/WkN7zkNi2ezEzXK2rwy1f2sVvow
 r6GFDw7Tl7rdW+UFpEirJixrL5cm2dxjZgp0ymqPVIbBmlBXsAfMjMrDRzzFXGaLzsdYraT/H
 NTQNY4lCi47NkWp85NytZ2878mlcTw0vKWtyBEvQrTxlruMinFuMrIfJ8KlQABlnHUKuRvpUI
 O7aHyGBm5SD2jhvl7WD9VW1ax70vJK/RwmZNIUlt0LdcNdh2gD02hb+4a2Zdyy3mq43HB/bgC
 P4l3IIH9mWC6FgjfSS5kjTUXOcdgGzWDKQ4h/OqKozwGN1FmnMuqqtyS8eUhyZA+Qgf6tm5cr
 aMGxQR4dos7FD8dIeJIiEUBOp8tKUTYpyS4LQcoPeXY7bfn7bJ2N0F4ksCqQwTho3OCtsCKk4
 YhBciTcSVyqqwyuJImzL5ELcwCXdYUAKAL5sMjlLlKjVlmhUR0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes,

On Fri, 1 Dec 2017, Johannes Sixt wrote:

> Am 29.11.2017 um 16:56 schrieb Dan Jacques:
> > @@ -1989,6 +1986,15 @@ GIT-PERL-DEFINES: FORCE
> >        	echo "$$FLAGS" >$@; \
> >        fi
> >   +GIT-PERL-HEADER: $(PERL_HEADER_TEMPLATE) GIT-PERL-DEFINES perl/perl.mak
> > Makefile
> > +	$(QUIET_GEN)$(RM) $@ && \
> > +	INSTLIBDIR=`MAKEFLAGS= $(MAKE) -C perl -s --no-print-directory
> > instlibdir` && \
> > +	INSTLIBDIR_EXTRA='$(PERLLIB_EXTRA_SQ)' && \
> > +	INSTLIBDIR="$$INSTLIBDIR$${INSTLIBDIR_EXTRA:+:$$INSTLIBDIR_EXTRA}" &&
> > \
> > +	sed -e 's=@@PATHSEP@@=$(pathsep)=g' \
> 
> This doesn't work, unfortunately. When $(pathsep) is ';', we get an incomplete
> sed expression because ';' is also a command separator in the sed language.

Funny, I tried this also with ';' as pathsep, and it worked in the Git for
Windows SDK...

Ciao,
Dscho
