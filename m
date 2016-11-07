Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6F6E2022C
	for <e@80x24.org>; Mon,  7 Nov 2016 07:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751971AbcKGH0w (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Nov 2016 02:26:52 -0500
Received: from mail-it0-f46.google.com ([209.85.214.46]:35127 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751464AbcKGH0v (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2016 02:26:51 -0500
Received: by mail-it0-f46.google.com with SMTP id e187so83673741itc.0
        for <git@vger.kernel.org>; Sun, 06 Nov 2016 23:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0wsyiB9N0YBjTuK2XZhcOxngpjKOdX3DAhE9rCafANs=;
        b=udzzYtKJk2iX0NwVoDqrg9g77KI+rAJnBn3kr4R0Unhn7Bme235BrS5EM0ZC36ZkJQ
         3eFDUGNnrenufMX+QgTAZ4bxcT46Mv8dS9Lk4WquaOsZM+590b19L7L6bOIM/VGpvO11
         4cvXk/0KP70yqCxyQIvacnJCkmJqScbj7SvMLoJOJTO3nueEbGCg4IdpcojNIQkxiOPR
         MfiRTeil0fgch2dcK7IAyJ3wQ8Jtuar2NDRi5vnlMvdDYw3+ELAp8CC+HdnSgxYo5IUQ
         vI3MXNBbHWQqfD3Gia3c5nlgkpVD0LqtucbMhnMTeQZyVt04XRTcAQ8a/ItMCvFU2CUz
         rzjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0wsyiB9N0YBjTuK2XZhcOxngpjKOdX3DAhE9rCafANs=;
        b=QSTb08fVJHS29eXYcr7XKg+ThFXm46IA1Y40eBU9UbK7FIyoW9SHmXpowub0sR5XKc
         luViNHYktnVtgj8RQE1MfqhvQ8uJRnfm5Bn8iAfo3gxWf/Wc7Xi8yXV1NHXcx+1aZN4v
         S/WyKaG0Ztdpv50li6Ua5kU00h0nbAWzh7OdUjJfvWdRh1V0OdMxiexr1/VHTuqmOfWp
         LQ4B7DW+2rWSze0b3cNime/JukleTH+I2JLzIckyxyGejNCnyqM4oPLxlN+l7c0ioGlk
         0wtnpV9OgWEp1col36yzAtrZBZSedfjpqnDV7mUts4y/jI7dZ8KgpCBSDdIWopkXVJUP
         +P/Q==
X-Gm-Message-State: ABUngvcupnbnii+fa7+26iXsMpmqTZAp2exWhpSWs2QDzYUxXWeEb8EXa4kUj9EeMrrWMRRNvkkrYGdKnHrBbg==
X-Received: by 10.202.241.136 with SMTP id p130mr3436220oih.186.1478503605792;
 Sun, 06 Nov 2016 23:26:45 -0800 (PST)
MIME-Version: 1.0
Received: by 10.182.142.68 with HTTP; Sun, 6 Nov 2016 23:26:45 -0800 (PST)
In-Reply-To: <alpine.DEB.2.20.1611041719140.3108@virtualbox>
References: <CADJspfL3zVCPv+mfRM_v4ukUggQkhGH7KB50a+HLPZXZqn1pXw@mail.gmail.com>
 <alpine.DEB.2.20.1611041719140.3108@virtualbox>
From:   Felix Nairz <felix.nairz@gmail.com>
Date:   Mon, 7 Nov 2016 08:26:45 +0100
Message-ID: <CADJspf+zqj2hHjD85dvt8Y4HKPViubvTzybbTq5mJDGCh2q1UQ@mail.gmail.com>
Subject: Re: git -C has unexpected behaviour
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        sbeller@google.com
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi guys,

thanks for the answer and the clarification.

From what you are saying I can see that this expects as designed. It's
confusing in the submodule case, but I get you don't want to add extra
rules which slow down performance and mess with other people at the
same time.

I will look into the git-dir solution, this seems to be exactly what I need.

Thanks, Felix

On Fri, Nov 4, 2016 at 5:36 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Felix,
>
> On Fri, 4 Nov 2016, Felix Nairz wrote:
>
>> Now, to the unexpected part, which I think is a bug:
>>
>> If the TestData folder is there, but empty (I deleted all the files),
>> then running
>>
>> git -C .\TestData reset --hard
>>
>> will NOT throw me an error but run
>>
>> git reset --hard
>>
>> on the git repository (not the submodule in the sub-directory!),
>> without warning, or error.
>
> I *think* that this is actually intended. Please note that -C is *not* a
> synonym of --git-dir. It is more of a synonym of
>
>         cd .\TestData
>         git reset --hard
>
> In other words, you probably expected -C to specify the top-level
> directory of a worktree, and you expected Git to error out when it is not.
> Instead, Git will treat -C as a directory *from where to start*; It *can*
> be a subdirectory of the top-level directory of the worktree.
>
> Please note that
>
>         git --git-dir=.\TestData\.git reset --hard
>
> will not work, though, as it mistakes the current directory for the
> top-level directory of the worktree. What you want to do is probably
>
>         git -C .\TestData --git-dir=.git reset --hard
>
> This will tell Git to change the current working directory to the
> top-level of your intended worktree, *and* state that the repository needs
> to be in .git (which can be a file containing "gitdir: <real-git-dir>",
> which is the default in submodules).
>
> If the repository is *not* found, this command will exit with a failure.
>
> Ciao,
> Johannes
