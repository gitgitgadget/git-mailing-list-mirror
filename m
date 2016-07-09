Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30A2B1F744
	for <e@80x24.org>; Sat,  9 Jul 2016 00:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932914AbcGIAlj (ORCPT <rfc822;e@80x24.org>);
	Fri, 8 Jul 2016 20:41:39 -0400
Received: from mail-yw0-f172.google.com ([209.85.161.172]:34374 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932223AbcGIAli (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2016 20:41:38 -0400
Received: by mail-yw0-f172.google.com with SMTP id i12so49843117ywa.1
        for <git@vger.kernel.org>; Fri, 08 Jul 2016 17:41:37 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PoXzGbG4V6cae5kkmSFBBvZ+In1Vt9R6QMvHYqticW8=;
        b=kM8jKtiq3yt4LsbXyEQHKuN3dhR7hmt1WZEk6muxHKAGuE+E5P/4omlSxrc4nR1iL+
         ux4O/EGr3QO61sZ6B8BAPrsHanKPWieeRg2ylmw4OtIx86WsStDtI3BDn3mPwqBN8+Jb
         8net9WUYVU+OW9Afm4+qiGn1H9syi24rpurszEXjRAlZM3+2iIvJvjx5aDvsaIEiHe8M
         /0XCxyg/Vd8iTEGP8RtRSUFRd7qgK497DerU7vkuazFw0xS4iuH5MYg71dTudMUbvCg/
         xxFrzSPflWz+vOGrCtdeMN4cFu+JI4seJGW/kMww2Q8LgMi/xi439EFKskWt4nfVHHdN
         BduA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PoXzGbG4V6cae5kkmSFBBvZ+In1Vt9R6QMvHYqticW8=;
        b=HbijRIq84rwb6MR23taxc0IBfJ1zuduiyrJKeBypYgOq59DhBWrM+wYQUk2ntXRj5M
         //9usB649RzBQTf6OuNH3FnZjQsYPV+22O0B1Y24Ol3GPYtVk/oUyyxhdRp7UbDOdazv
         5o3CScbRpY0fhfeYKDCA1WEv2Y+TOYA2n9O/7pwuD6F8BsOtGoFfZewGwa/eF65/0gZn
         1BazE327LNWo4/Psd9OtVNmTKkmdMGPnl7u+EcJzmkOY9qqp63MbYn3ELHmRbloZTRYn
         bbSFBmg4VsVMd/UF4CKncPZ+2iIBPNNdncX3v84oCDR+4pPFxYctpU70W1kfnd7/wIgk
         vT+g==
X-Gm-Message-State: ALyK8tJPGCBS8jwdgwxMvGr6liz+8AYn71dlCP4m1xojjUqi0ta4rsw4hBY+o26XIeSWRzXyxF2DppbXM7H1uQ==
X-Received: by 10.13.219.76 with SMTP id d73mr6821808ywe.234.1468024897337;
 Fri, 08 Jul 2016 17:41:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.34.133 with HTTP; Fri, 8 Jul 2016 17:41:17 -0700 (PDT)
In-Reply-To: <20160708003646.GB1916@gmail.com>
References: <20160707184408.GA1916@gmail.com> <CA+P7+xoM=-=sokA_+WDuY7KYUwSa=Qu8Y9U1aPHOgSH3n-VZnA@mail.gmail.com>
 <20160708003646.GB1916@gmail.com>
From:	Jacob Keller <jacob.keller@gmail.com>
Date:	Fri, 8 Jul 2016 17:41:17 -0700
Message-ID: <CA+P7+xr_dYbno+JsTmaG+WWrgwsAXXGTyA6HL4A4A34ahHMD=Q@mail.gmail.com>
Subject: Re: git branch doesn't allow me to forcibly delete branch which was
 checked out in a now-deleted worktree dir
To:	Erik Johnson <palehose@gmail.com>
Cc:	Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 7, 2016 at 5:36 PM, Erik Johnson <palehose@gmail.com> wrote:
> I'm not expecting _any_ git branch command to prune worktrees, but a
> branch _deletion_ shouldn't fail because git thinks the branch is
> checked out in a worktree that doesn't exist anymore. Even in the
> scenario where the worktree corresponding to that branch is on removable
> media, does it really matter? You're trying to delete the branch.

I disagree. git branch -d (should) fail to delete a branch when it is
checked out in a worktree. If the worktree is a persistent (ie: not
there due to removable media etc)  directory then it *definitely*
shouldn't allow you to delete.

It is possible we should update "git branch -d" should perform a
worktree prune first, since that would enable it to determine that you
deleted the directory, and any worktree which is removable should be
marked as persistent.

Given that there is a known workaround (git worktree prune) and that
it is expected behavior for a branch checked out to prevent deletion,
I think the best coarse of action would be to patch git branch -d to
do a prune before attempting to delete.

Thanks,
Jake
