Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DEAR_SOMETHING,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBB9D1FE90
	for <e@80x24.org>; Wed, 19 Apr 2017 20:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966093AbdDSUzP (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 16:55:15 -0400
Received: from mail-yb0-f172.google.com ([209.85.213.172]:32800 "EHLO
        mail-yb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966071AbdDSUzN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 16:55:13 -0400
Received: by mail-yb0-f172.google.com with SMTP id 81so16412929ybp.0
        for <git@vger.kernel.org>; Wed, 19 Apr 2017 13:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=24wrX3+8WqlxTd9YfmE7nQb+TEnRZXpquT+iMkV3MF0=;
        b=qUuHoJlsC6zqTWb13iyEz4HPzptgeYWs3lkZXRxR8wLEEDlzNKssX00CT5tg+znA8C
         lh2Y5M8RhammL2ujBfBZj3PxxPgIxee0w3m+MYVVGgEOPD6/8meVMRByNbngqaPaBaQI
         vBOhP4tkeIMXiggFT25gxfIn3ev37jV6dgS+baAv3ZorPUdlU06HjtrEx+i54Rczwp0N
         vZkoOPibI37qnoMnLuqc8kBmi+zy7Ndf1WPlR9yXhO8Hy+ri06qtgYYUYsDIlvXL+kAy
         4kX1w9xbfwGOVo2v+5b62TUgoTtweetwC8Abnoz7XVObTzk6oaZnSrHnjA8CTNToEpko
         iGcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=24wrX3+8WqlxTd9YfmE7nQb+TEnRZXpquT+iMkV3MF0=;
        b=bSsouPYtGQAHwAY6Pv7Y/BxE88349EQZK3s6t4K3SwSbW2UlWZCoGBZ7LhM7yxCAhA
         05QVvCDG0hLu8RCKhrgOsB52AvNeRJj5JQo2DbDyxc+nWH5gAOIVogVdXq4WiT0c5vhD
         RSzoYBc0K7dGQx/fdLiMZnYEVJHvkukim5mdS3A7ukBLJ63Dff8CN3yGDFvBVk1dryia
         ReKt6ay/6jzZT5RoGqbqNA/LmMHBGzaWr4BT04ggwXYb3PP+RUlpgW6XijactPIUwGrK
         JssKUuam8nz39HpnTDcLV3vKzqbs/ICctlIWhkFOa9QHXjj2kVu0KXwU0KoeBB14wsRz
         2lIg==
X-Gm-Message-State: AN3rC/5h9EgNzwaCNFfI5CMUtQ7H+j+S3erq29s6pKOWX02pOBu8hEzR
        d1Wn/AnCqYQMefM+e9ElWGKCWEBcIGlr
X-Received: by 10.84.232.131 with SMTP id i3mr6216799plk.172.1492635312124;
 Wed, 19 Apr 2017 13:55:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.153.156 with HTTP; Wed, 19 Apr 2017 13:55:11 -0700 (PDT)
In-Reply-To: <ea2780fd-8d63-6060-fb17-df5720bbc3de@freenet.de>
References: <ea2780fd-8d63-6060-fb17-df5720bbc3de@freenet.de>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 19 Apr 2017 13:55:11 -0700
Message-ID: <CAGZ79kavV-58JyUce9BMO9S3LVKGeUBQU-Qt79LAR41xgr=MxA@mail.gmail.com>
Subject: Re: minor typos in documentation
To:     =?UTF-8?Q?Ren=C3=A9_Genz?= <liebundartig@freenet.de>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 19, 2017 at 1:44 PM, Ren=C3=A9 Genz <liebundartig@freenet.de> w=
rote:
> Dear sir or madam,
>
> At:
> https://git-scm.com/docs/git-commit#git-commit---long
>
> you can read:
> When doing a dry-run, give the output in a the long-format.
>
> From my point of view it should read:
> When doing a dry-run, give the output in the long-format.
>
>
>
> Furthermore in the file:
> ./Documentation/gitremote-helpers.txt
>
> you can read:
> As the a push option
>
> It should be changed to:
> As the push option
>
>
>
> Additionally in the file:
> ./ci/run-windows-build.sh
>
> please change:
> # Script to trigger the a Git for Windows build and test run.
>
> to:
> # Script to trigger the Git for Windows build and test run.
>
>
>
> And in the file:
> ./diff.c
>
> change:
>  *   1. collect a the minus/plus lines of a diff hunk, divided into
>
> to:
>  *   1. collect the minus/plus lines of a diff hunk, divided into
>
> Thanks a lot in advance for fixing these minor typos.

Thanks for spotting the errors!

Care to craft a patch and send it upstream yourself?
See https://github.com/git/git/blob/master/Documentation/SubmittingPatches
how to approach it.
TL;DR:
    git clone https://github.com/git/git
    # hack hack hack
    git commit
    git format-patch HEAD^
    # use e.g. git send-email to send the patch to the mailing list

Thanks,
Stefan
