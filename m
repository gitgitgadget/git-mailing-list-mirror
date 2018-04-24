Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A26171F404
	for <e@80x24.org>; Tue, 24 Apr 2018 11:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752915AbeDXL7Z (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 07:59:25 -0400
Received: from mout.gmx.net ([212.227.17.22]:41563 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750736AbeDXL7Y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 07:59:24 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MSdRI-1f19TB1UGK-00RYr7; Tue, 24
 Apr 2018 13:58:49 +0200
Date:   Tue, 24 Apr 2018 13:58:46 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Junio C Hamano <gitster@pobox.com>
cc:     Ben Peart <peartben@gmail.com>, Elijah Newren <newren@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "vmiklos@frugalware.org" <vmiklos@frugalware.org>,
        Kevin Willford <kewillf@microsoft.com>
Subject: Re: [PATCH v1 1/2] merge: Add merge.renames config setting
In-Reply-To: <xmqqy3hd8q2k.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1804241354520.64@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180420133632.17580-1-benpeart@microsoft.com> <20180420133632.17580-2-benpeart@microsoft.com> <CABPp-BFANBs=tOhS5BFfTMkdQsNYbUDExWK8QB0V=qD9YwZyWw@mail.gmail.com> <cd49481c-9665-124a-5f94-791f1a16657d@gmail.com>
 <CABPp-BFqj2TFiHUDsysafq0NHC4MV-QYZVxOZe1TNRrXMOQfng@mail.gmail.com> <xmqqwox19ohw.fsf@gitster-ct.c.googlers.com> <1fb11850-4c20-5327-a63a-6d1f5aa18ea4@gmail.com> <xmqqy3hd8q2k.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:SHThjl81SU1K8cQSdliLYq6ZfQxI5tKXyc0UEitwkfcriSe6EfV
 lspc2CVLRXptWGIuDVoMdACeMaFOLcNbg6SXBmponFz1BNcipvGiOZCP/5tdZ3n+QlWRuIy
 xE2xKeFRFGEhtiqAQVJFB4miPafatqKQzQGzVQT+R9a+F9IsvL6EcLEF2/hFcj0xaDvqlwT
 t6jc7p4ORT4veUDFBxg9Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rrByIBtcJIQ=:m6/Y03LlQWOHlBGPVO7Rrn
 2k1yyURqc0YxvfUT2APR8apGIVXTXclM76tLycmo8yB3IYiDSshx4z/m9vlKhmUmVPJDHm3Wz
 TutPx4DmdUvqso6HadhHtSFR9UsAupnmrjDlvtOv9SudngEek076SDMIQFHCz58GXURSiTkXs
 cOruYS4Pq53TeNGhfyoJk9iDWnpXPl+jtxq1uPItv6k9FI/BLYpcAdaVyONA5WpkSkN/+xxOz
 i9z+JG0PVkrN1GU2WZrFOaqbrpdbIRv9rBsedrOFl/YsITsTvLmki51onYBZTSllF4dZO8DMJ
 X3lcU4KOXTGWzKO5PgqOs73CoJh9GYdmHQMX4Hxcw9cx1LMnhpbKg8blbSD15ywkD7Kgf0wCv
 fSu0WrHBCDy9lR8P62xPVpGJUTRl0k926UdkQBkx/moamdajJlbrGlA+X3Sap8rlSCIfnePh3
 3RrqyuhywSZ3D9aV21QDUy2ZLUsifJ3Rooz1fFrCfddkBoFeM/kpXlNsl+TtfWrgESAJXpKPz
 PxyDy9H4C3QttoNhQKLRO4bra/RvqBv+Tm7bQuTeEn3jmIOcrreo8JmwCJzrG/NbP/XI7/ON3
 p6YMYNlxhxAqUAc99q3/84kmxcHQYsymdMxv4Mc7bQme+Epc7lsXAL4ONq4VtLOgAsYaEKmrS
 Aoc3oDKREq4SXB0ENoAOPzIIyB8Wuvzj1CaBJewvJdEgc3a0dOBJ4fc/j2zYDgIKMmfWkRKeZ
 7n3vDDRHNCxvEdrPuGN0za5+3Z0ejClzhtU01PVD7nBqBQfbEVt0nuENaQ+D3WJrnerliEBPI
 B5BgjqU48ZxTuv0DEx0q+ziXWdIqlrRLqqoTst/HjZK3WwHvRQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 24 Apr 2018, Junio C Hamano wrote:

> Ben Peart <peartben@gmail.com> writes:
> 
> >> I also had to wonder how "merge -s resolve" faired, if the project
> >> is not interested in renamed paths at all.
> >>
> >
> > To be clear, it isn't that we're not interested in detecting renamed
> > files and paths.  We're just opposed to it taking an hour to figure
> > that out!
> 
> Yeah, but as opposed to passing "oh, let's see if we can get a
> reasonable result without rename detection just this time" from the
> command line, configuring merge.renames=false in would mean exactly
> that: "we don't need rename detection, just want to skip the cycles
> spent for it".  That is why I wondered how well the resolve strategy
> would have fit your needs.

Please do not forget that the context is GVFS, where you would cause a lot
of pain and suffering by letting users forget to specify that command-line
option all the time, resulting in several gigabytes of objects having to
be downloaded just for the sake of rename detection.

So there is a pretty good point in doing this as a config option.

Ciao,
Dscho
