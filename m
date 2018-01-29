Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 667B41F404
	for <e@80x24.org>; Mon, 29 Jan 2018 22:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751875AbeA2WAO (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 17:00:14 -0500
Received: from mout.gmx.net ([212.227.17.22]:64248 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751473AbeA2WAN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 17:00:13 -0500
Received: from minint-kr8j64v.europe.corp.microsoft.com ([37.201.193.1]) by
 mail.gmx.com (mrgmx103 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MHH3P-1eb4fb0AT5-00E5mr; Mon, 29 Jan 2018 23:00:08 +0100
Date:   Mon, 29 Jan 2018 23:00:06 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jacob Keller <jacob.keller@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH 1/8] sequencer: introduce new commands to reset the
 revision
In-Reply-To: <xmqqwp09lh6b.fsf@gitster.mtv.corp.google.com>
Message-ID: <nycvar.QRO.7.76.6.1801292256000.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1516225925.git.johannes.schindelin@gmx.de> <8a91bf2184a3da4c0d5a13ba184813068e51f5c8.1516225925.git.johannes.schindelin@gmx.de> <CA+P7+xozcQD2xuys6mh8MsfcYZ_nb2c9yxhDxkc7FTN2SfoofQ@mail.gmail.com>
 <xmqqwp09lh6b.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:mlWZZxIY8duZpR/6dVJhYh7uCMKrRicI6PaojcvzypQMSGk9pDB
 dJUCDU0c/Vsl95WCIxxKfyLEFmsOf4I57ByaNi4ovO0uXP3sye1f/wZoxkuFxGrHHJ7DCfh
 IL8/IeiGodR+0YWF9C3TYT6XSvCnwCINSGFFV/fTSYPcoIKYVSt0wrtzY3tkVb2Vjhsz+BG
 VrjODiojWbJAnU2TgLvLw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:v5oEc7mnXAM=:059f72IQ31xrwZt+/jNxvT
 vts0WtpNZb4X7Gm9aQAbK5I7b4Uwefzfi7s4j63S5M+5yl/RIFv9xdTn4lP3KiiK6jk6l5yG6
 7IJR3fsOC0VbDwiy2Y4CGQIsqG6n65b+tUZP0wVJIndikjbgzK/QL9qNbX45J657mw3sWskHZ
 pDldMFHOS4sKsDqG7JrHxHxN4hOBW+LSmSyORz1S1bn/qPUiFBOiGf8nOJZkeKbc8djgCOFME
 FPMl5AyStaBS0YiiixGoPPN14Cxvdc6szVtzFYMZHtZQMvhk/iCj0JFuEZ61ZyfabbMD05Rzf
 xuLwHeDV+675IKJzL+wm5AxDxOHmSwV7L7Tsec58bVdRb2zVbz93WRAddLMd7++d8gtoHKJQC
 UDh2JQIa1hu5gLj4dgpWJtHNdWAiDiYWDCviH5Yo999IJYOJl+y9Tuz+VVIsSioWSqFyo8yGR
 +yryLz6qDksdg4kVQCHd3IxNWu95H0Qceu25cg5Dm/2cuxDLav1ezwxTR/S1WIGsUe8MdrhPP
 bfBHmnnqIYDUfHXohC0NM5Kyi6DTQfcWdSfpfFCzwOeZA4uAaFsrkiO8whuAHmXlfPix2f0sa
 RyCar2/zLb7oNFy+wePdtCCCUBNSBoJfKC6w7czVCo+QeUFXvtixLo7cTZVb1CPAC71gVsdFf
 gOR0eyyQsgcrl4WPAZB4EDw3TUl2IqpecGNt0FkzsZOdiXezM9aYflQcLiTjkO9Zu5qWFWyYE
 H8YNLZNFzcHbtlUpeqtw5TwasHmqBLWr8kLMAAsSi2o+mKltnioeoGF70hZN14c7JtQoISXur
 sPkb98TBTY3XjcqkKtOEE1PapkXTkKM1dZWKzvHmWQEiT8AQPKu45vXU+QM4IVYHTBTVE4W
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 22 Jan 2018, Junio C Hamano wrote:

> Jacob Keller <jacob.keller@gmail.com> writes:
> 
> > The code looks good, but I'm a little wary of adding bud which
> > hard-codes a specific label. I suppose it does grant a bit of
> > readability to the resulting script... ? It doesn't seem that
> > important compared to use using "reset onto"? At least when
> > documenting this it should be made clear that the "onto" label is
> > special.
> 
> I do not think we would mind "bud" too much in the end result, but
> the change in 1/8 is made harder to read than necessary with it.  It
> is the only thing that needs "a single-letter command name may now
> not have any argument after it" change to the parser among the three
> things being added here, and it also needs to be added to the list
> of special commands without arguments.
> 
> It would have been easier to reason about if addition of "bud" was
> in its own patch done after label and reset are added.  And if done
> as a separate step, perhaps it would have been easier to realize
> that it would be a more future-proof solution for handling the
> "special" ness of BUD to add a new "unsigned flags" word to
> todo_command_info[] structure and using a bit that says "this does
> not take an arg" than to hardcode "noop and bud are the commands
> without args" in the code.  That hardcode was good enough when there
> was only one thing in that special case.  Now it has two.

I dropped the `bud` command. It did come in handy when I truly recreated
branch structure from a way-too-long topic branch, but that is probably a
rare use case, and not worth spending so much air time on.

> In a similar way, the code to special case label and reset just like
> exec may also want to become more table driven, perhaps using
> another bit in the same new flags word to say "this does not refer
> to commit".  I think that can become [v2 1/N] while addition of "bud"
> can be [v2 2/N] (after all, "bud" just does the same do_reset() with
> hardcoded argument, so "label/reset" must come first).

The downside of such a table-driven approach is readability, of course. It
becomes *less* readable because all of a sudden you have to jump back and
forth between the parsing code and the table (and then you also have to
keep the table header in sight).

I have had enough problems with such table-driven approaches in the past,
even in Git's own source code. Exhibit A: t0027. I do not wish upon my
worst enemies having to investigate problems in that script, for in those
tables despair awaits ye who dare enter.

So I respectfully decline to go into that direction in the sequencer.

Ciao,
Dscho
