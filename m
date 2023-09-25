Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12EB6CD4857
	for <git@archiver.kernel.org>; Mon, 25 Sep 2023 18:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbjIYSzu convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 25 Sep 2023 14:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjIYSzs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2023 14:55:48 -0400
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9DA95
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 11:55:42 -0700 (PDT)
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-65b0383f618so19242296d6.1
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 11:55:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695668141; x=1696272941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yTVjTwcw76pmQZr8KlAU/gNl4XR/EW5t2Y/mIgsnlok=;
        b=OsM08jRcTipBGcuwpO5sJMSqyl88XxQlUwsvhP0sjza/dKIV9JCtby32KY+aAToozh
         TjdHTIym63/ARNmkpBOPtl8JdnbbJtIiD1kAO8Y3M2QfL0StSBwfFwIlGfwbQAC8UYV/
         oNmjCSv7o45VcFeyM2nJLKQWm5t6kp5Ut7jARLUCZZuiw3uehguNVRKRk9j7nNBUu+ZS
         d32k91Hs4N1a3mLJHx1PNwE0DtEH8Q7kpTlA/i+DIk43Atn8Lrti1FKc0K7P1ieOHVvH
         lC4p3OwBHnwqwV8DyGGoDK2uyPZM/DuYr8AoxkQbAMvUP5Qd8tJel7d5iIu08C5DBe/C
         NbIg==
X-Gm-Message-State: AOJu0YxuA8afvyFRIPXTUEgd+VeWXFPbZkbhxiqrGrI7IW6690Y0koRp
        0OsyRBPPvMMvuBrpkrvt758n62IoZ1Qm4cFaKBs9HcYAdX4=
X-Google-Smtp-Source: AGHT+IE1S4aCen7cCPBQeaNUvuwNRGG+jtev+rhEnyyRLUblCQFZFiss+gXtLoMduOqyk6ymNHvxubqgyytKeXCwPfY=
X-Received: by 2002:a0c:f246:0:b0:64f:3f48:b6e1 with SMTP id
 z6-20020a0cf246000000b0064f3f48b6e1mr7018646qvl.19.1695668141064; Mon, 25 Sep
 2023 11:55:41 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1589.git.1695392027.gitgitgadget@gmail.com>
 <pull.1589.v2.git.1695553041.gitgitgadget@gmail.com> <xmqq34z2ump4.fsf@gitster.g>
In-Reply-To: <xmqq34z2ump4.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 25 Sep 2023 14:55:29 -0400
Message-ID: <CAPig+cSQGxhsQOEe+-XDfF0DujDpvz0iZpQUDvZpz4byNzLxiQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Switch links to https
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Josh Soref via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Josh Soref <jsoref@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 25, 2023 at 2:35 PM Junio C Hamano <gitster@pobox.com> wrote:
> "Josh Soref via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > cc: Eric Sunshine sunshine@sunshineco.com cc: Josh Soref jsoref@gmail.com
>
> (administrivia) I am not sure what effect, if any, this line has.

GitGitGadget specially recognizes Cc: trailers in the pull-request's
description[1] to ensure that the named individuals receive a copy of
the emailed patch series, so this is a good way to Cc: people who
commented upon previous versions of the series. Unfortunately, in this
case, it appears that GitGitGadget ignored the two "cc:" lines because
they weren't proper trailers; there are additional non-trailer lines
following them in the pull-request's description (and they were taken
as just more Markdown body content).

[1]: https://github.com/gitgitgadget/git/pull/1589#issue-1908988061
