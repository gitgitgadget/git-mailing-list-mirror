Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CFAF1F453
	for <e@80x24.org>; Wed,  3 Oct 2018 18:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbeJDBlR (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 21:41:17 -0400
Received: from mail-ed1-f48.google.com ([209.85.208.48]:35041 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbeJDBlR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 21:41:17 -0400
Received: by mail-ed1-f48.google.com with SMTP id y19-v6so6336044edd.2
        for <git@vger.kernel.org>; Wed, 03 Oct 2018 11:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KZPbBvN505hiwMd0kUFDp+mz125yuohEEo2OhVj2hHc=;
        b=nTT5SbLfukz5KTlRLi8FcJxIxgArp4d6ZSrf32u1SlHjV2gyyp4GC0izNMpMiPnyXx
         gRDoqXzl5jT0lkYVsDKw9WhzKk3U52Y119Q5kjRctG1gvxghUcBHOUd0Ys2zZ6XOQAKg
         d13JCIhfPg1OO82Ez6GOtFCpOg0wiidvMqmaxONTYpCNdSDg2Xd+jRtTi95lGba+jm1v
         qzWKM9TOf4YmLH8igJQiUEc+mu7VU5uBtElFEd2fpWlGSrH7wFh7KcyTMknS5nFJ9eNq
         zBFLwUr3SX+QlaW8R8IegTS+sNYXclzHJVFBSKnEQGdfHM7fT7YaBYC7jUBm6NTw/oIS
         ydYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KZPbBvN505hiwMd0kUFDp+mz125yuohEEo2OhVj2hHc=;
        b=fX4zEsJL4v79tdIFXyFPhfe6PWxuf4catrMCgfZ84WE3qruYHYjMRuV3Wuik5XtRf5
         bemfOPuY3erZ6defHtb0hI78mZhJ2Bt+RvNsIIO7yIYuT1DUhswGJE2EzDQsYM6bpz3G
         1HbEkwTdjMjEIL9AFrYdPfAVcPW+QOeZsXxhgUlPmfsC681ZmIS7z93EhQMQbIiajEBF
         +e26TgD0sgOioQh/xyTSo+p+49sfIZI/OOqSqZZaqAUr1/9SnFI+LWBfSKNHmgD8m4fu
         HVKjQm11Fe6It7uqGLhxNBYJ8vJ+8gwPuwmn27oS7HDj2SjmgmGgePSM6ZQY8kaq1XpC
         CfWQ==
X-Gm-Message-State: ABuFfojnfsM7FeakIt8/7Tl4rReSPi6LAAJZrzzZHcX1/aIMP3T6F0yp
        vmlKBRolt7Jg6wTyigynuKn5oSCd0OFexUNpAV06AQ==
X-Google-Smtp-Source: ACcGV63XBlwYJmpWb77uYM6AVdjElngQSTUMjmhMBnmtnTPpf8STv8rahNFXiMPTxjnY4nzL1DB56iBOepf6SMJCINw=
X-Received: by 2002:a50:93c5:: with SMTP id o63-v6mr4152067eda.154.1538592699093;
 Wed, 03 Oct 2018 11:51:39 -0700 (PDT)
MIME-Version: 1.0
References: <CADWf5z4pAR20qeoT1RnYENBB7Q5fA2fVVTNqPzMzvOE5Dq02qA@mail.gmail.com>
In-Reply-To: <CADWf5z4pAR20qeoT1RnYENBB7Q5fA2fVVTNqPzMzvOE5Dq02qA@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 3 Oct 2018 11:51:27 -0700
Message-ID: <CAGZ79kZ=FXEgTgZ7hO_7O2Qo-ze9ykQW0_Vgr=m7MFe8mc9+Mg@mail.gmail.com>
Subject: Re: inside the git folder
To:     chrisjberlin@googlemail.com
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 3, 2018 at 5:26 AM Chris Jeschke
<chrisjberlin@googlemail.com> wrote:
>
> Hey git-team,
> I am working on a plug-in for a distributed pair programming tool. To
> skip the details: I was thinking about sending parts of the git folder
> as a zip folder with our own Bytestream instead of using the git API.
> Is there a common sense about what should and what shouldn't be done
> when working with the files inside the git folder?

This contradicts the security model of git.
Locally I can do things like:
    git config alias.co "rm -rf ~"
    echo "rm -rf ~" >.git/hooks/{...}
and I would experience bad things, but that is ok,
as I configured it locally (supposedly I know what
I am doing); but if I have the ability to send these
tricks to my beloved coworkers, hilarity might ensue.

What stuff do you need to send around?

objects? Fine, as the receive could check they are
good using fsck.

refs/ ? Sure. It may be confusing to users,
but I am sure you'll figure UX out.

local config, hooks ? I would not.

Not sure what else you'd think of sending around.

Cheers,
Stefan
