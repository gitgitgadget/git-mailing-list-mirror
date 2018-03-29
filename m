Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DD9D1F404
	for <e@80x24.org>; Thu, 29 Mar 2018 18:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752514AbeC2SCH (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Mar 2018 14:02:07 -0400
Received: from mail-ot0-f170.google.com ([74.125.82.170]:41520 "EHLO
        mail-ot0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752486AbeC2SCF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Mar 2018 14:02:05 -0400
Received: by mail-ot0-f170.google.com with SMTP id i28-v6so7283359otf.8
        for <git@vger.kernel.org>; Thu, 29 Mar 2018 11:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=eaHHMI0npMBzUVdGrjxEyp2sC4hudSU2lUfly0lA4dY=;
        b=NrV76OKYo+qZ9TKaHm37kn7g+AMogImvGUItXlRymEyr+x6lzLP7i52FrwATjhaVK/
         +SXazMTVs3ycFS+gVWZCZd04Ck8sySy9eUmeF2ZWuVlCBNQHhCqEe1FOiPcT759gxFaQ
         XWvPNT1Rml7trOHk3c+9f1nBkFnb4goeuEITqaOphGRNCp8WQYi6C2lGFH6sjPCVau8j
         R6K10WtbF6922pLt0lbNoEuPiVWcRofe38P1rMzYBMGW0N8i3IoGp/Fz3yRyCYfMWDnT
         GyUtM+4Pl2PCf1NhGZGexy1tBUN1caTqqC+5r0oNx9R8v5/crbRdc9nWOoxaOer6a4iu
         SgzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=eaHHMI0npMBzUVdGrjxEyp2sC4hudSU2lUfly0lA4dY=;
        b=A3Lu2dZmmnFaIgg9YZowHMTulCG7OY/HXwRni9ywWdjNzNuorNQC1bBuWg7oVF/EDc
         SYX0QIedNnW+UNTFrpXbAz01Bvzv4S/Vp+uJ+TSJNRU3KEUyYEvhbpcZu3YwWw7tbJqz
         nxkXKZmvgft6cx+98K5jd0IVcWK21FX8/UJpMJ7dHDTOAB64zZJ0LknEYzjh3xGnEjMf
         G6xfsZ7bpHNt8DJgjdWxUEkcYuNrtYOGKjjm3pZ3NW8hVIhMtOsGzSkuAWvOlKgL2PMX
         V/N9//sgm3bHPYu05kCw4QLPkUS5CccrJPvtyN5+JpqQk7UXZA8xwbgeMvVszWvewsvi
         AP2Q==
X-Gm-Message-State: ALQs6tCTcXEmO/7U+drwOQ4C49WHwaRpEKb0qpj2MlkMjrkPsLDtBZTd
        WEChiz7Aa42s3Nlav9LckFoZlerxkguDOwStLXs=
X-Google-Smtp-Source: AIpwx4/R+pEWzdA5/cAWhgoKK281B3aquWFFTNLesWbJVr7IvBjbV3ldIzXUAn+t2MCIlG8f4HzrCu0xuQ4OSNL/s4A=
X-Received: by 2002:a9d:24c7:: with SMTP id z65-v6mr5777916ota.152.1522346524525;
 Thu, 29 Mar 2018 11:02:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.211.131 with HTTP; Thu, 29 Mar 2018 11:01:33 -0700 (PDT)
In-Reply-To: <20180329175007.GC31833@sigill.intra.peff.net>
References: <20180328173656.GA29094@sigill.intra.peff.net> <20180328174215.GC16274@sigill.intra.peff.net>
 <CACsJy8CAjb4zdAgD5H9OZOAoHdrRFzGm9gaL8Wbna+GXJJCW4Q@mail.gmail.com> <20180329175007.GC31833@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 29 Mar 2018 20:01:33 +0200
Message-ID: <CACsJy8CdqpNOw+zdMyugX-902Z=gLNij5_xcmE4jGLRBTqiO1g@mail.gmail.com>
Subject: Re: [PATCH 3/4] set_work_tree: use chdir_notify
To:     Jeff King <peff@peff.net>
Cc:     Rafael Ascensao <rafa.almas@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 29, 2018 at 7:50 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Mar 29, 2018 at 07:02:21PM +0200, Duy Nguyen wrote:
>
>> On Wed, Mar 28, 2018 at 7:42 PM, Jeff King <peff@peff.net> wrote:
>> > When we change to the top of the working tree, we manually
>> > re-adjust $GIT_DIR and call set_git_dir() again, in order to
>> > update any relative git-dir we'd compute earlier.
>>
>> Another way to approach this problem is not delaying chdir() at all.
>> We have to delay calling setup_work_tree() and not do it in
>> setup_git_directory() because it can die() when chdir() fails. But in
>> many cases, the command does not actually need the worktree and does
>> not deserve to die. But what if we make setup_work_tree be gentle?
>>
>> If it successfully chdir() at the end of setup_git_directory() (and
>> perhaps before the first set_git_dir call), great! The problem we're
>> dealing here vanishes. If it fails, don't die, just set a flag. Later
>> on when a command requests a worktree, we can check this flag and now
>> can die().
>>
>> It's less code this way, but it uses up more of your (or my) time
>> because even though the first set_git_dir() call actually happens at 8
>> places. Is it worth trying ?
>
> I do kind of like that. I'm reasonably happy with the chdir_notify()
> interface, but it would be nicer still if we could get rid of it in the
> first place. It's true that we _could_ chdir from other places, but

There's another place we do, that I should mention and keep
forgetting. Our run-command.c code allows to switch cwd, and if
$GIT_DIR and stuff is relative then we should reparent them too just
like we do with setup_work_tree(). Your chdir-notify makes it super
easy to support that, we just need to move the prep_childenv() down
below chdir(). But since nobody has complaint, I suppose that feature
is not really popular (or at least not used to launch another git
process anyway)

> realistically speaking, we do our one big chdir as part of the setup
> process.
-- 
Duy
