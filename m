Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 359DD1F45F
	for <e@80x24.org>; Tue, 30 Apr 2019 22:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbfD3Wt7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Apr 2019 18:49:59 -0400
Received: from mout.gmx.net ([212.227.17.20]:53563 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727459AbfD3Wt6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Apr 2019 18:49:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1556664589;
        bh=xjTVN4ae7VNYuqo5W4G4WftvxL74Mxcy7rRqajjfRuU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=HHoOe9rjCocoj2Zv8gKCQksDme6ElKkZdIER+286E0EqfjyakdSgTUB7Cw4vIx9i+
         RwA0ve3CPRJZ/UJgnG/s3TZPsHkwfHW3zkUNNdTBgL32C7QXFTAblw8OFD8Xpc+KD4
         m3WmEffqscwS9PFcCtAZDvyDMdYPmpH+9hsJgBww=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.96.188] ([12.174.135.204]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M9fLX-1hUB5W1tkt-00CxoB; Wed, 01
 May 2019 00:49:49 +0200
Date:   Tue, 30 Apr 2019 18:49:47 -0400 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase --abort: cleanup refs/rewritten
In-Reply-To: <a3d5dd8c-12a6-a1d8-a41f-ef75c15df024@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1904301848510.45@tvgsbejvaqbjf.bet>
References: <20190426103212.8097-1-phillip.wood123@gmail.com> <nycvar.QRO.7.76.6.1904291207040.45@tvgsbejvaqbjf.bet> <a3d5dd8c-12a6-a1d8-a41f-ef75c15df024@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Xta9uJGUNJx+6M0YqIBX0WJwW2F0wthjfFWSRsY2EH8GOiwEbI1
 NA85VaUDlwobjlVAbx0jBPOyYFJHy6NTRmx+Bb0rHZuH09/Sj7Mn8MZgtuPqZlcjvhBzupF
 DoibG70BHdafNripO+4IVeI+E90nzpj1haJ2dhidov0Tu3QpHm7Zk5kyZ+xB9XyUHvFbM+s
 /xhADYO7Iz11Sb/v/N0PA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iv1t5GZKivg=:+Q80prYqUwK9Oj1MELWTpa
 roj5wxQWL8MU9jKeT7rVKEi8x7Ld6IeW1aCGiIcPaBmuLbb7orFbI2Gxa87d7NCd0VECNyv/9
 scZl92sNBZEjp4gtAASu3Yevw8KRCEcPhLoXlR5hbWmPDfWg3uBD6itL+dVHCkOjxhnGeKrNR
 8ShExprNDFLZo4wLHkHxkSPlBQjpdCxs6hS/RnAE6pEtsCcbz5g0OAa77Gtjd0tuDE1zvtlIZ
 6LQ49wNhK3IZZPaoXrOA8zhKhwXerJc7XyIt23ny79ogHXA1V9t941q6VyStt8Bcb5qmrNJMv
 vIb3cTOMZ7u6EzooMNw6g35giDerpF3WfjQTfn4B9n+IxRx4/Sw2qDpmwY6xUFKQelhGvgpnP
 afl4jlmmFT1RNloP/ble4BaB0+3hiBwfFsVBq7aK+3nxwwiEaCaA1qvK2NfwyvB7j1fiw8VYW
 Pc4YlbSUDkPkxFWr5EzuG03sMv1fHqXArAmegsRgIFzEe81TWSuTfLsPLtNT2ejYYpHyhJPWK
 IFEC05OAuqaaEftrR51ZdAROo6bznkLGbE5qGGUff/tOVmAFwQzQombsA9rhTJnkOeUi9QHcQ
 EKVtMqAbCpRLY8dLVe34yeqliSnmmQ8utVi8v2HPkFkqo/55CMiybzxVZo4yxql4t1z0yzFz/
 vPmYNysx4uFT9afnir7PKrLu2pJEpGWiYlqibRIsKCbyA/mNQL23ik14hG8fWCkFmhZifQT4f
 YellupJOaU466VWRrhN32ZUGfaHEWfVM+R/Z1o+9l61Q5b2OrLuBCTT7hX0paTbJfgedvzoQf
 5PNiGVcgu+6prcog9VNkOo9/MG4b8K1qI7JXlUTPFQvV4yfrPjBpwVteJGuxsLHDH6Ffvzv8W
 dS+yUvRqKH0mBCY67XdKi0uqpk0kD2gMY2UbofzBgEbPOxphKTrS4LBva5oyBKhFU2b4RpUca
 xy0jg+K5Ljw==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Tue, 30 Apr 2019, Phillip Wood wrote:

> On 29/04/2019 17:07, Johannes Schindelin wrote:
> >
> > On Fri, 26 Apr 2019, Phillip Wood wrote:
> >
> > > From: Phillip Wood <phillip.wood@dunelm.org.uk>
> > >
> > > When `rebase -r` finishes it removes any refs under refs/rewritten
> > > that it has created. However if the rebase is aborted these refs are
> > > not removed. This can cause problems for future rebases. For example=
 I
> > > recently wanted to merge a updated version of a topic branch into an
> > > integration branch so ran `rebase -ir` and removed the picks and lab=
el
> > > for the topic branch from the todo list so that
> > >      merge -C <old-merge> topic
> > > would pick up the new version of topic. Unfortunately
> > > refs/rewritten/topic already existed from a previous rebase that had
> > > been aborted so the rebase just used the old topic, not the new one.
> > >
> > > Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> > > ---
> >
> > Makes a ton of sense, and I feel a bit embarrassed that I forgot about
> > that item on my TODO list. The patch looks obviously correct!
>
> Thanks, after I sent it I realized that --quit should probably clear
> refs/rewritten as well, so I'll re-roll with that added. (One could argu=
e that
> a user might want them after quitting the rebase but there is no way to =
clean
> them up safely once we've deleted the state files and I suspect most use=
rs
> would be suprised if they were left laying around)

I am not so sure. `--quit` is essentially all about "leave the state
as-is, but still abort the rebase".

So if I were you, I would *not* remove the `refs/rewritten/` refs in the
`--quit` case.

Ciao,
Dscho
