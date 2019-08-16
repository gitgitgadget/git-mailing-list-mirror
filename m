Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E73B1F45A
	for <e@80x24.org>; Fri, 16 Aug 2019 04:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbfHPEUh (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Aug 2019 00:20:37 -0400
Received: from mout.web.de ([212.227.15.3]:58265 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbfHPEUh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Aug 2019 00:20:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1565929226;
        bh=XdXPbRziPo2M61+niGk6GmNFXTjvdbsZMnTGmrEAHLg=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=P4mNqLcFdKv5iI0izQEdTpecJ3OcsT7Ws6B84RXEAicYD4WXaVrVJT5BT1BBk8uev
         lnKhbBYimdFT1Xkad7qR2q2QQiE9Iw4bBJGfYlawsm8dYMAYGiFAzd997k7Hn98Ujy
         DL9sScYnmWn3gm3cOuYoI8p/PsI5LG2rFYcbJzqE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MgOUY-1hauT60emM-00Nl7U; Fri, 16
 Aug 2019 06:20:26 +0200
Date:   Fri, 16 Aug 2019 06:20:25 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     "Yagnatinsky, Mark" <mark.yagnatinsky@bofa.com>
Cc:     'Junio C Hamano' <gitster@pobox.com>,
        "'git@vger.kernel.org'" <git@vger.kernel.org>
Subject: Re: suggestion for improved docs on autocrlf
Message-ID: <20190816042025.oiike3cahyfd5h7z@tb-raspi4>
References: <64c0a35825af4ff3956c6c9a5fb748bb@bofa.com>
 <20190812171049.ydec3nsmkt2xplhd@tb-raspi4>
 <aae529ce1b084b7bbcca3977e6909417@bofa.com>
 <xmqqo90u9ric.fsf@gitster-ct.c.googlers.com>
 <20190813032452.qg2ufgljm4bjeznr@tb-raspi4>
 <a5b84e2b8184414bb416f3aa83361a1c@bofa.com>
 <20190813154033.uhi7w5jgwcj4xan7@tb-raspi4>
 <d4a0500d5f5e4706aef481a33096465a@bofa.com>
 <0244daea3faa4d4aa899cff0dcc62917@bofa.com>
 <bb706de9a42f4e60ba974647e68f8387@bofa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb706de9a42f4e60ba974647e68f8387@bofa.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:GkEOj7Nw38p11PjoSPIvRLndIOMHcBerD3BlIevql5xBNFz/zDj
 xc2EyX0nJ4vHup4MbA63ZWR9zbfsYrnjjbEgbYJk0e3h5dAY9VbCj83TWlhNWqQAkfHaoL/
 UkRMrxJnLJ5rOngBcwtRUZ2zHSa3qpydWG2FNXf0thbg2SX42q0k7vtz2vo8PBg9ad7O4If
 Nr8aanEqhddtjQu757XTg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gL/Ih/czjtE=:+/8+tOnVNAvqm7aCBKOOec
 c/7we7YXQRhyy1ry66Lpx8AruNuzpjxfkwxo03rpCbSKiujbJorHV29xhR1yLwAS15bqXl1h1
 M8eJxejYXvV2i2yILNyhhZAWgrMm3KNutIlibatzTnOGyzu/QhFuhgoFY0x9Q3jvudFe8VVQM
 RD70ILBvScgqD2R6veC+IlxRlkHXiJ/Ga7jnnCY6sPf4CMPKBlkEM5YYygSxA/uUWFMb4MbRD
 kovrLrW9PG5V0t6CyYdfGY/JriBE4MNcSRGTwTPUy2GwWgPr1z4tDMptyIcBMiYfmmuKRzlf8
 X+f2z8WOvPJzncy04FHwKINHgycTCAT4dwkD8EcipHENbV262rLyThsrpyR0lcQ1jArXOVBmS
 PcQFN6SvECR28YMduAyoXhdyVeV46fqLPE3i2eM0/bzV4VfEDlXbL6gPmDizrioc6J2liMbqN
 uYrGxKE5d05V3f6CuaKbiIum6rNIOlq1fCnZ3RG9vOWVfWNmiGO9XPm4QPoZnFb/AFKrfvgdN
 c3DC7yflP+m0mO/QfFedR4rKHhAF5xa4rFRVC0w1fhC2rsFZrNA2pnURaLScbTEJyAAXaB7h1
 YPEo2zbYb4leX9LPZn6dsYgoR7l3RUFE5U5iQnec0VWH4/DjM1oklYX5m2mWTcXHEee4MY457
 4LndeU/QdDyJoAUl+QzlWq2z4lKVYwSfCYMGBnEF1UxV3AfbR4sutKYvK3Ts15gUoc+XT0oPo
 Z4eAG7Xf3Ms3155SoyLDuV0UnStxXTsvQWeiyiuhga2lTftTtMs7zPD3DCAKCgmN2XXnoBj+T
 u8aVB8cHnYQAq6I0WqbnqJi99cP7IYbdoS0spFI2ff+ZvH6eDo08h5bGJCHBTzcfp5tIjt3C2
 nS0Opuee+3+5wpDIyfO/a2OzeB3lU/6fxKjzFNg+scb/G3YyJ2p4SkdorPG+2tIDeVXJp0YKA
 LGddv91ZZcobaHPO6XWf6+uuqavPvY7pGEymS3mdZCF8ozu09yHogNiEOhQXBMMpo6FvtkMVb
 Qb+2WV+ja6EkRzFTkKGZJbiXQAuOgKZV9WzspxU3H++y7vcWH4+BJ2nqyihqKCILW1LQbLdHH
 t9wpp05rWflgwIEyo4UsIledLbG/A34BJ9pTWNkbu7khII/4DG+Odo/FfSBWcvWxMWcufmZVb
 xRGYF2Qn6idWtTe/LFQOZYqEsGuA7mMjVMzUfK/pclNi4QkQ==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 15, 2019 at 04:56:05AM +0000, Yagnatinsky, Mark wrote:
> Okay, first attempt at better phrasing.  This may need more paragraph br=
eaks, or something.
> Right now it's very wall-of-texty.  And probably in a style way too diff=
erent from the rest of the git docs.
> Also, the syntax is probably closer to markdown than AsciiDoc; sorry.
> Anyway, enough disclaimers, here's the first draft:

Thanks so much for the suggestion.

Feedback and Input like this from Git users are really appreciated.
I will re-read it a couple of times, and probably find some time
to make a patch out of it within the next days (or weeks).

>
> This variable has three valid settings: true, input, and false.
> (Leaving it unset is equivalent to setting it to "false".)
> 1. Set it to "true" if you want to have CRLF line endings in your
> working directory and the repository has LF line endings.
> Setting it to true is the same as setting the `text` attribute to
> "auto" on all files and core.eol to "crlf".  In other words: any file
> that has LF line endings in the repository will have CRLF line
> endings in your working directory.  If you  commit a new file to
> the repository, then git will commit it with LF line endings, even
> if it has CRLF endings in your working  directory.  However, if you
> edit an existing file that has CRLF line endings in the repository,
> then git will not convert it to LF line endings when you commit it.
>
> 2. If you set it to "input" then git will not do any line ending convers=
ions
> when checking files out of the repository into your working directory.
> That is, immediately after a checkout, the line endings in your working
> directory will match those in the repository.  When committing a new
> file to the repository, git will commit it with LF line endings, even if=
 it has
> CRLF line endings in your working directory.  If you edit an existing fi=
le in
> the repository, then:
>         * If the file had LF line endings in the repository, it will sti=
ll have them,
>             no matter what line endings are in the working directory.
>         * If the file has LF line endings in the working directory, then=
 it will be
>             committed with LF line endings , no matter what line endings=
 it used
>             to have in the repository.
> If neither of the above two cases apply, (in other words, if the file ha=
s CRLF
> endings in the repository and in also in the working directory), then it=
 will be
> committed with CRLF line endings.
>
> 3. The simplest setting to explain is "false".  In this setting, git wil=
l not
> perform any line ending conversion; all files will be checked out into
> the working directory exactly as they are in the repo, and will be
> committed to the repo exactly as they are in the working directory.
> This setting is recommended; if you are tempted to use "input" or "true"
> instead of "false", then consider looking into committing a .gitattribut=
es file
> into your repository instead.  Settings in that file override this confi=
guration
> variable, and since the same attributes file is being used by everyone w=
ho
> works on the repo, the results end up being more predictable.
>
> Or something like that.
>
> ----------------------------------------------------------------------
> This message, and any attachments, is for the intended recipient(s) only=
, may contain information that is privileged, confidential and/or propriet=
ary and subject to important terms and conditions available at http://www.=
bankofamerica.com/emaildisclaimer.   If you are not the intended recipient=
, please delete this message.
