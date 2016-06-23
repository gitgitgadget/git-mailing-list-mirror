Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 257632018A
	for <e@80x24.org>; Thu, 23 Jun 2016 23:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751832AbcFWXpz (ORCPT <rfc822;e@80x24.org>);
	Thu, 23 Jun 2016 19:45:55 -0400
Received: from mail-qk0-f171.google.com ([209.85.220.171]:35866 "EHLO
	mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751537AbcFWXpy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2016 19:45:54 -0400
Received: by mail-qk0-f171.google.com with SMTP id p10so127215723qke.3
        for <git@vger.kernel.org>; Thu, 23 Jun 2016 16:45:53 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gZXLQDeLvoTvOxkcKvqmhn6Df+hsBl7/58Qod0S4tAs=;
        b=eNr5j2dC7Fa4RvF8QuyodCWRLzyLcjxFruxsvh8KGjR8RYW/S/scIAqnkhMe+NmoKa
         7Wyylj1bpAn0NyqTZCBw5x81Dcm54gI+Yk1597vgenIBJqRqubNejFAH6vncOUcs0iVX
         ki5serAF3TfQwVLL6nQG6c0zwHyThdqHz9Hc30tv7M4co1XO1QOOKUwaeVaDmEFOq1ps
         aO3Fr5ptHv78fBf68yu2GC5GhjC4g9cvIy7x9SMiYOEPWhEqP8ilGySBH2cEiuNnKE/N
         03mRUC0WcNSETCmXVysWkRPp1scZzDEJ0gtirWZIcIVpRfGcV4dsBMxY0ac4+EHKC56f
         au2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gZXLQDeLvoTvOxkcKvqmhn6Df+hsBl7/58Qod0S4tAs=;
        b=Y0B7OUlCrGrW9UKmrvxS7N9yPhqvnVyyOKfCf1+IRbyajsX/7kq8GsWHkqPyMYsnqe
         tCRxVZoqa/8MYyyvgt1OGfXCnh9nacWw55NB5nBtZj+PoODHFQK2b22V/JMYPGq9TLwc
         UjvBQmCtPFz8vHgpmzVrey9ue89d3n76CTbyqwDuINQB3denovWq0AZigzbysvPIphNj
         5W5oN+bxDPuyQviXPwdaiV6LCF4/nF8xdXxFfuxvIYiyUh/KeaxJZzZt3b9qfiMmttbP
         LzcDyDXbx5x7LNEr6KXWqEatvpbcSzqq0rMAJzEaXXuAq5o9QHVH/yM/mWuKCjh0/KUJ
         DlxA==
X-Gm-Message-State: ALyK8tJfhU/tg+/D56whINTzCkhoA5qY5nxiIY0C6Bx2eem9Y9Rh6ytNXQFBDT6hk7d+Qh8bZWX3iFWrgCb/vg==
X-Received: by 10.55.36.202 with SMTP id k71mr1272235qkk.92.1466725553191;
 Thu, 23 Jun 2016 16:45:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.200.49.65 with HTTP; Thu, 23 Jun 2016 16:45:13 -0700 (PDT)
In-Reply-To: <CAB-vh3v1v4+jfs1cyDS-Ft5_1ibGqLzzzmJK-s7MHjVPR3uYaQ@mail.gmail.com>
References: <CAB-vh3v1v4+jfs1cyDS-Ft5_1ibGqLzzzmJK-s7MHjVPR3uYaQ@mail.gmail.com>
From:	Andrew Ardill <andrew.ardill@gmail.com>
Date:	Fri, 24 Jun 2016 09:45:13 +1000
Message-ID: <CAH5451khnqR+jhP9nEOJLNahghaRXBnRvedn0GgV8KcHzAysBg@mail.gmail.com>
Subject: Re: Git Bash Slow in Windows (possible fix)
To:	UberBooster <info@uberbooster.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Michael,

First up, Git for Windows has a dedicated issue tracker over at
https://github.com/git-for-windows/git/issues you may want to submit a
bug report there (reference this email if it's easier).

On 24 June 2016 at 02:02, UberBooster <info@uberbooster.com> wrote:
>
> Back in February 2016, I installed Git-Bash on my Windows 7 computer
> and everything worked great.  Git-Bash would execute commands as fast
> as the Windows command prompt.
>
> In June, Microsoft, in its infinite wisdom, decided to self install
> Windows 10 without my authorization.  Now when I used Git-Bash, it was
> painfully slow

Is there a chance that git was also upgraded at the time?

If the slow-down was caused by some change in git for windows it would
be useful to identify when that happened.

> After speaking with some people about this, they recommended that I
> inform you of my situation as it could be something that Microsoft
> installs as part of Office that helped make it faster.

I don't know of anything specific, but if the upgrade path you took
assumes something is installed (when it isn't), that is something that
may be able to be fixed.

The reason this seems unlikely that that is all that is going on is
due to you seeing the behaviour on a completely fresh OS and git
install.

If you are able to give more details in the bug report about how to
reproduce the behaviour that will help a lot too.

Regards,

Andrew Ardill
