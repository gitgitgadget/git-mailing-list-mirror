Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7ECB1F404
	for <e@80x24.org>; Fri, 23 Mar 2018 22:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752118AbeCWWw1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 18:52:27 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33564 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751677AbeCWWw0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 18:52:26 -0400
Received: by mail-lf0-f68.google.com with SMTP id x205-v6so20492578lfa.0
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 15:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saville-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yMQMK5klUZ0Q6AQaiLDh5Cs0Xsra3RVx/8XATPz0byY=;
        b=QqtL+XW4X84T71Rxq2UlhHsMHpOtQcdP5yLZtZaxrarXpsslDma7K6aoDJG6OLmtBx
         EauTx689iqXH7kPc2PYOZkEXg32IHt5G8cpNHAXJENstlyZmARmqOEqDDxABksVWUlzD
         Hce2n1hpONa3m9digkC0kBrXg/+NvVfI6tF2oVNZmZJSkCrrovNNaNdEdLFBiISjtPGS
         XF5U3mGJt4VGt6DEb/SMhxauIQWITriW3fwTOdK6eY0ljsuiGYJy6OGa2cmtVFnv9ogy
         8NwNIbSdeIsG4nZASSjzUN9N+mMHAj9XlgyPq8q4G4ZDUwzhSYJy12/9qXrTUvyVtoRi
         /mcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yMQMK5klUZ0Q6AQaiLDh5Cs0Xsra3RVx/8XATPz0byY=;
        b=iawqLOxmBXJdeVoR2LVusOToRzh+dR7EStN9PmAj1tQcNGGC7gqwumg7PnM/VvqppG
         Y9YcM6AvVk/gERSmFbf6e0vELb2Yh9pOlO/LVCmXHcwDi6pqw/Rdmi16mbwdVOKPsYK7
         Sq7D/oJKLTtH7XtKkvqN6JhmuEcy3hkUq7qblz8ST8RNr7pkUHO/q2B/Qct9GTUVXZa/
         xStw0ZcxPpiq1TfbZcWqBPCW94sHvTnIBPCUTK4Zjv4zu5Tg4adODfNuXYwzT1+uTDkS
         2tay8fueVxcLWhexgAOSSo1h0H9HNj7IfmRxPw7p/UWIyh1eDrIKK3BPapWWEE1aiAHw
         Wu7w==
X-Gm-Message-State: AElRT7E9aNlBs8By9mgaWxnk8kWGV5hIUwKsbjSxhT1Ho6p4JKlSvCoD
        +9Mxo1WQDGBKqOPPrespkIkpKJy3PY5MFbOcJoSI5A==
X-Google-Smtp-Source: AG47ELvQAaS50U2Scba3Tpl7F/adUYdw1QWy5rrUcno/ziyEk/1o8S5FVBF3+fR16azguStg6ya5hj30x0eKi/0lQvQ=
X-Received: by 2002:a19:9e95:: with SMTP id h143-v6mr21862801lfe.129.1521845544769;
 Fri, 23 Mar 2018 15:52:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:9690:0:0:0:0:0 with HTTP; Fri, 23 Mar 2018 15:52:04
 -0700 (PDT)
In-Reply-To: <xmqqpo3uh26k.fsf@gitster-ct.c.googlers.com>
References: <cover.1521779249.git.wink@saville.com> <cover.1521839546.git.wink@saville.com>
 <e893a9d550f4d09baf0d21adedca841b96feae0d.1521839546.git.wink@saville.com> <xmqqpo3uh26k.fsf@gitster-ct.c.googlers.com>
From:   Wink Saville <wink@saville.com>
Date:   Fri, 23 Mar 2018 15:52:04 -0700
Message-ID: <CAKk8israKrrF4PBH4csLQDyrQXwap0oZ3FkihswR1DUf8nqrxQ@mail.gmail.com>
Subject: Re: [RFC PATCH v5 3/8] Indent function git_rebase__interactive
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 23, 2018 at 3:12 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Wink Saville <wink@saville.com> writes:
>
>> Signed-off-by: Wink Saville <wink@saville.com>
>> ---
>>  git-rebase--interactive.sh | 432 ++++++++++++++++++++++-----------------------
>>  1 file changed, 215 insertions(+), 217 deletions(-)
>
> Thanks for separating this step out.  "git show -w --stat -p" tells
> us that this is a pure re-indent patch pretty easily ;-).
>
> Overlong lines might want to get rewrapped at some point, and it is
> OK to do that either in this step or in a separate step.
>

The longest line in the file before this change was line 532 which is 108
characters, now there are three lines longer because of the indentation.
Line 762 is 112, line 957 is 110 and 985 110.

My initial reaction is to leave these long lines as is, but if you want them
shorter what is the maximum line length?  At 80 characters per line
I count about 25 lines will need to be shortened.

Also, I assume you want me to only change lines in
git_rebase__interactive.

-- Wink
