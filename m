Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8157B207E4
	for <e@80x24.org>; Tue, 25 Apr 2017 21:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1954853AbdDYVXb (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 17:23:31 -0400
Received: from mout.gmx.net ([212.227.17.22]:50797 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1951359AbdDYVX3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 17:23:29 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MAloF-1crG6W0Syp-00BsEh; Tue, 25
 Apr 2017 23:23:19 +0200
Date:   Tue, 25 Apr 2017 23:23:17 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Andreas Schwab <schwab@linux-m68k.org>
cc:     Liam Beguin <liambeguin@gmail.com>, git@vger.kernel.org,
        peff@peff.net
Subject: Re: [PATCH v2] rebase -i: add config to abbreviate command-names
In-Reply-To: <87zif4q0cy.fsf@linux-m68k.org>
Message-ID: <alpine.DEB.2.20.1704252318080.3480@virtualbox>
References: <20170424032347.10878-1-liambeguin@gmail.com> <20170425044320.17840-1-liambeguin@gmail.com> <87zif4q0cy.fsf@linux-m68k.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:8f1k2iKovk8unbsRPc93xoXq4XFrRHQRJvhtc6ENY46nEl5Ollk
 ySe7pRjT5HCAHuVaiYsnzbIfnWW2wFKUh3nY4H36f57O+l232ZmyXKtHl0r/EIpHI/swYoY
 JVv/gcG8KyNzeaE7f+kCA7PGppurWqM4yLdUUrrsFsWL4ZHCEiNfCqUT0iEkdQhtbJnEDhy
 BWQ6PCjFqIH66Kh4glxGQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MbPg1Q1gHnY=:e2gJnjJWG+eNCFa9g8L5CV
 hL0joHrAJVlAfCO2f5OhFwTq872v8yHOO6Xn8sJwB6QflxAbFDzKRw8TlZXSFZ2l5RrciF5q2
 K4v2HFLKXjHThkURUnNWpPjeCz8VXCWeeccFxTTB3AWDLHoys6h4CytzNyGQS3nBd8ecUCAch
 eXMw4JzK4yEix4VUO9SkLQDufBw6cTYm1LCxESE+20V9Au1HYc2rX2I9gWwcGHi0opPdzN3DM
 Ef1LrDMM5PMbwPu6MWOnc0jqrPayfpNGMOZ3jwCYjwfXjFD8uSUQy9J9+sYuFDbrPzDdYwrS0
 6ychv+4cY0ICMN60j6qEdc6c0IdWLq79ABTDXrKtVHGEfnbXgUWURTYZmD/wawhSlK23VgAmS
 ssPynahxe6cO5Jqxg4vhU2UkVvVLyBL2XJhrWr8Nj1Z1WqkKUnyLvN+kMkxDnbgROE44RJxbJ
 so8oeINMpVEoWhU0h1T3Zq5VNJwdyuZoPJ6OXUQ30gGaZYFTkPaoLSoYCYXAgEYL3TBiFQTX9
 2iAPHXABHjF/rZrFLOUfikCpx0OLwUv0zBS/UGupNF/dAXJ62zaT4hTYYXIHeucIbvpzviGVL
 Fvmc4RjflAMfh90eAHU5h3+seLvmSY9Yud5lSE0/RBz955v1JpuF4rSL4qktOWWK+u0Wsg+eu
 pODLEHX16Hy0772uQI//4js+r/LIxnfhXGfRRa9IUndEEXoX2834D5dcFPdB4HPot9DUF8lBK
 +5SJ48Mr+8tSDSdSGHWGf9gpnAFrdpIEDxAVj8GAzoldsMMVDEJemJ/vfReBkEWnatvK3eaPR
 WvUmtWr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Andreas,

On Tue, 25 Apr 2017, Andreas Schwab wrote:

> On Apr 25 2017, Liam Beguin <liambeguin@gmail.com> wrote:
> 
> > diff --git a/Documentation/config.txt b/Documentation/config.txt
> > index 475e874d5155..8b1877f2df91 100644
> > --- a/Documentation/config.txt
> > +++ b/Documentation/config.txt
> > @@ -2614,6 +2614,25 @@ rebase.instructionFormat::
> >  	the instruction list during an interactive rebase.  The format will automatically
> >  	have the long commit hash prepended to the format.
> >  
> > +rebase.abbrevCmd::
> > +	If set to true, `git rebase -i` will abbreviate the command-names in the
> > +	instruction list. This means that instead of looking like this,
> > +
> > +-------------------------------------------
> > +	pick deadbee The oneline of this commit
> > +	pick fa1afe1 The oneline of the next commit
> > +	...
> > +-------------------------------------------
> > +
> > +	the list would use the short version of the command resulting in
> > +	something like this.
> > +
> > +-------------------------------------------
> > +	p deadbee The oneline of this commit
> > +	p fa1afe1 The oneline of the next commit
> > +	...
> > +-------------------------------------------
> 
> That doesn't explain the point of the option.

And what you forgot to say in order to make this a constructive criticism
is: we probably want to add a sentence like this:


	Using the one-letter abbreviations will align the lines better
	in case that the non-abbreviated commands have different lengths.

Speaking of commands with different lengths, I just thought of fixup and
squash. I do not think those are handled by the patch, but they should be
(the `action` in the first loop of `rearrange_squash` should abbreviate
via `test p != "$pickcmd" || action=${action%${action#?}}`).

Ciao,
Johannes
