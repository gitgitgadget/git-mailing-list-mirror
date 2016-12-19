Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4C461FF76
	for <e@80x24.org>; Mon, 19 Dec 2016 11:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755241AbcLSLVQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 06:21:16 -0500
Received: from mout.gmx.net ([212.227.15.19]:52205 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752830AbcLSLVO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 06:21:14 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Mdr7l-1bxiuh2N0H-00PemC; Mon, 19
 Dec 2016 12:21:02 +0100
Date:   Mon, 19 Dec 2016 11:49:25 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2016, #02; Mon, 12)
In-Reply-To: <xmqqinqn6c41.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1612191145080.54750@virtualbox>
References: <xmqqoa0g96o3.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1612131641291.23160@virtualbox> <xmqqinqn6c41.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:fHnbB7p9gyV5hw+bjS6v0mYLrOeOXuY1G5ubEzKbyT4vbIPqrPP
 VziVeYHOMuveXUk8tCnuPBPIRpew9IAUAYwdAdWcrZ4Y/uSLAT0MJr4+zl0Exh8CyBbO6uK
 Iw6ZH0o0PkW+VvgXhPg7e4HsbPQMcFFH2Dpotdsx/Xyg0BWDGhVzFOE52DMTnlbdhDFIhvI
 /r1XeaSpt2yk/1CCMZqsg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GFhGwOEvfqE=:Vt0mNkYWIl0yARnQUUzGYv
 mITTtya9y4d62+OYcCBcZ0c1SrOlkwkeiwEyyJmuH6A1555IiaLz0XspIVptP5kwPM620clOy
 fBlhQktHtHPnrbinu7ClbRdIMP1N5v/9+/EViKRfTq6hdyykyQZty6v6+wFEL1o0pPOZmwOkF
 ujN8qkwH2hwpJgB9Pq64q/ZVa00oiWOiR2xWM/lwXm1B2DACotq8Jg2rLNKRGsX4t5PBlFKuM
 c0GaqVRuYLJQlueLBfkEn8/3vK+KJ8toaqnhp3mZ5wwdh8EaS/Kng4Drd7/7TIYX0tZWaNzfw
 FeEQIMO06cTuuHDqbA/npW0i8HS/70gvweqL3917Dxo4w2UJnPU7rdTHTnb4aKjBn1ZqV0eRm
 0lD1D6oLngU5dEFUG1TZ/MiknMi4juOxqkubhLbTu08P79fCQAvq+vjT74b8Zs4qFbUQsBGrI
 7Eax4Eitn4lVRRJq62czZZif+KeoQK+iXGwDRgN0QcTgTgYNS+JH1wpSKosOeYWlzzGw1EvL4
 dOES0YF/mYczAZkwNdx3tjxPMz3MYvrU6MsYSPa1THkdEjeDzVxwPhsEF5og5T/uBgtrWguu8
 +DR9iFYyJz40/QFK3x/Me8Awbyqz3DDxp94dMzlhi59MKxBrk5JfoNoDmP/27B2hydS4KIwUH
 xo1Ey3Un/cnn+bmc+b2ux1yutJz+c0y6iTwH6GwFo6A491AEQC1pnEF15BI02MoQ/ag5wa6Zm
 WVELplO0zxf75kEUXKEjhEkSOBUTk9TJzFBWSyAijb2IDtCCSkcz0g8N9YD7cfKXvjGk0hHkx
 2vHAb+e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 13 Dec 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >>  While I think it would make it easier for people to experiment and
> >>  build on if the topic is merged to 'next', I am at the same time a
> >>  bit reluctant to merge an unproven new topic that introduces a new
> >>  file format, which we may end up having to support til the end of
> >>  time.  It is likely that to support a "prime clone from CDN", it
> >>  would need a lot more than just "these are the heads and the pack
> >>  data is over there", so this may not be sufficient.
> >> 
> >>  Will discard.
> >
> > You could mark it as experimental, subject to change, and merge it to
> > `next` safely.
> 
> Are you planning, or do you know somebody who plans to use that code
> soonish?

I am too swamped with other things (most importantly, automate the
identification of the as-of-recent-quite-frequent breakages reported by my
build jobs).

I know that one of my colleagues wanted to have a look at it, and so I
thought that having it as an experimental feature that I could even
integrate into Git for Windows for a wider audience could help justify
alotting the time.

> Otherwise I'd prefer to drop it---at this point, the series is merely
> "just because we can", not "because we need it to further improve this
> or that".

Oh, I thought that this was meant as a starting point for anybody
interested in playing with resumable clones or with easing server loads.

In any case, I just wanted to be sure that you considered making it an
experimental feature instead of dropping it. Just in case that you did not
think of that as a possibility.

Ciao,
Dscho
