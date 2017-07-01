Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8802E20209
	for <e@80x24.org>; Sat,  1 Jul 2017 17:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751890AbdGARpU (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Jul 2017 13:45:20 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:34284 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751389AbdGARpT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Jul 2017 13:45:19 -0400
Received: by mail-pg0-f53.google.com with SMTP id t186so77544927pgb.1
        for <git@vger.kernel.org>; Sat, 01 Jul 2017 10:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=w0zGylEkqyUFNk0fKgqLdIOrE9T2IcVY/ayn2b9O3bA=;
        b=uJGZyZcZaseGMn+4PNt2GKcM3qVE4giZ9Q1EczayVO78QQLh5U4kjyZS5WgVkxxrKl
         Xlp7mIUD7wafMIiS+Q9JK8c5Qy5e72idjOZpMrE8WfR7TACrSpk6WxhYoQd6NpSiNKGs
         inUM/IP2iM0HdsUv2YP3qUh7lQ5Ypc5s5jI103zi56TQOX7ZPWyI3IVGRH9njspSszNY
         tTcl+ZqdN4fJVFyNCacLykhuSYZRiAwn9QHYnJj6e0BMcpk/ZNi7CE6RBlncmMyTV1Py
         aacBjCIkfe0TCehxdKZbP+WCxwp4Kk4GZBGUUGUN0CaxgYIz+V+NjZvJHxhDbak8vzDI
         iEzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=w0zGylEkqyUFNk0fKgqLdIOrE9T2IcVY/ayn2b9O3bA=;
        b=swWfpzJAxw0tYy+tD/Aw5uwEgCAuKBBoQqfaM0On7dwaDpzLbrX5R+Y5Jg0cQIsMlE
         PCXYbkOKwS69MhTCRLzn6H7liJcW0kmH7TjuiWD42pNJiE4wVpB2SBUcjxt3OAvgM5xA
         vW+5t/ks6qO6wS3ajhd1jEz0nUXF2JG6/xhdX2W5F4/r+O7Dy04SZ7gmU62GmieVC+oE
         K95rAN5NiTEPWtWETEZMK33EYuDcQLUZqPSu5RK9ssfHICXwqtNxlkfGp6H+dr6MIehw
         262exZypA0nP8stZEWBu1ywapF5+39LOSWkjxpjrVPI/oEG70IoaheNS0HOMkpjJBCUX
         WEHA==
X-Gm-Message-State: AIVw110V6nxM22t1sTXohe7zePhtnXFqyug6Et3eC0ghFiD3y2kOtBJt
        M1W0Rahz4O31Rg==
X-Received: by 10.84.232.14 with SMTP id h14mr1712410plk.28.1498931118704;
        Sat, 01 Jul 2017 10:45:18 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:fd45:ceab:278e:5d13])
        by smtp.gmail.com with ESMTPSA id i126sm26987850pgc.6.2017.07.01.10.45.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 01 Jul 2017 10:45:17 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Dan Kohn <dan@linuxfoundation.org>
Cc:     git@vger.kernel.org
Subject: Re: Request for git merge --signoff
References: <CAHv71zK5SqbwrBFX=a8-DY9H3KT4FEyMgv__p2gZzNr0WUAPUw@mail.gmail.com>
Date:   Sat, 01 Jul 2017 10:45:17 -0700
In-Reply-To: <CAHv71zK5SqbwrBFX=a8-DY9H3KT4FEyMgv__p2gZzNr0WUAPUw@mail.gmail.com>
        (Dan Kohn's message of "Sat, 1 Jul 2017 11:24:20 -0400")
Message-ID: <xmqqbmp4nj9u.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dan Kohn <dan@linuxfoundation.org> writes:

> This alternative workflow works, but is obviously tedious:
>
> ```sh
> # First 3 steps are the same
> (feature-branch)$ git merge origin/master
> # Save default commit message
> (feature-branch)$ git commit --amend -s
> # Commit message now has signoff line
> (feature-branch)$ git push
> # This now passes the DCObot check.
> ```
>
> Or, I could manually add the Signoff line to the proposed git merge
> commit message, which would allow me to skip the `--amend` step.
>
> Could you please add a `--signoff` option to `git merge`?

The reason why we changed the default for "git merge" to start an
editor at around v1.7.10 was because we wanted to encourage people
to write log message that more meaningfully documents the change,
and adding sign-off is probably in line with that.  

I've done that "commit --amend" on a merge to tweak its message
myself number of times, but I have to admit that I never did so for
sign-off, but why not? ;-)

