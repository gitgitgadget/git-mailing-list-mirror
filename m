Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 254E920FD2
	for <e@80x24.org>; Sat,  2 Jul 2016 07:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356AbcGBHcq (ORCPT <rfc822;e@80x24.org>);
	Sat, 2 Jul 2016 03:32:46 -0400
Received: from mout.gmx.net ([212.227.15.19]:53986 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750846AbcGBHcp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jul 2016 03:32:45 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0Md3li-1b11yC0WeI-00IEyu; Sat, 02 Jul 2016 09:25:54
 +0200
Date:	Sat, 2 Jul 2016 09:25:53 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Duy Nguyen <pclouds@gmail.com>
cc:	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/9] Report bugs consistently
In-Reply-To: <CACsJy8A1ZU8VgBYmQAVC6LmXMVgt5CgvC_w0Y7Y6oX88RFO3dw@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1607020924410.12947@virtualbox>
References: <cover.1467199553.git.johannes.schindelin@gmx.de> <8615dc276828a3f99a27ff2eda9909548a7d435e.1467199553.git.johannes.schindelin@gmx.de> <CACsJy8A1ZU8VgBYmQAVC6LmXMVgt5CgvC_w0Y7Y6oX88RFO3dw@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:15ritBNiKfCS4KuWsfKKafQC44SaguAW0yCt9VWhtcYEaQsJy7X
 5pHOjHHy96nqGGz/9+NvJSTry74h1coYEVpW7VZSGNk+bHohp08Hna0w8nroOq71CFSoH6U
 BsxQxbCJREqeBoaRZGvzcmyGXHoRoyPMm7liDV8xGxzlTfIFpJK3VXg7WXtBrZsWCvP4x+l
 Q/NXhF9ZDcPvci0bSPxMw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:4oKwFJy8we0=:CxOnogywmd0d4WU9h+SMy8
 W4KpPH+x7kRjpcntEmLHJ2T0eeeHcZcx6ISv61Tm4e0ygzzJtIXgUBOOSIvjDRHLM4QeNlFSp
 m0rz8qb2aOv1ReCBFlHl9JX6AsfMnGkeBr09Mf+uKYym6wv0rEBhUe1MOFGuEcpX3qWUdExBW
 AKifgaUWe8rmAMOTWwdGFZi9czHhhdokTmy546aab4QDoS44KwJfUjVui+Ov9UIa2QUh3Y3QH
 nF12N6HWl6c/6Wk6XErHBsALt3Ivex4ltJAHI6YxHgtKS/usjTotsgTmvOMhu0hZXMopOV/o1
 pMCMQkmOZaBR5udXEyM5XuIVqg+6s41XyidxDjQTxQqK67BmvAjB2oq1yKD24Y7Q6yoSOPLDJ
 FXDHG8DuitvTtuXIWr3Tsnq/GUlQGrLkHw0NBo7e6AuBuJjsUA6/5XYtLUF/rn4TNO4VyxQzB
 1NQ+Hl0G4v89/z2ZGwQ20DkNXohw4XzwHEuADxK5kBnHmbetQRFznu5uLwmp8fnBRXbDkTkDM
 9m4Dqa7gDHo5jBdBEGaYuwz9YeWDA8RL09NogoTjScgoKbo8NFWvw7/cor4nOuS7Nlfc7Um9O
 nUm+nAj6I3ocaHEIgWgybiCCu0FHJR/2Cp3aVMQrXZg9Y3LtMpgoafP+BFVkNmOicDwsWZDbF
 mhT39Z8RULYfzXHwx5YD4HPQ8X7p+Y4mYTDrD1ZD7IOebgMMofFBl/vDBMcFTpti2SK1f6xWp
 0SPahXivj8dfsxfxvTgpqHoqfrafK1lKSsFU6pM/CBQC/O+UpSEikCwUejW5cmazh4fmPC3Dz
 kFSsS1c
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Duy,

On Sat, 2 Jul 2016, Duy Nguyen wrote:

> On Wed, Jun 29, 2016 at 1:36 PM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> > @@ -955,9 +955,8 @@ static struct merge_file_info merge_file_1(struct merge_options *o,
> >
> >                         if (!sha_eq(a->sha1, b->sha1))
> >                                 result.clean = 0;
> > -               } else {
> > -                       die(_("unsupported object type in the tree"));
> > -               }
> > +               } else
> > +                       die(_("BUG: unsupported object type in the tree"));
> 
> As a message targeting developers, we do not need to mark this for
> translation. There are a couple other _() in this patch that should be
> removed as well.

Yes, Hannes already pointed that out.

My answer is the same: it is not the purpose of this patch series to fix
this, and therefore it retains the previous behavior.

Ciao,
Dscho
