Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DECF51FCC7
	for <e@80x24.org>; Thu, 22 Dec 2016 23:07:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941727AbcLVXHh (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Dec 2016 18:07:37 -0500
Received: from mout.gmx.net ([212.227.17.20]:55672 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756845AbcLVXHh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2016 18:07:37 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LlleO-1ctXD32rFQ-00ZM92; Fri, 23
 Dec 2016 00:07:33 +0100
Date:   Fri, 23 Dec 2016 00:07:19 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Daniel Chumak <chumak.daniel.dev@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: Feature request: git rebase --no-edit --continue
In-Reply-To: <6ff2c5a3-fe81-0bec-ad9a-d62bdb4a176f@gmail.com>
Message-ID: <alpine.DEB.2.20.1612230006530.155951@virtualbox>
References: <6ff2c5a3-fe81-0bec-ad9a-d62bdb4a176f@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:2lCiKyz/fw3IvUjWCWOhHfadLTESn4AJ11eE6r13TKqc1lnmSjc
 3sFKAUCQK0jhXOw1Cym0uU2NdHyTMvIE6YYYWmsibto9N94ScJWEiPyrLz4VPrneX1s2/Ds
 xDhW39RIawXzbCs2/CuE685QFvX/gGz3xdwlJnd5byA//z22O+I0x24PRsZStnVr5/581+p
 Ia3AbDEKQZtpOFI1LSKsQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xC0PoluGx/c=:oRAeSZqAzwcsf9rt7nsx7q
 VQnL8iXdpicqDF3R0rGa2gDgGRL2eBS5vLKUYIZYn/SVF1zCMbxuTsZmJi1YRbJO9WWszWarO
 l8dFuciPXb5N+KvOILGjGrqF+aFFQk4VZl2gbMoRwfIikPKNObt1fJXCMz0759lAd0n0CRB7x
 EDvx/3YtH6c+3EkoYNE4E5y5Anf2lcuwBZDz4RxLcqSVkrNIAGmh31lQrh3bBc+PD7iVisekz
 /U60Xqk/NRuVwGd2cjA1wskgdvPni6ZdGF1NnucS6T7+EmkDQgVPW9hh79E7yyhcFTWGY4hGU
 FY2Jxh4cBAZjMm4CuoViMAJoOdBmqCk3ZwdRvIWjFwhGtX/+58LHaKh1JzbgZIgmNBl1Kr7U/
 yYDVF7KHx5acEp9bPnwjso44dUXvgJkvOcFSMwVMm3IqZcKdDbm60Qa+sRg/DC7SkT+TipSjr
 iW3SC042i/WWLy+sL9QehKdPHumfSLmdIxKbth3s5lKB6lvOZCVz/5fGM5YuWx9RB76y5DkiS
 MtDIB9PcFxW8AnswVUP6E6BOv6+LshuY1y5KsJXqH25yUI7f9U5QdF2BoR9gHcs0CGdrd2v69
 Z1sSPdI4vJAzhDfRm9jBlb/FQQZrhrlRUPuyF9xhWfF8jxXIcSMmeh0zMm21v5/kJkm6X2a7O
 Wa8UTL2spQpCptBUjuAIG31zMsJu+6kVoFlm3hu0RtIMUxLOFfAl892qqC19PXPZczRRm3YX4
 brPX0fLVzZVeKZSmOBClBAXzRd/pMuvkf/4O0WzdFM54LH9aOtnwMu6RUb3BYBgGTZx4GrWN5
 Lhjw+17
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Daniel,

On Thu, 22 Dec 2016, Daniel Chumak wrote:

> Is there a reason why there is no '--no-edit' option for git rebase? I would
> like to use this option after editing a commit and continuing the current
> interactive rebase without having to change the commit message.

Why not

	git commit -C HEAD && git rebase --continue

?

Ciao,
Johannes
