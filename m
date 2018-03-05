Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A88C1F404
	for <e@80x24.org>; Mon,  5 Mar 2018 14:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932069AbeCEOta (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 09:49:30 -0500
Received: from mout.gmx.net ([212.227.15.15]:54425 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752438AbeCEOt1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 09:49:27 -0500
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MJSQ7-1eqvkO0icd-0035P6; Mon, 05
 Mar 2018 15:49:15 +0100
Date:   Mon, 5 Mar 2018 15:49:13 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Jeff King <peff@peff.net>
cc:     =?UTF-8?Q?=22Marcel_'childNo=CD=A1=2Ede'_Trautwein=22?= 
        <c0d3+gitscm@childno.de>, Jonathan Nieder <jrnieder@gmail.com>,
        git@vger.kernel.org
Subject: Re: [BUG] [git 2.16.1] yeeek ... my files are gone .. by git pull
 <otherRepositoryUrl>
In-Reply-To: <20180228132807.GA6206@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1803051546200.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <741A56BF-93C0-41EA-856F-C1170803F0A7@childno.de> <20180222232031.GE256918@aiede.svl.corp.google.com> <8A26AAB4-E2E5-4681-87D4-0D6727CA423A@childno.de> <20180223064549.GA19791@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1802270032520.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <20180228132807.GA6206@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:6aIuV1NW6ZG7AMongs25qoSzkeV5UxSd4OchaTjBUxufoBCNku4
 c7nFAHsuU/c7tGDZOf3PtojHAzr/BQhYjbKlG4Z0Ro8+B/rYaezYuAGdnUWvbuZSijuPA2o
 O+LBNmz7Ws+gABSILCApsy7W0VNcmGYrUF4HBqLgTDcVckUsauQBsjDcAAFphWe4DmJgijP
 W5SbW1ypEipE66YFtZ2YA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Aj8w49pouGs=:bwpXGxzOZipV7dxmm7rhPc
 mq6s5lsumI3b2frAcQJoice6ppC52z9lq59XtDqWUQxePBHAZv5HGhM/LBV1TVNXuCrumy0kg
 e7wZna5vVbECRr9/aiUIafNGULc7v267MkZucNR7gtH9MoP6z4fRt/vyy/HMcYMClkX9NSiev
 dS3Dxz4aLh+8PCHCF8ythZZdVQu7yQ8aLt7UclonUA8BbqnRTLTrFY5yIH/Zc+0YZA8OaBGxl
 jFjSvXWIiCv98FkB2/dRfqB4AaiTPW9pp6CdEvaFld0TY2ey08yzikLDiK1slf/94bCqcS1oN
 f15bU4lul1wjJ7pIhiAGCXUjEqs2upI57z23TGZjghbLV9aMLe4UN+CLP2ovUl16dk/qIYK/H
 fyZYLsI4d/6nvs4PMPTsd6NtO/J+dSigkvpIY5Pr/abOWWnx+az0uKUTu2kF9beeDqf5T75Rt
 HKIiQ627Qt8ADEVI8UX/6BFrlb66k0jIfNV25jGACz0tZxvfbscnKHti05gEecSrpSgfSIRAy
 Ke6z8XMzIRwupWDn/As9TmjcRNSQzQb8335LTwXnQn0fiQwFPwCOCXGFi3SsGAnJfYYlhIAIi
 Opjt0YFULX4gyVwViFkg0HIcshIZfxX0s6JNtAQEHhN4FAoRnnJ8AqEpuWQ7J1uWxnVmJaGpP
 0iFCnvqWYq9TrSDOVkPnWMh9ptgKJAf/OSgltp57WM+maIkW0Rw7/kzKsOXFMs4h3gBZHtsCE
 Fatqq1+GGVD70o+T4hVrjv0/anazwwfygDf60Xgf1HyNZ5srp6ODIzgCpWpgQBz8MBlb8RE3n
 rca1hrjguDe3U96EAwcDIpWQb/foncWHxXV0UPHo4WfX41/wQzHjPpmjbj7ci68iHrxqA4w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Wed, 28 Feb 2018, Jeff King wrote:

> On Tue, Feb 27, 2018 at 12:33:56AM +0100, Johannes Schindelin wrote:
> 
> > > So something like this helps:
> > > 
> > > diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> > > index 81c5b42875..71e6cbb388 100644
> > > --- a/git-rebase--interactive.sh
> > > +++ b/git-rebase--interactive.sh
> > > @@ -921,15 +921,20 @@ else
> > >  
> > >  		if test -z "$rebase_root"
> > >  		then
> > >  			preserve=t
> > > +			p=
> > >  			for p in $(git rev-list --parents -1 $sha1 | cut -d' ' -s -f2-)
> > >  			do
> > >  				if test -f "$rewritten"/$p
> > >  				then
> > >  					preserve=f
> > >  				fi
> > >  			done
> > > +			if test -z "$p"
> > > +			then
> > > +				preserve=f
> > > +			fi
> > >  		else
> > >  			preserve=f
> > >  		fi
> > >  		if test f = "$preserve"
> > > 
> > > Because it at least adds "two" to the list of commits to pick. But
> > > oddly, it picks it directly as a root commit again. Whereas a rebase
> > > without --preserve-merges (and even "-i") picks it on top of commit
> > > "one" (which is what I'd expect).
> > > 
> > > +cc Dscho, as the --preserve-merges guru.
> > 
> > Your analysis makes sense to me. Please note, though, that I would not
> > consider myself a guru on preserve-merges. I think this mode is broken by
> > design (you can blame me if you want).
> 
> I think that is doing the right thing for half of the problem. But
> there's something else funny where we do not include the "upstream"
> commits from the split history (i.e., we rebase onto nothing,
> whereas a normal "git rebase" with a split history will graft the two
> together).

Let me ask to make sure I am understanding you correctly. Are you
referring to "split history" as the case where the commit graph has *two*
root commits?

If so: when you perform a merge-preserving rebase, then those two root
commits will be recreated as new root commits, by design.

The non-merge-preserving mode cannot create two root commits, as it does
not allow for introducing merge commits (and you'd need that to combine
the two strands).

It is quite possible that I misunderstand completely, though. Care to
enlighten me?

Ciao,
Dscho
