Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A54B1FBB0
	for <e@80x24.org>; Thu,  1 Sep 2016 06:36:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752188AbcIAGgO (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 02:36:14 -0400
Received: from mout.gmx.net ([212.227.17.22]:49495 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751243AbcIAGgN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 02:36:13 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0Lhf3N-1bIzQM3CAj-00mwBc; Thu, 01 Sep 2016 08:35:51
 +0200
Date:   Thu, 1 Sep 2016 08:35:50 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Stefan Beller <sbeller@google.com>
cc:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 09/22] sequencer: completely revamp the "todo" script
 parsing
In-Reply-To: <CAGZ79kYP6jYyuEOwQPC6pcOxCMVNNQ24pVLoQVrv6nNrGsDTKA@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1609010830110.129229@virtualbox>
References: <cover.1472457609.git.johannes.schindelin@gmx.de> <163aaa2a64ddf6dfb28c77c821726e14cc78619e.1472457609.git.johannes.schindelin@gmx.de> <135c9ac7-49a6-8aa1-fc10-02c2a1fd0b1a@gmail.com>
 <CAGZ79kYP6jYyuEOwQPC6pcOxCMVNNQ24pVLoQVrv6nNrGsDTKA@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1795171703-1472711751=:129229"
X-Provags-ID: V03:K0:Exdbx23zMZHE9UDnKm8QAwwwOBQPj51VEAljc5eAGu7ZIHVXyvS
 pVRzETpC3oRZON/oOpQ7+vpDHD4SK9+1h4DKyGdrw5MZKkPZWbgSQguDl+iAHnGv2F0LNKe
 XqZXXZX16OZhzj0wWm8DPcOdahLYRjQtEUxxMu/mtJfI5qPkuy84r8Dl4Cn3jtwwSycbleZ
 SMAffIaVgdzGCrONScVGg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8FgV9zBqyQg=:JRqCk20BJS9DU88IUfbTZn
 py/XlsFZXXyQ5rd/atItIXrKdW71XUJIzjJ/1v7xXmI5KvMfb3pGMuStbl/njbso7R9ioni1g
 i5GzXkz7FVo2dMvKWM+l3cMA1ue8cqtQ4kGJc95TlTtIkEBoDmejsdbbYvU7Z2Ff/FXkBLYQF
 CVXp8H9G/W8f3aomiTiELUfdmWF14E2dQ1uCE72SbCyvqDO30ICadGJteO7yRytz+zkw5fWm6
 oG2QH/IBc1QCZqYwV3NfOA+ddfW0e6gUXDKqT6azcAbDOarVakTGi6WhIeMEeHdaACy7SyIp8
 QuB2q/Ak27H+q95ZNKmkY6NOi9FnSkz1X4WFUuzZfmvUULkCmtUo/PBPtDwTIujdTmglQAZrS
 12bsm3F+9Dy8WIytfantTqvASjlzW11Ou4iwoocYXdTq6TK06cQJAcOElqUthD8+S6ETVEbHd
 ePZuh9A8vC+5NPXMvfBUCmcG2OlEKjCAru6x4A59F+dqW6jivEIx5zHL9TsNsp2BzqqHgwS4s
 UXUzd0+Q0oU7ZFCQdkHG6p4zvIpZmr35dvXbHbWU+c9vq6kFJidsjKnhQhrx97V+2s3NlrO61
 51pRNHWCM9yEFTQWfVrLu48bCROPfwCPk2nIU/S1V7LO2ZDJjbMKgG2QRhftKPDe1gwiucTh/
 ICOvoklnL77BV6fYHwgqgzTzfAVPCgzkqg6iuC0CGa3SifDdMG5zKa/7bck8oAP9+CtykJfpP
 zk20ySPT6V8LNpgV3wMlMNjTsoqroO+OT+iohmdMGnw1dDNh+NMA8KGJDtbe7CdL9eBhlCdmG
 Cq7WV9P
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1795171703-1472711751=:129229
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Kuba and Stefan,

On Wed, 31 Aug 2016, Stefan Beller wrote:

> On Wed, Aug 31, 2016 at 10:29 AM, Jakub Nar=C4=99bski <jnareb@gmail.com> =
wrote:
>=20
> >
> > BTW. perhaps we would be able to continue with 'git continue', regardle=
ss
> > of what we have started with, I wonder...
> >
>=20
> git continue as a shorthand for `git <relevant-cmd> --continue` sounds gr=
eat.

Before we get ahead of ourselves:

1) this has nothing to do with the patch series at hand, and

2) if we were to introduce `git continue`, we would need to think long and
   hard about the following issues:

=09I) are there potentially ambiguous <relevant-cmd>s that the user
=09   may want to continue?

=09II) what about options? You can say `git rebase --continue
=09    --no-ff`, for example, but not `git cherry-pick --continue
=09    --no-ff`...

=09III) Would it not be confusing to have a subcommand `continue`
=09     that does *not* serve a *single* purpose? It's kinda flying
=09     into the face of the Unix philosophy.

Ciao,
Dscho
--8323329-1795171703-1472711751=:129229--
