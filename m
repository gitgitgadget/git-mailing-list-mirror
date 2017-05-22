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
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AA2B2023D
	for <e@80x24.org>; Mon, 22 May 2017 19:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757958AbdEVTnv (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 15:43:51 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:36082 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757825AbdEVTns (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 15:43:48 -0400
Received: by mail-io0-f174.google.com with SMTP id o12so88379621iod.3
        for <git@vger.kernel.org>; Mon, 22 May 2017 12:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SbmmtJV3jerDBfWdLGoGJHyLFB87C7tqkGCDGK9fC4w=;
        b=JHktrI66XbXlnjuPe9g+G2FbHir8qqgzq/9uF2Sn3TvzUTCumK3ZWktQvIbcCkKNdW
         Rmho9iTAU32siQ48a9aK3dJRzV4K+D8tYM/mAS0tCEPpmVsDOYT1lUgrbVoqegNdmaGO
         T8H5fzOf3VPD9zlfwNrk1iBmmdIPsSZUz7gNfjughb6rEaT4PfjBTpX0ntidAnVGbpdg
         3jwIFzl0RO/QXoAxEzCeCGBHr5jXf2RD+b2eQxE5PrMqutRBh8sEQGd5Pj9d1bn6yTEm
         VGf4YriPYX68MrEEDhP9i01s7u23uAxlUbrMERwIEFAfv9s+LPzQwuekSYm6CV/fj598
         40TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SbmmtJV3jerDBfWdLGoGJHyLFB87C7tqkGCDGK9fC4w=;
        b=eFVN+oQw3xlOy7QPzvcknp/UJvUP+aCJM3sshrK7+qU5sVoyaXDYpfhM1+Zxc10ITs
         n6z4hvbvbi+xtOQy6yWCabmuM++1F9Bernqm517Qq0P2Y+cn+m+QUelZu5EKi4JKnGDt
         Bdcfu+I8DbGSLc/IMu52aBQqn2udvT7mcOSGzq/yZ7GT3H0m73bQZVuSKT+27kcycgqG
         pkGiKUldIfnmeU8dhZB4TnCMCZKiNn2cJ9PK9YKtsXSvn9HkpBt+Ec5ObyJn0cxSBBDm
         S3Pn8N/CKktGak4VegPWMlUoaJqScO6y+uGqG9L5DQUSH82ZTxufPwHLPweTG4Re9lGB
         PjDA==
X-Gm-Message-State: AODbwcCKXgNeBCW9JUGSsHi9jLq3jZ999r0FNoLRHacz6mKU2co6Wa+U
        4g2MF4+xxGaoxYQ8oXFVll0uSvy00g==
X-Received: by 10.107.201.131 with SMTP id z125mr21915657iof.160.1495482227366;
 Mon, 22 May 2017 12:43:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Mon, 22 May 2017 12:43:26 -0700 (PDT)
In-Reply-To: <CAGZ79kYirjV0eQgB_ng-64HSPN_7njUMjnoNBkmWnx-rinsemQ@mail.gmail.com>
References: <CAGZ79kYirjV0eQgB_ng-64HSPN_7njUMjnoNBkmWnx-rinsemQ@mail.gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Mon, 22 May 2017 21:43:26 +0200
Message-ID: <CACBZZX7HYU1USdcX_=CDFiMDtdaySSjd0zv-Bb1Z9-nHxk8UvQ@mail.gmail.com>
Subject: Re: Another git repo at kernel.org?
To:     Stefan Beller <sbeller@google.com>
Cc:     webmaster@kernel.org, Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 22, 2017 at 8:34 PM, Stefan Beller <sbeller@google.com> wrote:
> The Git community considers using submodules for some parts of the
> code (a third party lib, SHA1DC, computing SHA1s that warn about
> potential attachs, see shattered.io) [1].
>
> We are also concerned about single point of failure there, so a repo
> at kernel.org
> mirroring the potential submodule[2] would be great.
>
> I cc'd the git mailing list as we may want to have further discussion who
> shall have access to the new repo.
>
> [1] https://public-inbox.org/git/20170520115429.12289-1-avarab@gmail.com/
> [2] https://github.com/cr-marcstevens/sha1collisiondetection

The access problem could be solved by none of us having access to the
repo, if the git.kernel.org admins are willing to set up a mirror of
the github repo, a cronjob running git-fetch with the appropriate
parameters to just fetch the master (or everything, but only master is
needed). Updating such a mirror with a daily cronjob would be more
than enough.

Less seriously but worth pointing out: It could also be solved by just
setting the user:password to foo:bar and publishing that in the
description & setting the repo to non-fast-forward only. This will
only be used by the git.git repo, which'll point at a specific sha1 in
its history, wouldn't that be a nice demo of the whole "give the repo
to your worst enemy but as long as you have the sha ... " parable
Linus posted on-list back in the day... :)
