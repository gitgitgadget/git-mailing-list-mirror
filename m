Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCE681F576
	for <e@80x24.org>; Wed,  7 Mar 2018 07:04:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751177AbeCGHEt (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Mar 2018 02:04:49 -0500
Received: from mout.gmx.net ([212.227.17.21]:59359 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751074AbeCGHEn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Mar 2018 02:04:43 -0500
Received: from [192.168.1.106] ([88.26.243.156]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LhSfM-1eOaMm0eTA-00mZKH; Wed, 07
 Mar 2018 08:04:37 +0100
Date:   Wed, 7 Mar 2018 08:04:30 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Igor Djordjevic <igor.d.djordjevic@gmail.com>
cc:     phillip.wood@dunelm.org.uk, Sergey Organov <sorganov@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution (Road
 Clear)
In-Reply-To: <77349f89-16c5-8f14-10da-e15381d11dc1@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1803070803360.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <87y3jtqdyg.fsf@javad.com> <bbe64321-4d3a-d3fe-8bb9-58b600fabf35@gmail.com> <nycvar.QRO.7.76.6.1802270051470.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <CA+P7+xq8UUcLWomUi=PS_hTKfJd3dMAxMmhioDS1bixwcmKAqw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1802271718090.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <4d7f3406-b206-cc22-87df-85700d6a03d9@gmail.com> <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com> <940d959d-151d-68dd-0f13-320ebad0d75b@gmail.com> <87606hoflx.fsf@javad.com>
 <0ac3a3fd-4053-e32e-75ed-8829f22c2e1f@gmail.com> <87a7vss6ax.fsf@javad.com> <6c8749ca-ec5d-b4b7-f1a0-50d9ad2949a5@talktalk.net> <872944c4-ca97-9f55-a424-86d1e3299a22@gmail.com> <nycvar.QRO.7.76.6.1803051812330.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <77349f89-16c5-8f14-10da-e15381d11dc1@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ebFi+voIWkvjSAxPtBk68rmLKS3e8L0qxIJM+zdq34C5wAja6VY
 2yAAr1jgV3vLI1nZGxaZh+3jF4nFOdEUc0DjDbtEOxAF0OpiGbICAvCDJTTmFFaOelo2dVu
 S3TLZSSBj6KIbwIJ2kCM8R8LpbZ07JzZ9MxtOWR26ShUDSBKi1Giw+/+/BMElFtQvQFJRca
 rKq93azho51RQ/AodAGLA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HDUbbjhHQrY=:Cl7Iz9zmxot8XZuJ72Pby+
 nK43wPUXfsb2xFp6pUVLY06FUFBul9Ez3QCF2+1TAxw5pekrkjV8QjETmjNZ9ne5tgaoH/iv/
 FoMsdq7pSCQOT/1KJeIP/AqGu7vNgR6FUUue3fNeviNk45JmIBGOm/RKY5XvPLafl2XVAN5WD
 NBeKMdPjo6rTd2RE+FacRwHxnrbmzkmO4+OnktCgMl9uwJy3rSGDQVFTFbeb4gHqkbYP/GusB
 XBGa3U90sfi/9r1zigpAXLkViNC8o9kmRGafCi+nwhgE0Iubx/bIjkfk+AaBnn6MeQyd+9qUL
 SXxT4+j9qJSpAt9y0VHrkXmfePb9qg7jJ77A6H2r4+OgoGrbG+ReLlIPzayXIGYQtfRlPLpwI
 0SWrWjOAmcF7cd769PSuDpO0hyc3wydJJDDy8N8Sev15akGcWzZnYX5BUNU5LhtHZimDX5mO6
 W2u87fEZw5P1RnZdJRlMVHRH+wBN9k+zYTmBNDFnmktBajHJLfmzQV7Rf2h6NbJK6VBgPdEVS
 pFBS/M6hAyEPUe3kgawkDeqVVk/yeHFR3E8zaSVVNXlCh11xE/wMkjjya/ERUXwd0F+Mi7WxM
 5mmhc9kXsfQ1LhoLjFFAYOp/oOm7a6Xv3tmjSutVFBqTF4xrnMmOP8rVkFTQzNO2A5tyKPFG7
 t1qsq4UGPi2k6040hbOk/y581If7H86dwL/a2Cy/6blIW/VMH+XZ85HR4EvVcksoWgpHqups8
 ixG7q2zJ//0cIVSsk2JCpVa/4EX1qeXVhhoDGg/7t9xxEOPiTmwiAtjsfsCoeCOjbp9BtSUFv
 8SP8H1Voa44DINHaeCT4m2n2fL8/cf/EDbfU0PdpRt/6G1lr4Y=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Buga,

On Wed, 7 Mar 2018, Igor Djordjevic wrote:

> On 05/03/2018 18:29, Johannes Schindelin wrote:
> > 
> > > By the way, is there documentation for `git merge-recursive`
> > > anywhere, besides the code itself...? :$
> > 
> > I am not aware of any. The commit message adding the command is not very
> > illuminating (https://github.com/git-for-windows/git/commit/720d150c4):
> > 
> >     Add a new merge strategy by Fredrik Kuivinen.
> > 
> >     I really wanted to try this out, instead of asking for an adjustment
> >     to the 'git merge' driver and waiting.  For now the new strategy is
> >     called 'fredrik' and not in the list of default strategies to be tried.
> > 
> >     The script wants Python 2.4 so this commit also adjusts Debian and RPM
> >     build procecure files.
> > 
> > Digging through https://public-inbox.org/git/ during that time frame comes
> > up with this hit, though:
> > 
> > https://public-inbox.org/git/20050907164734.GA20198@c165.ib.student.liu.se/
> > 
> > which is still not a good documentation of the algorithm. You can probably
> > dig further yourself, but I think I can describe it very quickly here:
> > 
> > To merge two commits recursively, you first have to find their "merge
> > bases". If there was an obvious branch point, then that is the merge base.
> > But when you start a branch off of master, then work a bit, then merge
> > master, you already have two merge bases.
> > 
> > The trick about the recursive merge is to reduce the number of merge bases
> > iteratively to one. It does that by taking two merge bases, and performing
> > a recursive merge on them, which generates a "virtual" commit, the
> > condensed merge base. That one is then merged recursively with the next
> > merge base, until there is only one left.
> > 
> > A recursive merge of two commits with exactly one merge base is simply a
> > three-way merge.
> > 
> > I vaguely remember that there was something funny about the order in which
> > order you want to process the merge bases: if you did it in one
> > (chronological) direction, it worked beautifully, in the other direction
> > it would generate tons of merge conflicts or something like that.
> 
> Thanks, this is very informative (together with the linked discussion).
> 
> Not remembering seeing this before, I wasn`t really sure if this was 
> some undocumented core Git (plumbing?) utility (used withing Git 
> itself, too), or just a leftover (yet still useful) sample tool.

You raise a good point. The "recursive merge" is not really documented
properly. Maybe you can enhance my vague description and provide a patch
for Documentation/technical/?

Thanks,
Dscho
