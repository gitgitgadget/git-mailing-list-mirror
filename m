Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 616071F404
	for <e@80x24.org>; Thu, 12 Apr 2018 12:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752652AbeDLMb3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Apr 2018 08:31:29 -0400
Received: from mout.gmx.net ([212.227.17.21]:46323 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751711AbeDLMb0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Apr 2018 08:31:26 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MexlN-1eqqkO17wv-00OX9b; Thu, 12
 Apr 2018 14:31:17 +0200
Date:   Thu, 12 Apr 2018 14:31:00 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Sergey Organov <sorganov@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v6 00/15] rebase -i: offer to recreate commit topology
In-Reply-To: <87in8w2585.fsf@javad.com>
Message-ID: <nycvar.QRO.7.76.6.1804121411580.65@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1519680483.git.johannes.schindelin@gmx.de>        <cover.1523362469.git.johannes.schindelin@gmx.de>        <87tvsj6rn2.fsf@javad.com>        <nycvar.QRO.7.76.6.1804110009080.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>       
 <871sfm737e.fsf@javad.com>        <nycvar.QRO.7.76.6.1804111324350.65@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>        <87h8oh51jm.fsf@javad.com>        <nycvar.QRO.7.76.6.1804112233470.65@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <87in8w2585.fsf@javad.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:56fwBjUU8ZxShzzBSCMphei+nplcbIibrwJPJSzeryTGKqRKXLy
 X8djWzp+PQdGMKkwy8EuIfAlFTkrT6NZf0llgDjj3pEyHzOnxlHXMy26ewNPxZ67QHTxrob
 mVR1eGqjNRRJfDC6fNYI3dWDQC2DRfN8h8dpKimLGaROJu+Ase9mEaacN2iY0pZ401APPZL
 2fX3B+AOxrgK+YE7ggkwQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:K6yKDhn9lAA=:ksVX95rdjCM6wdysjVWWUQ
 uoSbh5C6Km85U+7q82HvJyMYC1Qh9MjN0aMBUYiziVPmTUZ4MWdsf3R26xae4GV9aXy0VvhVU
 MwubvorwXFaR4U308LXKyiZGxJZMz82MhApImBN2XWEns8R+zHkP+z9bbMfns6rhbcBGU3wEQ
 AV9krQc4KGsuCANIOpJOda1y7T2ZEvKERDTqfLlw9uw5qHvcNqC2sxyw5ACowGIbfGAj3NQrH
 X5oGy4zWoPE8/Wp/g3uAuHQij+k3dbkfzSPlU+xfTWcB6rNiUV1bqxr7lfPjc0ZiC24ZwE8xt
 bYI8oURzA6k/1TsOVIlF1OyNVk4eD1VfjyfjsNnF7CLpm7frQdz4HiUnVfc0+YFu+yPB0hH8Z
 oEJ5l0ruZxJOSapN0ZyjYmnYxaFVCqMlYYdP5poQj7Ub8iUR1xZizwzVpCGlrDOQI4shKgvY8
 PgUFI3p4uoHCVEDkKfRG6/68k0FB3PkLiEyFLiq81ueKHY2h4v+RUETDutsyVckBNW4oBFt9a
 Rx2Y0RvTiu/m764vK2Rf+BBC1LdSwFDuWWPkxK+Y2gSOzN5es62CpYizbKNypB8E/Bv7q5MS7
 AEsGrfrnjFv4BiVWpEro44ZXaXi6lXGvHjR3gXz3AJixfyx7lADyjTkh7mVSBCi8/JsSZRzTe
 ITP4CwZEIr8307zMXXXlTX1zejodG1/lPgri+c+iU4IhyMSnEHtywDj2KYuVKeMrBmAFgSBm+
 OTYyFVgFrp64zNOjRLXd523Kwa8JS3tohLUEeEp8WU26uqK5onY69x/IXApWLaXhgtz93hOFM
 K9ZGIoqF37Dg216rlHfOCkke8u4nCVjdP+D5rGDUsk266vcFE0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sergey,

On Thu, 12 Apr 2018, Sergey Organov wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > On Wed, 11 Apr 2018, Sergey Organov wrote:
> >
> >> The RFC v2 and Phillip's strategy are essentially the same, as has been
> >> already shown multiple times, both theoretically and by testing.
> >
> > No, they are not.
> 
> It's off-topic here.

Well, you directed the discussion there. So there.

> If you _really_ want to discuss it further [...]

I am always interested in a constructive discussion toward the goal of
making Git better, to improve its user experience, to give users more
powerful options, and to make things easier to use.

I'll let you know when I detect a change in this discussion in that vague
direction.

> Abrupt change of the topic of discussion indicates your intention to
> take attention off the apparent ugliness of 
> 
> git rebase --rebase-merges

If you want to discuss ugly things in Git, that is really an abrupt
diversion, but I would not fault you: there is plenty of that in Git.

As to `git rebase --rebase-merges`? I do not actually find that really
ugly. I find that it says what I want it to say. And after how many people
agreed, I find it rather pointless and time-wasting to discuss this
further. Naming is hard, and you seem to have a knack for coming up with
names that are really terrible. That is why I stopped discussing this with
you.

> I also get it as an indication that there are no more arguments in favor
> of --rebase-merges on your side, at least for now.

You seem to misinterpret your own arguments against --rebase-merges to be
anywhere in the realm of convincing. They are not.

Did I say "flatten history" to you in this discussion? Sure I did. We also
talked about Darcs. About the theory of patches. About the inner workings
of recursive merges. About commit graphs. And topologies. And we threw
around many terms that we know people understand who are deep into the
inner workings of merges and cherry-picks.

Does this mean that we should expose all the terms we used in this
technical discussion to the user interface?

No, it does not. We should not absolutely not do that.

So it is not at all a convincing argument to say "but you said XYZ". *In
this mail thread*. Which is necessarily full of technical lingo.

Also, I am still waiting for something tangible from your side. Something
non-theoretic. Something practical. Something like taking that FAKE_INIT
example at heart, studying it, deducing from it what weaknesses we cannot
tolerate in strategies to "cherry-pick merge commits" or "forward-port
merges" or "re-apply amendments in merge commits" or whatever you want to
call it.

Your suggestions so far are heavily biased by your own preferences, based
in theoretical musings, not in practical examples. I do not see any focus
on the Git user base at large. "What? They don't know what a topology is?"
is a question I could see you asking.

There has been a lot of talk in this mail thread, and the only actual
outcome I see is my own work, and Buga's tireless efforts to test
approaches for their practicality. There is zilch concrete testing from
your side. No implementation of anything. No demonstration what kinds of
merge conflicts are produced, how often they would have to be resolved by
the user. None.

The important thing to keep in mind is that all my efforts here are spent
in order to come up with a feature in Git that empowers users. And I want
this feature to be as usable as possible. And I want it to use as simple
language and option names as possible. That is what I will keep focusing
on, like it or not.

Ciao,
Johannes
