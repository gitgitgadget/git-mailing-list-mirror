Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 979AE202A0
	for <e@80x24.org>; Thu, 26 Oct 2017 19:15:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932458AbdJZTP4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Oct 2017 15:15:56 -0400
Received: from mout.web.de ([212.227.15.14]:58944 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932404AbdJZTPz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Oct 2017 15:15:55 -0400
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MQf77-1dl10n1Jfx-00U69M; Thu, 26
 Oct 2017 21:15:44 +0200
Date:   Thu, 26 Oct 2017 21:15:43 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Consequences of CRLF in index?
Message-ID: <20171026191543.GA27760@tor.lan>
References: <D0A67AD8-2D63-4683-9F2A-20B0E8E65D4B@gmail.com>
 <20171024181415.3tvmc36aqi335v66@aiede.mtv.corp.google.com>
 <07309D89-F536-4DA8-9214-B605007845C6@gmail.com>
 <20171025171357.4nk4aj2c4m4b6kl3@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171025171357.4nk4aj2c4m4b6kl3@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K0:2yswx4vS14XhlmjdnY2+5tBiH23Ro8rVx/bI8kuV8Kt8t3jEi/K
 F7DAXc/Tz4S4OHYmSRwsG71sJtYPfP7nnNxT9k/WEmrTo0V/a0IHtSSTuwGvtaWxwixwmJ5
 3JlxsxpNGwHfvv9EyeTdaX4pIgN4xKj8+/V7wsCRmR2XONh5H4ST/5dIS3t4F59j9QZaI7P
 s296qLEjquNGGocZbg/0w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:n3iXE2DCJa4=:zV0G6f7oap0CKEhxpCajHv
 YUsXS+WSvMEbFi76JSNC4fok9K1H3VjoFVSed5VfF64giOXKCtghIhJXDOVLJ8rQLXEz9g2/I
 /CH/BmqRGiUQz/ElgBKD9YSrgnDDCtF4qCa3iXDHc+yruqioor+fP5K+6L/6xVR729JF9D5bJ
 3oT8UZPfNSs7BL8BKbjfOhF9Mksl4TNGQhWh5W0aYvnokCpj9KrtjoNaWVHZhMDDG/u/Ixupu
 txQtHryH7fS2SbL4D7W7VetQQpUCJQt6p+QqKJUaAOozw4BrnwG22VOesj+7cxQ3VUj7eVyeH
 Z191GkjT4ojdCPkQtFKbeG2gNS7XycgTX3beN/JgRxg2/SKGInhKeoJHaKx3jw+MubmWg/6If
 sLhr2q+bWdE1q/3eplF7SteJRpqzR+NC/6/QIFPqKYjehaJ3+ReJUbztWlPIwZ4GFLV8AmHXV
 RNs4h4gkqOB/TA3KxCyfRnGbLRQs8YoglaJZakOI1pxW2hXuhfhokBdUG/0w6y254FoSaSO1p
 76HI2OPO9XxB2iGQIObtVFP4drPGdy3BKtKCAZ0T2277PsyoN2jVagF6sebmPfilxh2Dt1rr1
 PUZitZnJO3X7exZzFryR66xajZk0+DetYNoUYiBwAWyOoX6Pl7klSkvuvhS8M+izEfrtTrcSO
 s3NB7sS4GRFSBgd0L3QJrwKi7cHY2O5WKRw2rZJOME4XuRG5NLpW85rjmUxw72WmssHqoyamb
 Y2SZnphK3IogWTYdW7bQLjBUZrzLyClcoxcfajthwzA+HMbml9WoDPxhdE6O4S9mUEWd25Ti2
 avTJdgj3QncHd9RX928VgUOZLszeA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 25, 2017 at 10:13:57AM -0700, Jonathan Nieder wrote:
> Hi again,
> 
> Lars Schneider wrote:
> >> On 24 Oct 2017, at 20:14, Jonathan Nieder <jrnieder@gmail.com> wrote:
> 
> >> In any event, you also probably want to declare what you're doing
> >> using .gitattributes.  By checking in the files as CRLF, you are
> >> declaring that you do *not* want Git to treat them as text files
> >> (i.e., you do not want Git to change the line endings), so something
> >> as simple as
> >>
> >> 	* -text
> >
> > That's sounds good. Does "-text" have any other implications?
> > For whatever reason I always thought this is the way to tell
> > Git that a particular file is binary with the implication that
> > Git should not attempt to diff it.
> 
> No other implications.  You're thinking of "-diff".  There is also a
> shortcut "binary" which simply means "-text -diff".

Not 100% the same, as far as I know.
"binary" means: Don't convert line endings, and there is now way to
do a readable diff.
The only thing to tell the user is: The binary blobs are different.

Then we have "text". The "old" version of "text" was "crlf", which
for some people was more intuitive, and less intuitive for others.
"* crlf" is the same as "* text" and means please convert line endings.
And yes, the file is still line oriented.
"* -crlf" means don't touch the line endings, the file is
line-orinted and diff and  merge will work.
"* -text" is the same as "* -crlf"

> 
> Ideas for wording improvements to gitattributes(5) on this subject?

None from me at the moment.

> 
> Thanks,
> Jonathan
