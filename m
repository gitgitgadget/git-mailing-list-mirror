Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D425D203C2
	for <e@80x24.org>; Thu, 21 Jul 2016 14:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751555AbcGUOUO (ORCPT <rfc822;e@80x24.org>);
	Thu, 21 Jul 2016 10:20:14 -0400
Received: from mout.gmx.net ([212.227.17.21]:51009 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750856AbcGUOUM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2016 10:20:12 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MdoR7-1bgvIo0FTR-00PeCA; Thu, 21 Jul 2016 16:19:59
 +0200
Date:	Thu, 21 Jul 2016 16:19:13 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	Jeff Hostetler <jeffhost@microsoft.com>, git@vger.kernel.org,
	peff@peff.net
Subject: Re: [PATCH v1 3/6] Per-file output for Porcelain Status V2
In-Reply-To: <xmqqoa5sc9ud.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1607211616320.14111@virtualbox>
References: <1468966258-11191-1-git-send-email-jeffhost@microsoft.com> <1468966258-11191-4-git-send-email-jeffhost@microsoft.com> <xmqqoa5sc9ud.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:u8zg7tbYA7Q4Bwwr80Cb5w12QL1UtF2X8B/Hn6+vFHuqCChMM5I
 MMH2hyQKJktkLng+djn5lW1LrCwm7EbUC08eyKT9m0JTQj440EdaMCfN5U3mcoFru/1XejI
 ayYmd0ASqgWO2YmBdZkdL5bS+Cd3vIMDVJBsRQCW13GrzjWL3NxLGQ4Fjjw2w41uJvLAeoH
 Hg2TMT0cl/9PjZOlX9i5w==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:m+bWDmVFJVc=:WQVr/TGG1rd/6lqNxZAcgQ
 2jVFFRdNe+agPbifwz1bvQfzw4sZ0DscceY6JTMFt7FJBN4uwlvMZob0lSK5C/bJqbNqNBJQN
 6qcTdTdvyZQqwMugk1jLd3ia1l7Z+xVgCl9kR8PhHLtZCYoaSJKTBRFxlga8fnELBXPEyc+C+
 riMvM+a/wil4fMnIExJj90q6U/fKJGUnPv+nUUIB1AlkiyWnQj2VJcidXC5/tKndi8vV2eDll
 u0TrzD6x5t4tFT/YSy83fzzo0d1+ryMBwbJjGJ7PmZPg4lkhhNrB4FeeqGm6TbLa7HHkNUuPn
 ZZ+RFvFnaGUrvHGhuXkHCZId97l0d8qipIXFpmU6YZVv7ivqmNXC3AyooASgJ1UHZ/yvb1Jc/
 ZA6sXyCSU4y3BJ+melsU8PioSPZXZOJeefg6W1TGUNjNxpTijr/i3M2EmxCdUdpjGPJ3ownZg
 4Y141FB0xbnPys0qUZix/Xc7SUq/isnBDhhbBFXQiKKULRthh8WmanbpOrWDymEYug7Y46kLK
 ry551BN58P5zO8Ntf7fShz3txN4JBx/Njg86atVpwx7Sil690Ko9d/DrqHv3EWs6x6cHKkksQ
 AH2Sl79vxRSUV9cqoo8IS3Ms7lVLKYmxRW2zKyGjciFr+NVOPaz2nWbgiqEw70fgudc2HtZ/b
 mLsGxrQAJfgC9L9OKkEy1Ngngv07pV39ctjqJ94qItyGadMCbtJ6gpiUxKKb7YmT3DvRihcYg
 nsrj6QXaOD4HNH9reWDVK6hiTEOEohRzan8O0BzOBav2iH+P+9KtC7RbQJObkiskNM0PpR7nD
 xv33PLq
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi,

On Wed, 20 Jul 2016, Junio C Hamano wrote:

> Jeff Hostetler <jeffhost@microsoft.com> writes:
> 
> Just to avoid later headaches...  please look at your commit titles
> and imagine how they will look when listed among 400+ other changes
> when they are included in a future release in "git shortlog" output.
> 
> > Subject: Re: [PATCH v1 3/6] Per-file output for Porcelain Status V2
> 
> Subject: status: per-file output for --porcelain=v2
> 
> or something like that, perhaps?
> 
> > This commit sets up version 2 porcelain status and
> > defines the format of detail lines.  This includes
> > the usual XY and pathname fields.  It adds the various
> > file modes and SHAs and the rename score.  For regular
> > entries these values reflect the head, index and
> > worktree. For unmerged entries these values reflect
> > the stage 1, 2, and 3 values.
> 
> Also, we usually do not say "This commit does this and that".
> 
> See Documentation/SubmittingPatches for more details regarding the
> above two points (and more).

Maybe something like this:

-- snipsnap --
status: per-file output for --porcelain=2

The output of `git status --porcelain` leaves out many details that,
say, an IDE would need to know about the current status.

Let's introduce version porcelain status v2 that adds the various file
modes and SHAs and the rename score. For regular entries these values
reflect the head, index and worktree. For unmerged entries these values
reflect the stage 1, 2, and 3 values.
