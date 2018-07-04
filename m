Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EDC11F6AC
	for <e@80x24.org>; Wed,  4 Jul 2018 19:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752897AbeGDTdM (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Jul 2018 15:33:12 -0400
Received: from mout.gmx.net ([212.227.17.22]:48877 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752653AbeGDTdL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jul 2018 15:33:11 -0400
Received: from [192.168.0.129] ([37.201.195.74]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M96Jd-1fOP2p3pMb-00CNop; Wed, 04
 Jul 2018 21:33:03 +0200
Date:   Wed, 4 Jul 2018 21:32:46 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Tobias Klauser <tklauser@distanz.ch>
cc:     git@vger.kernel.org, gitster@pobox.com, dana <dana@dana.is>,
        Wink Saville <wink@saville.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: Re: [PATCH] git-rebase--{interactive,preserve-merges}: fix formatting
 of todo help message
In-Reply-To: <20180704141635.GH24016@distanz.ch>
Message-ID: <nycvar.QRO.7.76.6.1807042131460.75@tvgsbejvaqbjf.bet>
References: <1530706658-20519-1-git-send-email-tklauser@distanz.ch> <nycvar.QRO.7.76.6.1807041505000.75@tvgsbejvaqbjf.bet> <20180704141635.GH24016@distanz.ch>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ZuRPx6UjOaNvWLYd9Loo+R9lozgPvE3fH8onGwbSAf89z8MO5Q8
 6YKjKXij6S4KgE4KdJ6FmphHdmIhF24x/LKuL4symu1jSdCmUeQ9fkLcxioeIV2GfFiEyXe
 EH2xye3KVLA/sURQSlNbnkDCQQcqCFSkVkF92F3GF9Ibze7W7vYqt+4tsqNZyMDVrt9Y3bq
 07465eqssQ5wc38JPkDXQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mOd6OUnI1qM=:3OYt5ow2rgHlif/HJwZMO7
 WQsKcSi+Ab1KiTpa/Galmbv7RNAQobapQ7qJ020x886TjGTFgL3s+/UvOVN3AHUTYVfISkjJ1
 E5IJmjs9HI+2+qjZnNZ8bZFpm/IDS/0KPhfPPWf86B7tyOsl4lhKunUeVrhcCFrIype8mNqzM
 oxRhQEzwG62O7etQ/rkiSxuMJq8FYO2jigmtOMcUi14t+WYzwgTA5+s+rsyiqPL7j8EFkaK9m
 BTrZ3jZB6VLKX4yqH2CbHp1JjGiPpoSi9BPrJD9rx552o4ndmlK0iGFVPJGyxy9YyPyxO4GvE
 9KCpuPE21mQM+iY+TlVTSHcPxmY+jTn32Fem8HW5vS1yYDZq55/Nj2vqEssQYwRXQxBzzzxnO
 5ZKTKrpaXoRAO9TOKeUBFFTX84Fu2ZGjZum+WbbgewGfdYa24AQUlhD58flrl8pOlksqHtRVu
 cGIn/JD7nZ0xyFKU1/6fDmSw+aH8Ca+KV+eD4+mY3el4MMd07dUVQkbFmbQ38e5SVYLAKsqyd
 prkCqyHPeZGMuxlg5ld5WBT0UBsTGZIK9QhtDA/KzQJrOdYYdPBOgdawAVvwb2IFkCOQAJaJx
 OEDdelTAWI2LNI/fC433wcAmwYI+w3JzVhxKMkmeBiTAJ8jzLnEQe5DIr36xGqw0qh/vi0Gku
 berUfwxIg5mOt9sa4znFw17+fUwmF+4JygSTe8l2P5c8IDSzGhR/hvZpMmHwSU4uJhD5Kwwji
 GJ6K/HNXIqIuFFGpx0n/XY+YiYpEWchckW7c11QE3oHA0SstVHmcUF2Q4M/YfyfZRs07ewcrv
 zuqdCeA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Tobias,

On Wed, 4 Jul 2018, Tobias Klauser wrote:

> On 2018-07-04 at 15:09:34 +0200, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> > Junio, this gets an ACK from me, could you apply the
> > `git-rebase--preserve-merges.sh` part selectively, please?
> 
> Let me know if I should provide an updated patch just for
> git-rebase--preserve-merges.sh

I think we'll have to wait for tomorrow to get an answer to this; today is
a holiday in the States.

Ciao,
Johannes
