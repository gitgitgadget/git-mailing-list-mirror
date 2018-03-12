Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDF461FAE2
	for <e@80x24.org>; Mon, 12 Mar 2018 10:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752005AbeCLKUF (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Mar 2018 06:20:05 -0400
Received: from mout.gmx.net ([212.227.15.15]:49319 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751344AbeCLKUE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Mar 2018 06:20:04 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M9JYE-1en7cw2TJm-00Cg8O; Mon, 12
 Mar 2018 11:19:56 +0100
Date:   Mon, 12 Mar 2018 11:20:00 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Igor Djordjevic <igor.d.djordjevic@gmail.com>
cc:     Sergey Organov <sorganov@gmail.com>, git@vger.kernel.org,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [RFC v2] Rebasing merges: a jorney to the ultimate solution
 (Road Clear)
In-Reply-To: <6362804d-e204-a9e0-9ff0-51d8497ce921@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1803121056400.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <87y3jtqdyg.fsf@javad.com> <87r2oxe3o1.fsf@javad.com> <nycvar.QRO.7.76.6.1803070742580.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <87vae8yq15.fsf@javad.com> <nycvar.QRO.7.76.6.1803071450511.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <a0cc88d2-bfed-ce7b-1b3f-3c447d2b32da@gmail.com> <4918cc79-79ba-5dd2-ea84-dc47db47d835@gmail.com> <b11785bd-5c96-43c1-95d8-b28eccfd13c8@gmail.com> <d29d3c0e-6473-0461-c8ea-02975ce4de14@gmail.com> <nycvar.QRO.7.76.6.1803111644380.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <6362804d-e204-a9e0-9ff0-51d8497ce921@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:GiOMvtOE+PHh54WQTaB0Q+JHbSW0R/sMDscTIszwz/Uu4rLF5D/
 JLqJg8ERfFI9MNeXEeXCMUNmYkCJtKajPP4cfPON19UnOmELtTvTf/Cw9C2uC6qjmufHKzr
 dF3BmeILgBrikFkptn4NDBBBVdKNozTChE0lzsExY/SD/vc7VtEY0wZf2Hj4NW/S5BWd1l4
 J9JWhgqlMgPm0fFG3L0Ug==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2yn8BY46tl8=:uah3SwXzH17z0i/M51VGcA
 8p1UDugvc34a75P9s9hxn3GE5h/1pLjbx8bujS5sLQPiEaUK6ECF1dyv2sGP6W7TLmz58ILeR
 iBmnBz2rEgVM6e81K6Zn0ksIu0M8yc+uH1k2ZVgb5csvKJklSE6zn8TWybJ3hq9N+voKeYt5n
 4+6OY3OaozDe+mnYUU8KuEo7EmkQD1jRBEfky9PFxFBiOOqvCd+Ucj0DvE9W2IoRJ2gzTOwl7
 sIO12HAFD0VtHiWxB+BXjuTctasMNuEhmt/pC8+IxUd00lt734ifWlv7kIaRZ+P8NiI8wsYpq
 SQMb7zfx4h/bIhanmNecZ2dqf/+1pJwho6bnbveQe+lyQhNrCP6LeNlrFMuipnVlS3orHBv+y
 Hp117ryp/+YwPv7c9XANdo//NMmxBlX2UDzTXYg5sl3CgCO0hvDmYY2EhS887mWeWt75i24Tc
 OlzSqrwhaBRs1dap+9rw2BetHP7cK43Tl1CIAUHrTm8TXkfb/0MikVRsLG2PtFm/r1IVtwFo3
 SgBiWA0dpyukfn8eEq3Xz5yAXC0E7XktCNYFP5vqbFqiTRrdoVXBCP/BpfkBC4RwcbLDyAsWx
 j/2qt+wDo7PIO2ja1TRyOakd3r/ZTaG04+lKGx68j5zti6FeBV5LdlpRPA9Zn7KS/f6T/bAV1
 3DXj19kVAIETI9gVRbF93i2vjVefVa6dV4jBT6WB6j2haf/phSV460aCKiCmg9ZANi6Qnlpoj
 ZwGUxYNKMtcaFlrdAx9jjjbyVQN4ENsbIewC/jbOIOpCrWJPo6rBY9s/qbHRLXIq2vIAY5Gd7
 tfSiRBBeo7QarLnQxe48x9mkePM+/huGW4XQBx9O3aOcMxG7HhnWDBdSRa/XEN6nw2cXkvo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Buga,

On Sun, 11 Mar 2018, Igor Djordjevic wrote:

> On 11/03/2018 16:47, Johannes Schindelin wrote:
> > 
> > > Having explained all this, I realized this is the same "essentially
> > > merging the new tips into the original pretending that the new tips
> > > were not rebased but merged into upstream" as Phillip`s one, just
> > > that we have additional temporary commits U1 and U2 (as per
> > > mentioned "patch theory") :)
> > 
> > But if the old tips had been merged into upstream (resulting in the
> > new tips), then the merge bases would be *the old tips*.
> 
> Exactly, and that is what part you`ve cut out of the quote was 
> showing :) By Phillip`s implementation, we would start with *old tips* 
> as merge bases, indeed (old tips being U1 and U2 in this case),

I really do not see how it would make sense to take the original merge
commit as merge base in this scenario. It makes no *logical* sense: in
which interpretation did you develop changes in two divergent directions
from that merge commit?

Whereas if you use the old tips as merge bases, you can say very easily
what those two directions were: one merged with other merge parents, the
other direction rebased on top of upstream. There. Two divergent sets of
changes that we want to reconcile ("merge"). Easy as apple pie.

> where it further gets transformed as previously written:
> 
> > 	git merge-recursive U1 -- M U1'
> > 	tree="$(git write-tree)"
> > 	git merge-recursive U2 -- $tree U2'
> > 	tree="$(git write-tree)"
> > 
> > ..., where we know U1 = U2 = M (in regards to trees), so this is the 
> > same as:
> > 
> > 	git merge-recursive M -- M U1'
> > 	tree="$(git write-tree)"
> > 	git merge-recursive M -- $tree U2'
> > 	tree="$(git write-tree)"
> 
> Here, `git merge-recursive M -- M U1'` simply equals to U1' tree 
> (being a fast-forward merge), so we can write the two merges above as
> a single merge, too:
> 
> > 	git merge-recursive M -- U1' U2'
> > 	tree="$(git write-tree)"
> > 
> > ... which is exactly what Sergey`s (updated) approach suggests, 
> > merging U1' and U2' with M as merge-base (and shown inside that 
> > sample implementation script I provided[1]) :)
> 
> So from *old tips* being the rebased merge base (Phillip), we got to 
> *old merge commit* being the rebased merge base (Sergey), or vice 
> versa. Does this shed a bit more light on it now? Or you wanted to 
> point out something else in the first place...?

Okay, I'll trust you that these stunts show that the two strategies are
equivalent as to what their results are.

The biggest difference is that it is easy for me to see the motivation
behind Phillip's strategy, whereas I am still puzzled why one would come
up with a complicated strategy that splits merge commits and re-merges
them later, and why it should work in general (I still suspect that this
is not the case).

Where "easy" meant that I had to spend 1h still to figure out why using
the unrebased merge parents as merge bases. The same amount of time did
not allow me to wrap my head around Sergey's verbose explanations.

But I'll take your word for it that the strategies are equivalent, and go
with the one that has both a simpler explanation (in my mind, at least),
and an more robust implementation.

> > I am still not sure for what scenarios Phillip's strategy is the same as
> > Sergey's (updated) one, as the former strategy can do completely without
> > temporary commits [...]
> 
> I think the root of misunderstanding might be coming from the fact 
> that Sergey was mainly describing a general concept (without a 
> strictly defined implementation strategy, not being restricted to a 
> specific one), where Phillip came up with a solution that eventually 
> seems to use the same concept (as those transformations above should 
> show), but simplifying it further inside a concrete implementation.

Well, Sergey started off by suggesting the "rebase the patch relatively to
the first parent always" strategy, then came up with a long-ish email
describing a different approach (which I slowly realize is related to the
first strategy, and it would have been *much* appreciated if it was not
left to the reader to figure that one out), then incorporated what I
called your hack (again, no clear and concise description what changed,
just throwing a bunch of big bones to the dogs with the next long-ish
document).

So I will not apologize for stopping to pay so much attention to that
sub-thread at some point.

> By saying that Phillip "simplified it", even though transformations
> shown above might show different, I mean he managed to further decompose
> what Sergey was aiming for, abstracting temporary commits U1 and U2 out
> of the equation, thus making them optional, but not required.

That is not how I read Phillip's mail. It was more like "how about this
instead". And it was simple enough, with clear example how to implement
it, that I thought about that single mail for an hour, until I was
satisfied that the motivation behind this strategy is sound.

Then you confirmed that it worked on your examples, and that's what
settled the score here.

> So, if easier to implement and reason about, I think what Phillip 
> described is a way to go to produce the rebased merged commit - but 
> in case we want to have that "clean rebased merge" check that U1' == 
> U2' comparison does provide, as they should really be the same (tree 
> wise) in simple (and the most used?) merge rebasing, we can do that 
> after the fact, even.

I do not know what that U1' == U2' check would buy us, as Phillip's
strategy does not require rebasing the amendments *twice*.

> Might be this check could be the most useful in non-interactive 
> rebases, where rebased merge parents` trees could be expected to stay 
> "balanced" more often (U1' == U2'), without interactive fiddling to 
> "disbalance" them. I don`t know, just thinking out loud.

Again, Phillip's strategy does not leave things to be "disbalanced".

> > [...] and cannot introduce ambiguities when rebasing the
> > changes introduced by M (i.e. the "amendmendts" we talked about).
> 
> Hmm, not following here, which ambiguities are we talking about?

U1' vs U2' of course. Those are two things that can be different, even if
they ideally would have identical trees.

Phillip's strategy does not leave that room for ambiguity.

Ciao,
Dscho
