Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1C301F404
	for <e@80x24.org>; Mon,  5 Mar 2018 17:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752154AbeCERxE (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 12:53:04 -0500
Received: from mout.gmx.net ([212.227.17.22]:41123 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752069AbeCERxD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 12:53:03 -0500
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LgNGi-1eMvVi1MpA-00nhJl; Mon, 05
 Mar 2018 18:52:54 +0100
Date:   Mon, 5 Mar 2018 18:52:53 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     phillip.wood@dunelm.org.uk
cc:     Sergey Organov <sorganov@gmail.com>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution (Road
 Clear)
In-Reply-To: <6c8749ca-ec5d-b4b7-f1a0-50d9ad2949a5@talktalk.net>
Message-ID: <nycvar.QRO.7.76.6.1803051836110.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <87y3jtqdyg.fsf@javad.com> <bbe64321-4d3a-d3fe-8bb9-58b600fabf35@gmail.com> <nycvar.QRO.7.76.6.1802270051470.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <CA+P7+xq8UUcLWomUi=PS_hTKfJd3dMAxMmhioDS1bixwcmKAqw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1802271718090.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <4d7f3406-b206-cc22-87df-85700d6a03d9@gmail.com> <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com> <940d959d-151d-68dd-0f13-320ebad0d75b@gmail.com> <87606hoflx.fsf@javad.com>
 <0ac3a3fd-4053-e32e-75ed-8829f22c2e1f@gmail.com> <87a7vss6ax.fsf@javad.com> <6c8749ca-ec5d-b4b7-f1a0-50d9ad2949a5@talktalk.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ofdxonFuRf+V4bCIHRVC+xsuqYHeSMI62KW129NDnUxFXXfinZl
 7IFSEcVmCH/3GCBtGV/qAAgw3E0d/KoAKAysexclu2kytUsEbnanuGlvJB0R8TVcyeYtlVr
 6ZgIdrup9W2Jy1OJ2PZwl74Jua/KVFZ7lUv8IWiCe17SY6wOxUwmfHDVNIskd1BWavWKx7C
 slfghlPeQse5BQApyDX/w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WHpPFnaVz2g=:bi3qxym7ivg4PB+E6yEug1
 jP73mvn1hBrHEwJilAd9IISTFstHguEuVc/FUpityctA7UC+8OnCemvuFWJ5HWNLQ3ZW9lq4u
 Dat+/zwpXLi35g9bniM8y4ig1MtEFXsoi7e3chhK6zl4jK5h+/WzPL55RgwMWujiYJzAv7h/x
 gdHe2btpY5g6fzZAa2XyYqA5f2Lah+mMDSlnpD4dnIecCCxmn2Pi6wdcYLc6l2qOmuB0zhxlw
 /G7pFaLxxhe7XgIvUwqR91bvMkrKGDXURWb7+fVeIgOjR94tB3EvAjai41xdaqaaqxsG5XFZa
 c0ZJD0XMPbVY3UUTHizIFjYbvOAO/L4EW5aycj2crdu3waXqkSstSY0U3Z4fi6mM7x1Jxp/8h
 rGreDYjFyeX+LH/DUh4R9/uExFPhpKdFAL3THUfdlkaKQywapHn8PUrp8Ifj3+ZUuDjTOHIBS
 6kVoU6Gn5gZ6pUr95nZGjJxoh36MXIdb62U7ucO1mBeCg1DtFD2IiQnJtlZmyGx+gl54eIwoL
 MQvBU4MyR7YuyuXN/rIgL/dHgdEM0d3F+7X0/fBcbCK/pvYS+68fax5e2hrLpSTuyVQDpkmsM
 RUuj9wcXnKDJv5lgS8avFRogrKNKoX9gTuSAq8gsdugGeP+2TCr4/wYgZ39r6NQolnsblndMx
 x2B15VYwwjBZuynj9Ark2y8E1G0ddk228vnzUJ+5ca5H02JWxLpnTPMGU9w89mwBmLjUlGfI3
 AgL7eyEcgX8pnhbp8SMEpCmcDltRpLNPBfZsdZcqUCvwY/piYYee2iXNrVHQ6wBcG++vORGF7
 60YAT30LKiPrM5ZjKS5GYUtS80YuAAvPB9B74QfHkQpCvIGGgsYAkFv5zhtZ/myFPz4A1uM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Fri, 2 Mar 2018, Phillip Wood wrote:

> On 01/03/18 05:39, Sergey Organov wrote:
> > 
> > Igor Djordjevic <igor.d.djordjevic@gmail.com> writes:
> > 
> >> On 28/02/2018 06:19, Sergey Organov wrote:
> >>>
> >>>>> (3) ---X1---o---o---o---o---o---X2
> >>>>>        |\                       |\
> >>>>>        | A1---A2---A3---U1      | A1'--A2'--A3'--U1'
> >>>>>        |             \          |
> >>>>>        |              M         |
> >>>>>        |             /          |
> >>>>>        \-B1---B2---B3---U2      \-B1'--B2'--B3'--U2'
> >>>>>
> >>>>
> >>>> Meh, I hope I`m rushing it now, but for example, if we had decided to 
> >>>> drop commit A2 during an interactive rebase (so losing A2' from 
> >>>> diagram above), wouldn`t U2' still introduce those changes back, once 
> >>>> U1' and U2' are merged, being incorrect/unwanted behavior...? :/
> >>>
> >>> I think the method will handle this nicely.
> >>
> >> That`s what I thought as well. And then I made a test. And then the 
> >> test broke... Now, might be the test was flawed in the first place, 
> >> but thinking about it a bit more, it does seem to make sense not to 
> >> handle this case nicely :/
> > 
> > Yeah, I now see it myself. I'm sorry for being lazy and not inspecting
> > this more carefully in the first place.
> > 
> > [...]
> > 
> >> So while your original proposal currently seems like it could be 
> >> working nicely for non-interactive rebase (and might be some simpler 
> >> interactive ones), now hitting/acknowledging its first real use 
> >> limit, my additional quick attempt[1] just tries to aid pretty 
> >> interesting case of complicated interactive rebase, too, where we 
> >> might be able to do better as well, still using you original proposal 
> >> as a base idea :)
> > 
> > Yes, thank you for pushing me back to reality! :-) The work and thoughts
> > you are putting into solving the puzzle are greatly appreciated!
> > 
> > Thinking about it overnight, I now suspect that original proposal had a
> > mistake in the final merge step. I think that what you did is a way to
> > fix it, and I want to try to figure what exactly was wrong in the
> > original proposal and to find simpler way of doing it right.
> > 
> > The likely solution is to use original UM as a merge-base for final
> > 3-way merge of U1' and U2', but I'm not sure yet. Sounds pretty natural
> > though, as that's exactly UM from which both U1' and U2' have diverged
> > due to rebasing and other history editing.
> 
> Hi Sergey, I've been following this discussion from the sidelines,
> though I haven't had time to study all the posts in this thread in
> detail. I wonder if it would be helpful to think of rebasing a merge as
> merging the changes in the parents due to the rebase back into the
> original merge. So for a merge M with parents A B C that are rebased to
> A' B' C' the rebased merge M' would be constructed by (ignoring shell
> quoting issues)
> 
> git checkout --detach M
> git merge-recursive A -- M A'
> tree=$(git write-tree)
> git merge-recursive B -- $tree B'
> tree=$(git write-tree)
> git merge-recursive C -- $tree C'
> tree=$(git write-tree)
> M'=$(git log --pretty=%B -1 M | git commit-tree -pA' -pB' -pC')

(The $tree obviously wants to be passed as parameter to commit-tree, but
it's easy to get the idea.)

> This should pull in all the changes from the parents while preserving
> any evil conflict resolution in the original merge. It superficially
> reminds me of incremental merging [1] but it's so long since I looked at
> that I'm not sure if there are any significant similarities.

Interesting.

Basically, this is pretending that A'/B'/C' were not the result of
rebases, but of merges between A/B/C and upstream, and then performing an
octopus merge of M, A', B' and C'.

It is a beautiful application of the duality between merges and rebases:
ideally, they both result in the same tree [*1*].

That is a pretty clean and simple-to-describe paradigm to work off of, and
to reason about.

Ciao,
Dscho

Footnote *1*: I frequently use that duality in work to rebase "clean"
patches on top of upstream, and use that rebased branch to figure out how
to resolve merge conflicts when merging upstream into a long-running
branch (whose tree is identical to the pre-rebase version of the clean
patches). And yes, I *think* that this is essentially Michael Haggerty's
`git-imerge` idea.
