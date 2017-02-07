Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 500FC1FC46
	for <e@80x24.org>; Tue,  7 Feb 2017 14:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754250AbdBGOyu (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Feb 2017 09:54:50 -0500
Received: from mail-vk0-f41.google.com ([209.85.213.41]:35968 "EHLO
        mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753888AbdBGOyt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2017 09:54:49 -0500
Received: by mail-vk0-f41.google.com with SMTP id t8so79302919vke.3
        for <git@vger.kernel.org>; Tue, 07 Feb 2017 06:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pufP5wz9CfkVQCKkC+PIj/WOyr2UdamAVs/VTFyT1Lo=;
        b=G7lHuISmhiDZfgusdsfu1LDqaXuykWGP6v0sgmUZDRCtgZnc2gjvnj9Uqk1HqEvF74
         bB6CqmtPC3XZqtFoAJADtYlF6Ouw8Xq568P70G4T3nPogSyTNx69II9SBQ/Ey8wFAApV
         CRwVcnUyF2hCN2NilRXfJcXJzUvWscTlw1a1U+lFxTDiMT8t5OQbzk5jLvz29DxMYcoS
         KMFjx2N1UPCFzFKFA4OUhVDZxN/okrMN3OEx4Q9kfqgAo6Qb9BsFBnheR5oM45+uUGP9
         VArRCBlwVNlEgYAUsq2lbk/wbjfR5nXbsgVuRY8S6pcWKtDHW0Rn69DNwGGE5Du+gtLF
         fTfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pufP5wz9CfkVQCKkC+PIj/WOyr2UdamAVs/VTFyT1Lo=;
        b=s0k6NubfHDHs9PjJzrJoIY8UkiWiLdwwnQkwjiKXDY8YBJPPwQYuoJUB4jThPjkAGV
         2wvY9kXBPSaNREFw2j6zkAZ80itaTF/47mUB5+9tb8brOyMiTHR0drQ3WxskFrl95nTs
         TobrhlFRneZF5QnTtq2KFpxsF4ISCGbwsyw3R3VLgQwcQa3nJfUxHvJehIoJF6eYlMZu
         Sfz+3UGeP6CaDFnTaPUbq+cFRtbYke8WGDDythz6ajnTPUDHWwNZl7znMKl9Ky2Vzc00
         0fYrkEe5WQLHtyRYInVvT8V4kq4rENO7iGP1CuiX6IsfDTdotCkUjj1PPG5ZJacC/7ca
         hCPw==
X-Gm-Message-State: AMke39nEej0r51eiduBuyeVVS1tw8aPWNsx/I+2bOkbys2OG+U6AF0LFkFNzNItZ2fM0QgKo5XDzONwUbHt2xg==
X-Received: by 10.31.169.16 with SMTP id s16mr5902615vke.21.1486479288239;
 Tue, 07 Feb 2017 06:54:48 -0800 (PST)
MIME-Version: 1.0
Received: by 10.159.34.48 with HTTP; Tue, 7 Feb 2017 06:54:07 -0800 (PST)
In-Reply-To: <CABURp0qbKMfngfsC5pQeO+qyRPxa21vi090hMWDtLd+BBH_3Jg@mail.gmail.com>
References: <CANOj2JG5VuDtS30PfOrZ=4q8pTv_frY7=p+0g=UW3yV6ev+1KQ@mail.gmail.com>
 <CABURp0qbKMfngfsC5pQeO+qyRPxa21vi090hMWDtLd+BBH_3Jg@mail.gmail.com>
From:   Samuel Lijin <sxlijin@gmail.com>
Date:   Tue, 7 Feb 2017 08:54:07 -0600
Message-ID: <CAJZjrdWbqvBRtyyfhgAt1E9ZdTUaz+Zpk7iGasNoeSuFJbsKog@mail.gmail.com>
Subject: Re: Request re git status
To:     Phil Hord <phil.hord@gmail.com>
Cc:     Ron Pero <rpero@magnadev.com>, Git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 6, 2017 at 6:45 PM, Phil Hord <phil.hord@gmail.com> wrote:
> On Mon, Feb 6, 2017 at 3:36 PM Ron Pero <rpero@magnadev.com> wrote:
>> I almost got bit by git: I knew there were changes on the remote
>> server, but git status said I was uptodate with the remote.
>>
>
> Do you mean you almost pushed some changed history with "--force"
> which would have lost others' changes?  Use of this option is
> discouraged on shared branches for this very reason.  But if you do
> use it, the remote will tell you the hash of the old branch so you can
> undo the damage.
>
> But if you did not use --force, then you were not in danger of being
> bit.  Git would have prevented the push in that case.
>
>
>> Why ... not design it to [optionally] DO a fetch and THEN declare
>> whether it is up to date?
>
> It's because `git status` does not talk to the remote server, by
> design.  The only Git commands that do talk to the remote are push,
> pull and fetch.  All the rest work off-line and they do so
> consistently.
>
> Imagine `git status` did what you requested; that is, it first did a
> fetch and then reported the status.  Suppose someone pushed a commit
> to the remote immediately after your fetch completed.  Now git will
> still report "up to date" but it will be wrong as soon as the remote
> finishes adding the new push.  Yet the "up to date" message will
> remain on your console, lying to you.  If you leave and come back in
> two days, the message will remain there even if it is no longer
> correct.
>
> So you should accept that `git status` tells you the status with
> respect to your most recent fetch, and that you are responsible for
> the timing of the most recent fetch.  To have git try to do otherwise
> would be misleading.

This argument doesn't work for me. Race conditions in *any*
asynchronous work flow are inevitable; in commits, particularly to a
shared branch, I also can't imagine them being common. It's like
saying because there's lag between the remote's response and the
output on the local, `git fetch` shouldn't bother saying that the
local remote has been updated.

It wouldn't be hard, though, to define an alias that fetches the
remote-tracking branch and then reports the status.

Nevertheless, this is one of those cases where I think Git suffers
from a poor UI/UX - it's letting the underlying model define the
behavior, rather than using the underlying model to drive the
behavior.

>> Or change the message to tell what it really
>> did, e.g. "Your branch was up-to-date with 'origin/master' when last
>> checked at {timestamp}"? Or even just say, "Do a fetch to find out
>> whether your branch is up to date"?
>
> These are reasonable suggestions, but i don't think the extra wording
> adds anything for most users.  Adding a timestamp seems generally
> useful, but it could get us into other trouble since we have to depend
> on outside sources for timestamps.  :-\
