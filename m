Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A9AA20A78
	for <e@80x24.org>; Wed,  1 Feb 2017 23:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752070AbdBAXH5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Feb 2017 18:07:57 -0500
Received: from mout.gmx.net ([212.227.17.20]:57190 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751788AbdBAXH4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2017 18:07:56 -0500
Received: from virtualbox ([217.136.241.150]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MWTSA-1cwcDG0QXK-00XYTI; Thu, 02
 Feb 2017 00:07:48 +0100
Date:   Thu, 2 Feb 2017 00:07:32 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Segev Finer <segev208@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 4/4] connect: Add the envvar GIT_SSH_VARIANT and
 ssh.variant config
In-Reply-To: <xmqqvastmt09.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1702020005570.3496@virtualbox>
References: <cover.1485442231.git.johannes.schindelin@gmx.de> <cover.1485950225.git.johannes.schindelin@gmx.de> <9780d67c9f11c056202987377c542d0313772ba2.1485950225.git.johannes.schindelin@gmx.de> <xmqq1svhpvm0.fsf@gitster.mtv.corp.google.com>
 <xmqqwpd9ofry.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1702012319460.3496@virtualbox> <xmqqzii5mthp.fsf@gitster.mtv.corp.google.com> <xmqqvastmt09.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:leCHeD/8mCCWD0SRbJ6vEZscnc4GdjJleDy47w4ea3Er0iWHCkw
 zhvKvlBBpytv37VG+FbRa/InuhO3O7IS04Wq05L1VC5YtUQkdeBQnLny6k3DXPdR1A8p69I
 8cfDcrHFVz/+7qesVVNBZAJ3bNpqKAW9nCoOKwl1Ye+QHLfvSnxnE0Yf2eNa7eV5hpUjzxL
 bRCcLxThAHALoM1Vs7mow==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mL6PCUkB81U=:PTDLulY+jtHyT71T6AylAl
 QfBttqlCNpa8RxsZj41lNvzzFLl70Hvsprd82y9fFAeNCLDqrGL666PaUU2aZIXXLj8pYZpfz
 WCIS65C/ocdXkhI8tl/jWTczWtOdiPjFEcoMTyyDtMT4WBh4b6hCDcCLwiV/548Xj51CxarWe
 GYf/RgnEBYDKvp2Tq099EOB3MRRPW4C0ciMNZr6XnDWi5KknqXa3oqVr63OKyJ+9P35GA9L4l
 /lTx0F7SOMABMj91kK0Fi4sBqhNsdsJTMlJE7Wd5b+2+fvRHgVUkToDaZXIGBn+n993Fdlba4
 EiJ087o/YfPeyGpsZiIW7ZpM9jKJ+vlHvKoxGYlvCRsJ0VrXhWLqxFi0EsXbg51/xVxzL6ZY+
 B8J+BjTiG9FXhGlrvZBlzd9+GHPBoX3TDH71Ka08fSnYQM+ba5w4gUdwNtIlGPQ6VoLR7Z8Ah
 X9dmHpjqR7haaCxiNKRnC7SEtbAkfzhgmusNxtUb67Q/xkbxNflqaohHhE+01oUbZkGO7pdRD
 EXlHpud498WpTzAD3tIhVX3X3wtBklUzvcvPJlUyNZwiBmsFjA/xfKmx3gqOsXt0HN+6ro0dN
 VV3rxF0kLwy9yC9PR1SAQeu5zHoM0aaRJcm0pirYPxp+W/Wa9Skt/v5wKRcd+ysY456lozWz6
 Vd/zJ68uXFlhRNT95mEQPkVwyZin5+z7UM39lmPPf8hTkzyNnwAeVk/gYOOUXy7qlLsvXVede
 VKrc2+VOMcWjlpEo39nhWnXXytY/t1093dvR8SA7i5RFgiPioAVRAtNkI6M6F3iNSb6mByeGA
 h8pie5M
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 1 Feb 2017, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >
> >> That leaves the "putty" case in handle_ssh_variant(), does it not? Was it
> >> not your specific objection that that is the case?
> >
> > Yup, you can remove that while you reroll.
> >
> >> No worries, I will let this simmer for a while. Your fixup has a lot of
> >> duplicated code (so much for maintainability as an important goal... ;-))
> >> and I will have to think about it. My immediate thinking is to *not*
> >> duplicate code,...
> >
> > You need to realize that the namespaces of the configuration and the
> > command names are distinct.  There is no code duplication.
> 
> To explain this a bit, there is no reason why allowed values for
> SSH_VARIANT must be "putty" and "tortoiseplink".  An alternative
> design could be "port_option=-p,needs_batch=yes" and it may be more
> logical and futureproof if a variant of tortoiseplink decides to use
> "-p" instead of "-P" and still require "-batch".
> 
> Prematurely attempting to share code, only because the current
> vocabularies for two distinct concepts happen to overlap, is not
> de-duplicating the code for maintainability.  It is adding
> unnecessary work other people need to do in the future when they
> want to extend the system.

Except, of course, that your hypothetical port_option and needs_batch
settings would be handled at a different point altogether.

I sense very strongly that this discussion has taken a very emotional
turn, which is detrimental to the quality. So let's take a break here.

Ciao,
Johannes
