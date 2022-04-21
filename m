Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95586C433EF
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 02:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353883AbiDUC4o (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 22:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiDUC4n (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 22:56:43 -0400
X-Greylist: delayed 1472 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 20 Apr 2022 19:53:54 PDT
Received: from gateway30.websitewelcome.com (gateway30.websitewelcome.com [192.185.147.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1898DF1B
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 19:53:54 -0700 (PDT)
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id 9E76C47FF
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 21:29:21 -0500 (CDT)
Received: from gator3142.hostgator.com ([50.87.144.177])
        by cmsmtp with SMTP
        id hMZNnzABob6UBhMZNnXbJO; Wed, 20 Apr 2022 21:29:21 -0500
X-Authority-Reason: nr=8
Received: from mail-pl1-f170.google.com ([209.85.214.170]:39824)
        by gator3142.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <csosza@designsoftware.com>)
        id 1nhMZN-002Ify-3U
        for git@vger.kernel.org; Wed, 20 Apr 2022 21:29:21 -0500
Received: by mail-pl1-f170.google.com with SMTP id c12so3503699plr.6
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 19:29:21 -0700 (PDT)
X-Gm-Message-State: AOAM532esLf7nZUFNQdsfV/lCNdxkM8gHXODUbV4cNQPE9wdGTe2ytpq
        AkpR7NYdb4zUQHzKw3u1lniI+l3DWnx11HHZZc4=
X-Google-Smtp-Source: ABdhPJyWltH8hn8/GIq2handcXBez4XADRX+Io2xH3pkABOp5bWu+5tZZPH8szwJaVfxTN2/HtGKhNvqjMdhSIX3KiI=
X-Received: by 2002:a17:902:70c8:b0:156:509b:68e3 with SMTP id
 l8-20020a17090270c800b00156509b68e3mr23320318plt.113.1650508155328; Wed, 20
 Apr 2022 19:29:15 -0700 (PDT)
MIME-Version: 1.0
References: <4026b85f-8cae-bcca-af14-e886e80725d4@designsoftware.com>
 <Yl2h5I0apzWhpVtr@camp.crustytoothpaste.net> <fa40a6e6-dd83-9e88-e2f7-ab8aff2ca5a4@designsoftware.com>
 <04a50f96-363f-210f-b894-11945d0eb3e8@gmail.com>
In-Reply-To: <04a50f96-363f-210f-b894-11945d0eb3e8@gmail.com>
From:   Attila Csosz <csosza@designsoftware.com>
Date:   Thu, 21 Apr 2022 04:29:03 +0200
X-Gmail-Original-Message-ID: <CAMYm8FoA55JwXezckJxMPXGLh2+osCwsHHrg_MSjLMqG2emygQ@mail.gmail.com>
Message-ID: <CAMYm8FoA55JwXezckJxMPXGLh2+osCwsHHrg_MSjLMqG2emygQ@mail.gmail.com>
Subject: Re: Git bug report - disk errors on Windows after push
To:     neerajsi@microsoft.com
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator3142.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - designsoftware.com
X-BWhitelist: no
X-Source-IP: 209.85.214.170
X-Source-L: No
X-Exim-ID: 1nhMZN-002Ify-3U
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: mail-pl1-f170.google.com [209.85.214.170]:39824
X-Source-Auth: csosza+designsoftware.com
X-Email-Count: 3
X-Source-Cap: ZHNnNHQwcjtkc2c0dDByO2dhdG9yMzE0Mi5ob3N0Z2F0b3IuY29t
X-Local-Domain: yes
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Please check this link also
https://github.community/t/what-could-be-the-reason-my-git-repositories-keep-getting-corrupted-broken/184711

You can found many link on web on 'git corrupted repository'. In my
opinion when a git repository is corrupted on Windows there is a good
chance to HDD errors.

I suggest also run intensive test on Windows (run a bat file commiting
and pushing to a bare directory type repository). Check your HDD
healthy status after 10-20 run of 'git push'.

My git software is come form 'git-scm.com' and I'm using TortoiseGit.
My git software is up to date.
Last time my laptop HDD is crashed loosing sensitive datas. I will
never push to a local repo I'm using online repo-s like github.

///
fsutil fsinfo volumeinfo e:
Volume Name : Seagate Backup Plus Drive
Volume Serial Number : <removed by hand>
Max Component Length : 255
File System Name : NTFS
Is ReadWrite
Not Thinly-Provisioned
Supports Case-sensitive filenames
Preserves Case of filenames
Supports Unicode in filenames
Preserves & Enforces ACL's
Supports file-based Compression
Supports Disk Quotas
Supports Sparse files
Supports Reparse Points
Returns Handle Close Result Information
Supports POSIX-style Unlink and Rename
Supports Object Identifiers
Supports Encrypted File System
Supports Named Streams
Supports Transactions
Supports Hard Links
Supports Extended Attributes
Supports Open By FileID
Supports USN Journal
///

Maybe this email not reaching the main mailing list I'm somehow blacklisted.


Attila

On Thu, Apr 21, 2022 at 12:54 AM Neeraj Singh <nksingh85@gmail.com> wrote:
>
> On 4/18/2022 8:52 PM, Attila Csosz wrote:
> > I've experienced the problem at least 3 different external disk.
> > I'm not using cloud syncing service (e.g., Dropbox or OneDrive) for git.
> >
> > Attila
> >
> Hi Attila,
> Could you please share a bit more information about the disks that are
> being corrupted and the specific error messages you're seeing?
>
> What is the underlying storage type (e.g. USB key, external hard drive,
> etc)?  Also, which filesystem is the drive formatted as?
>
> Could you please save one instance of a volume in the corrupted state so
> that we can consider further investigations?
>
> I believe the output of "fsutil fsinfo volumeinfo <drive letter>" and
> "fsutil fsinfo drivetype <drive letter>" should give us some useful info
> about the volume that's being corrupted.
>
> Thanks,
> Neeraj Singh,
> Windows FileSystem Dev
