Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E5F420248
	for <e@80x24.org>; Wed, 10 Apr 2019 22:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfDJWNr (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Apr 2019 18:13:47 -0400
Received: from mout.gmx.net ([212.227.15.18]:36217 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726612AbfDJWNq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Apr 2019 18:13:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1554934422;
        bh=HhFIa/iiFLiPuk04A1GSJtqP5kGv7eKyd/oO/bukF+w=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=VJVa7EU/UJoa3m61TPRqlkc2uPeQ+UEiJNKJaX9HxOdZMYhph8nrU9q57igDVbqZk
         aT+N5246WzWdfUw/Lx+t3aXE+Ym6Wh3Md8pn3S7wOOd3y3LxF6NKESeF8nMxsIt6Nu
         88MGo9sEwKrYnT5NP1kOnahrTsLZQteaxlO0mN2I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MKIEQ-1hChJQ01CQ-001iHh; Thu, 11
 Apr 2019 00:13:42 +0200
Date:   Thu, 11 Apr 2019 00:13:42 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2019, #02; Wed, 10)
In-Reply-To: <xmqqmuky36nj.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1904110013100.41@tvgsbejvaqbjf.bet>
References: <xmqqr2ab2gs6.fsf@gitster-ct.c.googlers.com>        <20190409191831.GC32487@hank.intra.tgummerer.com> <xmqqmuky36nj.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:a8TjenoEA4JlsHDdjhLoB3Xl5MghJfHM2t24Ku86xyNrTzOcT4D
 qIWfobHjr3lRJWY0xrq8EfkeKQ5U9vSIvbnfgy9TJX3/36LJRsg1WKt1Cw01ATXhtoag9op
 rxgcts6sYSC0XbxmJyUv42UC/89hZexUg41TmHi9bpBq0SZLoKTYdY42JvlGZiB81CxACqx
 7cCurQJ/lgKWuO1eJS5Fw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6Sua4Spb0pg=:A+qhpGKaS8vZFjFph2mJJ8
 lgboluNeLcJZsmgQXvBJpvwZOSKd8B9YUdB/8sgfj8+vxRVVk8IUPOinR/3bLN30tTw+HFAg3
 bMSP3HIOExmWGAcYEfnglB7VpvRe+8yRbFGD27ARhk//r4XZ+NLB0S5+Nl6TIk+pX8QOL061i
 DBSup2nAd4RqKld/Vi78JupTWIqbe972ny/l0dk+JST5jsonfqdK+9hx+rBvYXnZIDh550jSG
 2jdAAJLCb6kxw8Ib/+r1G4gaCq3eVrGQvWYO9WLsCpov8/81jKGYqNRQ3bN5HRFPAqklDnbYN
 Noj/fLx6TnEv7EQqOSdYYqZ9+9eZ+GGKsq9LfOWLSXEDPQ/O3iT1B1xcLW+T3Q2KFwQl74hpc
 qXSsPpaXavI9VcqEHd8GKDhqbNrODPYZeu5GgO4iSCYmya3jN4WkDGXNvVojv2YWfqoMKCm7w
 KR03MJWl3P/KcTo90fY3MPhfA+7FxlmPKbKWcdMVbfuvIX2ogLm7vt+XXZqv1lixBa96YKvwH
 2AvbqxA0NYg8v49V+LlzwJFoLDgphAy5QxLh4ShA+huEFv/DU3ezPIIv2jVysq62hlSMidunA
 EZFYPAx1veLzK2b1HpWr7EDTjDi4aoI4HXnnr9LDKvgNTLq1ljwTAm5aTjGqXNdyf4TVooLph
 n58k97MqwwMVMHOjsBa+p59V70/NIUyCLrqzCf6ufk0bOvJNQ2GnNuX+WgGLS9XD2UoRH1AV5
 cKxfu1uEOF5T18jJbIXzSN7KACBRMe75oxzaero1phC73mVtzryMroodzDnxeFQqVTgdt7hNc
 t7FT5CPk8OVprqogpije63y7l8YIdH7IsiNTQpBSoI7Zue+HL3KdpkUnvX7nDnpL+fZWhSFnj
 uQVRQJIaqGiVeUg4+dFIUekgxvtKnIuqrk6fhm/tnXa+q3bDkboJ5qZeYFQKEvpU60zxgntp0
 u2M/kAbov+A==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 10 Apr 2019, Junio C Hamano wrote:

> Thomas Gummerer <t.gummerer@gmail.com> writes:
>
> > On 04/10, Junio C Hamano wrote:
> >
> >> * tg/stash-in-c-show-default-to-p-fix (2019-03-21) 1 commit
> >>   (merged to 'next' on 2019-04-10 at 9489a31a36)
> >>  + stash: setup default diff output format if necessary
> >>  (this branch uses ps/stash-in-c; is tangled with js/stash-in-c-paths=
pec-fix and tb/stash-in-c-unused-param-fix.)
> >>
> >>  A regression fix.
> >>
> >>  Will merge to 'master'.
> >
> > ps/stash-in-c is still marked as "Will cook in 'next'", so I assume
> > since this is fixing a regression in that topic, "Will merge to
> > 'master'" is a mistake here?
>
> Thanks.  I actually intend to unfreeze ps/stash-in-c and topics that
> fix it, now this topic is also ready to go.  So I'd rather mark them
> all for 'master', and give all of them exposure so that we can smoke
> out remaining issues, if any.

Awesome!
Dscho
