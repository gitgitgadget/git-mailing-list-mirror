Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5DD4200B9
	for <e@80x24.org>; Mon,  7 May 2018 05:39:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750737AbeEGFj0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 01:39:26 -0400
Received: from mout.gmx.net ([212.227.15.19]:56509 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750708AbeEGFj0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 01:39:26 -0400
Received: from [172.20.102.139] ([70.60.96.235]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M8ehf-1eS9Kp47mt-00wF9Y; Mon, 07
 May 2018 07:39:09 +0200
Date:   Mon, 7 May 2018 01:38:48 -0400 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 13/18] color: provide inverted colors, too
In-Reply-To: <xmqqvac0qmbq.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1805062349450.77@tvgsbejvaqbjf.bet>
References: <cover.1525361419.git.johannes.schindelin@gmx.de> <cover.1525448066.git.johannes.schindelin@gmx.de> <1ebbe359547689d32aa27564929d733a26bb8054.1525448066.git.johannes.schindelin@gmx.de> <20180505182922.GD17700@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1805060001230.77@tvgsbejvaqbjf.bet> <20180506063543.GA3418@sigill.intra.peff.net> <20180506064104.GB3418@sigill.intra.peff.net> <xmqqvac0qmbq.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:06QY6CEv4sX9e1HTIMk3Xl1wbZaEKdTaivLLe5tUrZH2/Un+cTG
 cjjq1vaIGOR4Rk+y+ykUt6I0g4xpRraQt/IG7Fs0hAVTxZlhK15d+t/pugT9xV8YkvAjZUw
 i6LhE62G8EeaAezWU8oKG/Seqw8NI5OkdOrytHwXcXOSpsc5mIGtq7Zub9WoOYuCzN6eHzF
 JQw50liBDvASG4CyZCquA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Ac56KQA2lFc=:DL8sSZLUb+DHmJM/TlkeEv
 OaIhK2NBQW0W7xC8n5wiWYpM/dHA51Iup92tKtp6t+lEa9p+wK0ZEnkP7iOZ3jsRdOil+IDt+
 8FmsO2xDVo5RxGtCbLrblT5dsPvzFjIkkxYVEu6Vgh7c63mlBSirjjUJCpHRBNMTe66ZxoLrB
 XJp6TlGK/94O9/UgCJW9AzPrcZezxJN5ej8LCnHbGD0zkw0sA4kFzMertnvXN5ibbIkMJTtK+
 tkUngNJziVD5j0m6DCP+g60vQWDxmVgfZyinh5r2Xsof2FCT5n5q7ewoajjBfcfLAXgQW0X2g
 qV+B+JLEbVkNAaKG5Mz8fLv8PNjB4a5ccCxNluELOJOeKeI35KnZAEAgKkkvh+Z2ydRIuhD3R
 XMB3Kmr+lWvoplRzPpwsK7Pn9QefuSbtaViS54fgPyVwRtPyagFGc1Jdua9bt8CSq/uREgGvZ
 QmUCcMtYIV/Q+maUg71jYzXPjO7dy/9uURSVTmRA//88aNqFAQizYJd1Z4UAF2Pj9qoHTrrm1
 KAi+HllwJ+/u1u0Ot4M7Eq0SJdbuiFD6Dt+O2FpA88q0h0te1JKisimHbzv41h+whxK82MHB2
 cZU4vf4bye1i3hmwMHDbTTYJZ9vQZaYwq1Gvvfm6//rinjfznHxWQcqr/MEGaMJslkfrwn+VA
 7CgiwalpnDQ5tQPIdZrBdYg/AUmD8MiexNgxQJy0y5yPUu8Dlo837s1RGYhgLm/0yBjkTMaSm
 7DyO13tlHYqEuaIrDFusFoTaQZDJs7IV3MrhML9M9B77seJuEXVlkI1/gSKm5BNH75LTXSlBK
 9PRqAk0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 7 May 2018, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > So really, I guess all I am arguing for is having GIT_COLOR_INV (or
> > REVERSE) as a constant, and then teaching the code to combine it with
> > the existing "new" color. It's perfectly OK to have:
> >
> >   \x1b[7m\x1b[36m
> >
> > instead of:
> >
> >   \x1b[7;36m
> >
> > It's two extra bytes, but I doubt anybody cares.
> 
> I do not think two extra bytes will be missed, but it was not
> immediately obvious to me how much flexibility or simplicity weu are
> gaining by combining values from multiple configuration variables.
> With a "letters on a new line is painted with ${new}, in addition,
> the leading plus is further annotated with ${tbdiffNew}" (similarly
> to "old") scheme, the user can take advantage of the fact that there
> is no ${reset} between ${new} and ${tbdiffNew} and set tbdiffNew and
> tbdiffOld to a same value (that does not change the color but
> changes some other aspect of the appearance, like "reverse" or
> "underline").  Since only pre-designed combination can be used (your
> example works only because you chose to allow combination by
> annotating the leading "+" with ${new}${tbdiffNew}), we'd need to
> (1) establish a convention to paint things with similar meanings in
> the same color, modifyable by individual command (e.g. you could say
> anything new is by default green with "color.new=green", and then
> "color.frotz.new=blink" "color.status.new=" "color.diff.new=blue"
> would make frotz, status and diff subcommands to show new things in
> blinking green, normal green, and blue), and (2) push the codebase
> to adopt such color combination as a preferred design pattern if we
> want the resulting system to be useful.
> 
> I guess you are getting simpler configuration, which is a big plus,
> but to make a truly useful combining convention, we'd need to
> rethink and find a way to transition existing configurations to the
> new world, which may not be feasible.

I really do not like the sound of that much complexity. It strikes me as
yet another instance of Yer Ain't Gonna Need It. In *particular* because
nested diffs are a special thing: you *already* get overwhelmed with
too much information, and adding colors to the fray won't help.

What does help is to keep the colors, so that they can mean the same thing
in inner vs outer diffs, but reverse foreground and background to make the
outer diff "stick out more".

Should my assessment be wrong, I think it'll still be relatively easy to
add support for config settings, *then*, not before we know it is needed.

Ciao,
Dscho
