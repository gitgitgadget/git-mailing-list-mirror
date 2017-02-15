Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3C952013A
	for <e@80x24.org>; Wed, 15 Feb 2017 12:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751768AbdBOMCj (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 07:02:39 -0500
Received: from mout.gmx.net ([212.227.17.20]:61082 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751412AbdBOMCi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 07:02:38 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MYwQh-1cryVR3DUJ-00VkH0; Wed, 15
 Feb 2017 13:02:31 +0100
Date:   Wed, 15 Feb 2017 13:02:29 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Clarification about "Better tooling for reviews", was Re: Google
 Doc about the Contributors' Summit
In-Reply-To: <xmqq4m01if1z.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1702151215570.3496@virtualbox>
References: <alpine.DEB.2.20.1702021007460.3496@virtualbox> <xmqq7f4zqiyj.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1702101658010.3496@virtualbox> <xmqq4m01if1z.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:+71b5jSl3oIMC4jTYFLAnm5u1qU4m5wr/+x63aO0CXRIRDZrf+p
 K/oon33uzLcxo2Djtyz19zDYxVp/tjEqM0WTuHs6xnD7FVnpEtbJh713AK10+Ts1Okj//dD
 3TRM0HILLFS6578hB8S5OmCDdFtmNTfb4NDYztISkCsxgCvQSGW99xwnE7htYFKH3BhHX1Y
 209SsZh6nUN3AKQYu9IHg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Efm0Zf3iM44=:Mk20WLshl7Yl1F2gsISmVe
 aWViQzhqS/lNTm/FY2D7FLBEO6bzFl5jvZm1D3boafRW5pd8PGM3BCL1bAm/p9reys1Afjd+1
 9Jsqk+V39phZj8JQ7XNA/QdDDNbVExjxwPzTujFQV0Ox73WGf/rWVNniiXJoHcFS+osTSRUwP
 5Ll/8n/1dDy6Y+9+WrR2x6K67Rm6BV4SpJogAS1W2JCTsYqI8+xvv33p0OrHWCC08sEfQeqKc
 KD/276lmKFIkD5WZUIj08j0cEsNYI4c64bBUFnjmfgNcjWn7M6Jkitat2SsJeydG3en+HKxp3
 3HXjMKeOzVHX82asqMDgCha6OpqAAGbfJ/3ou+lWhEQ7LFenYc/xS5CTIBYYwZmNjROphNvPe
 tX+vEqbGYxVaC5oIcrBZQi6fQyIpqVrl4AOlCmTGusr2BCk+U96LkupTvIb3rVeE+H7gUGCGj
 RdJnqCfPA/M29uvXFD300b4Nm6SXrECEVc7XrgkoEQvfRp/Yd3doIit6xFi9M1VSh0+Kf1K4u
 bNarGGEegwhZIcuqqaBYJVE8UwVfI+R+2a7hKUnwI/6M6SVRhmlH160CQyybXfipfwNTb9nMt
 liFynsk9zfpMpiOsaJdTEMZ4CDzti6cF+AkShLcZO2bWhvmDlUjVDCMgH/op+ky9x1RBQhfam
 PnyFiBUHGCCWDyp1nIQLMO7+r4vZdVu0PlBj5Pen0WaB/7Cbn0ILFa6hUJ0CdNoyICZVXJbxH
 WEAmj8cThBOZmpIZFNQH/k+UwTKsyhN26sIlBW2EzsrXKAbzVC4/JEScWF0I+K4PnffnGkxww
 g2wbE5/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 10 Feb 2017, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Technically, it is not a write-up, and I never meant it to be that. I
> > intended this document to help me remember what had been discussed,
> > and I doubt it is useful at all to anybody who has not been there.
> >
> > I abused the Git mailing list to share that link, what I really should
> > have done is to use an URL shortener and jot the result down on the
> > whiteboard.
> >
> > Very sorry for that,
> 
> Heh, no need to apologize.

Well, you clearly misunderstood the purpose of the document, and that was
my fault, as I had not made that clear.

> I saw your <alpine.DEB.2.20.1702071248430.3496@virtualbox> that was
> sent to the list long after the event, which obviously no longer
> meant for collaborative note taking and thought that you are
> inviting others to read the result of that note taking, and that is
> why I commented on that.

Of course you are free to read it, and to guess from the sparse notes
around what the discussions revolved. I do not think that you'll get much
out of the notes, though.

> I've hopefully touched some "ask Junio what he thinks of this" items and
> the whole thing was not wasted ;-)

I am afraid that it was quite clear to everybody in the room "what you
think of this".

And I do not think that your clarifications how you review code had any
direct relation with the discussions in particular about better tooling
for the review process.

To open the discussion of that particular part of the Contributors'
Summit, I mentioned a couple of pain points, and the remainder of the
discussion really revolved around those, constructively so, I want to add:

- we actively keep potential contributors out by insisting that email
  communication is the most open and inclusive, when right off the bat,
  without any notice to anybody, our mailing list rejects mails sent both
  by the most popular desktop mail client as well as by the most popular
  web mail client.

- developers who really, really want to contribute may switch email
  clients or try to configure their existing email clients to skip the
  HTML part of their emails, only to be met with the reply "your patch is
  white-space corrupted" which cannot fail to sound harsh.

- the few contributors not deterred by this problem, and persistent enough
  to try until they manage to get through, often drop the ball after being
  met with suggestions that would ideally be addressed by automation so
  that humans can focus on problems only humans can solve (every time I
  read "this line is too long" in a review I want to cry: how is this
  worth the time of contributor or reviewer? There are *tools* for that).

- discussions often veer into completely tangential topics so that the
  actual review of the patches is drowned out (and subsequently
  forgotten).

- for any given patch series, it requires a good amount of manual digging
  to figure out what its current state is: what reviewers' comments are
  still unaddressed? Is the patch series in pu/next/master yet? Is the
  *correct* iteration of the patch series in pu/next/master? How does the
  version in pu/next/master differ from what the contributor has in their
  local repository? etc

- the closest thing to "this is the state of that patch series" is the
  What's Cooking email that neither CC:s the original contributors nor
  does it bear any reliable link to the original patch mail, let alone the
  original commit(s) in the contributor's repository.

I really do not think that any of your descriptions of your workflow and
of your review priorities could possibly be expected to fix any of these.

I have an additional pain point, of course, in that your priorities in
patch review (let's admit that it is not a code review, but a patch review
instead, and as such limited in other ways than just the lack of focus on
avoiding potential bugs) are unfortunate in my opinion. But that is not
your problem.

It is clear to me that these pain points only affect potential
contributors (and some of them only frequent contributors who are as
uncomfortable with the sheer amount of tedious "where is that mail that
contained that patch? Oh, and what was the latest reply to this one? Okay,
and in which worktree do I have those changes again?" type of things that
really should not by *my* burden, given that we are trying to develop an
application that helps relieve developers of tedious burden by automating
recurring tasks).

That is why I did not call session "Let's criticize Junio for something
that does not even bother him", but instead "Better tooling for reviews".

The only way forward, as I see it, is for other like-minded contributors
(one of the GitMerge talks even dedicated a good chunk of time to the
description of the pitfalls of the Git mailing list, and home-grown tools
to work around them, so I am definitely not alone) to come together and
try to consolidate and develop the tools to work around the problems
incurred from the choice of using the Git mailing list as the only vehicle
for code contributions [*1*].

When (or if?) those tools become polished and convenient enough to make a
difference, who knows? Maybe even you or Peff find them useful enough to
switch. After all, even The Linus switched from tarballs and patches to
BitKeeper (and I read that it took only a substantial amount of time and
effort and money on Larry McVoy's part[*2*]).

But nothing of that comes as news to you. You knew all that about my
opinions and my pains. I actually did not expect there to be any benefit
in the "Better tools for review" session for you, specifically, and it
seems I was correct in that assumption.

Ciao,
Johannes

Footnote *1*: git-svn, gitk and git-gui Pull Requests and subsequent
merges do not count, as it is clear that they are not *really* part of the
Git source code, and therefore not *really* reviewed on the Git mailing
list.

Footnote *2*: Some posts I read about it are unfortuntely gone, but here
is an archived one that still works:
https://web.archive.org/web/20120414183625/http://kerneltrap.org/node/222
