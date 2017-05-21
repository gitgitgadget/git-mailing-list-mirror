Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BD37201A7
	for <e@80x24.org>; Sun, 21 May 2017 06:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751351AbdEUGSB (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 May 2017 02:18:01 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:35084 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751292AbdEUGR7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 May 2017 02:17:59 -0400
Received: by mail-it0-f41.google.com with SMTP id c15so137256424ith.0
        for <git@vger.kernel.org>; Sat, 20 May 2017 23:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OD8rHo3M1PRlSPcxrLj+e20BLFVXBQA3twd0dfQKDHc=;
        b=RDcBGB3213QoJrrZnfrQnJ0WnyzIcWBrHKKcbViw3ygE+OLikuKRvcPvVjTgM8VU7W
         AZwvVtZ2th/MdGAhJupfHPvY4VznDgZ8YbMiSCWgVsWcwlvk8OklM2R1cEca876OBiIJ
         MRXJ8vHuneW0uQYDqzTAUdxbIpI9yHfDpMmY43lbuVB+WZsAthYIo2rniTEeMoZY0Zbq
         1YzWCIQF3pYk3M+ws9c4sSAvYw/QpAhczhDs2cEwifLvRDfzHXUovAZ/d0fxXm7kVoiZ
         amG2r+bhRbnxFcftodPOOWIeoRrUvoyEPhNGkkwvl1cx1jfyqdVUkVAA+DgirKl3Z5NH
         cOaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OD8rHo3M1PRlSPcxrLj+e20BLFVXBQA3twd0dfQKDHc=;
        b=RA+Co8DJEHODzS8sefJ71QmoNeFZEvekIJ9uOqoRlSs7xIJJm6S4EqkyUrQIhhy9Gk
         V2emtCHzKtIjWUaXv/jjzJ43kOgSuQa357AVGEy1Z6xK2qzBGXN0omscuOCCpFIJpsv0
         SCDB/Wb/0ssQmBhSfqyjgcs6aPwGHg9Ai2AaimZEfqcc/mm/+mSW87L8PsGYAn1NEKG1
         LXIPqHMlgu4f3EL5IWm4/GPklZb8FE3cXkMcS+35FXAlbGu6HThT0xahZmwxVSTGg/cC
         f+yPwR5NieAEys8qrFvU/QGAwIMsIH9nd+6verSk2tcFDJYagF90lneuL2TF+/SGZUbJ
         UxkQ==
X-Gm-Message-State: AODbwcB9VEKeN9gp3PfK7sIfBiiAGjk9kBOf9zjI6Q5AcrLd0CQjxCGc
        1dD60gqsezOguj73HCuZeN3HW4SfuO5q
X-Received: by 10.36.67.9 with SMTP id s9mr26813728itb.94.1495347478801; Sat,
 20 May 2017 23:17:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Sat, 20 May 2017 23:17:38 -0700 (PDT)
In-Reply-To: <20170521025604.GA8068@csmail.ucc.ie>
References: <20170521025604.GA8068@csmail.ucc.ie>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sun, 21 May 2017 08:17:38 +0200
Message-ID: <CACBZZX4VjxfHBn6O6mWBh-DfAy9cHUxcnn-UfVHzCqm+2VZOiA@mail.gmail.com>
Subject: Re: Options to avoid docs generation/installation
To:     Neil Cafferkey <n.cafferkey@cs.ucc.ie>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 21, 2017 at 4:56 AM, Neil Cafferkey <n.cafferkey@cs.ucc.ie> wrote:
> The INSTALL file says that docs are not built by default, but that's not my
> experience. "make all" results in the generation of several Perl man pages,
> e.g. "Git.3pm". Is it the case that the behaviour documented is not
> propagated to the perl subdir?

Yes, this is a bug in the Makefile glue code for the perl subdir.

> Also, setting --mandir=/dev/null still results in the pages being installed
> in their usual location (at least in combination with setting --prefix to
> avoid disturbing my production git installation).

Sounds like another bug, maybe, but I didn't have time to dig into
this one. When you run ./configure --mandir=* that does end up in
config.mak.autogen, which we source and it should override the
`mandir` in the Makefile, but maybe it doesn't work properly...
