Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EE171F859
	for <e@80x24.org>; Mon, 22 Aug 2016 13:44:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755526AbcHVNkW (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Aug 2016 09:40:22 -0400
Received: from mout.gmx.net ([212.227.15.18]:54699 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755119AbcHVNi6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2016 09:38:58 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MK0Np-1bceuv1vsL-001Srb; Mon, 22 Aug 2016 15:38:52
 +0200
Date:   Mon, 22 Aug 2016 15:38:51 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Stefan Beller <sbeller@google.com>
cc:     Eric Wong <e@80x24.org>, meta@public-inbox.org,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Working with public-inbox.org [Was: [PATCH] rev-parse: respect
 core.hooksPath in --git-path]
In-Reply-To: <CAGZ79kb9x6RHdFeA8WXpq4NFYr-G+B1R7_8u883LO8zvPyr+CQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1608221523130.4924@virtualbox>
References: <CAGZ79kasebzJb=b2n=JQiVMrSfJKaVfZaaoaVJFkXWuqKjfYKw@mail.gmail.com> <alpine.DEB.2.20.1608181430280.4924@virtualbox> <20160818204902.GA1670@starla> <alpine.DEB.2.20.1608191720040.4924@virtualbox>
 <CAGZ79kb9x6RHdFeA8WXpq4NFYr-G+B1R7_8u883LO8zvPyr+CQ@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:G0W5C5K72TD6T9H3u2J7Vx5KxVt/qRss/VDMVKTjNNcMNOOXVBH
 83AXSPC8bRl5f3zCcYnI5aAv2wl9AmiZevSeDBMxF25Zqpqx/NlAPNqWTMY6cCnFFEkgyeO
 QTWwdlh7dMpJDcZnc7/pMOboFsxxR9cFPqUZ3bjLF51mC2xlNAH+t8jBGlI/b0UknMTQ1Cc
 PbfRKOzwap8UPObBcxQnA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:SFTSJb8TVxw=:kXriTXCeQvf8gL+0RLow7c
 K+Bm4UPPLNL20k/cc7+MAB+hsnzglV37L5Tr0igBBW4mT3e9A2J2XKXtYflQAlAxJ4i4t8TQU
 iWDiA6SCnzhAp58vvq50dbxZIgOipXmRN8nVxY5McUAOPsdFkofkmgL1J4v3YZIF/OdA+mEy7
 24keMmrnVBEhgIfODrXxThhJYV/MzsXRyECD2QbGGuzDsNqtAliuyBkric8anGeD9FkxS5hxR
 pEXCbjVQh6FlkQMtBbRatqy6leTdBE8HPVsz5tfYZAuoYmW5O8513QvgplYA5eToNOTONJqeR
 i90BzioR4QaCwGIuAGSxFHxIbSS2Q5TJOgkT9iMSRbLlQyfOWuP57+C9dArouINBFcQ+s1ici
 6QGAk/XUdWiH4nVZ4YuQxg8j0RGRYuQfmA2XwgKL31OEUBZtq23WDY7U28c1HlFF3qlffLQrC
 zkDgQ0HbYarqxMuQAoDQ+wKHPlyd50fCqLnSJqXx7ysiwuhbEnL/egdgjG8x5l0IuQZFg7jtg
 U1IKzbZNmVRAb3hx82vgKesIzUiiPK98fftnN3wYD9aXneA8FyKoabtggELTnoDdoGVv7qT8v
 VMMHC0vbHkRkSCa46oGiAq1tWanvw3lTcVGL3TO5Xp4AkG1pa8IT3/WxmlAx1nqb0ytpNL80P
 yt6JTmInktK973srp+9tTwoZ2CKQZDWMEgs/yoyA+K+rdl1uIDkVIb9umbgbPujkTEtr/vJGg
 nr+M9aLUpuHnUhRu8uSFt8EailZEbiKxgqDWslvcM9Gp7jdHElHr/gTclXIXJ/zigNMHPK1Ci
 SmiU7ZZ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Fri, 19 Aug 2016, Stefan Beller wrote:

> >> I see a choice of mail client as no different than a choice of text
> >> editor.  Neither my mail client or text editor is heavily customized.
> >> The key feature I rely on from both tools is piping data to external
> >> commands.
> >
> > There you go. That key feature seems to be unavailable in the most
> > wide-spread email client: Outlook. So by not restricting the choice
> > you should make it possible to use that mail client, too, right?
> 
> Well I think this data piping is essential to any workflow.

Data piping can go through Git, with convenient commands.

> Even if were to abandon email completely and roll our own communications
> protocol, one of the first things added would be an API to "use your own
> text editor".
> 
> In my case git-send-email works well for the sending direction without a
> lot of custom tooling (read: none apart from the initial configuration).

Sending those mails is but the tiny, first step of contributing patches.
You know as well as I do that many a times contributors have to work
through many iterations to get their work accepted.

So while send-email helps with one direction, everything after that is
hard, manual work.

> > We do not even have a section on Outlook in our SubmittingPatches.
> 
> "You can write one? Pretty please?" would be the canonical answer. ;)

Sure. And my answer to that is: I cannot write it. Why? Because I cannot
get it the heck to work. Because Outlook supports writing mails, i.e.
messages from humans for humans. You can change the font, insert a nice
photo from your vacations, left-justify, right-justify, center the text.
You can do all kinds of nice things that you need to do when talking to
humans.

You can even paste a diff, for a human to read. Humans are very good at
not even seeing that there is no space at the beginning of the line.
Humans are also very good at understanding that those 8 spaces are the
same as the tab in the source code.

Outlook can also keep excellent track of who was Cc:ed, of mail threads,
filtering mails based on a plethora of criteria, integrating with a
calendar, etc.

So Outlook does really an excellent job.

What it does *not* to well is something mail was not designed for.

> Maybe we should invent a patch format that copes with broken whitespace?

Or maybe we do not even have to go that far, but maybe we can teach `git
apply` a mode where it is much smarter about whitespace changes and
wrapped text in the patch it receives?

That would probably go a long way further to making the patch submission
process we use more friendly to human beings.

It still would not make it easy to go from replies containing suggestions
how to improve the code to the corresponding file/revision.

> >> Users ought to be able to pick, choose, and replace tools as they
> >> wish as long as an interchange format remains stable and
> >> widely-supported.
> >
> > Right. Let's talk about the interchange format called mails, for the
> > data called patches. Is it stable and widely-supported?
> 
> It is stable as it has been around for years and you can choose whether
> you use git apply or the patch utility.

You seem to assume that mail clients have an easy time with this supposed
"stable" format.

They don't.

> It is widely supported as it is raw text so it can be used across
> different platforms. However it doesn't cope well with email, as email
> modifies text sometimes such as mangling white spaces.

I "mangle" whitespace all the time when I respond to mails. You will note
that I re-wrap quoted text to 76 columns/row.

So I am as guilty as any mail client of your charge.

Sorry.

> > Can users really pick and choose the tools they like most to send patches
> > to the Git project? Like, the Outlook client? Or the GMail client?
> 
> Of course, see[1] ;)
> [1] https://public-inbox.org/git/CA+55aFy2AEe7ew5Px=2Uit6hraGV9zFr=JZ57rSYXWMQ4nMjeg@mail.gmail.com/

You speak in riddles. That link leads to Linus' mail talking about
committerdates and generation numbers.

It does not help me, not in the slightest, to send a patch via Outlook or
the web interface of GoogleMail without risking to get yelled at for
corrupting the patch.

Ciao,
Dscho
