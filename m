Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E267202A0
	for <e@80x24.org>; Wed,  1 Nov 2017 16:37:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754674AbdKAQhZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 12:37:25 -0400
Received: from mout.gmx.net ([212.227.17.21]:60331 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754089AbdKAQhY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 12:37:24 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MPIvU-1e5WA13MWG-004TBf; Wed, 01
 Nov 2017 17:37:09 +0100
Date:   Wed, 1 Nov 2017 17:37:05 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] mingw: document the experimental standard handle
 redirection
In-Reply-To: <xmqq4lqevbmk.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1711011726030.6482@virtualbox>
References: <cover.1509382976.git.johannes.schindelin@gmx.de> <436f0fb010709fe0d90460dc7bc1b3482237b192.1509382976.git.johannes.schindelin@gmx.de> <CAPig+cQs+6xCn=OR_Mw8vbEwEJ0c=sqnaEChOxuVw=kV4PQwsw@mail.gmail.com> <alpine.DEB.2.21.1.1710311807420.6482@virtualbox>
 <xmqq4lqevbmk.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:xiv8YFYI/0G1Ky6LGXkxgRD4lte543w7vNl7CRF7kiRVEHnvX0Q
 N/Y4jzGaNXF0kBR1Wb1PWLK8c5LEfTWONkedHjIODU4pQzPP+IUvVxyDU8P3rWJopL5iTJQ
 m//6iOlyAjP+FGAkZrP3uLoSkNRM4bmxYwClkhXC+C592iZ4wB4iFewNGZv3jHVLvM+hejT
 PpS2AdjC9h/WgKbd5F9mQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:CIRhUA3UHD8=:dD261DLmnLoTiWL8g9zKci
 /wStASyWTdUFMJ1o8gFRfuj8DBIvY3sKWg96cCt47lKP7yX2bNYxqjfVHI4rCSiE2m0GN7vCh
 us2Jf4tfjCbGaFQ4hjz/aX7/GHikPNjDiwIihbdH8DsyxQPgPdyCpV4hNUw6RFkBXlOLtf/j6
 ZdlGJ+o9DJz4/AXE7K4v7nL+C9ORfRMjYCJeAP+MXToQP/fasETcfpaakJegVQDoomKVO7L+7
 UpT9nSAzazeyg61nusuZXQ/akTF0cNslj3dQvsdOTWgP05dyxPBZ5ocovMmEGLi7cuHYLI1wM
 coK9kUZFX72EgYcIIXtVTMvwcyPbkT7qkJqqmuhK01rcbAkeXoVLSxwiT7o55qnl5vlsCeFyd
 uaL2DaZBBIZ/OSG2blQJ5jiW9F7np+oviRUQ04V+/gJ1+sXbvvDkIL/KKF3hwnVgJwf4U6kbT
 qd7TmR1HAt0pKQCpiUEqOoIK3cahP7pkGRpio7K0rZfOyH1vdFrIYRKyR2SorB2l9CJFVFjCA
 tO+5IluWHzHiHHb4BiESveNVNIJ0YqvF+uEikRGsZNT8+HlPtMqF+kzBhRMgTWfxWkiYhLxPj
 sHH7EIMEsgnPXBqhK9iyEKG1SBIAES4Y+Bbnh89rmjLLWVHQradFYOkW23EzUtbW5P8EjTmIY
 NpEpvD21dbdZ31dPNx1Th+e+SoJdqxgBhWCTwHfoKrLAAkmQCSCGqQuo1NoxUqDx0zZi6iial
 Vr5SYz2+6QHxWXXanaLHf8/Axz7aCRgnbrcbuLcIZGVReX8bwaEvDWw6uBUgEpDkssw29iFv7
 /tINQy573rtGNsTsfqtULE927BK2NXXXPWFZrrthZ7/7FfPEsBeh1QB9+mXncVUbmsgNTAe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 1 Nov 2017, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> > +Two special values are supported: `off` will simply close the
> >> > +corresponding standard handle, and if `GIT_REDIRECT_STDERR` is
> >> > +`2>&1`, standard error will be redirected to the same handle as
> >> > +standard output.
> >> 
> >> Consistent with the Unixy special-case for '2>&1', I wonder if the
> >> 'off' case would be more intuitively stated as '>/dev/null' or just
> >> '/dev/null'...
> >
> > I feel this is the wrong way round. `>/dev/null` may sound very intuitive
> > to you, but this feature is Windows only. Guess three times how intuitive
> > it sounds to Windows developers to write `>/dev/null` if you want to
> > suppress output...
> 
> It would be just as intuitive to write '2>&1' for dup-redirection,

No. You misunderstand. I was mainly concerned with the `/dev/null`. Every
Windows developer knows what `>file.txt` means, and many know what
`2>error.txt` means. But `/dev/null` is not Windows, period. It is so not
Windows that Git itself translates it to `NUL` (which you Linux die-hards
won't have a clue about, I would wager a bet).

> Perhaps "dup-to-stdout" or even just "stdout".

No. The value is a path. I can special-case values that are not even valid
Windows file names (such as `2>&1`). I cannot special-case values that are
perfectly valid paths.

> By the way, the description talks about "special values", but it
> leaves it completely unclear what their normal values mean.

True. Fixed. I also threw in an example for a pipe.

Ciao,
Dscho
