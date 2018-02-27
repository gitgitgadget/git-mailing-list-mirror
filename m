Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 503311F404
	for <e@80x24.org>; Tue, 27 Feb 2018 21:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751798AbeB0VFf (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 16:05:35 -0500
Received: from mout.web.de ([212.227.15.14]:48473 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751518AbeB0VFe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 16:05:34 -0500
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MW6Ib-1fEgBa23lR-00XNTE; Tue, 27
 Feb 2018 22:05:19 +0100
Date:   Tue, 27 Feb 2018 22:05:17 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Jeff King <peff@peff.net>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <lars.schneider@autodesk.com>,
        git <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v7 0/7] convert: add support for different encodings
Message-ID: <20180227210517.GA17555@tor.lan>
References: <xmqqr2pm81hh.fsf@gitster-ct.c.googlers.com>
 <DC552BF4-3E87-41E0-BF92-4BA9633D374E@gmail.com>
 <20180216165815.GA4681@tor.lan>
 <19EDC192-0D83-4762-AC6A-81F7D693475A@gmail.com>
 <xmqqbmgfvf2y.fsf@gitster-ct.c.googlers.com>
 <xmqq7er3tqjq.fsf@gitster-ct.c.googlers.com>
 <FDF4DEB8-E71A-4BFC-9437-678C8F65BBDC@gmail.com>
 <20180226014445.GB8677@sigill.intra.peff.net>
 <20180226173533.GA7877@tor.lan>
 <20180226204635.GB12598@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180226204635.GB12598@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K0:TkNv1dZw7l50p2yy34bYnOXyTpxI6WRplOokpv3//XFy0ycUhYs
 Jr9kxUPGs5lvfmgqQvC2yRRoGZRpkKwCwhUF6NGkKbWgWuYJhXpfN89IPSY4Biwd7zJh0dI
 235XUNNbO4J0tVEcn3thV9axB8hHBHC8y9hu0dDbgCaV+RMGY2gUDJ58Pl6v40TXQjpJV+x
 79XKY2sKK4b4FW2V7WUlw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:iIjKfLv5AQI=:X7oRriCh72Wp0YCrZ3E4tX
 svGOllCMBAK1ej6QwB73/DXXdR5ntmKMYVcW9+p8bOE7wJ5kRsJia67BHxMGyDPzOUES/Pz+o
 x60xmDIWc2wryEnbzRZuPJOXwHY4JdA9mLK3wG+eN9GI2rXG2CHv2FAbNZx9nSEfIW0/qNueT
 TX0FeQli5A7u3UqRbeBm5OTPwvUh9ea7XRS3C2lbYKQRw4+QmirxXms3Qx+Z3lEPsF0opcEoi
 JmWgByKy0ZHXLOVTmkIAP8QVFl1Rc4N1O+kkwzY51WT0tuRxXN2MyEQh0TcJW/qGf3pW15Apg
 E50EEJtFgb9krl4Oat+dCjC6oNOUgOcITZAaA1u5ofWYcLBs86uMHoq82m4gK/rX+KTnJlu3D
 1pA9wNkNGzj4wzQR0Aj6C3BLRx2bS7vam5xbaQcLiwwvKjjb2m2aalxNXEQrXpsyhxYuoOuAV
 0z2idCtVMD8lBO8xxvyWI5JiJ99MeNh1EhG/qlnIpxiLgnzu4HAVuxtfbWbgc3rFXD8yj5oFJ
 PymAJ0FYoxbgsJiMhDMgiOw2wHIR/5Y8zWzLYH8TgxEXkbMhhAPbKexT2gDAgreC/Lt8GZAWG
 AGJvbp4am94yY5dcCwuZUIDSvCiNyBlpoeQ23vaKLENPxJh17Jg/eTFnlEH17XfrTsKODJ4Ia
 HtgQHsNKZ0uQq7NCuaqvD4BYa+mFx7wYRWskjtLbsC1X6IIGviAqAQzm28SDoQiQqyBNHDlCx
 Yb/v4r+hNiY2nYPy+xtRQiiUmh5GEDYfTbmnAl9LHBlZb3JuiRrQ0zjjPJg5ENEeYmN9JEdve
 S6fQjQwN6phHxUNuKuIswVdemwf0A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 26, 2018 at 03:46:35PM -0500, Jeff King wrote:
> On Mon, Feb 26, 2018 at 06:35:33PM +0100, Torsten Bögershausen wrote:
> 
> > > diff --git a/userdiff.c b/userdiff.c
> > > index dbfb4e13cd..48fa7e8bdd 100644
> > > --- a/userdiff.c
> > > +++ b/userdiff.c
> > > @@ -161,6 +161,7 @@ IPATTERN("css",
> > >  	 "-?[_a-zA-Z][-_a-zA-Z0-9]*" /* identifiers */
> > >  	 "|-?[0-9]+|\\#[0-9a-fA-F]+" /* numbers */
> > >  ),
> > > +{ "utf16", NULL, -1, { NULL, 0 }, NULL, "iconv:utf16" },
> > >  { "default", NULL, -1, { NULL, 0 } },
> > >  };
> > >  #undef PATTERNS
> > 
> > The patch looks like a possible step into the right direction -
> > some minor notes: "utf8" is better written as "UTF-8", when talking
> > to iconv.h, same for utf16.
> > 
> > But, how do I activate the diff ?
> > I have in .gitattributes
> > XXXenglish.txt diff=UTF-16
> > 
> > and in .git/config
> > [diff "UTF-16"]
> >       command = iconv:UTF-16
> > 
> > 
> > What am I doing wrong ?
> 
> After applying the patch, if I do:
> 
>   git init
>   echo hello | iconv -f utf8 -t utf16 >file
>   git add file
>   git commit -m one
>   echo goodbye | iconv -f utf8 -t utf16 >file
>   git add file
>   git commit -m two
> 
> then:
> 
>   git log -p
> 
> shows "binary files differ" but:
> 
>   echo "file diff=utf16" >.gitattributes
>   git log -p
> 
> shows text diffs. I assume you tweaked the patch before switching to
> the UTF-16 spelling in your example. Did you use a plumbing command to
> show the diff? textconv isn't enabled for plumbing, because the
> resulting patches cannot actually be applied (in that sense an encoding
> switch is potentially special, since in theory one could convert to the
> canonical text format, apply the patch, and then convert back).
> 
> -Peff

Thanks for helping me out.
I didn't use "git log -p", but a simple "git diff".
(And after re-using utf16 with lowercase, it works as you described it)

I wasn't aware of "git log -p", something learned (or re-learned)

The other question is:
Would this help showing diffs of UTF-16 encoded files on a "git hoster",
github/bitbucket/.... ?

Or would the auto-magic UTF-16 avoid binary patch that I send out be more helpful ?
Or both ?
Or the w-t-e encoding ?

Questions over questions.

