Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB89C1F404
	for <e@80x24.org>; Wed,  7 Mar 2018 14:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754416AbeCGOIt (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Mar 2018 09:08:49 -0500
Received: from mout.gmx.net ([212.227.15.19]:33209 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753953AbeCGOIs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Mar 2018 09:08:48 -0500
Received: from [172.16.5.73] ([84.88.84.116]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LmbZb-1eJPmU1uF9-00aDGl; Wed, 07
 Mar 2018 15:08:41 +0100
Date:   Wed, 7 Mar 2018 15:08:41 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Sergey Organov <sorganov@gmail.com>
cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [RFC v2] Rebasing merges: a jorney to the ultimate solution
 (Road Clear)
In-Reply-To: <87vae8yq15.fsf@javad.com>
Message-ID: <nycvar.QRO.7.76.6.1803071450511.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <87y3jtqdyg.fsf@javad.com> <87r2oxe3o1.fsf@javad.com> <nycvar.QRO.7.76.6.1803070742580.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <87vae8yq15.fsf@javad.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Aa9ac1Xio1Z5hVKennJoTahNgWC9tnOZTWoW/TMjx0InIAiKT7Z
 KjVZDSrodaWvJLvEi+HYcFNhsoH+HkX4xpbN2amzw2Q7gG5Q7Pmuj0DP3KYs/q45iRfm/8D
 K0m88fE/j3Dxf9+mRT6SpVJ8PHG2ZPSMThezzyuzv9yIZRgIut6NGtp9pxgBCGsJYhNAMeP
 klSW86WTEqL7iaqplZi8Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OFtT8tQlkOA=:h8A93SPnslW0hetPlbzziH
 xJbTA3V0EV2dZtiX3xu9Y7fJ6DWIFTkH/K277E3UzsIWEg5jArJDFNlJKO01VFGcoVz3txGSP
 aMzTfDpsWYVp9igrciWrChFo3gUI/qcoPcoo4Qiw9kg/VQj7C2+LeJqxpbPvAhQEAkHP5uQ3i
 23gpBhrqOiCcs4l04I+2JSfU9SADaOD5a+cGLrSUan00vuThNm52hKEX9FHiLu98tXXH+DKSC
 vwA9KB4m4zCjfjEojlVsLbhd1rKUKSn6eaRyWDMXqVahTPUCv7vj7qtv3aQKRt9FCcGus7QYb
 e9IpUdkhbjNYb62f5ABOHR/PcWR+lCqUy+6UMG1043OjTU+UrgYtMlUaQ//wihkJkKOv4EkRZ
 37dKVOEn8VH1DCZN0Tf/ximKzDiFru33Vi6Aj9XrN1Ojq57Zf6ZLQJv/yH9+rxD2JXEaCN65y
 vr2fxP+FtQeCsZoSSvRxjZKbmj+ogSY2jGLwWs6a+kzLFC5JN4r78faxcSSmRTW6lx5HnC2pT
 9mY6VlLgrNEsZDVV3jtSNVrapGPg+ssfC7h1YP2F9l3PU1s/MLCP9AtgOLDagDUX85Mg55iaF
 jbTmlnwPZsWbpBTqpKecie5Qm5TnF07vWEf/XCbNheJZyDVrxhwRMwhZUMFcQ/ctJzadH6XKJ
 DFhVmG0eFCJvAMnGNGDwkHETgUPxgnExUc28jGIZyf8LrT+VSQG89xD5HAQmsbT2rlJyniQm3
 jgMLOYIfvJWpnMPClVlFdhpKGyMqdNAB5bg5SfSwG8B+AvQjbK/id8QXTPfl//E1eNkNr6cET
 WaNivuuywxXt42PKub8G9ejWLlGFOPdh4dGcP/6RMf1CgXGLTM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sergey,

On Wed, 7 Mar 2018, Sergey Organov wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Tue, 6 Mar 2018, Sergey Organov wrote:
> >
> >> This is v2 of my "Rebasing merges" proposal.
> >
> > Didn't we settle on Phillip's "perform successive three-way merges
> > between the original merge commit and the new tips with the old tips
> > as base" strategy?
> 
> It seems you did, dunno exactly why.

That is not true. You make it sound like I was the only one who liked
this, and not Phillip and Buga, too.

Are you interested in the best solution, or in your solution :-)

> The main problem with this decision is that we still don't see how and
> when to stop for user amendment using this method. OTOH, the original
> has this issue carefully discussed.

Why would we want to stop, unless there are merge conflicts?

> > It has the following advantages:
> >
> > - it is *very simple* to describe
> 
> The original is as simple if not simpler:
> 
> "rebase sides of the merge commit and then three-way merge them back
> using original merge commit as base"

And that is also wrong, as I had proved already! Only Buga's addition made
it robust against dropping/modifying commits, and that addition also makes
it more complicated.

And it still has no satisfactory simple explanation why it works.

> No problems with octopuses, and no virtual merge bases of recursive
> merges to reason about.

But those are no problems for Phillip's strategy, either!

So your point is...?

> > - it is *very easy* to reason about, once it is pointed out that
> > rebases and merges result in the same trees.
> 
> The original is as easy to reason about, if not easier, especially as
> recursive merge strategy is not being used there in new ways.

So do it. I still have to hear a single-sentence, clear and obvious
explanation why it works.

And please do not describe why your original version works, because it
does not work. Describe why the one amended with Buga's hack works.

> I honestly don't see any advantages of Phillip's method over the
> original, except personal preferences. At the same time, I have no
> objection of using it either, provided consistency check problem is
> solved there as well.

Okay, let me reiterate then, because I do not want this point to be
missed:

Phillip's method is essentially merging the new tips into the original
merge, pretending that the new tips were not rebased but merged into
upstream.

So it exploits the duality of the rebase and merge operation, which both
result in identical trees (potentially after resolving merge conflicts).

I cannot think of any such interpretation for your proposal augmented by
Buga's fix-ups. And I haven't heard any such interpretation from your
side, either.

> >> 3. I now use "True Merge" name instead of former "Trivial Merge", to
> >>    avoid confusion with what Git documentation calls "trivial merge",
> >>    thanks to Junio C Hamano <gitster@pobox.com> for pointing this out.
> >
> > "True Merge" is probably also a candidate for improvement. If what you
> > refer to is a "true" merge, that means all others are "untrue"
> > merges???
> 
> [d]evil merges, obviously.
> 
> Seriously, it's pure history joint. Just "joint' will do.

You might want to try harder to stick with the existing nomenclature. That
would make it a lot easier to discuss.

Ciao,
Johannes
