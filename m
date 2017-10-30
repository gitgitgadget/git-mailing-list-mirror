Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BC37202DD
	for <e@80x24.org>; Mon, 30 Oct 2017 17:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932615AbdJ3RcE (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 13:32:04 -0400
Received: from mout.gmx.net ([212.227.15.15]:60656 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932476AbdJ3RcD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 13:32:03 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LgptO-1dLIeR0FpW-00oHoi; Mon, 30
 Oct 2017 18:31:57 +0100
Date:   Mon, 30 Oct 2017 18:31:56 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>
cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2017, #07; Mon, 30)
In-Reply-To: <xmqqr2tl40pl.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1710301830210.6482@virtualbox>
References: <xmqqr2tl40pl.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ckAIPQTw5BnNlXbjqo+Vm7tx9wZ9dRY43Cdvx0SjxBDniMMtThR
 ZdgTUUfIb36X/lOJWT6ei7kxZTPgadKL1Wna0aWLcTQ9euLCQAxUJ0+kS0kY69dPXipd+OX
 INh3BBQqVdL5tkH8kxMVObD3kwVP+/xd8dwhfJt0MuBElcqmnc1Bdypm4rbaoBt8LeFeNLJ
 jLheVS/9BhgrrsqbzJZyA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:F7pve3OsopE=:BUEYbwoJJHLsBznhPLKBxq
 oE8wMX86e5ctEdeEb1QvEPNJkmlvw5arCRAzcfyHlQbC1WX2XTzzQSG5nilQoiaL8Z6zPVO+M
 SDTx2kwDh5xhnRF7eMKT4R4AmRb75B4hxKKMY67faKmZ/yuQgY2G9q1B/TAYKQC78HT8OeF6f
 NXHaKb+oGO/HSqKgVR5ujwVLkr3zM47hzvN5cMN7AzqrSPtAYC7sFSGdfCuvibVydCnOfYawu
 ePylxirbRb/yVWF5778FukldA5kxxg11Xkx1noBE+XpmkDn2r+YZRjRgn2LIRU8g3MU9lNEu7
 loH3kHCuOKf0QEUN7zrROU+xRyJJtDIxOBiG5hv6xIYhV8W3idjL95zMvHwDaNsWG3N7bFBRX
 5tPkpZE8//JmbgVONBzszMxMkTkalbWz++S71INrO/ZKlv++9HrzFDw5GJogZOplZ1k1TIKfs
 BAVbWKTopYoTjxB0kqdb4T1Alhbhsj9rzFnGutJDUMR3/pPTtOGhQDqAkholI6tMWUoDxMXe9
 1Dmisz7RD4tfzeNLGh8ylp0NE2tB6mTrDYHagNEa263TjwjOp4XDYh+lakEHmbMfbyT407h2+
 9HW2nxLF5u6nYLi1KY2oKtmvolVryCL5nvPwXk+3YOeBKaV8zZLdjLEJ86obyWublQ/EbeXxW
 UnHDjt9QUh/xZH/dAEN5hZn7PdLNxMCYg9lVR/nOkApzqlhddgaAexz3m/72yzUf90Y80W1lG
 3UD1qozB6Trj8Wk1IQLfQkE8v9PDN4/HX48X9z5VZLb56FBjiFAzSUnjhu82pStuNSWwRgg6e
 pdAbvLMFgyu47ZEMFnlLQdSrzbib33Du/pBW8AHYmi/fixlF3E/KP98n+KGc3lwzV92WCow
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 30 Oct 2017, Junio C Hamano wrote:

> * jt/partial-clone-lazy-fetch (2017-10-02) 18 commits
>  - fetch-pack: restore save_commit_buffer after use
>  - unpack-trees: batch fetching of missing blobs
>  - clone: configure blobmaxbytes in created repos
>  - clone: support excluding large blobs
>  - fetch: support excluding large blobs
>  - fetch: refactor calculation of remote list
>  - fetch-pack: support excluding large blobs
>  - pack-objects: support --blob-max-bytes
>  - pack-objects: rename want_.* to ignore_.*
>  - gc: do not repack promisor packfiles
>  - rev-list: support termination at promisor objects
>  - sha1_file: support lazily fetching missing objects
>  - introduce fetch-object: fetch one promisor object
>  - index-pack: refactor writing of .keep files
>  - fsck: support promisor objects as CLI argument
>  - fsck: support referenced promisor objects
>  - fsck: support refs pointing to promisor objects
>  - fsck: introduce partialclone extension
> 
>  A journey for "git clone" and "git fetch" to become "lazier" by
>  depending more on its remote repository---this is the beginning of
>  it.
> 
>  Expecting a reroll.
>  cf. <CAGf8dgLu-TeK8KbHv-U+18O+L2TxKcGv5vFFHy38J6a_YXRfew@mail.gmail.com>

It was my understanding that Jeff's heavy-lifting produced a shorter,
initial patch series with parts of this, that was already reviewed
internally by Jonathan.

Am I mistaken?

Ciao,
Dscho
