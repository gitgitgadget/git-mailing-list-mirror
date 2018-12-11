Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 577B220A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 10:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbeLKKTf (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 05:19:35 -0500
Received: from mout.gmx.net ([212.227.17.20]:52423 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbeLKKTd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 05:19:33 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MN1Gu-1gYs3q2sDg-006cQ6; Tue, 11
 Dec 2018 11:19:26 +0100
Date:   Tue, 11 Dec 2018 11:19:25 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: email lags, was Re: [PATCH 0/3] rebase: offer to reschedule failed
 exec commands automatically
In-Reply-To: <CABPp-BGeDA=Cm6MYkrCK=pN94y9AKRHgknjyXN1oMfnSsTCnzw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1812111117280.43@tvgsbejvaqbjf.bet>
References: <pull.90.git.gitgitgadget@gmail.com> <CABPp-BGeDA=Cm6MYkrCK=pN94y9AKRHgknjyXN1oMfnSsTCnzw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:bU2UCdKg1eJulWfJ3P0qfHaYvRuY+unrCdcJFrJZKZJzqp+BLNz
 RJOXJjeMWgOBdxTR44ffclIK+zpbuYlK5xfmiIuEO0R5QeLnB0iFaLw0HwSZDk+ugRYWzAJ
 Ez86SQZrGaXGqgjJ5gEodzf80HloPhxBW9Hix8n05pQJ1JiJZU5prjZn1ONeik2+FeKAue1
 PT2z3k8s+d2RN+FD9nSPQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RxhcvCNAPS4=:5SikpEHSbk4HFYvXPAUEqA
 4pugFtpAnHyU9Ci27n8GLD2FPzplpVTvgnAzsme35mzG/jVVXhbPna4/oxfVXBVrr/nJKqhme
 gDEYTnIbnBcJ01rQ8tkwZtMZ18CGm49m5EhWYA0IQVeyOUnwP3zIgvc/q2GZKBGwd7r8l9vCB
 GxHKBCiJD8oA1IojKxTXqWPtcOViM8GrW8x1uiBX3bzzQCTnYR20E9m5Kfl9IPfU4uTg4E0IT
 0+2KWKvn8RpZaZK15q60JxEVrcpYaHiZqSm4omp3Dw/V5gek9uWTWLp6Xf8O4AjAHnGynzPt5
 AegfneOG6NXgWhkBrGzfPrhnQC2+E3fAofjSc/Zld2seZC6+HkwEAvn6cU2fV5mqnahfYRFhy
 dVPFQ30LA83242whG7qIvFYRNUQ+i3wijOmj7vf0ErR9xgiKiziM+WAWlwheQkUgF7TewlMUj
 Urb8ab4IiQPepcM/EhiUMMif0c+uM2Nq42CAFphUnPD0CpsOzbxsbomBykjShs7QDXdJrRAMk
 iH4w0j6lBcVfWledQWUMLGrsqWxtCJgyG+fj70rlV41B0E37wLVvv9rmmQpEgZ5bph7aZHyV+
 iQTMeSgFL9VKJLn3XSTy41fVbeplN61cozHfIVOgGg8dKKGJSaJy6k3fznB+A8nAsGZ4zmjb8
 af4xD/d6BYbzSlwKF5L4Hgd+CIDrScVQgx10qmJbuij3lo2SPiCqjdGsV2e200Ydh0CghfoJV
 5F7RqJ2DQ2nrCQpoIQjl3YyNuT55f5im3ROvipEJQkvETqaUmLKceNQctLWGua9YDFIEJOBOz
 0piORTJ5bGs72+Q8OsXbBRl+S5uhh4+K5T7nlh9bOdoRbn9LMOAz6C7lsQl2fGLzdMU9vScnX
 vTG/bZZiMttSwOCYeH5RBHxfZRlE8aJGnG30tLqMe3dSTlSMcaZsekwebhPDfF8RngPpv63lB
 dstdtWm30jQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Mon, 10 Dec 2018, Elijah Newren wrote:

> On Mon, Dec 10, 2018 at 3:13 PM Johannes Schindelin via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > The idea was brought up by Paul Morelle.
> >
> > To be honest, this idea of rescheduling a failed exec makes so much sense
> > that I wish we had done this from the get-go.
> >
> > So let's do the next best thing: implement a command-line option and a
> > config setting to make it so.
> >
> > The obvious intent behind that config setting is to not only give users a
> > way to opt into that behavior already, but also to make it possible to flip
> > the default at a later date, after the feature has been battle-tested and
> > after deprecating the non-rescheduling behavior for a couple of Git
> > versions.
> >
> > If the team agrees with my reasoning, then the 3rd patch (introducing -y
> > <cmd> as a shortcut for --reschedule-failed-exec -x <cmd>) might not make
> > much sense, as it would introduce a short option that would become obsolete
> > soon.
> >
> 
> Complete side-track: This email showed up for me just five minutes
> ago, whereas the rest of the series showed up four hours ago, making
> me think this email had disappeared and trying to figure out how to
> respond when I didn't have the original.  Any ideas why there might be
> that level of lag?

I have such email woes for roughly half a year now. No idea where this
comes from, whether this is some graylisting at work, or whether the
`<author> via GitGitGadget` marks gitgitgadget@gmail.com as suspect with
some mail providers and/or central lists of dubious email addresses.

At first, I thought it was only GMX, but yes, I also see it with GMail
now.

Ciao,
Dscho
