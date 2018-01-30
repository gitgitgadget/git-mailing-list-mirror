Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05EAC1F404
	for <e@80x24.org>; Tue, 30 Jan 2018 00:03:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752212AbeA3AC7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 19:02:59 -0500
Received: from mail-qt0-f171.google.com ([209.85.216.171]:45209 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752083AbeA3AC6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 19:02:58 -0500
Received: by mail-qt0-f171.google.com with SMTP id x27so15048995qtm.12
        for <git@vger.kernel.org>; Mon, 29 Jan 2018 16:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sMjde//ixxNq6323JKBC4TpPAAGnfY6kqMlsWSGgM3Q=;
        b=pvqe9gdgNnOQIN232zgiIccTk1NFqYgSDuHzNoEzOZmFRSgUEX/xNZkza3M9JTAjkO
         c7RFrhv8z90zh8LfM6s7h+4dnvGAPKFNt1iXp/Gvv8deQ1knpWvc1F9AH97dO4zYLWAC
         7EFn1N6RX4Eqr94C4V8n2+FpopZLzQnWS9CvySMFeoBPWMcr+tz2I5tEZJ7toBRmeqWs
         8q2IKm3hDW3E/Q45zDCg8ArawEnO39EEFfmSp0s2oHmuYYyf4lO6LFef+lu6L/ry2Gdm
         Yjk0iyuBn/gu+r5snQOvgrHoMLMaSYqo9ys8mjwwX7kEuGZVb3IYJHjrU6qQAUkw9Pv0
         U6XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sMjde//ixxNq6323JKBC4TpPAAGnfY6kqMlsWSGgM3Q=;
        b=lNmvg1scMKHxb2kHFxtMRrd9rP/yFxXlyFYT1UDfofmZ7+IWEZ8NOGAdPNjS2YjFr/
         GYmTBrphKbFoZIUeBX7igGav28m2cFHGJA9Cd2m3MLIWs3AI6jaxmyzmpBxKm6wTD3go
         l6iF296KeZ9/L4yWnbAiOxI+eV5Gdtyhiy3HAWSe7CHGEClMzFSb8F0Y/7aSiwr6rEPP
         lhx8wm4weLjkNtliCOHavwzp6dBVSe/3N7HJeXmxs5ahH4DJwoe0AvQv0qJmJNKXNojb
         iVh6wzh0BeWdkYPYTtGawFhNgL/Ww5Kr/O7wwMbJ6x7w/0oj3Wy6E65oJWEyc5Q5oMf/
         y5BA==
X-Gm-Message-State: AKwxytftm5Wc5m3ZuT/kUw9JdT/ovbfaPQ+jsP3pVmGMHY17OZhXD0th
        xPUdlNR2uSUJz+Biuvk6azYR714gWKVKtlCILfw=
X-Google-Smtp-Source: AH8x227NumcLUOmhiAPGXFw/4fjMQ9+0Ds8TrI4tgMyPzeN43MdyyuJcR9Y51ai17+Q3Cory5tlmWOUA26jEq35bY6U=
X-Received: by 10.200.26.163 with SMTP id x32mr42767658qtj.257.1517270577848;
 Mon, 29 Jan 2018 16:02:57 -0800 (PST)
MIME-Version: 1.0
Received: by 10.200.28.137 with HTTP; Mon, 29 Jan 2018 16:02:17 -0800 (PST)
In-Reply-To: <2df7b921-6fe2-d55f-4ef0-3f4f0bd69261@gmail.com>
References: <2df7b921-6fe2-d55f-4ef0-3f4f0bd69261@gmail.com>
From:   Andrew Ardill <andrew.ardill@gmail.com>
Date:   Tue, 30 Jan 2018 11:02:17 +1100
Message-ID: <CAH5451=Xdotsk-t56ZPdybuAURYbHYe8xzD7uU+ZZjSu3YtyWQ@mail.gmail.com>
Subject: Re: Bug/comment
To:     Ilija Pecelj <pecelj@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ilija,

On 30 January 2018 at 10:21, Ilija Pecelj <pecelj@gmail.com> wrote:
> Though it might not be considered a bug 'per se' it is definitely wired.
> Namely, when you type 'yes' word and hit enter in git bash for widnows, the
> process enters infinite loop and just prints 'y' letter in new line.

What you are seeing is a program called `yes`, the job of which is to
print the letter 'y' (or something else if requested) on a new line as
often as it can.

It is used, for example, when you want to answer 'yes' to all the
prompts a program may ask. See more at
https://en.wikipedia.org/wiki/Yes_(Unix)

I agree it's a little weird if you have no idea what it's doing, but
it is very useful and very old, used by many many different scripts
etc, and so unlikely to change.

Regards,

Andrew Ardill
