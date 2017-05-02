Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 891A41F790
	for <e@80x24.org>; Tue,  2 May 2017 20:06:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751039AbdEBUGd (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 16:06:33 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:36413 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750758AbdEBUGc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 16:06:32 -0400
Received: by mail-it0-f49.google.com with SMTP id o5so21340924ith.1
        for <git@vger.kernel.org>; Tue, 02 May 2017 13:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1VTKOgpV8kjczCISvAzUt/U6XFG4P3E3AMvFohGoBRE=;
        b=h6chzXoMZWQsiu8ZThw06yCbZDUnhxLB3ETx6LwrsPAO0DLUCaRFG5yapB4caCkPa0
         osGWJlfRue5RixxNIT2XY/5tMGkxT9avZjCHqDz/38ex82D4x8Tzh3/vlmfLHcEEF9jM
         wKN/elTvDga9aZzkZC50IcjcNBysA5v0nuRhPQzt5mhAKIMscvzHs2J8cZMrdb/7CTkZ
         RDZ1JARwdQWCljc7oQhQhxOyKnv/zUNtbr3y+jIvIbDAhUAtARm+PKSi2g8VLwa/9DmV
         asqZ/fiNPdmm0qhcIr9TfiOCLDo6u8gpQHHyWsTF7P0Ld2on2YJwQ0YFszj6bixFhgX4
         Fdrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1VTKOgpV8kjczCISvAzUt/U6XFG4P3E3AMvFohGoBRE=;
        b=pEc0bwP5TcSfpKiwmIznrHv62XqQR+JoZJwfuuN8KjwumYjGDkNWmzZcN/1Qd2INJ+
         upDGRkFoLoWC6g8ClYDo8F+vZ7qW45NuYmUZxYvYJYzdM7OORLLRar/F/owrVZ5exdM6
         ZJcMjmlM/Y+nan9ln3qyXXJ/gwuc+M9/yu/34dDWrYkzFJNy4pvZG9f1pkMUT2E69MRQ
         qJ/JSgqgmLvU274odev5b3TR7Eymgcib2CebIXYfPAgqigvnghC7Z/CfW8E3cAPHmRy6
         SH89gKTuNqkY906i9NpcBxHi3X5SKnVdP/pbVxL5xoEjAjsvS/DPviQe/xOtCLroWXhn
         cbyA==
X-Gm-Message-State: AN3rC/4y+w9dD6IB9nQakzDUChFgUUjSeQMsQtB5s/QcBrqO9CF/VCXN
        XMPoiLVTKrgx9sFmOIrp41Ai2bRnxFY5jGA=
X-Received: by 10.36.98.21 with SMTP id d21mr5142805itc.94.1493755591576; Tue,
 02 May 2017 13:06:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.134.97 with HTTP; Tue, 2 May 2017 13:06:10 -0700 (PDT)
In-Reply-To: <SN2PR0801MB575DC31D49660CF33DFFE2599170@SN2PR0801MB575.namprd08.prod.outlook.com>
References: <SN2PR0801MB575DC31D49660CF33DFFE2599170@SN2PR0801MB575.namprd08.prod.outlook.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 2 May 2017 22:06:10 +0200
Message-ID: <CACBZZX4WnHSXBWu2AJ1+Gic=4M0kuF8Fysqky_XTPWPUPeNzaA@mail.gmail.com>
Subject: Re: Reference help
To:     "Desjardin, Donald" <Donald.Desjardin@stratus.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 2, 2017 at 9:33 PM, Desjardin, Donald
<Donald.Desjardin@stratus.com> wrote:
> Sorry if this is not the place for this.
>
> I'm looking for any reference to potential problems when updating a git client (say from 1.7.N to 1.8.N) with old workspaces.
>
> The scenario is this:
>         Lots of developers use a single machine for work
>         They have lots of workspaces created using the old client
>         We want to upgrade to the new client
>
> Are there any potential problems just upgrading the client and NOT re-cloning their workspaces (or stashing or committing or pushing)?
>
> Subversion had/has some feature that could tell that the workspace was created using an older client and you could magically run something to update the workspace.
>
> I'm not above telling all my developers to commit/push to a feature branch, remove the workspaces and re-clone as needed on a flag-day, but I'd like to know if I have to.
>
> If there is any documentation that talks about this (I know 1.7 is old).

Git, unlike Subversion has used the same stable underlying storage
format for all of its history. So you certainly don't need to migrate
these checkouts when you upgrade git, they'll just work.

There are several things that changed in the UI, some in incompatible
ways, most prominently the behavior of "git push", but it's unlikely
anyone will be affected by that beyond some minor annoyance.

You can see announcements of major changes in git's release notes,
which you can browse here:
https://github.com/git/git/tree/master/Documentation/RelNotes

E.g. 1.8.0.txt in that directory will have notes for upgrading from
1.7.x to 1.8.0.

Note that both 1.7.0 and 1.8.0 are really old, from 2010 & 2012
respectively. Although it'll be a bigger jump you might want to
consider updating to the most recent release directly, currently
2.12.2, this'll be more changes at once, but you won't have to go from
1.7 to 1.8, 1.8 to 1.9 etc.
