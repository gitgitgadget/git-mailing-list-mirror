Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E965C1FC96
	for <e@80x24.org>; Fri,  9 Dec 2016 17:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934190AbcLIRdE (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 12:33:04 -0500
Received: from mout.gmx.net ([212.227.15.19]:52637 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932353AbcLIRdE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 12:33:04 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LdHeL-1cxVIc2K1Z-00iT9F; Fri, 09
 Dec 2016 18:32:55 +0100
Date:   Fri, 9 Dec 2016 18:32:53 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Vasco Almeida <vascomalmeida@sapo.pt>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v6 01/16] Git.pm: add subroutines for commenting lines
In-Reply-To: <1481303956.4934.8.camel@sapo.pt>
Message-ID: <alpine.DEB.2.20.1612091832310.23160@virtualbox>
References: <20161111124541.8216-1-vascomalmeida@sapo.pt>         <20161111124541.8216-2-vascomalmeida@sapo.pt>         <1479823833.1956.7.camel@sapo.pt>         <xmqqoa17quls.fsf@gitster.mtv.corp.google.com> <1481303956.4934.8.camel@sapo.pt>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-971758209-1481304775=:23160"
X-Provags-ID: V03:K0:oa57h4uWSWl4ZZC7hDLmiqqzEITwr3qeG4YMbKBOpti0FJ+Y74Z
 jAfW0Cdh2FynNMEqkypQd15r/ZbnvR/wrzFIArLKTswYC4e2a63t8fwdnUN1r3b2IYsWdTB
 gIUcU4VgAGdSi6g3eamTWIY/S9btxhjpak9GaXonbVBIhcaqbPCYsR97AEAdvhFzOU8W4uo
 SeCoIKL68UVFZVZVMyAHg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Lu9CdIdiAfQ=:dJe+hO/05FSZNAD48Lk2yC
 ArK6yPQOVvmbymO6ayt5rH59JzIjLfHtq+PslkCSk8wumCil8urrtImTLHQMZsYxTeFdi+xO+
 pNrOC0JHDUP65Oi1LOnZdDfmoZ0gCSlb0USJZ7C0IyvP+jbeM3NcWTuL67IWJD+ENmjWekDWi
 j7PM1wAzX9tiEQuraekCeIYtVaRV38Pws03skIx/ePVDs0pIpbMA2N9r94EG8JS3g7UgOfWzE
 QJ3oh9TJChEsSdFMSlbTKOvuB6GzxtOki1eQUfijzXaAFYJS4PShjKPn6543OLuhTX5h6tqUv
 1dJQDF+Z7DIn6SjszV2XFAOCZTJrSTwmLV6hqYRkfv3MzvW1e31XDkbopcMI1jgbxJv8hhK4L
 QuoHXmoj83Rb084Feir4+rNWO4iGsAXIjZNztf2gkGxHZbVqoH1q2KOrSy7WySHEgWZoDCRoj
 8ZaRNZh0U/RU0CAgy1ieR+j78MVvwepalJAh8Vw66ibV/umg8vQUDr5sJL6Vu5XXNFZqbo78T
 zrkKntlwc5emyWB0498LWgYvYnIRiBkrUZNtDhxyQ4WCxEvNsvF/O5kgTXl7pdNNWdjySQ+oO
 Mtvoi+46S3JOP/CTMxxNEVlQlHpNYn0avsgkUvr8zlqezRYKwM6dCmBKZBx0FF+Gi2lYuiDCN
 cwohPwbPbmc7vdG2Ky3ic4Cp7XsHbif5sMX1n1snq29pu0uTre9A5ATELUXbfme6tRq//WvxI
 GeAQ7o0iF6SRKtoMRAFggdr2n4r6Zu0xGSuWnfZuLECopGQYT0dyoUAZ+VVNW9uSsBSJGpaMV
 4AVRo+s
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-971758209-1481304775=:23160
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Vasco,

On Fri, 9 Dec 2016, Vasco Almeida wrote:

> A Ter, 22-11-2016 =C3=A0s 09:42 -0800, Junio C Hamano escreveu:
> > The incremental update below looks sensible.=C2=A0 We'd also want to
> > protect this codepath from a misconfigured two-or-more byte sequence
> > in core.commentchar, I would suspect, to be consistent.
>=20
> Are the below changes alright for what you propose? It just checks if
> the length of core.commentchar's value is 1, otherwise use '#' as the
> comment_line_char.
> As a note, when I set core.commentchar with "git config
> core.commentChar 'batata'", I get the following error message when I
> issue "git add -i":
>=20
> error: core.commentChar should only be one character
> fatal: bad config variable 'core.commentchar' in file '.git/config' at li=
ne 6

This is exactly the same issue I fixed for rebase -i recently.

Good eyes,
Dscho
--8323329-971758209-1481304775=:23160--
