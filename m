Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24D961F403
	for <e@80x24.org>; Sun, 10 Jun 2018 16:08:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753507AbeFJQIU (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Jun 2018 12:08:20 -0400
Received: from mout.web.de ([212.227.15.14]:46525 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752158AbeFJQIT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jun 2018 12:08:19 -0400
Received: from localhost ([213.64.64.87]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LdalO-1gAlYh0FQQ-00inxM for
 <git@vger.kernel.org>; Sun, 10 Jun 2018 18:08:17 +0200
Date:   Sun, 10 Jun 2018 18:11:53 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     git@vger.kernel.org
Subject: Re: Why is there no force pull?
Message-ID: <20180610161153.GA27202@atze2.lan>
References: <20180609190154.yl4ig6dxfihgm5qi@christoph-lap>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180609190154.yl4ig6dxfihgm5qi@christoph-lap>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K1:AWPVPwhWum4MPiMs8WePezz32pZD0Bb0msZWhu89Q5PQqnJVWPz
 DYRzj2QR6FZfPHSoVYNWav82ffFNzbGrSLK/Px9fAq15Fuv/0GXtOl0LiS3P0ypkxvoslkQ
 WK6/C84PwzHsHEXcwmkovqo2TWBr9UQpqyZmcDixAJw9j9z3Qm6cdO461v6vLBxo7w/Ioak
 q8WS1suD5zaDmrpMfzyjg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:B7Tm2cWg8+I=:QHSD9zISHNdE4Z0MmmYWlX
 g+2zzoCVzjxq3iTfX9fY12K90bhfCbQESFeg7XP/2+9wYqv6MRKsyD8bfjCGVfNuLigIGka3R
 YTsl6a3rEI/6eoJRNxNKy8fgyq8lODeMYCXHGh8GLQ8Jn1RnM2RYjtqpLfwrmIvdqx1+7rYFn
 XuZ+MEf3PCngGw+l+2ydGGQEbe4M1Qg8H0WgHcusBGmGglO02i7OeCMg8ip7Wn2r4EiwWZc5T
 bN5st/ULF0+dBvXvkHNIezSFL1GQJ+iQllfxt6r+pz123a/iL/tqsaxkbxkXLSsWMGUPibzRy
 RYvkmKSJpWQ3ajCouQ/PxOkhdjXbKY38EzT7R6GsQXFF8Wul9eNJJP4MfaZhjGB0XMgKWlr75
 Pb0wmxKdu/2k8eJlHHb5pC7RbMvyraXdt9pFsGq+Iu4w0BlVHPuIHcYYxpk4KWWgwygsOxIPF
 LFGLHL3/5m4Qu1/jiDwCwBh0It8EapHnOLHGx4Qr5rkpR93QPTENHb/r/fZX5k7EAlDBaO2hg
 YOLK0eXVeNkB02MA4RQ1UTS5c57RUBYxRq+E+a3PrDD91rfO58NH+EBRPYuowRQV0eb2d7Z/w
 M3RHyrphugzVYl4hHjH2EG+flMwYpMj4QlJpNE9Z2hkKgx34UvVGpwD+8pJmdFXZYWV/BfjDw
 SXPFkt1Mjbd4DFcVSO5IDTtaEn+F3+Twdr4SYxCnJng0KOVZhVMBMSTnN7VmcKUzGjAnPpsm2
 f/a+VQX4qmkC4/ysHoCBk8yuY6fFIPHVk+NNML+v2gtqJWQGdkCp8f8i3u4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 09, 2018 at 09:01:54PM +0200, Christoph Böhmwalder wrote:
> Hi,
> 
> Since this is a use case that actually comes up quite often in
> day-to-day use, especially among git beginners, I was wondering: is
> there a specific reason why a command like "fetch changes from remote,
> overwriting everything in my current working directory including all
> commits I've made" doesn't exist? Now, I'm quite aware that something
> like
> 
>     $ git fetch origin/branch
>     $ git reset --hard origin/branch

This is not exactly what you askeded for, but I tend not to recommend
people using "git reset --hard" at all.
Either use a "stash", just in case.

Or, in your case:
$ git fetch origin  && git checkout origin/branch

This will put your working tree onto origin/branch.

As a bonus, in case that you have done commits, which are now no longer
visible, "git reflog" is typically able to find them.
