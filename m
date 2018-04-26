Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 648561F424
	for <e@80x24.org>; Thu, 26 Apr 2018 15:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756431AbeDZP0u (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Apr 2018 11:26:50 -0400
Received: from mail-ot0-f169.google.com ([74.125.82.169]:35001 "EHLO
        mail-ot0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754556AbeDZP0t (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Apr 2018 11:26:49 -0400
Received: by mail-ot0-f169.google.com with SMTP id h8-v6so26158671otb.2
        for <git@vger.kernel.org>; Thu, 26 Apr 2018 08:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2Q2LxqK9yKzIkGvNW9Iz2nnW5foPNkFs0TeAuGgr+N4=;
        b=sgbmX53QogKmud6bjFtO0LUwDOFhU5kEKZvQa6fVGfrEL0Nfkqx45qodL4HgYg8Y9r
         2XrJyRPS9VDWprf1ij8qr4pjV+Zu6Gu7zIvH0JO8Q5ToAFBtVIYq472oiEgYgMc12Uw3
         xbS3e1Db1PWw+menviJIQfUIA1CfAEPDcOLjXQ4Y+9iTNlXza9UxxOeZoqE8sWGhg4NN
         CUgnC8LdLyn+GMp4QIs+JMsofH74ZM1kD4mnDdYkIsCKLdXSMMAJRjEe9qA7aQ890TiG
         fJGtL5Dwu4IchhBWBnyMTZxF1c0aESRdxYA/LjxuQ2QtVKLpPqLSYoRRGySmRu+iiA9E
         pDUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2Q2LxqK9yKzIkGvNW9Iz2nnW5foPNkFs0TeAuGgr+N4=;
        b=Sh7XyH8g5KaUK8Ki8cn/wTH+mJK0UMfwGyUj4H2n1PO7dXct3CecRT+H3hcBtnPXQ2
         7SkJ/13WGRFxNg9hoaMs8z9/TtZ3ooeLunujlRtmrA439vCo1/HVlmP/KQ9hU2yJtRoI
         l/mBaDyqx4AAKmFcoQYaawiyXwDFu4xX8Uyu4q/psV6CpeRazSX4sASNJjs6ArbVymQB
         YOhT08Aru02c2U2PC+V3VQf7GFODfZwnmFREbzv6DUZ5Df5BPCwwyYOE+77U+w8sZ6Lg
         YpEt7Y6vU0camiuRxrilldpA3f5i93qpg2X2PfYmW1tVHTBbXkwLoDEU7N/PTifDw2pF
         qXRQ==
X-Gm-Message-State: ALQs6tBhp/NJqUi12kVCcKLnqXqRrBckjTt5eBIZ7iPf1TxFFFdI75DQ
        18erqiLjqoKx6hafjANUicbK79VXq6UFcL1aMDQ=
X-Google-Smtp-Source: AB8JxZrYBfkGO2GUFd/F9Bo5phfAAg7dKjDcUMf+LvIT3jPIenwSeZo4H4mACBPyAYPnBXFdrvm6sFqXfzCnQxvV0N8=
X-Received: by 2002:a9d:1d92:: with SMTP id y18-v6mr9023798otd.304.1524756408774;
 Thu, 26 Apr 2018 08:26:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.198.152 with HTTP; Thu, 26 Apr 2018 08:26:18 -0700 (PDT)
In-Reply-To: <xmqqmuxr4r6n.fsf@gitster-ct.c.googlers.com>
References: <xmqqmuxr4r6n.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 26 Apr 2018 17:26:18 +0200
Message-ID: <CACsJy8CuVRy4UPEwXJJYAjePEz5zjKMLhRjh9UFw0DPYTzobkw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Apr 2018, #03; Wed, 25)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 25, 2018 at 10:37 AM, Junio C Hamano <gitster@pobox.com> wrote:
> * nd/pack-objects-pack-struct (2018-04-16) 15 commits
>  ...
>
>  "git pack-objects" needs to allocate tons of "struct object_entry"
>  while doing its work, and shrinking its size helps the performance
>  quite a bit.
>
>  What's the doneness of this thing?  The interdiff since previous
>  rounds looked reasonable, but I didn't see this round otherwise
>  scrutinized by reviewers.  The numbers given in the commit near the
>  tip do look impressive, though ;-)

I think it's ok to move it to next, though I'd prefer to move it to
master just right after a release so it gets tested for a whole
release cycle. This also gives Jeff a chance to check it after he's
back (if he wants to).

> * nd/repack-keep-pack (2018-04-16) 7 commits
>  ...
>
>  "git gc" in a large repository takes a lot of time as it considers
>  to repack all objects into one pack by default.  The command has
>  been taught to pretend as if the largest existing packfile is
>  marked with ".keep" so that it is left untouched while objects in
>  other packs and loose ones are repacked.
>
>  What's the doneness of this thing?  The interdiff since the earlier
>  one looked reasonable, but I didn't see this round otherwise
>  scrutinized by reviewers.

This one should be safer than the previous one. I think it's ok to move to next.

Anyway I'll re-read these two series this weekend to see if I could
spot anything new.
-- 
Duy
