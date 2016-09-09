Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED75A1F6BF
	for <e@80x24.org>; Fri,  9 Sep 2016 15:08:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751998AbcIIPIN (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 11:08:13 -0400
Received: from mout.gmx.net ([212.227.15.15]:49751 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751618AbcIIPIM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 11:08:12 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LiDnn-1bDBf42IlP-00nOwZ; Fri, 09 Sep 2016 17:08:05
 +0200
Date:   Fri, 9 Sep 2016 17:08:04 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 21/22] sequencer: left-trim the lines read from the
 script
In-Reply-To: <xmqqvayfwlgu.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1609091707470.129229@virtualbox>
References: <cover.1472457609.git.johannes.schindelin@gmx.de> <8c30113a920e075e5ecd68ba31b4007de3e2dbc2.1472457609.git.johannes.schindelin@gmx.de> <7996a963-52b5-5f3c-f686-f5cf22573573@gmail.com> <alpine.DEB.2.20.1609011608440.129229@virtualbox>
 <xmqqvayfwlgu.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:+GJLnHFIDK7mVu+PWO36rETrEQKFKxtt+ccFUOOYdWTCPCtxRSj
 w8gyWuuU2/zlZvXwugno1TACwpIzgMeWfsl3hconv4E2kmgcjaO7Ux0MpICyei4+uCNqbNF
 ZXqS7iC5zmc+6OKSUgjvGS1fZM8UJHvl33J61VpLMxvHjcqa/4kbr7VVKmVFynx7vGqdIBs
 W7h64cm53n+hfrl8kf3ww==
X-UI-Out-Filterresults: notjunk:1;V01:K0:es5WkMup6Ow=:j8sU5MTSHddbDhePELeyrV
 OFnclNCR1YkAH5w/eGqZOkfOmUp/ckyUImcaJJizgy/01aSXKpK/UvDNWy2NowBgQwApCGIHi
 XTWLrBUmS0a1o1eF+9zKiMOU0+VM31I3XlGm9+LX3dZ1n2HjfYt/7h/lPGtl6DngEzXYpxQq+
 G4fJOYt1nuwYNUv04j9u/uhHciH1n7E7KNMw9HFMXnLHk++cOnoF8L3Sgx1SBfuvJJSR9HMKy
 8VD63se4bGRo5I0lO31IOC4SQjZoZH1KDAjRJweGJkmMK82qTn9bxZy4B/39TiccKnL1egSxt
 bkyTsiWSAV6cr9BOW/mfncw/JzL59N6+X07rHKADql23Ezw/KD63GxtJyWw43uYFbdeS0orWv
 mNSOFiRzOLNDbZH7HCEO0JQa23d9dIOVMyQU2guVgyLWAAdcapB77A2PqSSniisPqlVbMHq5Z
 DvW5k0wpjda1e0qFw1CTH6JvL0th/MtcAR/E3lfjkxKdEvqSLDMVVtZv002KGo3IZTEBtoIgj
 XDEBr9elkvKGFTsIY+nZnIw/QpDQxU+IQrtrACVGw5KSeNAY++FAzy4qmPAnynNB5SZ2d40GC
 xJCYyJE6cb15+zIlpa+NxSl3i+5K6IwXv2hvmUVw9YA3VNKsYTL7JhkELQWVv7gnyUfqreM04
 4w2IV9YVHZOYzEinPq1/BZ3dogBwXlCboAL7ozZZqm1v6CTOs9mevvbzGhrMoJCMSdYWa5SHd
 Z7f+vrZnucXCmiRe2/tklvuioTM53TCL4pkCwEg5t4fZ0bC6Ss2zWecRDkSqeNVK6ldbVFRMN
 LzaOJtW
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 1 Sep 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> > Interactive rebase's scripts may be indented; We need to handle this
> >> > case, too, now that we prepare the sequencer to process interactive
> >> > rebases.
> >> 
> >> s/; We need/; we need/
> >
> > Hrmpf. From http://grammar.ccc.commnet.edu/grammar/marks/colon.htm:
> >
> > 	There is some disagreement among writing reference manuals about
> > 	when you should capitalize an independent clause following a
> > 	colon. Most of the manuals advise that when you have more than one
> > 	sentence in your explanation or when your sentence(s) is a formal
> > 	quotation, a capital is a good idea. The NYPL Writer's Guide urges
> > 	consistency within a document; the Chicago Manual of Style says
> > 	you may begin an independent clause with a lowercase letter unless it's
> > 	one of those two things (a quotation or more than one sentence).
> > 	The APA Publication Manual is the most extreme: it advises us to
> > 	always capitalize an independent clause following a colon. The advice
> > 	given above is consistent with the Gregg Reference Manual.
> >
> > Based on that, I think that a capital is the correct case here.
> 
> Does that manual have anything to say about semicolons, which is a
> different thing?

You're correct, I overlooked that.

Fixed,
Dscho
