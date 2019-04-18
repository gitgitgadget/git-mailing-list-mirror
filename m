Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19CD920248
	for <e@80x24.org>; Thu, 18 Apr 2019 12:17:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388749AbfDRMRO (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Apr 2019 08:17:14 -0400
Received: from mout.gmx.net ([212.227.17.21]:59351 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387519AbfDRMRO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Apr 2019 08:17:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1555589827;
        bh=4k2F9cHGYfVBGgF1Va5uTdWFdIhA8QED+UT9O76HKJ0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=izGFAEaYuRNZURgEDmirLxEWW3vh1hrlVLS2GpqmGiWfuXDlM69wky7YgTjMjlD5i
         GVHnZtY586DMhJfkIj9bPkcWaITJANpFzI0MqfldwxexmrhTGVYWjTCfisD/NZ2IGY
         PO8W+Wfmp3AdLpts+mPuwC6vqG+JkF2tTtbsZbAk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M6B6s-1gtWO12Jhq-00y79B; Thu, 18
 Apr 2019 14:17:07 +0200
Date:   Thu, 18 Apr 2019 14:17:12 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 7/7] Turn `git serve` into a test helper
In-Reply-To: <xmqqa7grqsbt.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1904181416250.46@tvgsbejvaqbjf.bet>
References: <pull.168.git.gitgitgadget@gmail.com> <411587e4b80bd4e5a1cb9b1ec438cda7a0681465.1555070430.git.gitgitgadget@gmail.com> <xmqqa7grqsbt.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:3XYSccxYmqqTBReBL0QUlNiuaxk0ocnhcAI/P65qR0dncLVfFtP
 //Gd7CRPs0tZasTiGMJas2xHLhGVM0BtuT6hNRQ3LP7GzrlLA04XcK71E92/vkL+Rc4XmMe
 soUbjp0DjFPipmeZxdla1ug77FWKF7L5mPilt06/78nL4n+yxvJ6zYeXEZ4jZpb58/zSrvq
 0ccVDxiE6M/hKoI3O2/nw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Qy0dvqMnIhQ=:I3gj2xUaHda2zsncSck3Ub
 QMBKAmKc+ojSmiXw3oV0oiOgO8L771MuOGK1l97ttpkfIb4B2kfsMHbIe42becrhZoGeP+lhL
 0b+AdGRvDuNiIr06wk5XI6J8qa+c0lO5amsAkamsGgg5XrjrlhX0hh6tDr5YUUh9eURDeQgog
 wjKSf+Q6lisSuV6XbeS4TRbdsuE3Fbii2nx19H8ucnTvW+jZNAhiNxNk5/8WtUxLsROxBUhKO
 ypw8Ia8Jv88+6MxqtmDgO/GKfpC3HNVJjE20+ib7oW/8J5bsd3bgjM2n8CJGeM6oz+xLkb6o6
 7LToSQ7lW2SpuqtE9hL/htq3cC9gZJvH1Vop6SnTP3mRkisTou5A2fPMrOquluImW1ZefZrUO
 o4N062TKOuPu+CbcJzlMqMCkXBlyiu7SaiD4AWQh5ZyEUMIErUZHRqWLGjPcmtsAuVHdfdunB
 inkBjNd53fxBh/gNGadkrB6lv/uYK/gzt16/POB9Yd9/BzmhK3+nDDDuy35ZkHQfGWN3JMHnh
 mYw37+uVl6SSbEsrRUXxNw5R6bybGZXaSThoTcUAw28lWMS5FuvWaSM0T4VFhYC+p9PHraT/0
 uBjY/cpHc2UtFfcduiOnckNX9U1hOF4APF8w7srjMyXL5NXhd8jkzBWgGjCC1yW/LrUaVSuWX
 lWIakLYUlu8XUIDDBKJkQyX4L+ry9qK2UPBd8VRV4FA7a9Mkyt/L0QLpfBw7SWAvWc5/LtZBM
 KL5Ko0gjCirB52gmHwdFDXr5zthmyKdtBctbpIGK/9H/3V2/qhCHYk2DjCvP6HjzQzAYbUw6i
 wssCLzbKgnhroIePIdu8mEH5BCPKPPL9+PXa0d1T2FvzAD2Y59DwQGVZWf3OhUqQzbUUIeEdr
 jNZSKqisrAFoQnzcXQ4sMsmDm15K4CUuu7h4LnqtdqnFy9h6NyhICexhdsI066F8iIMSNZPRF
 TF2PYczZFFw==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 15 Apr 2019, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > The `git serve` built-in was introduced in ed10cb952d31 (serve:
> > introduce git-serve, 2018-03-15) as a backend to serve Git protocol v2=
,
> > probably originally intended to be spawned by `git upload-pack`.
> >
> > However, in the version that the protocol v2 patches made it into core
> > Git, `git upload-pack` calls the `serve()` function directly instead o=
f
> > spawning `git serve`; The only reason in life for `git serve` to survi=
ve
> > as a built-in command is to provide a way to test the protocol v2
> > functionality.
> >
> > Meaning that it does not even have to be a built-in that is installed
> > with end-user facing Git installations, but it can be a test helper
> > instead.
> >
> > Let's make it so.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> I've excluded this step from tonight's pushout, as I would want to
                                         ^^^^^^^

Would you be surprised that I first read this as "pu shout"?

> hear from the people on the other side who have (once) thought that
> this was an addition we would want to have, before we remove/demote
> it.
>
> I do not personally think, as the design of v2 stands, a standalone
> "serve" server that "can serve anything as long as it goes over
> protocol v2" makes much sense, but perhaps those who have been doing
> the v2 work may have different ideas, in which case let's hear what
> their plans are.

As this has been resolved in the meantime, I'll just leave it as-is.

Ciao,
Dscho
