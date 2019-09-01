Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DB981F461
	for <e@80x24.org>; Sun,  1 Sep 2019 18:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729007AbfIASZA (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Sep 2019 14:25:00 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39965 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728930AbfIASZA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Sep 2019 14:25:00 -0400
Received: by mail-lj1-f196.google.com with SMTP id 7so1326305ljw.7
        for <git@vger.kernel.org>; Sun, 01 Sep 2019 11:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=mHw3wkIlldEcF23rY7TUtH6F0T9A3kLW+AfThwXezxg=;
        b=CjgXbxswZN7fsdS1DeX/k6kOuu0LQuF2mXzf21dYwT7HkPEwe2yktKi513Z6Eop4Iz
         augw5bT4U13tujKNrCUa+iyM1HpABdHUE1mhHRmg2MxH2zBQHh1XGQIIu2NPB2BZrzyW
         WCZkWCa1sxZGDu8QZtWRUPjlYqEbiyfeChfXJvYkMJJwgVdJwCvfcGWUKNspLMKpCsnr
         JNQysjMyrysmcYvjpRlP6NhaJz0Vxykgn2QMb4BQTpL8FUkuenWkSeHYfp/ALH2iQAfG
         KxIPtuTxvRibuMsbroTdNanC7t7i9ntG+ZGmCNixW4AJ3eo/SRnQT6BN0DQ4ielSJXa4
         f8Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=mHw3wkIlldEcF23rY7TUtH6F0T9A3kLW+AfThwXezxg=;
        b=amQW5EhRPr6M6XpzsDoxkHpQT8DIBazSmG9+/yZKVRtBKVHoA8uO5aKj1RfxXi1IAF
         DRkHfSp6wxE53qOaMm9Kqz1FFLwmIalJ6w97UVpGAgYI+1fEY1pivioevBuQHWlvCSYJ
         mzlzfd7HYx+SjskhVrKoq40a0gu/EqcYLksFva3sRiZWbYm5p2KB+3YvmfkaC5w4rmSl
         g5PwP6ziA1r/NfdRcas6XR6pCMivZsLhmDjbBNG26oe9R0n4LQDicHn/I3XWGBiDmMOS
         OtlB2WQTYKi3IsGDCKBttkfAqXz/LTaR11jhRTlaNklunwd8/hzp9apil/eJIJRR9hlw
         768w==
X-Gm-Message-State: APjAAAWYSbI13g2yKwfnMQ4URNcvsyoZ/PsQdc1j++tIQiTmRIXx/RdI
        KnMqHCuiIcoYfT12xm6YD1CDmEuSZmI/PNJ/fcO0pe0/
X-Google-Smtp-Source: APXvYqzS58aoJ6hbHZ6zGOM76t2UYN5xS94kjlLA9fKw6OBQxQvnX688mVhV8ydrzlSbKGOwkpkmashfA5vYK4LBBwc=
X-Received: by 2002:a2e:5c5:: with SMTP id 188mr14540412ljf.166.1567362298434;
 Sun, 01 Sep 2019 11:24:58 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqbmg13sxq.fsf@gitster-ct.c.googlers.com> <20190831122326.9071-1-birger.sp@gmail.com>
 <20190901113218.3lfu4ifsxhzrsw4g@yadavpratyush.com>
In-Reply-To: <20190901113218.3lfu4ifsxhzrsw4g@yadavpratyush.com>
From:   Birger Skogeng Pedersen <birger.sp@gmail.com>
Date:   Sun, 1 Sep 2019 20:24:47 +0200
Message-ID: <CAGr--=+x6rdb9wexJ3bo+yZu3_zgNB48Ku-jDbcAnQ2We77cSQ@mail.gmail.com>
Subject: Re: [PATCH] git-gui: Add hotkeys to set widget focus
To:     Pratyush Yadav <me@yadavpratyush.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Pratyush,


(New patch according to our discussion coming up)


On Sun, Sep 1, 2019 at 1:32 PM Pratyush Yadav <me@yadavpratyush.com> wrote:
> In case you haven't been following the list, Pat has been inactive
> recently, so I am acting as the interim maintainer of git-gui for now,
> because no one else stepped up and Junio would rather not maintain it.

I saw a discussion about it some time ago. But I didn't catch that you
are the maintainer. That's great! I use git-gui all the time, so I'm
happy to hear someone is going to maintain it.


> ... it would be great if you base them on my tree next
> time around.

Okay, I will.


> I have recently been going through the git-gui code, and my biggest
> gripe was non-descriptive single letter variable names. So maybe
> s/w/window/

I agree about non-descriptive variables. I was following the style of
the rest of git-gui.


> If some files are added/removed via an external command, that means the
> index we choose won't be the file the user last looked at, correct? What
> about using path names instead, so we know exactly which file to
> display, even though its index might have changed?
>
> But if it is not a trivial change, and needs a lot of work, I'm fine
> with the way things are. If the user changes stuff outside of git-gui,
> some side effects are to be expected.

A somewhat non-trivial change, for me at least. To implement what
you're suggesting, I'm gonna need some help or the patch will be
delayed quite a lot...

So honestly, I'd appreciate it if we could leave it like this (for
now, at least).


> > +
> > +             if {$_index eq {}} {
> > +                     set _index 1
> > +             } elseif {$_index > $_list_length} {
> > +                     set _index $_list_length
>
> Just to be sure: _index should start at 1 right, and not 0?

I'm quite sure this is correct. Setting the index to 0 throws an error.


> If _list_length is 0 (iow, no files are staged/unstaged), this won't
> change the focus at all. Are you sure this is the desired behaviour?
> Would it make no sense if we switch to an empty pane? The user did
> explicitly hit the button combo to go there. Yes, they won't be able to
> actually do anything, but what is the harm in switching focus if the
> user explicitly requests it?

An error is thrown if we force focus to the "Unstaged Changes" widget
when it has no files listed. The same goes for the "Staged Changes"
widget. That's why I put the condition there.


> Do you expect these functions to be re-used somewhere in the near
> future?

Not really, but I feel the "key bindings" section of the script should
have as little logic as possible (and just be a bunch of key bindings
invoking functions).
Also I think function names are a good way to describe what the code
is doing, so personally I actually think it's better like this.
But if you feel strongly that it should be like you suggested, I'm open to it.


Best regards,
Birger
