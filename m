Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 721D820323
	for <e@80x24.org>; Wed, 22 Mar 2017 16:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759177AbdCVQJx (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 12:09:53 -0400
Received: from mout.gmx.net ([212.227.15.15]:63251 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759016AbdCVQJv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 12:09:51 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MLOMM-1cqArY3zTW-000bdL; Wed, 22
 Mar 2017 17:09:39 +0100
Date:   Wed, 22 Mar 2017 17:09:38 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Sebastian Schuberth <sschuberth@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] t7504: document regression: reword no longer calls
 commit-msg
In-Reply-To: <CAHGBnuPL9CUincZkFR758KcZL3-Ra=n_fbsc1EQ=vio2scod5w@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1703221704500.3767@virtualbox>
References: <cover.1490194846.git.johannes.schindelin@gmx.de> <773531a3892fb78e8f70e540fc000bceb2c1bb7b.1490194846.git.johannes.schindelin@gmx.de> <CAHGBnuPL9CUincZkFR758KcZL3-Ra=n_fbsc1EQ=vio2scod5w@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:FGK10FdwM1M3QK/wIyk7oFwsT+L460SvZ3mtB4gI+VBqPGvo4wm
 Q8A1VPZuTMrvkki/s9ZaR2AuH9ZXst0d5mHar+hBTw/Mt/v8N0IEazAp/thSdw90qiBp3XB
 8ykcIu5mWNYEM6Y0RwO0tMUcgWsMB0/qmlKgzcSrxvjl2lTbJISLHjdz2N79d7X7dDED3T6
 8EdvMzm1+mBQL4+Ergp5w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:r78x9XCS5YQ=:mDtnjaw/yyBYgjfkueGznZ
 qnL6n7SJrGKlmMQIApB9uqIdt6hu/EPe2M6/lQshug5S+Ji9IAInR19ifwIxlBaqR1C9gJx10
 1perG4maMe4KRZrpR5KPL8zlbXkb3tOp7H0Yq8+Lx1/41CJ7BwSfqiRJWPSXIIbGxpOTXugiA
 r135Ges7mCoaR+esZyOQszK5lGOb2U9X4EF3GRgA9P2Zzq0Aep+8UB9ASnvz15wLzh3HoYBp7
 80cDeAHz4SyxBW2icUO+pjZjzre7r74p7z1BoNYGscKZYULAn1crcvsPXYYtTN0O5FSG5Lfqs
 d4KUE+nyWvuI9DnGEIZ8OJhelTyqvB3IiyrKEMtjIG6E6ys+eh5oDRtTngofVNxtSu9JpBZSK
 WcZyY/xHrnZCvjf9yhUwQcRuyVk91FAvgeED9MIGBqxmCtn9KvDt9EAKukLIf3hGVqcikLpD7
 xi6yCYnPMp+HXt0tg0nXu7jhvtA9jvII3nCKvvDbsasoiDP+Unv5YzYTVSjd8DVfFAvcTS05a
 c/UhpS3Tm+o4VTqcH6SjEaXQUw2z8710LCRCrMfUohr3T73DbqvJCdPMIutscedoaXuze+WsG
 aCYT5vhhEVm++2pUaHay14T6qaKHR5Bj7TmPP0ZMQwOoywVWAZh1a+/00QcPt21vhSCst1tm4
 gx+Z0P7I/NLh6ErhHDcZ+y8X0nyu10OadznPZZxtDalmXSsPCQfqj1NQzFH7f78zSS8ahqLvI
 TGf5PBnlPz9MBSa29qc6J54Rzx9/OO+E31yAcwp4W0+d8booGzT++qbG2nQ3at/TDApuft2S6
 kyRodnHYGzl7312Ttku7Puh5UEDcg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sebastian,

On Wed, 22 Mar 2017, Sebastian Schuberth wrote:

> On Wed, Mar 22, 2017 at 4:01 PM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> 
> > +# set up fake editor to replace `pick` by `reword`
> > +cat > reword-editor <<'EOF'
> > +#!/bin/sh
> > +mv "$1" "$1".bup &&
> > +sed 's/^pick/reword/' <"$1".bup >"$1"
> > +EOF
> 
> Maybe use
> 
> sed -i 's/^pick/reword/' "$1"

It's not portable, otherwise I would have used it. GNU sed expects an
optional extension to be used for a backup file, and that optional
extension needs to be specified without whitespace between it and the -i
option. BSD sed *requires* an extension to be specified, and it has to be
separated using white space (or is that orange space now?).

So even if we could make that call portable somehow (and remember, BSD sed
is what OSX uses), there *would be a backup file*.

> here to avoid renaming the input file? Not sure how portable -i for
> sed is, though. Otherwise, maybe remove the file "$1".bup afterwards
> to be clean?

No. The file in question is written to the .git/rebase-merge/
subdirectory, therefore cleaned up after the rebase.

In any case, this is *test* code. So I'd prefer to have the changes to the
C code scrutinized a bit more, not the test code as long as it is obvious
what it does.

Ciao,
Johannes
