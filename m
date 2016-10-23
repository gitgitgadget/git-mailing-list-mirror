Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0ED3820229
	for <e@80x24.org>; Sun, 23 Oct 2016 09:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756300AbcJWJu5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Oct 2016 05:50:57 -0400
Received: from mout.gmx.net ([212.227.15.19]:55555 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753241AbcJWJu4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Oct 2016 05:50:56 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0Lj1Xa-1cUYm409IE-00dCuW; Sun, 23 Oct 2016 11:50:42
 +0200
Date:   Sun, 23 Oct 2016 11:50:40 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v5 00/27] Prepare the sequencer for the upcoming rebase
 -i patches
In-Reply-To: <xmqqinslbl5t.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1610231135270.3264@virtualbox>
References: <cover.1476450940.git.johannes.schindelin@gmx.de> <cover.1477052405.git.johannes.schindelin@gmx.de> <xmqqinslbl5t.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:gaLUHS4OznlQbnEVH1rnK7bkvcGE55nXqhRTn7fz6nXrb2BzwB4
 V5p2skmTJbyU+0IbB/NoMy6KJarnmRCMLPSh6wLJmKFEXHIdYGb+LmMHJhcBhFRWxo1Gj7K
 WkY4KKd61sBXglSdFXNqMnEJF8pi0y5Bu68uaZahH18Xdv63HVKeMqbqt7Cy6UT6pUq4550
 2iaGwLT5n632G4zKH+wRQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Eg1vbLhow+8=:zRtJQcog4VzaSI7589gDjR
 CZoHzWuWlRklgRvfa3dNbub1tHvA9UbhBp37InOwQ9Q1cSQ+X+gzmVFsbljB/iKx30X81zVem
 Ps0UIOczrdKAovjfGvXrMhhuYqwHAulUwimROa7kgivyQZg7ZV0CVWJM58DYJfkZgfTBxTnry
 JWK0nW9AoxGvACqRN3f9Mb9+BVX3GYjssFrxFCVtmpWJCq8cp54vsfUd1GBWPc/K2FskSscao
 5v6hCDaXE56HR/bMqmKwTavIFLJq7mpEhR3GR5b3bzQccC2D8WoqdrhkP0Z63zVRbCU6Fickb
 GvCoJDhE/9co9isslbHIPKU8FALML25zSDinB7LB1BNm2idO/2tS+LoICwGVO16GmFbe1xnID
 tnAh+WSIk2yLctvDTqifgc5avGlTXGv1JZytw6fjMpBHhv5FOu+nJ9p0CQLk6cFNujyZLMPBK
 NjEXtjED0WDg8IT3m+Cm5QTtmghdILNVj1MbAJMxf5JZeIqChqVzFMyAyDJTDL1SWyS+Zn/R3
 ZjbSPgbp8L0uEXxkDOjDzEHewu1NPZqWEQUp0Grkhophw4H4X9zSkndvZXnfumpcPJQU4IrAG
 1FHS+N+Zc9ytmYm0iOxYsddJldwBrRNku9ZAa19Mq6Sm1P2F773TwqJ4y1c49FBbwVICtyd2h
 IvOP3uW4OPpyzGS/VY6/syeMcubWtlO2dXXVC+mqBAJC25xFbLJqLEhM7pt0Njp/ivJIFIFVQ
 3MpMuIeMOEa2H+lmky8hgehEY9beEp+rHyIj+QbdyVPjwWI9cRxL5j+iKFsFLNhZ69VnrMp2Z
 OSFcY3r
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 21 Oct 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> I still do not understand (note that I am not saying "I do not
> accept"--acceptance or rejection happens after an understandable
> explanation is given, and "do not understand" means no such
> explanation has been given yet) your justification behind adding a
> technical debt to reimplement the author-script parser and not
> sharing it with "git am" in 13/27.

At this point, I am most of all reluctant to introduce such a huge change,
which surely would introduce a regression.

This is what happened a couple of times to me, most recently with the
hide-dot-gitdir patch series that worked flawlessly for years, had to be
dramatically changed during review to enter git.git, and introduced the
major regression that `core.hideDotFiles = gitDirOnly` was broken.

The lesson I learned: review should not be valued more than the test of
time. This lesson has been reinforced by all the regressions that have not
been caught by review nor the test suite running on Linux only.

It would be a different matter if I still had the cross-validator in place
(which I did when I sent out v1 of this patch series) and tons of time to
spend on accommodating your wishes, however I may disagree with them. And
in this instance, I thought I made clear that I disagree, and why:
Internally, git-am and git-rebase-i handle the author-script very
differently. That may change at some stage in the future, and it would be
a good time then and there to take care of unifying this code. Currently,
not so much, as the only excuse to use the same parser would be that they
both read the same file, while they have to do very different things with
the parsed output (in fact, your suggestion would ask the parser in the
sequencer to rip apart the information into key/value pairs, only to
re-glue them back together when they are used as the environment variables
as which rebase-i treats the contents of the author-script file).

So no, at this point I am not willing to risk introducing breakages in
code that has been proven to work in practice.

Ciao,
Dscho
