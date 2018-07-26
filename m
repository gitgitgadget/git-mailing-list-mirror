Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E87BE1F597
	for <e@80x24.org>; Thu, 26 Jul 2018 13:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730030AbeGZOvX (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jul 2018 10:51:23 -0400
Received: from mout.gmx.net ([212.227.17.20]:55559 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729873AbeGZOvW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jul 2018 10:51:22 -0400
Received: from [192.168.0.129] ([37.201.195.94]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MP1PX-1fffjS2NeR-006RCf; Thu, 26
 Jul 2018 15:34:17 +0200
Date:   Thu, 26 Jul 2018 15:34:15 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Christian Couder <christian.couder@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC PATCH 0/5] Add delta islands support
In-Reply-To: <20180722054836.28935-1-chriscool@tuxfamily.org>
Message-ID: <nycvar.QRO.7.76.6.1807261533350.71@tvgsbejvaqbjf.bet>
References: <20180722054836.28935-1-chriscool@tuxfamily.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:xhi9kX88KqgFAT8vqhm8xivY1PpuxwxKcHsDRXodtXoZIGEbNYI
 Lede5+dmS7Zu7fHsZ5cJ39dRGQNUclODgALNiEkU+3ZAikBggkMztNwVZl4te2XnR2c9ed2
 h9yrrq8omvvYFqXYoLds9PF4dp8VcEJoBz8rwaW8/mOhwZFZ2g1UPcuYLo6uTLp1Awxc3ci
 0kD2li7DX9gt2qv/aPVKg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:r12d4BFIowc=:wP7d6D28rWv0miUlD2qP9H
 uahDCV04FwGRuaj4cNw08jM2MXjFIm2JmHRyF23Rmjh3oeuf/c7SnW66db0bIg/PVV2d8OG1v
 5B//HvjekMKsuXy25EnRoAMSpZUOBTfs5sLGDBzKAjFyp2Eb3s/404KEnENWUzCikBap09uxQ
 5ExZk10ipetCHqxXzbKvTx4ecgbr2FPcsO5ZeSAIHp14tf3L/cjw+LENz0C2cE2JjjV37OzdO
 I5T3kZSiG5ennhlDRnBQBTVSuvYoIxVriWHY6q8JEGPhOQfDsPoSdmUCJA7cxPiRHRreOXobT
 wQJV71KsQZqOYQKWKWkUfCCOd+AGLb8flWXhQa6rRlqmnhlFqzl1pVRCUEFRIjEQpqD6SIgVb
 oxz4jEkOeYyHC0//b7/zLJgTJ5BDqK3Au5slb07YVmX29I6QKsIWnUujLUjLr9Zmd0yrz7ay/
 S7S+ww/jootdtUFNcrSdOEKaABxCo2Mz7CF4Kz1qgB37IRYBDaefQf+6XaUO8rWxhgxv5Fv2f
 gY3QBmCdNDYvF4WUavOrVE7WLubVIs6kgASPB1wTPWEp5VcjDJT+O/lQJxFM+Zg7M5JtiiJbw
 sqkHGHmmtcG9InErPljWWG4EgOqtoc12V+3NouBL7GTkW9NucZxQjtNAMjzGCPeVzQGcyWViD
 SigGhCXD43RsMiCa1XYgdyiiNAHUb/XW77jMry+FWV7My6MZOXcXXYBjHeVTFfMbsOC60Y45j
 nUKVsSt/dKo57b0SmCXbfvCK9jHMQLGBqJJYD8Kn4HYSbFoDXz3HFGQIVJwZ+zOv8QPn4oUyq
 RZPV8K/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Chris,


On Sun, 22 Jul 2018, Christian Couder wrote:

> This patch series is upstreaming work made by GitHub and available in:
> 
> https://github.com/peff/git/commits/jk/delta-islands
> 
> The patch in the above branch has been split into 5 patches with their
> own new commit message, but no other change has been made.
> 
> I kept Peff as the author and took the liberty to add his
> Signed-off-by to all the patches.
> 
> The patches look good to me except perhaps that "pack.islandCore" is
> not documented. Maybe something could be added in
> Documentation/technical/ too, or maybe improving commit messages could
> be enough.
> 
> Anyway I wanted to send this nearly "as is" first to get early
> feedback about what should be done.
> 
> This patch series is also available on GitHub in:
> 
> https://github.com/chriscool/git/commits/delta-islands

It might make sense to explain *somewhere* in the cover letter what the
patches are all about, i.e. what problem they are supposed to solve. I did
not see any indication here.

Ciao,
Dscho

> 
> Jeff King (5):
>   packfile: make get_delta_base() non static
>   Add delta-islands.{c,h}
>   pack-objects: add delta-islands support
>   repack: add delta-islands support
>   t: add t9930-delta-islands.sh
> 
>  Documentation/config.txt           |   8 +
>  Documentation/git-pack-objects.txt |  88 ++++++
>  Documentation/git-repack.txt       |   5 +
>  Makefile                           |   1 +
>  builtin/pack-objects.c             | 130 +++++---
>  builtin/repack.c                   |   9 +
>  delta-islands.c                    | 490 +++++++++++++++++++++++++++++
>  delta-islands.h                    |  11 +
>  pack-objects.h                     |   4 +
>  packfile.c                         |  10 +-
>  packfile.h                         |   3 +
>  t/t9930-delta-islands.sh           | 143 +++++++++
>  12 files changed, 856 insertions(+), 46 deletions(-)
>  create mode 100644 delta-islands.c
>  create mode 100644 delta-islands.h
>  create mode 100755 t/t9930-delta-islands.sh
> 
> -- 
> 2.18.0.237.gffdb1dbdaa
> 
> 
