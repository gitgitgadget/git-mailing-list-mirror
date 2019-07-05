Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 786081F461
	for <e@80x24.org>; Fri,  5 Jul 2019 20:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbfGEUpP (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jul 2019 16:45:15 -0400
Received: from mout.gmx.net ([212.227.15.15]:59115 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726898AbfGEUpP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jul 2019 16:45:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562359512;
        bh=CgwLDsDCXd1Wwq+KQWxTDXt54e9geqQtrF6Ok4t4X2A=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=IRzg4dvsSrnsRaQ41Zx83q2vBWR7D55nPKzluEPgVALjcni8yKX+Viy6LfihLWTAt
         tdIauJEasJsQ70gsbQQw18PvB4f4dx4hOWdSJ3A8S9dPqulLvtIJ8T3yH6LlGqzsZl
         Mzv/blp0DdL9neuU/LxkFfeFDKh7aZ+GDxAi1TXw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M9nxn-1hdhmf0T6j-005oX8; Fri, 05
 Jul 2019 22:45:12 +0200
Date:   Fri, 5 Jul 2019 22:45:42 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jakub Narebski <jnareb@gmail.com>
cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Gabriel Alcaras <gabriel.alcaras@telecom-paristech.fr>
Subject: Re: Virtual Git Contributor Summit
In-Reply-To: <864l401u8w.fsf@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1907052244230.44@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.1907031429420.44@tvgsbejvaqbjf.bet> <864l401u8w.fsf@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:3t5aVbXH4Qso9+K9BOTHjfysVZnZ3BgsVHGXzH7bb31p8Aic2iz
 JBitj/aI53ChD+hXeQIhJm8u8ehGNBUqZU83OE3nl6mz1GZp5jsrOyQYQjP+eRNPG4t/ZwM
 GPxlj2xdvtS9r3Euf+b9MnSpYQEeeTqu710CY8nn2+8CYa6djZYdZ0PekBKb/RGzccajBJi
 3nyUUc/sBpgCuve15Ux7A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tZTE0+PKV0w=:JiQuTkttf4O9KLlwQljFGx
 nezTXRX+msLkQTorJd5+YwHYuzEP8cT83MCpKh4hi6/9wtbYW5sqS4eiLOJsSNdFQXzUoLtBW
 IujIxdYV0Yqq0tTsKaAdCaULS0N/XH4svABCP6dnvbk+Grru8PcGflOmW3cVjzlwM3o9AnZOK
 1f3nfkY3xmN3lgUY5XK0Hyk3n5g/cgJXV1BorOD38gZFLWn8/cYJNVlOqpGd9vd/bgH9gDK3u
 vMs18Uz166iEQyVs2nv+3h/1mz6zNBwzBRiHZD4nqE009556Q2KwZVNEX7rCG42u47cH8/DWw
 kUyoprYXCghqc4iNUrG0xy5QKt/KvlATaa93o5YmF8CY0jzyCjH/GYe6/flFj9oH7M+B92qko
 zYBgJnH+qBRT+IuRv3kuVv6UiRkDjQkTPKS6ceWpd8m2hTr6x7HJytIYenrO5nOpQatpaxut2
 d2SmXvUBzeV6nVUEEvxBzKrN10HgTCCpZzgrMOJsoRlZ3wNc/aoN1fTQHTo4agDUE19IV/Cjm
 7p5a2AzfSWclpwcs6xzoZHnRt3NljO/UvNIEpMckPXX2oUqo0e0gPSMh4bDIJncYKeN8QyWvV
 NnqXC4bPDzarp5NRir48dhDVS7rCWgTXyUKvpFRiRaq8KIsDuhVPpX4rHxAgTNOiO0JJ0PX7u
 xO7kua7CEwwl1ZZLRx/BTAX9bWRWzom+VMBTcT1L/wrlk1xVP8TPEa3yY/Hzonz6M/Tm6drss
 n4xijMZZGblJvILVQtqRnPOa7HWYp5hUdMm/2rGuANptU3uliMEklf/vQD8bF33sSu6PTlbqo
 b3fTpOYEEVXx6Zj8hW8lnzBu6VOjd1Bd7nnXx8OFDPkvimmxleItBVSR5x6dd+3Piez5tI9qO
 Y7IeIL2cucwXZbwZgzR89f+JHmN5e3ddWRN8bO+iP6kDIISOR5tYiMZmaMxfa6c3hDybiROde
 5gtvVMB4U1s9hXeZydHOYiEnK2GoXzO+XJNPPz6FI+YQ8WappUMv4i3lgh3kTluFqNj5swKCg
 bNlNKgRNJnhIbTx3dYvAGGhzytB+EQqhwrhQl7aRZvpSP8pkcVnnAIWWrXuLTX20YrQg3Wklf
 2PEsMGOhn3HBMsrnyQ2+oS2qa/xdYO+Xo2P
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jakub,

On Fri, 5 Jul 2019, Jakub Narebski wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > I kept talking about this idea of a purely online Git Contributor
> > Summit, and it is finally time for action.
> >
> > The idea: just like the Git Contributor Summits we have on the day
> > before GitMerge, but instead of traveling to the same place, we'll use
> > an online conferencing system.
>
> By the way, would there be GitTogether meeting held in conjunction with
> Google Summer of Code 2019 Mentors Meeting?

I know of no such plans. Please note also that the GSoC summit is in
Munich, Germany this year.

> > Obviously, there will be more people interested in participating; Plea=
se
> > do drop me an email if you're interested and I will send you a link to
> > that spreadsheet (as I do not read my mails continuously, it might tak=
e a
> > day, but I will, promise).
>
> I think it would be good idea to have some of us from Git Rev News team
> to chronicle this Virtual Git Contributors Summit meeting.

Sure, I forwarded the information to you (Christian already had it).

Ciao,
Dscho
