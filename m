Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 924B11F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 14:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391001AbfAPOHI (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 09:07:08 -0500
Received: from mout.gmx.net ([212.227.15.19]:52611 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733035AbfAPOHI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 09:07:08 -0500
Received: from [10.49.55.26] ([95.208.58.177]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LfkUs-1h35uY0Kh0-00pP8Q; Wed, 16
 Jan 2019 15:07:00 +0100
Date:   Wed, 16 Jan 2019 15:06:43 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH 2/6] commit: copy saved getenv() result
In-Reply-To: <20190115193209.GF4886@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1901161506180.41@tvgsbejvaqbjf.bet>
References: <20190111221414.GA31335@sigill.intra.peff.net> <20190111221539.GB10188@sigill.intra.peff.net> <xmqqsgxywp3w.fsf@gitster-ct.c.googlers.com> <20190112102635.GA16633@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1901151502130.41@tvgsbejvaqbjf.bet>
 <20190115191714.GD4886@sigill.intra.peff.net> <CAGZ79kYMiy=j8z2Y3XA03OD07jeUEXs3frNpjvyAFguVxeoBow@mail.gmail.com> <20190115193209.GF4886@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:IU8m4jcSo01YDAG06LozQTa6mRoFD09w98Cx8mtN0sLPoPVcBzf
 FO+H4Rj1hSAG4saM9wD1cB2dxL4/4HNb68jBCZmE5+UZnyBbLNuLiywhC+yQcEZOYx7taZ4
 7fk1sivAO4eWgT4h8lLUxe8YfPnrdLnMBp0xfuomxETKmXlfAvYqH5Wl9tjofIJS0qvRtA1
 DTQjxd9pxC3G64o38cOGA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UpnC3D5/el4=:wsWclj0U0nvxLL+DJCr9lL
 nxCKgL4vIU9pCcSNpIua0B5hbmVblV9RCAKaW6eijbREhPpf9/BJ4E2Ikap9LpQnVqKwqwmXy
 tSY7DkEDcKzEXjZmR3ds0q09273UVG++3inRw3jxrgacYF5hLsQLEuPX+Al9Cka8JsMFaeLtP
 O8FOTwjV1yOr6JGdr+zdoYIoUbDX7FgEz//IlAs3gNV4H7qZHbQalDtKtAKftwPMnW9YJ5mcj
 LYqA7OvHBGnKfYOK6vtmuNa54FlRTa+4gZYY9e1uQg7C3QFG+ZJEg5Qm24CZdsrZ/W3YkXaSA
 eXRANRb4tHsdwtIgu9ixbrWh2v9twXfbH4M3VHr8vLaffjlMvBCu6JLUH7iipnyurShgxXjCK
 1/0HIjsCJkKqwizWkAmzFZlUdHvct4APH2B58lBAbBd4jUDGsxWJY5WGFD1n19HDFOU7e+rn3
 5yqmsSacCSSoJiaxj7udz1+SlqXPtoq1E3G2S3WGq2w0Hqo244/MS0m8maESK/1k8wIgiMM6i
 zxfw07fBmD0cPpEqIE6dPkRRV428Hf3N+y6nJsPibkCVvlJ3RvnzNoYjluKOOBihJXnzY9vZk
 uMqrjgEEX7j8qfVioXxOg7Kfy8rP4qQ+qEP4l2mbmuWZPK1ejOXNtZHsAx6vVKPl4OJevEgPM
 ns1sRgxbYVir1bD5464gLv64/AGlGZNHO5KUxLlDWd0ytfJ7bLFsuxyl8rODu082eWHURlBBf
 X9loCG/iubZGRZzcLUPeY4Kyvd/ux1u6/iH+EW8dN+oGwjEzigC+Zpod92AATCsX/Iudjomt+
 4qPrr/wA4jP809fEHx0zKRkgToI35ceH860dpjM3Qt7zStR2Xt84KMQPJzAdVN/EsPhNlXtus
 AZlwl/pkrjQ2selJsuE7aA3mpNFtIMsH/DJz14uJkd+R0igpf9+jW5MrIFzROMKMP13vyhjTd
 PbKb5jdzRdg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Tue, 15 Jan 2019, Jeff King wrote:

> On Tue, Jan 15, 2019 at 11:25:45AM -0800, Stefan Beller wrote:
> 
> > > Stefan was routinely running coverity, though I haven't seen results in
> > > a while. I think we should make sure that continues, as it did turn up
> > > some useful results (and a lot of cruft, too, but on the whole I have
> > > found it useful).
> > 
> > coverity had some outage (end of last year?-ish) and then changed the
> > way it dealt with automated uploads IIRC.
> > I have not looked into redoing the automation again since then.
> > 
> > Since 7th of Jan, they seem to have issues with hosting (for everyone
> > or just the open source projects?)
> > https://community.synopsys.com/s/article/Coverity-Scan-Update
> 
> Yuck. :(

What a timely coincidence to corroborate my argument, eh?

Ciao,
Dscho
