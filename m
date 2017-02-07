Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39C911FAF4
	for <e@80x24.org>; Tue,  7 Feb 2017 06:46:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752630AbdBGGqz (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Feb 2017 01:46:55 -0500
Received: from mail-qk0-f173.google.com ([209.85.220.173]:32777 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752068AbdBGGqz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2017 01:46:55 -0500
Received: by mail-qk0-f173.google.com with SMTP id s140so79046254qke.0
        for <git@vger.kernel.org>; Mon, 06 Feb 2017 22:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=lUbj4j2+/dg3h2cXeHdvD3gd/6tu9gSYiU44R87pZWk=;
        b=bTnu7tsFM0T8RWEDJRlZ5HyK70BeQDoRxtOPzkc/rrFHUlfdAG0H0mVDifntMggdHp
         PW7gbsXPMljsNcJ8oNWIHALKJUx89GwH4cU/2c6hI0kR2VNeiGmQK5vm3Rg5YUis9kYd
         Hixgn9tF7yuKEkdL+bE04kWKSs4dUnvB52n8aSmxBtpYaVgWeWpdFjbpKzFYdowZQbp8
         QJnHNfxk02S0RX+BNOr2thodFakSA3U/CljPIvPAqgwSsiqK9iqZxF72mFJUyWKCDMmD
         q4wAk71uvNwAcqbOAZwPrw/zEBDoSzGW7PzYEmK92o3qosJ9EykL8CPYBPVtNMTGcmNl
         yPQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=lUbj4j2+/dg3h2cXeHdvD3gd/6tu9gSYiU44R87pZWk=;
        b=DqA10dyLE/TW673OucKHKxwbI4Jp2bAzbkHoPRxky/aPMUiMyW8wRcil9E4V+6CtaI
         cz/c3RAK4QKu8Ze9Gw5GDyoEIo40QnihziEHntbsxecNHNObMnLkekBIg5SC6BtJP0if
         I1dFF2L21FlKTAkxg7DYeRnAdNICo28Dfp2whnymdMuITxDXO6N38LmOPDV5f0f45g4W
         UtNteJ+N0OlN5ddNYjdYs6AODjA4Y3cKjeDFx+4/T8rxam6teggzsezrM65/O3TF3fCW
         8xo+BhTT83txGz4jUhJQ7fuKHR6lpFHU/pP4/Rusqo7ujNSjLFPvPqvFrws1gduOzlyw
         c9hw==
X-Gm-Message-State: AMke39nW+5m9zeiHcFpcmg78HIDlr6k2YNUJmXFAIxIRtJymeAuMxpFZlghLa3R7Kw/3zVPzGN9ZweK5lav4Cw==
X-Received: by 10.233.220.134 with SMTP id q128mr12558517qkf.220.1486450013958;
 Mon, 06 Feb 2017 22:46:53 -0800 (PST)
MIME-Version: 1.0
Received: by 10.237.47.7 with HTTP; Mon, 6 Feb 2017 22:46:53 -0800 (PST)
In-Reply-To: <CABURp0qbKMfngfsC5pQeO+qyRPxa21vi090hMWDtLd+BBH_3Jg@mail.gmail.com>
References: <CANOj2JG5VuDtS30PfOrZ=4q8pTv_frY7=p+0g=UW3yV6ev+1KQ@mail.gmail.com>
 <CABURp0qbKMfngfsC5pQeO+qyRPxa21vi090hMWDtLd+BBH_3Jg@mail.gmail.com>
From:   Ron Pero <rpero@magnadev.com>
Date:   Mon, 6 Feb 2017 22:46:53 -0800
X-Google-Sender-Auth: sE5J6Zu500jZijDg89KOnEhLfxo
Message-ID: <CANOj2JGAaLLEHMs6KBf2PmCipqu-eYSGADzGGBzNVKwP0DTCtg@mail.gmail.com>
Subject: Re: Request re git status
To:     Phil Hord <phil.hord@gmail.com>
Cc:     Ron Pero <rpero@magnadev.com>, Git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phil

Thanks very much for your reply.

I do understand why git status should not automatically fetch from the
server. The solution is that I become aware of that nuance (yes, I am
fairly new to git) and conduct myself that way.

Still, one way or another, it was easy to feel tripped up by that and
some kind of verbal cue could help.
I wonder if this kind of message would help: Latest fetch: {timestamp}

BTW, you might consider posting your answer on
http://stackoverflow.com/questions/27828404/why-does-git-status-show-branch-is-up-to-date-when-changes-exist-upstream

Why? Because someone suggested emailing this suggestion to git@vger.kernel.org.

From the stackoverflow page:
"It would certainly be possible to add that extra text (behind a
config option so that redundant noise isn't shown if you how Git
works) but asking for it here isn't going to change it, try emailing
git@vger.kernel.org"

In answer to a couple of your points, I was not using force. And I do
understand that if I pushed to origin master it would have stopped the
merge, alerting me to the conflict. Thanks for that.

Thanks again,

Ron

On Mon, Feb 6, 2017 at 4:45 PM, Phil Hord <phil.hord@gmail.com> wrote:
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
>
>> Or change the message to tell what it really
>> did, e.g. "Your branch was up-to-date with 'origin/master' when last
>> checked at {timestamp}"? Or even just say, "Do a fetch to find out
>> whether your branch is up to date"?
>
> These are reasonable suggestions, but i don't think the extra wording
> adds anything for most users.  Adding a timestamp seems generally
> useful, but it could get us into other trouble since we have to depend
> on outside sources for timestamps.  :-\
