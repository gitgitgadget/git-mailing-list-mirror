Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 676491F404
	for <e@80x24.org>; Mon, 19 Feb 2018 23:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932218AbeBSXJq (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Feb 2018 18:09:46 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:35807 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932169AbeBSXJp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Feb 2018 18:09:45 -0500
Received: by mail-wm0-f45.google.com with SMTP id x21so17871103wmh.0
        for <git@vger.kernel.org>; Mon, 19 Feb 2018 15:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+2BM8VPbwutTcCKo2W0qhoJlvLwG4fnQXW9vYIbEc0A=;
        b=gRNr9bCaV+WmvRyvxiC3cyV7yqkDAjtInbzixQU6UlmT78cVSx0dgdjitbLuuhdmWP
         tJem56RICuZ83Q7gqth1l9nwEzC4qZFlfrHDM+TcQvtJkix+/2USmx96kdwXCw0qWOrt
         ZBp5H7WZDJcEakIGLP4x1Op1KygYBw65h70pfHwm59kF9y7rw6axuHocgqD/XyTCXBO/
         voLzzR1iklqmCNjhlGhy4Utq0wjEZ1dc8OJJXmdKTzfQ+KQ55fyKbo59Khx89/882yqN
         LoItKyQ4S38pn0az7FHWMbh5j4FACyUz4NSKAInLtdfEfO9cdlzaMqiLl2FD//8hNBvE
         9x4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+2BM8VPbwutTcCKo2W0qhoJlvLwG4fnQXW9vYIbEc0A=;
        b=XthLgOtSMAcBuGfy38ktvFgHyYcjGCr7T3hoCOqruQ7GtWy93MvWZyNdk3KcLlipEz
         vD8R61ghTRHSlFeyFLavkRCo1QM52mk6zTrHI7lTKyKomCkNJtF90qhRmwZc09284e44
         yB0lA88iUHwqFj3yxkKLJZtFg/nJXTtHaLS1VS808gOjJeiSA9e28OGCFp8IMwFQ/DW+
         +qA8vSXAVpSW2stc7D6h+aPpOOHd+fhW7M6jTimAGX18km0fln9hNQefxhQd3gkxErSF
         Xji/Se/j5cu6YfW/ivp0Dvy9/Td9EJKZPC7SreclAQqg9dC+A6q/ICikkRiliDLTnx8k
         5zZQ==
X-Gm-Message-State: APf1xPBK8A71QKF6jq359pDGGxt+g9xbpyfz2hAEvA2iR3GISrlDmm0n
        uRax2CQtdtHAP09eCUFhYo2e/aoxKwGJ/Au2JJ8=
X-Google-Smtp-Source: AH8x227Z0sKpjgk/c7WbSGpn2cMuw+JNu6jFs4himbXi3YK8F/3TGEeevXykuyrUVjj+n7i706gBqMNkWOVPBI9MS8k=
X-Received: by 10.28.107.69 with SMTP id g66mr11237233wmc.145.1519081783679;
 Mon, 19 Feb 2018 15:09:43 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.195.200 with HTTP; Mon, 19 Feb 2018 15:09:23 -0800 (PST)
In-Reply-To: <20180219223653.GE6619@genre.crustytoothpaste.net>
References: <CAE1pOi1XtrWqG7mOdrNt10YoZG0LOAB7i9cc1Gi8oWhULxE57A@mail.gmail.com>
 <20180219223653.GE6619@genre.crustytoothpaste.net>
From:   Hilco Wijbenga <hilco.wijbenga@gmail.com>
Date:   Mon, 19 Feb 2018 15:09:23 -0800
Message-ID: <CAE1pOi070p9VNPnLS3jSXp7TrbR2fhOc7sx+58exAp92k4D0dw@mail.gmail.com>
Subject: Re: Is there any way to "interrupt" a rebase?
To:     Git Users <git@vger.kernel.org>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 19, 2018 at 2:36 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On Mon, Feb 19, 2018 at 11:35:25AM -0800, Hilco Wijbenga wrote:
>> So a scenario like this:
>>
>> my-branch : X -> A -> B -> C -> D -> E -> F -> G
>> base-branch : X -> Y
>>
>> git rebase --onto base-branch HEAD~7
>> commit A --> conflicts
>> ... lots of work ...
>> commit B --> conflicts
>> ... lots of work ...
>> commit C (Git handles conflicts)
>> commit D (no conflict)
>> commit E --> conflicts
>> ... er, that should have been fixed in commit C
>>
>> How do I keep all the work I did for commits A and B? I get the
>> impression that rerere does not help here because I did not finish the
>> rebase succesfully (and that makes perfect sense, of course). Is there
>> a way at this point in the rebase to "go back" to commit C (so without
>> "git rebase --abort")?
>
> What I do in this case is I unstage all the changes from the index, make
> the change that should have gone into commit C, use git commit --fixup
> (or --squash), and then restage the rest of the changes and continue
> with the rebase.  I can then use git rebase -i --autosquash afterwards
> to insert the commit into the right place.

Yes, that's essentially what I end up doing too. Obviously, in cases
like this, Murphy likes to drop by so commit D will have made changes
to the same files as commit C and you can't cleanly move the fix-up
commit to commit C. :-( I had hoped there might be an easier/cleaner
way to do it.
