Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB0E11FE4E
	for <e@80x24.org>; Sat,  2 Jul 2016 07:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750900AbcGBHYZ (ORCPT <rfc822;e@80x24.org>);
	Sat, 2 Jul 2016 03:24:25 -0400
Received: from mout.gmx.net ([212.227.15.18]:50859 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750789AbcGBHYY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jul 2016 03:24:24 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MTTKZ-1aqonV0FoF-00SMKt; Sat, 02 Jul 2016 09:24:18
 +0200
Date:	Sat, 2 Jul 2016 09:24:16 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	git@vger.kernel.org
Subject: Re: [PATCH 3/9] Prepare the builtins for a libified
 merge_recursive()
In-Reply-To: <xmqq37nt1i0k.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1607020921200.12947@virtualbox>
References: <cover.1467199553.git.johannes.schindelin@gmx.de> <753eabc5193c148c67e64ed5d070b6ff08f51d82.1467199553.git.johannes.schindelin@gmx.de> <xmqqziq33ju2.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1607011123550.12947@virtualbox>
 <xmqq37nt1i0k.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:IsFJpjh9qU4DB54KDl/J26AMTSEiZWrQ2lZsP2wZ5s5Cu7Xgp9I
 3Hpx3zvudVxBtW6Yzgc6MCthlVKZTikYnDVGxPDW8nUgQ8DQPRsJVu6bPl80+psamThcxCg
 ohx9qtwzxg5ydwgD9GkIHra7JG4AKllMJ7EBkJGCCFSCkHngGoW24pZqqFd4TBzrAlR9XNW
 IP9XUYvHS/Qbw+FlPjn8A==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:FLyZYr7N+Nw=:iwkPh5YM7F5glounxV85hW
 Zo5rSosT5xq1pDnn8sn8yg0sfe7zU3QoZs5QuypXLjasAUS60VhsgEIIdGumBg8RD1+Jp5Wfg
 6BPAdt8xr3eQKBZT2QC8ta0R76gjOB3BJP9dAgrkmyGviyBtpIFEbgl78CxxzYgGFpZDD/gN5
 KkRO3/cAmPRsC2K2gArIFq0rDmJriheYGOrVNu114EabTwyHFhgSz2bXVnnyI8hEV7/mOWqSx
 ceexyIiB0NF/6YuLQBl/IlUOxODricvZ6vrn9u/RY4NCuoMalH6pqyFZaqskOTDh0Ht0kKZve
 nH5sgOBgNiRIo19jiZm9GJpiPRXCs0kTWKFypHCoWrnF2BYtKDcuQL0D1Ejg07RZz5MG2758z
 8yldn5aXtIswf25ZFaocB9bDB1uRSZ5NJC+pAZp4iSaH/7eojAarjBEMyXIegQN6ZP9UewtQc
 mM9a1w/8NWL4/Zqw0ln80ovXFj6DdWCLT5N6HhaPsJt8objvgNT2JeIAvWjM7geVjTNvW4kgi
 pb0M2su7iJkF5msr5B6EG/AXsoILPkxuUjJ4zOCrUYnXhJayH8Zf8zKs9TsI7g8hhemFgKbsq
 Ptc/EjYSUV0la5uqVG2fiqVKVwoNNh8sh/aUye2NtGQeGMc7px4bDcQa5+0lcdFA/yVAVpEiA
 DGB8RHmi9/SHGOpVeYL8/jxwTrDkWnxJjghaJ2VwRhLq+bhRmhBAC+cdThpiUUC2mmCNrayHh
 wh6CQ9IhLiNuBYZ6Vs0MmRDwvBT0GBdLxeT+PmvQ54bAzcVBxdgjV3/8gxoZK/Ly/M27RyN2I
 WwArrFX
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Fri, 1 Jul 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> > A truly libified function does not die() just for fun.
> >> 
> >> The sentence is wasting bits.  After all, a helper function in
> >> run-once-and-exit program does not die() just for fun, either.
> >
> > This sentence does not so much target *you* personally as audience, but
> > the occasional reader of the log who wonders: "Why don't we just call
> > die()? We would not have to worry about passing back the return value
> > through all those long call chains..."
> 
> I was (and I am still) reacting mostly to "just for fun".

Yeah, sorry, that part was lost on me.

> > Even more natural is it to guess that the code will call error(), just
> > like we do almost everywhere else.
> > ...
> >> But that does not mesh very well with the stated objective of the
> >> patch.
> > ...
> > I could imagine that you wanted even more fine-grained control, where we
> > have a range of return values indicating different error conditions.
> 
> I personally don't.  I was pointing out the discrepancy between what
> the introduction says, i.e. "this way is way more flexible for the
> callers when they want to do their own error handling", and what the
> code actually does.  If the explanation said "This series does not
> give the full flexibility potential callers may desire yet, but at
> least gives enough flexibility to do 'I do not want the called
> function to die, but append my own error message before I die
> myself'.", that is certainly an understandable stance to take, I
> would say.

Ah, but the message did not say "error message handling", but "error
handling". With my limited command of the English language, I tried to
convey that this patch allows the callers to do something when the called
operation reported an error. Previously they did not get the chance.

Ciao,
Dscho
