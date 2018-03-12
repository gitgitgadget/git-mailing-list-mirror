Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C13961F404
	for <e@80x24.org>; Mon, 12 Mar 2018 13:49:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932190AbeCLNtj (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Mar 2018 09:49:39 -0400
Received: from mail.javad.com ([54.86.164.124]:45518 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751248AbeCLNti (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Mar 2018 09:49:38 -0400
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id ADE223E896;
        Mon, 12 Mar 2018 13:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520862578;
        bh=uHdu2T63XtZXdX9sKu2cuSRAMNTwArABIo/yeGf0QXA=; l=1770;
        h=Received:From:To:Subject;
        b=V2CVz7Scyupj1dclA8CxO7oSzCYyfzGfjuX7f6Z3/iGsudY5C2+HjrC9UsFae3hHd
         cUE0ghUrolpMpOLnS+R+oFuVFFsMNT7aTX3LkODcBHlgO5f0tcPG7IUJUFx9wqAXpc
         wj+SMVhsEG34zPz3465lQ3GoKA/+APAsJPkwjk5I=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520862578;
        bh=uHdu2T63XtZXdX9sKu2cuSRAMNTwArABIo/yeGf0QXA=; l=1770;
        h=Received:From:To:Subject;
        b=V2CVz7Scyupj1dclA8CxO7oSzCYyfzGfjuX7f6Z3/iGsudY5C2+HjrC9UsFae3hHd
         cUE0ghUrolpMpOLnS+R+oFuVFFsMNT7aTX3LkODcBHlgO5f0tcPG7IUJUFx9wqAXpc
         wj+SMVhsEG34zPz3465lQ3GoKA/+APAsJPkwjk5I=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520862578;
        bh=uHdu2T63XtZXdX9sKu2cuSRAMNTwArABIo/yeGf0QXA=; l=1770;
        h=Received:From:To:Subject;
        b=V2CVz7Scyupj1dclA8CxO7oSzCYyfzGfjuX7f6Z3/iGsudY5C2+HjrC9UsFae3hHd
         cUE0ghUrolpMpOLnS+R+oFuVFFsMNT7aTX3LkODcBHlgO5f0tcPG7IUJUFx9wqAXpc
         wj+SMVhsEG34zPz3465lQ3GoKA/+APAsJPkwjk5I=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520862578;
        bh=uHdu2T63XtZXdX9sKu2cuSRAMNTwArABIo/yeGf0QXA=; l=1770;
        h=Received:From:To:Subject;
        b=V2CVz7Scyupj1dclA8CxO7oSzCYyfzGfjuX7f6Z3/iGsudY5C2+HjrC9UsFae3hHd
         cUE0ghUrolpMpOLnS+R+oFuVFFsMNT7aTX3LkODcBHlgO5f0tcPG7IUJUFx9wqAXpc
         wj+SMVhsEG34zPz3465lQ3GoKA/+APAsJPkwjk5I=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520862578;
        bh=uHdu2T63XtZXdX9sKu2cuSRAMNTwArABIo/yeGf0QXA=; l=1770;
        h=Received:From:To:Subject;
        b=V2CVz7Scyupj1dclA8CxO7oSzCYyfzGfjuX7f6Z3/iGsudY5C2+HjrC9UsFae3hHd
         cUE0ghUrolpMpOLnS+R+oFuVFFsMNT7aTX3LkODcBHlgO5f0tcPG7IUJUFx9wqAXpc
         wj+SMVhsEG34zPz3465lQ3GoKA/+APAsJPkwjk5I=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520862578;
        bh=uHdu2T63XtZXdX9sKu2cuSRAMNTwArABIo/yeGf0QXA=; l=1770;
        h=Received:From:To:Subject;
        b=V2CVz7Scyupj1dclA8CxO7oSzCYyfzGfjuX7f6Z3/iGsudY5C2+HjrC9UsFae3hHd
         cUE0ghUrolpMpOLnS+R+oFuVFFsMNT7aTX3LkODcBHlgO5f0tcPG7IUJUFx9wqAXpc
         wj+SMVhsEG34zPz3465lQ3GoKA/+APAsJPkwjk5I=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520862577;
        bh=uHdu2T63XtZXdX9sKu2cuSRAMNTwArABIo/yeGf0QXA=; l=1770;
        h=Received:From:To:Subject;
        b=Au6KqoBv9GX4e2O0CLJvzIgMSJPgpoVlpM46tfElb7kB8m5zzSop8sDhPOBw9Bf4o
         O0VC4GQg3ECWX2uJa+jMqOa3iK2W+t+8+ZrDKy0Z5KIfUdaBupe1p8y2uvQZ0VKjr1
         fPI9QVPaB+eiK4e4WPq2Pd6frKjQ+NN8A04h/m30=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1evNpY-0001O0-0j; Mon, 12 Mar 2018 16:49:36 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Igor Djordjevic <igor.d.djordjevic@gmail.com>, git@vger.kernel.org,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [RFC v2] Rebasing merges: a jorney to the ultimate solution (Road Clear)
References: <87y3jtqdyg.fsf@javad.com> <87r2oxe3o1.fsf@javad.com>
        <nycvar.QRO.7.76.6.1803070742580.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <87vae8yq15.fsf@javad.com>
        <nycvar.QRO.7.76.6.1803071450511.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <a0cc88d2-bfed-ce7b-1b3f-3c447d2b32da@gmail.com>
        <4918cc79-79ba-5dd2-ea84-dc47db47d835@gmail.com>
        <b11785bd-5c96-43c1-95d8-b28eccfd13c8@gmail.com>
        <d29d3c0e-6473-0461-c8ea-02975ce4de14@gmail.com>
        <nycvar.QRO.7.76.6.1803111644380.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <6362804d-e204-a9e0-9ff0-51d8497ce921@gmail.com>
        <nycvar.QRO.7.76.6.1803121056400.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Date:   Mon, 12 Mar 2018 16:49:36 +0300
In-Reply-To: <nycvar.QRO.7.76.6.1803121056400.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        (Johannes Schindelin's message of "Mon, 12 Mar 2018 11:20:00 +0100
        (STD)")
Message-ID: <874lllh09b.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

[...]

> The biggest difference is that it is easy for me to see the motivation
> behind Phillip's strategy, whereas I am still puzzled why one would come
> up with a complicated strategy that splits merge commits and re-merges
> them later, and why it should work in general (I still suspect that this
> is not the case).

Because I believe that rebasing simple commit (1 parent) should be
nothing else but reduced version of rebasing any commit (N parents) at
N=1. The [RFC v2] being discussed provides exactly such a method.

OTOH, check what Phillip's version does at N=1. Is it the same as
"rebase simple commit" strategy you already happily use? If not, please
explain why it must be different.

> Where "easy" meant that I had to spend 1h still to figure out why using
> the unrebased merge parents as merge bases.

That's because you try to figure out something that is not there in the
[RFC v2]. I suggest to forget everything you've already imagined and
just read the [RFC v2] proposal afresh. It should take about 10 minutes
or less to get it. Really.

> The same amount of time did not allow me to wrap my head around
> Sergey's verbose explanations.

Honestly, I don't believe it, sorry, but I'm willing to explain anything
you wish to be explained in _[RFC v2]_.

> But I'll take your word for it that the strategies are equivalent, and go
> with the one that has both a simpler explanation (in my mind, at least),
> and an more robust implementation.

It's up to you, and it'd still be much better than what we have now, but
you will need to face the (I think unfortunate) consequences I just
summarized elsewhere in the thread.

-- Sergey
