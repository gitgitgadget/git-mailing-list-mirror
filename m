Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95192C433F5
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 12:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 798A960FE8
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 12:45:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbhJSMr0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Oct 2021 08:47:26 -0400
Received: from mout.gmx.net ([212.227.17.20]:56749 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230097AbhJSMrZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Oct 2021 08:47:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1634647510;
        bh=PVtZOHcwri1OrXcn2oizCjpilCEdc891eQdyOd80A/0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=UdguJUROrl62GYS8GMhn9UczShHK3STz0dCPHiIF4yXgnZdQinTV/2h7jXAx+LQgC
         K0Cw8qvz1R7cCP0tFPrT0iPrPgmBPfd+Bm5ygaM3FUMgwch8PFm/GhYvKqHsdoeH2b
         y0VPAck7MimhV7oYB/k7RhZIwQGQrC8HTPyCpnrg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.7.163] ([213.196.212.140]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MdebB-1nC9Aq2s77-00Zc8V; Tue, 19
 Oct 2021 14:45:09 +0200
Date:   Tue, 19 Oct 2021 14:45:07 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: js/scalar, was Re: What's cooking in git.git (Oct 2021, #05; Mon,
 18)
In-Reply-To: <xmqq1r4hv7bv.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2110191436250.56@tvgsbejvaqbjf.bet>
References: <xmqq1r4hv7bv.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:A0fB6Bgh4EVntX1rNrTU7H8POwDqJGhfvxdEZ5PiaYXZfguBosk
 pHqg8HkkFPlbq8SnfoAIZmxY1oTymAW1UhWCzqqQe97mVmSOV1bukilQfea22q7pbwOgpBa
 0qSBsuykm7RWtKmPAxG6wyA3t5aPxOmX7fKxpZzyULZQtGUcZYNNs69Yz7AlTrZWkywKV2R
 Uhkvi9sKr5djqhFfQNv0g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GJqEuQq4bVc=:i03lK5OSlzlQ5MYkuGS8DW
 zu5jvtuWNWXgu1/dJAW7kDyIG18hrmCjnuQGQW1x3UdMuiu7x6H8ncTrMARFYU9dpGW/cin5n
 4Dt19xO/ryYY7KibV/l/LEq0F12m1nI12eRrHv81ToThUtvwScMa94gr+3y45h34pbkEQUkw3
 SnFmIHZw72LHENU3/iKVGd2UJi68oKYXnsPzVEZPQzH/b9ZrbBkpqFb3nb36iOC6Gq9Ru6YEG
 rjEG19y1F4UeuGOFVzx8Yhgc2yWk3PEf2O9BwBFiyKcKqLPrWH+Q652L09rxE8PfyvVKe+RDf
 2QtnIJQCKZC3fXyAvOkbI8LTt0Z4zwv0ZPHPLAarh3NMGfI7hQ/VWkC3P5XcdZSP+8gD2OMYf
 TO85iqctisazgDCuSnmCmCFxmGlJEmrkgvwUCEgZw/p41LYCNH/6kh7nXWFCNJf4I1xgTtU3L
 BxWhLMspbS475HeKDtkxv7C9hUS/oQrvlfxI7O/rfWeikzxV71kGfbF4KYYnYnXwHk1GSjFfO
 gwux1spGsHMKLxBqhrhWk+ZJk8uHvoxr9t+LGugsau87hnmYVVcV0eyEGavxTE4bNCqxL3lgY
 bi+XFq4uPDLPzHyVAZwP6zVsOer4ID5n8KpDdJMCuQDgmNmd4vbwmaIhFxeknMp7HTAM1hJNl
 VBZ56dRADie53pDIA4N/CDulzie21yJ42vxGBh6r/Wt/COFsXwO3PtmuYTOyFN9Bdk+ihrU07
 2u27xEZuTobLOxxqfU9mz+Q1hlfFCL7L1Ca8qKar5XvPekZOlAtPvMk8KotvXtjYGI91lAZ2b
 LDVCf3OfvjMECUod7vymWFS6F/5AbPf3E7LjTw3SxwQZJaYFgClZMnlUcqkZw8okiCD5T64o0
 8cGUXG5WhU2ZU4gfRL4IlEeMQnkspU4mO/2/oNkZK11XvzC/utEJRCFd/I8HH7AbO/eNVsGJE
 StAkhn/4Ux8g8MIquOWe8Oo+CZNEp59Ishps26RNRTKGPXQ/MeLQmjhqA/kTVcBixHBoYjw2m
 x1NsKn8gjkHBL7VQeG8DDhXz0H0kq1H0YPzMkYcbvn2a/g+QIsnhB6A5/9L2REMydTK4JyAdy
 ddqo6RSF9lLL/4=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 18 Oct 2021, Junio C Hamano wrote:

> * js/scalar (2021-10-07) 15 commits
>  - scalar: accept -C and -c options before the subcommand
>  - scalar: implement the `version` command
>  - scalar: implement the `delete` command
>  - scalar: teach 'reconfigure' to optionally handle all registered enlis=
tments
>  - scalar: allow reconfiguring an existing enlistment
>  - scalar: implement the `run` command
>  - scalar: teach 'clone' to support the --single-branch option
>  - scalar: implement the `clone` subcommand
>  - scalar: implement 'scalar list'
>  - scalar: let 'unregister' handle a deleted enlistment directory gracef=
ully
>  - scalar: 'unregister' stops background maintenance
>  - scalar: 'register' sets recommended config and starts maintenance
>  - scalar: create test infrastructure
>  - scalar: start documenting the command
>  - scalar: create a rudimentary executable
>
>  Add pieces from "scalar" to contrib/.
>
>  What's the status of this thing?

As far as I am concerned, the current status is: We agreed that this thing
_can_ live in contrib/, and that the `scalar` command itself should not be
integrated deeply into Git because the end game is for `git clone` (and
maybe `git maintenance`) to learn Scalar's tricks.

A concern was raised that `make -C contrib/scalar` does not rebuild
`libgit.a` whenever any of `libgit.a`'s source files were modified. In
light of the previous paragraph, I believe that my time would be better
spent on designing a new `git clone` option, though, than to spend time on
a build process that will be soon obsolete (except if I allow myself to be
distracted by things like teaching `make -C contrib/scalar` to know about
`libgit.a`'s prerequisites). In other words, it is a technical debt I
firmly believe is worth accruing.

Other than that, I heard no objections, therefore I believe that this is
ready for `next`, to be cooked in the v2.34 cycle.

Ciao,
Dscho
