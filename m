Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 021041F516
	for <e@80x24.org>; Tue, 26 Jun 2018 22:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932107AbeFZWMR (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 18:12:17 -0400
Received: from mout.gmx.net ([212.227.17.22]:54859 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751989AbeFZWMQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 18:12:16 -0400
Received: from [192.168.0.129] ([37.201.195.74]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MJjUO-1fZ2el0LZs-001DRa; Wed, 27
 Jun 2018 00:12:11 +0200
Date:   Wed, 27 Jun 2018 00:12:11 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
cc:     git@vger.kernel.org, joel@teichroeb.net, gitster@pobox.com
Subject: Re: [PATCH v6 0/4] stash: Convert some `git stash` commands to a
 builtin
In-Reply-To: <cover.1529943789.git.ungureanupaulsebastian@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1806270011441.21419@tvgsbejvaqbjf.bet>
References: <20180405022810.15796-1-joel@teichroeb.net> <cover.1529943789.git.ungureanupaulsebastian@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:JQ6AKhWlnUBp9ThLYsLNt1eP7G/ARJ2rhL0qjCgO+SZcJU5k0rB
 T1Iyv+yKC0zzYCGuzdiRw6bcc89gJtbX1zDgSHy/IJGbmXBY1gF0GV+tHwkpI4bKEvmIBeL
 /DH8aou9VeyPTuuH0EVWNFCYHnp1r6M8FZLcvLfzTxYc0Ae148Tub9+pUtAKVOqI9npqJHu
 kPV8u+Jz63ROiewkdLT+w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZXXpN58bCjU=:alPgalrzZQ98qrDCFw+rO2
 AkUmFeZSRZLEo027mJ+uJ2vRcsBuk/NI8bDuK32FxaH3XumoHYnIXAEPJ8naJz2Kwf0OFs8oE
 VZyveXKijrp531egMr3JLz9s5gH+PMbs2KIkPc8892c99azfNkMco86rG1I0tY3Jz9Jqtdv23
 bjMG7pV3kAVAV+vCpiBa45EXBo5xFYMyTfIdv7Vsj/FsyPFua0M79CSitN51gb95dhhVvNm6O
 gjUzwJOSqTppxElhMHhxeAm7W0CMpEVnaYPesAw3kGOoAbBLjVd5lKdRzPVE/KREyJdQtKVlR
 AWWcilP3jdm/5gQlaO9wi4y7+3tgePb1OTowhQD4J23QWfx1YL64Bb54J3XfOe8NPkkOvfHGV
 +/dXYF4zNuwuNdef+vmKLIv9ug0FV2rEIj4L4g8UwLA6qAdv93oOcVFlJhETj03Jaa6oon/ip
 vg7RPNtlry5jtiYjVRDyGVjd0ULDWgr+1LRHwEGEDJooxN6dyL2SD6090xza1wwSgeYQj90PM
 iNFM8Q6hrvgU3lMAXii1v854IS2t3IBXkf1ofncev+eIBmQrifTY4tD/yQbCXtowXHQze/GU+
 Hvtf33Rx61qINcGBeSoePW9ej83hoJQLiZ0oPu4/Srz/Q4PPOpexS5xg1rSxxD3+eBBlUEiKM
 CX3cnOGRZ705Qe7HU+6gLlo10t0bAZixHyf6oq22CEIwu3HpDVPMht4Ddjkx6XV3SuyVdNwuU
 sfqAZrLERLjdDHvcuH1x6txpEdNlt1zkAc5FaJnZzMvLAPorToV4+b76SIG+n5U5Hgk4gnRQU
 ZXbvxJX
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Paul,

On Mon, 25 Jun 2018, Paul-Sebastian Ungureanu wrote:

> This second series of patches contains commits to convert `apply`, `drop`,
> `clear`, `branch`, `pop` stash subcommands to builtins.
> 
> 
> Joel Teichroeb (4):
>   stash: convert apply to builtin
>   stash: convert drop and clear to builtin
>   stash: convert branch to builtin
>   stash: convert pop to builtin

Were there any changes since v5 in these patches?

Ciao,
Dscho
