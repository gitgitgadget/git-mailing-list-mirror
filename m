Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAEDA215F6
	for <e@80x24.org>; Wed, 12 Oct 2016 21:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934249AbcJLVKU (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 17:10:20 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:34397 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934247AbcJLVKS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2016 17:10:18 -0400
Received: by mail-qk0-f176.google.com with SMTP id f128so53076410qkb.1
        for <git@vger.kernel.org>; Wed, 12 Oct 2016 14:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cOnhMajKIJiaadHL4XLi2fIAhrX22Sar3VTOc6FMCvQ=;
        b=ijqyAvc+8z1uTzszXbbhzLswazxFXItrPw0SHtYFT81uyO/h+uOXXmriQBPbp/f4c+
         IVzaDagM6bokQmvtK+B5fLU9kRo3arcxRtS+mNkFIKNBBblH9F4H2XK7weKUJHSUD4eK
         6wfELDWfsAYarcgvTDHyaV/JwTzswgEbgy6F1r4HsnnUJYsmOI0nbZQPN6I6ZlRAaqPK
         kLliW0f1eA/BzU5/u+QNRFs8fmxB1T0IWKBlIKDum0e0rbNh0JNhYM3McfgLKaMAmEIl
         /AOZvQ/9MDW4R/HhBHk9vgfZNB7Gt29wvAtjVybQxC78LtHm8zwTpmlBQMTsZ5CUx/oG
         UQoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cOnhMajKIJiaadHL4XLi2fIAhrX22Sar3VTOc6FMCvQ=;
        b=BBEFLfrzw0xTMcfkJlIxGPecC8Qz0NHcJie+zz/va1UfAejr3/Abb8soc/Tyux3cYi
         K4Dj0ItdE0/vHu7iSteJ3GKj7u0czqxI5UeavKj8fgrYT1en9a2ThJ/y5X9XcWs3L3OL
         DwgAfvC5qtLykcgEx5lv2uhEEsrFsLMaxg7hb63ivE06Z7JocrM/LrYp/U55gxSw8l/B
         k3oLaD5Sly5OGvhcRfLQvb2rw2r1Sk01TWY4zyBmCDRzZGNsclGjI8MSM1pf2vBxQXTP
         IVtI9mdPCT+yPWgk7QHzI0joM9TK0ruyGnB1+ylSpPv9uYGfmmkHzeqEcXBkMc4AtnIj
         D3NQ==
X-Gm-Message-State: AA6/9RlK4BWbis0CXsapn0Jt91W3z89Ud/oIPHJtXgVwlgFhZgKs8dchxz0wNnZAkedNWS9W9heKeDh2de1MIITe
X-Received: by 10.55.36.131 with SMTP id k3mr3061787qkk.86.1476306312381; Wed,
 12 Oct 2016 14:05:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Wed, 12 Oct 2016 14:05:11 -0700 (PDT)
In-Reply-To: <6c83c905-b10a-7f54-873f-54186faacfc8@FreeBSD.org>
References: <6c83c905-b10a-7f54-873f-54186faacfc8@FreeBSD.org>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 12 Oct 2016 14:05:11 -0700
Message-ID: <CAGZ79kZo5W1r0s26G3foB7caP6+u66mdzqzyneqXBX_B7A0RKg@mail.gmail.com>
Subject: Re: problem with git worktree and git svn
To:     Mathieu Arnold <mat@freebsd.org>, Duy Nguyen <pclouds@gmail.com>,
        Eric Wong <e@80x24.org>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

+cc Duy who knows about worktree,
+cc Eric Wong, who knows about git-svn



On Wed, Oct 12, 2016 at 7:45 AM, Mathieu Arnold <mat@freebsd.org> wrote:
> Hi,
>
> I'm a FreeBSD ports developer, and while our main repository is in
> Subversion, some of us use git-svn a lot for development.
>
> I discovered git worktree earlier this week, and I found it a great
> asset to be able to have more than one branch of my worktree accessible
> at the same time...
>
> Anyway, back to my problem, the way git-svn works, is that it looks for
> a directory named "svn" in its gitdir and if it is not present, decide
> the repository is using git-svn version 1 (whatever that is) and goes to
> parse all the revisions to recreate the svn directory.
> So I can only use git svn commands in my main worktree, the one with the
> real gitdir.
> To fix that, all I had to do is to add a symlink named svn in each
> worktree's gitdir and pointing to ../../svn.

For some definition of fix. ;)
Sure it fixes your local setup now, but would we want to use that as well here?
My gut reaction:

* not all platforms know symlinks
* IIRC there is some worktree magic that tells you the "main" dir,
  so if that was used in git-svn instead it should "just work".

>
> I think all that needs to happen is that when adding a new worktree, if
> the main git directory has a "svn" directory, add a symlink to it in the
> worktree's gitdir.
>
> --
> Mathieu Arnold
>
>
