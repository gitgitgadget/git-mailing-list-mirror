Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FA541F406
	for <e@80x24.org>; Tue,  9 Jan 2018 13:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756965AbeAINFW (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 08:05:22 -0500
Received: from mout.gmx.net ([212.227.17.21]:52622 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756923AbeAINFU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 08:05:20 -0500
Received: from [192.168.0.129] ([37.201.193.20]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lbi2Z-1fJjjy0bTH-00lELh; Tue, 09
 Jan 2018 14:05:09 +0100
Date:   Tue, 9 Jan 2018 14:05:09 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Jeff King <peff@peff.net>
cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org, dstolee@microsoft.com,
        git@jeffhostetler.com, gitster@pobox.com, jrnieder@gmail.com
Subject: Re: [RFC PATCH 00/18] Multi-pack index (MIDX)
In-Reply-To: <20180109065018.GA32257@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1801091357560.37@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180107181459.222909-1-dstolee@microsoft.com> <87k1wtb8a4.fsf@evledraar.gmail.com> <c08416f1-bbec-2037-34a6-f454d85de439@gmail.com> <20180108102029.GA21232@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1801081438470.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <20180109065018.GA32257@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:xZRgqCyjWDxfaeQ6/7zGk5DGLE/O1AuxPOv2lC4nTdlJ4PkxIHN
 MCKzj23wDO9ED4nZ6bYfGm7dn7hhGZkV3qhbPOyYx+ZVjzMzH10NkPlFH6YRi51F5pErpKl
 E03ekAraSQgJoQwIJY3/1XnuSNVNKiE4csC31Hd89yb7g4gYYY4TMEucXLyndssvcuoM1El
 PCL0Kq611IXU1RDwiBkKg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rZExe/opStk=:KDaXNVcSXT563O6GSmjqDL
 /C2xa7oT0R96dTnEypQV0tCjbFtqIBtaBxCl7PmqT9W+YBUsg+t3Ek2aKS0/VHkzvXdKEg/y6
 qk09obZ1jKNYyAKnH8DCqbiL42mWnY1eBrB4azXBu+4iKFQCeSyge/2H8YCFyjIge8Ffjv8hn
 ZTNcD1wvgi9DKc0m70hF0ikwvnQUJdaxux9YaAkEPGsJchXgeg7sOf2wparTPljPmGmBSDHmQ
 XoLdnze4HyGPsK/cghjhrh23V1bOlzZ59+116uanbjjIMDT8f3y7JGdiI+qvZpHZlV7fgeRg4
 4xwazSE6rN18UkrWyGyADPsEihX3JjQ0KTB2zIgUpvzyRTkAmBhqgzb2RIBlv0nEQLoF04hjk
 EyaCRtWYKslPk4HS0BhX+tMcxKRpdyxgEfInELtQUnE1AGQM6zZWtHOrLNYP7ku8sEca6u9vq
 rqKVBQ9QVxcMf1Os2aGnPNfM4UlOBQDpE4J4Ct27UzyO/KDQ66nGpUdvj8wGQspt+31IQP/8w
 jrA2QctTxv1d2bKNBXtL0ElV9GCRlmaSMCzfIGvipJerdPjuLdaEfLP67GFj+8y6qZW8GEJI7
 FgxpTApPwUWngXZxQ2ThYf9gMiwRvGPxdtwIuPJdPR2JRG/ElTnQbElqj9MAq1nJ6joFjFPJX
 cGAC6jHEW3m49lfRtNCZ/2WSdMnUZPHTS/LRtIrZV91y16Z7vIM+fRBACmH04ImnlI3YqVMTC
 Zyq9HKvLXMM+yqrMYPw+AvuOWgigc+cYm0FZ0417rZ4H4gVdz2dzGRPo39NeVEeZO0ew1CsiI
 2CybA/kF9LtXaGuPCOzBxt+4SvsKM2nxW5awebJSi6QdatA92HTKQfzxrqUHrZuUIFGWA55
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Tue, 9 Jan 2018, Jeff King wrote:

> On Mon, Jan 08, 2018 at 02:43:00PM +0100, Johannes Schindelin wrote:
> 
> > Take the interactive rebase for example. It generates todo lists with
> > abbreviated commit names, for readability (and it is *really* important to
> > keep this readable). As we expect new objects to be introduced by the
> > interactive rebase, we convert that todo list to unabbreviated commit
> > names before executing the interactive rebase.
> > 
> > Your idea (to not care about unambiguous abbreviations) would break that.
> 
> I think that could be easily worked around for rebase by asking git to
> check ambiguity during the conversion.

Sure.

It also points to a flaw in your reasoning, and you should take my example
further: previously, we guaranteed unique abbreviations, and who is to say
that there is no script out there relying on that guarantee? You?

> But I agree it's a potential problem for other scripts that we might not
> have control over. I hadn't really intended this to be the default
> behavior (my patch was just trying to show the direction). But it does
> make for a pretty awful interface if callers have to opt into it
> manually ("git log --oneline --no-really-go-fast").

Exactly.

> I am a bit curious if there's a bounded probability that people would
> find acceptable for Git to give an ambiguous abbreviation. We already
> accept 1 in 2^160, of course. But would, e.g., one in a million be OK?

What is that going to solve?

I think a better alternative would be to introduce a new abbreviation mode
that is *intended* to stop caring about unique abbreviations.

In web interfaces, for example, it makes tons of sense to show, say, 8
digits in link texts and have the full name in the actual link URL.

Currently, we have no way to tell Git: look, I want to have a short label
for this, but I do not really care that this is unambiguous, I just want
something to talk about.

(And you are correct, of course, that the uniqueness of abbreviations will
no longer be guaranteed for partial clones, and it is already not
guaranteed for shallow clones, and it will only be possible to guarantee
this, ever, for one particular repository at a particular time.)

I am just hesitant to change things that would break existing setups.

Just to throw this out there: --abbrev=8! would be one possible convention
to state "I want exactly 8 hex digits, don't bother checking for
uniqueness".

Not sure how urgent such a feature is.

Ciao,
Dscho
