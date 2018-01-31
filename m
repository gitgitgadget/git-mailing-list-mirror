Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FE1E1F404
	for <e@80x24.org>; Wed, 31 Jan 2018 13:49:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751662AbeAaNs7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 08:48:59 -0500
Received: from mout.gmx.net ([212.227.15.18]:50401 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751447AbeAaNs6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 08:48:58 -0500
Received: from MININT-KR8J64V.europe.corp.microsoft.com ([37.201.195.59]) by
 mail.gmx.com (mrgmx002 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0MdKgV-1ePUSf32UF-00IWfN; Wed, 31 Jan 2018 14:48:50 +0100
Date:   Wed, 31 Jan 2018 14:48:48 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Jacob Keller <jacob.keller@gmail.com>
cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/8] sequencer: introduce the `merge` command
In-Reply-To: <nycvar.QRO.7.76.6.1801292230550.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Message-ID: <nycvar.QRO.7.76.6.1801311441430.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1516225925.git.johannes.schindelin@gmx.de> <647382ac70bfb7035345304a32d08f4e7b51cd40.1516225925.git.johannes.schindelin@gmx.de> <b3b37af6-4b65-5a44-a395-6f75a4adc98e@talktalk.net> <CA+P7+xr4KtR4q8Y=-+pv2TzvP009zRVR6a_zh2GOZXt_LXrFOg@mail.gmail.com>
 <nycvar.QRO.7.76.6.1801292230550.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:7OU9pRCA1m6qK3ddaMRy3WQAA4nEqyUbY1RIN9wxBDMr4VaZTz8
 HU8br9xunftD5QLWgrEfzQtRvlloyw8JfbnShqQA8ea4bMfQMsN6dlzJ3mdKA3Nww3aQCr0
 91jUp5B5UU8Rj/pWW5dAI475dNij2Lk4UaZtUUKKK90UjTupGoSUccAtZjlqOBqSWlZiJPk
 T1Ob8h2IFN7eotJBGuERQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:45Z9TeF3u/k=:uJJVIUCbKntY084aQ5WQYh
 ZCdio/LgMuvaGuDlKqOs1buX4/lFQo8Cx2Z6Q9fNygVzD3DcW/vW9U6OZq+Nt/BueG3QC+tcP
 sV/dChTaq9gsxM/mG13ZF6FBuKGV4hldimlLYC0IqBwia5EoOuzqH/Tshk9j7iUHgBiep+eZD
 mG3TVUlhoxAlDDe6eyniCeGRwkK9siCEN25hjFkQr7pSFqj7fTZrWD1Be0WREc7praXSJwEBT
 UrQ/L7nxFPTJjErdf+8AHar/asIsH4vTJpskl7rUrffNa8pqfYPlxvBPeHdpSjJZikkY3BLJK
 U92yxz8BCaWgEWODZP3VBf8Aq/BY0H/Fc0PUf4ShKt4HgmJC+jN5QUsKn72w5J0+vHFAv6hl6
 /IlMWNUh4xVk4b2pHRI+llu6lAR6gBkVev0vgT8ciceOEb19rk2vOB7a9vG7xAFIRN3IbuXQ1
 ePEE6rZTe6lNFphCIwWbBLgwJxF9fAIZsCWEp92Hb/EVCWjc2j7zIJiDms9HRSG46tLFoD4IA
 3NQS/sGXffcpEMBgmZUzcPFYPnJQzj5AGq/F8feeH7eM8Il8FZKyu1JZhhXXHp/1ijqwKZidt
 r4uthWtvm+V2OFMKRELCCnLg3O27Cpk3ylcyjfeMx7hl3ImWbDAKQZA+60LTO9EnKxalpx0Nw
 FRWByOAKEDACz3y8cW6uXMnjYal1yEPuuAQsX5MdLt2CCnURUB6XZIT4PMZ+XABQ0eXbJ97ng
 mKiilgdVMwMiWBnHpd5Bd+NraRrqmtETlCn0ep9P0//xBdSIxD26VlBQHpJD/hFY9eY+xus8I
 l+WlyFsjqzprddTVsWYzHPkSfmd3o6s0kXQJaV6WqsqsG/pv92zH/XESzYa/bJrCax+i9V/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jake & Phillip,

On Mon, 29 Jan 2018, Johannes Schindelin wrote:

> On Sat, 20 Jan 2018, Jacob Keller wrote:
> 
> > On Fri, Jan 19, 2018 at 6:45 AM, Phillip Wood <phillip.wood@talktalk.net> wrote:
> > > On 18/01/18 15:35, Johannes Schindelin wrote:
> > >>
> > >> This patch adds the `merge` command, with the following syntax:
> > >>
> > >>       merge <commit> <rev> <oneline>
> > >
> > > I'm concerned that this will be confusing for users. All of the other
> > > rebase commands replay the changes in the commit hash immediately
> > > following the command name. This command instead uses the first
> > > commit to specify the message which is different to both 'git merge'
> > > and the existing rebase commands. I wonder if it would be clearer to
> > > have 'merge -C <commit> <rev> ...' instead so it's clear which
> > > argument specifies the message and which the remote head to merge.
> > > It would also allow for 'merge -c <commit> <rev> ...' in the future
> > > for rewording an existing merge message and also avoid the slightly
> > > odd 'merge - <rev> ...'. Where it's creating new merges I'm not sure
> > > it's a good idea to encourage people to only have oneline commit
> > > messages by making it harder to edit them, perhaps it could take
> > > another argument to mean open the editor or not, though as Jake said
> > > I guess it's not that common.
> > 
> > I actually like the idea of re-using commit message options like -C,
> > -c,  and -m, so we could do:
> > 
> > merge -C <commit> ... to take message from commit
> 
> That is exactly how the Git garden shears do it.
> 
> I found it not very readable. That is why I wanted to get away from it in
> --recreate-merges.

I made up my mind. Even if it is not very readable, it is still better
than the `merge A B` where the order of A and B magically determines their
respective roles.

> > merge -c <commit> ...  to take the message from commit and open editor to edit
> > merge -m "<message>" ... to take the message from the quoted test
> > merge ... to merge and open commit editor with default message

I will probably implement -c, but not -m, and will handle the absence of
the -C and -c options to construct a default merge message which can then
be edited.

The -m option just opens such a can of worms with dequoting, that's why I
do not want to do that.

BTW I am still trying to figure out how to present the oneline of the
commit to merge (which is sometimes really helpful because the label might
be less than meaningful) while *still* allowing for octopus merges.

So far, what I have is this:

	merge <original> <to-merge> <oneline>

and for octopus:

	merge <original> "<to-merge> <to-merge2>..." <oneline>...

I think with the -C syntax, it would become something like

	merge -C <original> <to-merge> # <oneline>

and

	merge -C <original> <to-merge> <to-merge2>...
	# Merging: <oneline>
	# Merging: <oneline2>
	# ...

The only qualm I have about this is that `#` really *is* a valid ref name.
(Seriously, it is...). So that would mean that I'd have to disallow `#`
as a label specificially.

Thoughts?

Ciao,
Dscho
