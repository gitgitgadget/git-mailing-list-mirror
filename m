Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E7841F424
	for <e@80x24.org>; Fri, 20 Apr 2018 08:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754000AbeDTI0x (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 04:26:53 -0400
Received: from mout.gmx.net ([212.227.17.21]:59135 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753946AbeDTI0v (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 04:26:51 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MDFB2-1fCjBG2oIe-00GaRq; Fri, 20
 Apr 2018 10:26:42 +0200
Date:   Fri, 20 Apr 2018 10:26:25 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Jacob Keller <jacob.keller@gmail.com>
cc:     Sergey Organov <sorganov@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v6 00/15] rebase -i: offer to recreate commit topology
In-Reply-To: <CA+P7+xrv54RBFx1eYbvgVyqQ88uxT73vOf3jazCVsvuXwvd-gA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1804201017450.4241@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1519680483.git.johannes.schindelin@gmx.de> <cover.1523362469.git.johannes.schindelin@gmx.de> <87tvsj6rn2.fsf@javad.com> <nycvar.QRO.7.76.6.1804110009080.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <871sfm737e.fsf@javad.com>
 <nycvar.QRO.7.76.6.1804111324350.65@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <87h8oh51jm.fsf@javad.com> <CA+P7+xq8KJKJ0d1unW3btUhKVjOZM3EdTSKdDs96pn5J3WwSKA@mail.gmail.com> <87sh810ym4.fsf@javad.com> <CA+P7+xq8LOUZxVd832cOQFi4V=2YvydxtT6_y4NLKvFkki4QdA@mail.gmail.com>
 <nycvar.QRO.7.76.6.1804130002090.65@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <5d522cc9-3922-9f24-3a1e-0c121c47ca96@talktalk.net> <nycvar.QRO.7.76.6.1804140146450.234@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <87fu3r257z.fsf@javad.com>
 <CA+P7+xrv54RBFx1eYbvgVyqQ88uxT73vOf3jazCVsvuXwvd-gA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:BEqIFJiTKwaEdI4yh2abR6qBefoD1gJzC7kFQ3vC0GmeCx1TP34
 Rb4mFsgPxDJVvlpfs1i6WbW3mOKQnoczoW5Om+FilSNVNEJMp6UDzi/qMGTSOiznG3cPpfs
 j5HsvUh3HGWu2PYA/4zqCHxyFF7cQEInh+RPm+NectCqjybZdfIUCAsOzyY8eK65H0vyxG5
 6umZKQHlH+LjqN/MTZJGA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nzrIkiBPpNE=:Ow8U/GfKziaQm+9jofUmdh
 6usa/pIakP4hFxgiICq2ytq9Cexb2NgW53elzpikuaK8nVUcbri1vYp8bybSNN2+bjWkiPQzk
 KlRGZYgquFANvW/g97SMZOgnD4HX6OJcU5HGc8C09UeaotE/zLEa+1t+LgkQcU8LenMsyWrn6
 t/AtgI9jHHsjna3Mhr+afeeqix0V/yRZmyZGcXiky6ezyP/ox9o1wmDEPLKUO+LA1/213fDUx
 TiyUVa9WhtEqMJNhHF3an8ivjfyYuLWdTlofuOBn29ECeuIB1o+SZVBgicA44M0cgd6WsvogV
 UwjZw6+y2O53IS0IhDy6K8LcQnCDqwFNV2Y77Pn/Nfd1rVxMaa9HnDR5B0I3c5iVH6fEuMxTU
 3+AYU1Iiwp/HCjFvMTFXMjITgXcHKnnTzrHefzHcSySiQESoLXTbOEsTo9egBID086i0URerZ
 SoeIolulX5Lx+LRSzis/A6J9EcmvVEaOjh0BXNRzTlGOeNYudYeD4vvHFYyeEiFEnc2tFNc8j
 KdT9U/ShrqutEEucm1EjvKVnPJFUyx35RL5DIQV05LGy0HzJ6c6XQci7m1udXBi/H5GQ7+lY9
 cNMcZfmaK4pqqw2wZKRFpAVt8PV84IUdbaoqpOirUCMjSQW0A6Z/KG3G63tXolZSEaikzEuOe
 X7rfeiVGl42CpGEaKlqKrPC7TY9oOFU0nZYn4lYbgOypFg8yIQJXF+Jy3Of6de2T2FB7mog3x
 nXdpS1hjOLZzaqn0LHUzLH5kcjMEPnFKDuqmI3xOSTPeFX/+5w1wWH6UbrvUwLFxVDsQ7V7bu
 Wq8IEAQmMIB9H+Vdqigt5cDPgzcpgX4F2eDhuXiYr9w462DDIU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jake,

On Thu, 19 Apr 2018, Jacob Keller wrote:

> On Wed, Apr 18, 2018 at 9:24 PM, Sergey Organov <sorganov@gmail.com> wrote:
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >
> >> On Fri, 13 Apr 2018, Phillip Wood wrote:
> >>
> >>> On 12/04/18 23:02, Johannes Schindelin wrote:
> >>> >
> >>> > [...]
> >>> >
> >>> > So: the order of the 3-way merges does matter.
> >>> >
> >>> > [...]
> >>>
> >>> Those conflicts certainly look intimidating (and the ones in your later
> >>> reply with the N way merge example still look quite complicated). One
> >>> option would be just to stop and have the user resolve the conflicts
> >>> after each conflicting 3-way merge rather than at the end of all the
> >>> merges. There are some downsides: there would need to be a way to
> >>> explain to the user that this is an intermediate step (and what that
> >>> step was); the code would have to do some book keeping to know where it
> >>> had got to; and it would stop and prompt the user to resolve conflicts
> >>> more often which could be annoying but hopefully they'd be clearer to
> >>> resolve because they weren't nested.
> >>
> >> I thought about that. But as I pointed out: the order of the merges *does*
> >> matter. Otherwise we force the user to resolve conflicts that they
> >> *already* resolved during this rebase...
> >
> > How it's relevant to what Phillip suggested? How the order of taking 2
> > steps, A and B, affects an ability to stop after the first step? It's
> > still either "A,stop,B" or "B,stop,A", depending on the chosen order.
> >
> > What's the _actual_ problem here, if any?
> >
> > -- Sergey
> 
> I believe the order of the merges changes which ones cause conflicts,

That is a correct interpretation of the example I showed.

> but it's possible to generate pre-images (i.e. a set of parents to
> merge) which cause conflicts regardless of which ordering we pick, so
> I'm not sure there is a "best ordering".

In general, there is no best ordering, you are right. There is no silver
bullet.

I am not satisfied with stating that and then leaving it at that.

In the example I presented, you can see that there are common cases where
there *is* a best ordering. In the wrong order, even if you would force
the user to resolve the merge conflict in an intermediate merge (which
would introduce a nightmare for the user interface, I am sure you see
that), then the next merge would *again* show merge conflicts.

And I, for one, am *really* certain what my decision would be when offered
the two options 1) force the user to resolve merge conflicts *twice*, or
2) reorder the intermediate merges and present the user with exactly one
set of merge conflicts.

So it is irrelevant that there might not be a "best order" in the general
case, when in the common cases quite frequently there is.

It is just another example where theory disagrees with practice. Don't get
me wrong: it is good to start with theory. And likewise it is simply
necessary to continue from there, and put your theory to the test. And
then you need to turn this into something practical.

Ciao,
Dscho
