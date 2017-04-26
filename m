Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C8AC207BD
	for <e@80x24.org>; Wed, 26 Apr 2017 19:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965400AbdDZTS2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 15:18:28 -0400
Received: from mout.gmx.net ([212.227.17.21]:50597 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964978AbdDZTS1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 15:18:27 -0400
Received: from virtualbox ([95.208.59.152]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MK0bZ-1d4q223Jv3-001VPw; Wed, 26
 Apr 2017 21:18:19 +0200
Date:   Wed, 26 Apr 2017 21:18:18 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Johannes Sixt <j6t@kdbg.org>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v5 6/8] Introduce a new data type for timestamps
In-Reply-To: <c6bcc382-f526-cf0c-8181-3985216e6c2b@kdbg.org>
Message-ID: <alpine.DEB.2.20.1704262117550.3480@virtualbox>
References: <cover.1492771484.git.johannes.schindelin@gmx.de> <cover.1493042239.git.johannes.schindelin@gmx.de> <fea2df0e1ff5869572cf756d75fd3468d184457f.1493042239.git.johannes.schindelin@gmx.de> <c6bcc382-f526-cf0c-8181-3985216e6c2b@kdbg.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Sq6fU8aQtIBjzIdHcA4bdc+coDS/+fAY9kfrTaa5Ge2FCFiuqpw
 4ddJjk2sKfdTclW3gFOeOWPlOyM2Qu0oCBAFvSymt3g6oN2tn7yTwlnbzHSI1aESytIXObb
 jkeRElXu2ly2bY+hD60nASgVai+HHQale8AViGHmt3yZMwGtDTbthHzqppHvzYgZUVT+MJ+
 h+e9bsETOTxp857U0kX4w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BeFeoQCYimU=:2+9CXPu2ZjuGFqGtGSGovV
 o5XbIWKWoh9AiNFaLKPSD5/RsE3qljoL9nkPGqaltN35RRgXSIpMpkNVnkaas2tV34ILV9TL0
 bJvoo5eNBOgD+I3xmCG74m9WkWVQU7byVFQN8dhzGo2Cj++74jgdySHdwTzLmlpbwH/DTucZ0
 kNv7pykW9j7/9ib30UJgqdLfrNw+bpnInwrGi15MWUAcqborr8+7J2tlWXVPy50QNBXHLwth6
 4MWui3F7Xm5a4KX1I9u2k8PpIgGGjU0xlU2cJSkydd9tNO2opnQU4HwVDHz3jQkCsKZbyIFPZ
 CACEqI3Mr9d6smbwWfPNhIFLyq7cdCvT0nultWHq2Tu2BjGd9KGVR7OtAu8nD4d5O+pI8ikhC
 L938Ribs+LcJ/3b56AspOXbY6ts8lsNTS5TLmz0g+WUN+TdCqkIsx1bYYSWoi/xj9kcQwjDV5
 1RKC82M7Qh9hahPPnyihZvlnjagGrn1iFkP+IdiD6sbgZnZDrOp/K7xHI9XodN81GufZfeTFL
 N8obmVwXYwDIlrYm5InhHY760GUxjs8HZ+gEEUxOiuvuF/TSTGlf1sDnUDXzx6wVtkAOOx25J
 c1PjrE14U+fotAgHmgp5VSqFk8m/Ek+bXM4+d7tLOj3IpC0A1fmKUQxiQjuRyZn5QUx9ntrmr
 8GkN5bHrv18+UhlAjzO6sTskKH9diT+wx2T7mmfxIVQDA5Z89e3OzTDQF+Nc46Dv7T0ofX2yA
 Ig2BvhETp+8RV4iuY7i0a96nzH21nOIv/lVpDkppOmGzJjSswUGsLIILkLIkR6BuqRrUGLxem
 4KqFiyV
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes,

On Wed, 26 Apr 2017, Johannes Sixt wrote:

> Am 24.04.2017 um 15:58 schrieb Johannes Schindelin:
> > diff --git a/archive-tar.c b/archive-tar.c
> > index 380e3aedd23..695339a2369 100644
> > --- a/archive-tar.c
> > +++ b/archive-tar.c
> > @@ -27,9 +27,12 @@ static int write_tar_filter_archive(const struct archiver *ar,
> >   */
> >  #if ULONG_MAX == 0xFFFFFFFF
> >  #define USTAR_MAX_SIZE ULONG_MAX
> > -#define USTAR_MAX_MTIME ULONG_MAX
> >  #else
> >  #define USTAR_MAX_SIZE 077777777777UL
> > +#endif
> 
> This part of the hunk is fine: if ULONG_MAX is not 2^32-1, then 2^33-1
> will fit in a long.
> 
> > +#if TIME_MAX == 0xFFFFFFFF
> > +#define USTAR_MAX_MTIME TIME_MAX
> > +#else
> >  #define USTAR_MAX_MTIME 077777777777UL
> >  #endif
> 
> But this is not: just because TIME_MAX is not 32 bits, does not mean that
> long is also more than 32 bits. We need this:
> 
> diff --git a/archive-tar.c b/archive-tar.c
> index aadd5865f6..b5d6ce27d3 100644
> --- a/archive-tar.c
> +++ b/archive-tar.c
> @@ -33,7 +33,7 @@ static int write_tar_filter_archive(const struct archiver *ar,
>  #if TIME_MAX == 0xFFFFFFFF
>  #define USTAR_MAX_MTIME TIME_MAX
>  #else
> -#define USTAR_MAX_MTIME 077777777777UL
> +#define USTAR_MAX_MTIME 077777777777ULL
>  #endif
>  
>  /* writes out the whole block, but only if it is full */

Right! Thank you, v6 coming up,
Dscho
