Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CBF220989
	for <e@80x24.org>; Wed, 12 Oct 2016 11:06:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752287AbcJLLG2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 07:06:28 -0400
Received: from mail-vk0-f44.google.com ([209.85.213.44]:36436 "EHLO
        mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751847AbcJLLG0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2016 07:06:26 -0400
Received: by mail-vk0-f44.google.com with SMTP id 2so44025687vkb.3
        for <git@vger.kernel.org>; Wed, 12 Oct 2016 04:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=v0+oPXMYbOgmi6RUy5tjonxBMbK1ltocT9OdPRVj43M=;
        b=RunqWBkzvdmkJ6zAM7K6o5Qhjcy4S7XXL6oc2pPnT9uRj+eGB2046DJi9VqVIQ9QzN
         En7z6K9Svh19eT+ihqaVxtx8poobFnl1aGL/abKm5eZzVhMLsO1T9/23rmM3+fPH1g94
         tlCgm+EEN644w2UTRI3z+DkOr8tydZIEXUwflfi59snPO29c9HOERRs5JuZmgoW+OE+0
         sLl10KCR3zS/ZYTx1wHFMeR4Agq2M0HnBWO+Mh0NvpHP9kjo/0UhPD/LFI7squejki4d
         CoQvuyPUNChdj4HfsJvHmiJ1mV/ekJgDHQ3lJvg0i0hhV94sMNjFTxaYoeXaRxO+GKYz
         oH6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=v0+oPXMYbOgmi6RUy5tjonxBMbK1ltocT9OdPRVj43M=;
        b=AGyzAo4LicomydD/PhPnZcwiuJc9adSDNpVUUf5QmGDnEqm9dB2eE79httlC2ml+mR
         jniiAD55kO7n6wtZNa5dYaH47r4eqOGCWRy3gGZuvmNq53zS6olK3vRwR2HsIwR6emyh
         ncJItCVnQnE/Apn2o2votzGV6x6JdHE+WpQU8ZarufabbRNhX20/2dvxcrGmS6MTb59E
         ZJhXiblfXITFgtt8GhLyUV42rJM+d0YUImqLYdhMzWgQjsccWD7wZRviBv2te97yJK9S
         eotzIM9GyUqgTsx63HEk75rC7RWnI6kRhI97+WgN+mpY20dwpUZcr5m9F9A4NXhih5s1
         PGIA==
X-Gm-Message-State: AA6/9RlSTXHtmiGl9PCitUolsVCkOfuvuowu/P6GXTjQr/yMUobFpja29MfvWFzcshdAp/H25ufiq82cOwOjtA==
X-Received: by 10.31.56.204 with SMTP id f195mr194395vka.61.1476270385322;
 Wed, 12 Oct 2016 04:06:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.81.37 with HTTP; Wed, 12 Oct 2016 04:06:05 -0700 (PDT)
In-Reply-To: <1066408917.43087.1476269456819.JavaMail.open-xchange@app06.ox.hosteurope.de>
References: <1066408917.43087.1476269456819.JavaMail.open-xchange@app06.ox.hosteurope.de>
From:   Mike Rappazzo <rappazzo@gmail.com>
Date:   Wed, 12 Oct 2016 07:06:05 -0400
Message-ID: <CANoM8SUtrV8CD8M=4CUB8xr9gQj_hKzGOdjQZHuz4+36y_UfJw@mail.gmail.com>
Subject: Re: git diff
To:     webmaster@peter-speer.de
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 12, 2016 at 6:50 AM,  <webmaster@peter-speer.de> wrote:
> Hi.
>
> I created a new branch named hotfix from master.
> I switched to the branch, changed 1 file.
>
> Now I want to see the diff from the both using
>
> git diff hotfix master
>
> I do not see any output (difference).
> When I do a git status I see my file with status mofified, not staged for
> commit.

Since you just created the branch, and did not add any content, there
is no difference to see.  A branch is just a pointer to a commit.  You
now have two pointers pointing at the same commit.

If you want to see the difference between your changes and the master
branch, you can omit the first reference:

    git diff master

When you start adding commits to your hotfix branch, you will be able
to see the diff between that and master with the command that you
gave.  However, your arguments may be in the reverse order than what
you expect.  You want to specify master first because that is the
mainline branch (I presume).

When you have several commits on your hotfix branch, you can refer to
older commits to diff against.  There are several ways to refer back,
but the simplest is to use a tilde '~' followed by a number to count
back.  For example 'hotfix~1' refers to the parent commit on the
hotfix branch.  There is a lot in the documentation[1], so take a look
there for more info.

Good luck.
_Mike

[1] https://git-scm.com/doc


> Also, I can see that I am working with the correct branch, hotfix
>
> What am I doing wrong?
>
> -fuz

On Wed, Oct 12, 2016 at 6:50 AM,  <webmaster@peter-speer.de> wrote:
> Hi.
>
> I created a new branch named hotfix from master.
> I switched to the branch, changed 1 file.
>
> Now I want to see the diff from the both using
>
> git diff hotfix master
>
> I do not see any output (difference).
> When I do a git status I see my file with status mofified, not staged for
> commit.
> Also, I can see that I am working with the correct branch, hotfix
>
> What am I doing wrong?
>
> -fuz
