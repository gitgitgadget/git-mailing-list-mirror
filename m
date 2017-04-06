Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D571A209F2
	for <e@80x24.org>; Thu,  6 Apr 2017 18:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753041AbdDFSim (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Apr 2017 14:38:42 -0400
Received: from mail-it0-f50.google.com ([209.85.214.50]:35641 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752675AbdDFSik (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2017 14:38:40 -0400
Received: by mail-it0-f50.google.com with SMTP id y18so106684809itc.0
        for <git@vger.kernel.org>; Thu, 06 Apr 2017 11:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZQDy69YOexbtR0B/lfm7vDf3vIK/3UUSBIDxKINCaUc=;
        b=hnXWeC66N7CY7ikpKSNVvHUKtAVeH4075J83NWYqrZCOVy+cpHpFauDUW19o2waQaW
         nCq9py3xbVyw3p4F/+07SLgR8aZQr3LYJiRnm+1OnVcFWNKjaNSqJL/t7uFovPvCq4Te
         70Y198NE2sD5vYNgc0OviHBs6XDVIrPaJBgFVeWFkqVf4N7sFczsNKzUE4eMNWM93vVv
         XuJ4oSEiQo3mH1qffB8amtNg3JliNTWqfxFdDMvKDZB/4/fCKTIxjPr371HNT0niRqnA
         9qLOFsIUc175zXNuuf4bnfqDR6SnzjzU9AhBitaLsLNfoq5qpt0Jpo8D6DQOmgiTaHna
         QZ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZQDy69YOexbtR0B/lfm7vDf3vIK/3UUSBIDxKINCaUc=;
        b=j+j2i7PE832wM3X3ryjnN1STrLkomltqj6T9ICEHeDTto8bCrPlrkfJQIaA2bQch/k
         xGTe65ojquZvgw51qZoFKBTq0lAEaOoenQ2CHz5krxg20hcv1g+ktRqiWbtlmhmpi1Ka
         hYxlt+YKkesasyCcBYPsF4KB4GSspMlKks5Y4YPkQz+ScxL3M0KGQ3gH5/cIDda4u2Gr
         M8Sgye3dYvdQjtdzAKE3EfSlpcPU8ByfrTOsbGgSase1hto89zgxVz9DVzCyJJDTiUKh
         BigR6Fx6TEVmk6Zyrd98BuE411NRw56Ghhxkn2zWqqMuUEN7NYZx9CmkTCkoUERjc9xC
         2G2A==
X-Gm-Message-State: AFeK/H3ZFYoHtoNBB9YWzhEBzayesTfDOjC2IN26ioZ+8Jvv+pCUk5cB
        mXJ3vSWjVeNnODVkZT/lQswvzTcruq3Knm8=
X-Received: by 10.36.76.16 with SMTP id a16mr23286278itb.91.1491503919707;
 Thu, 06 Apr 2017 11:38:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Thu, 6 Apr 2017 11:38:19 -0700 (PDT)
In-Reply-To: <955c152a-b278-ecfd-8bc7-671c3aa81dc6@ricozome.net>
References: <955c152a-b278-ecfd-8bc7-671c3aa81dc6@ricozome.net>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Thu, 6 Apr 2017 20:38:19 +0200
Message-ID: <CACBZZX7xA92e5n=E8fdGHiBHaqzRjP_MVWsaE2v=DcVmCO2r0w@mail.gmail.com>
Subject: Re: how-to get commit content with pre-receive hook ?
To:     Eric Belhomme <rico-ml@ricozome.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 6, 2017 at 4:03 PM, Eric Belhomme <rico-ml@ricozome.net> wrote:
> Until now I ever had a quite "basic" Git usage, but now I'm working on a
> project based on Git hooks feature.. and I'm a very beginner with Git hooks
> !
>
> My need consist doing a syntax check on submitted files before a 'git push'.
> So the right hook is 'pre-receive' and I'm already able to identify the
> files I want to check using 'git show'.
>
> But I don't know how to get the *content* of the file being submitted to run
> my syntax check rules against it !
>
> I googled but most examples using pre-receive I found are doing sanity check
> on enveloppe but never on actual content of the file !
>
> Could someone here put me on the rails ?
>
> Regards,

As documented in githooks(5), the hook gets a list of these on stdin:

    <old-value> SP <new-value> SP <ref-name> LF

That means that you can use any git command to inspect that ref range, e.g.:

    git log -p <old>..<new>
    git diff <old>..<new>

Or (pseudocode):

    git show <commit>:<some path> for $(git rev-list <old>..<new>)

This is no different than how you'd inspect the content in your git
repo, e.g. to get the README.md content of the master branch of
git.git:

    $ git ls-tree master|grep README
    100644 blob f17af66a97c8097ab91f074478c4a5cb90425725    README.md
    $ git cat-file blob f17af66a97c8097ab91f074478c4a5cb90425725|wc
         61     397    3001
