Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 889161F404
	for <e@80x24.org>; Tue,  6 Feb 2018 20:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752975AbeBFUFz (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 15:05:55 -0500
Received: from mail-yw0-f178.google.com ([209.85.161.178]:34610 "EHLO
        mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752965AbeBFUFy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 15:05:54 -0500
Received: by mail-yw0-f178.google.com with SMTP id t201so2249339ywf.1
        for <git@vger.kernel.org>; Tue, 06 Feb 2018 12:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DuI0fXvwCeHjUy7xqiT+W554gaSnKqDk6rgp1MBNNnI=;
        b=lBHXIUGn8U/DDuI6pDyjRrwCh6rTG34prnDQXRFX7z5dlvgFKQIfMJ0fSaZODfAMwP
         uIXVWQf/YrHvHVcL/wyFM0zZH+9cbms2nD9gmku0Uhe8vGZsT1QI8hKx+nKxffcKvOzP
         UWnNaUxnLKVswOX5+VCXhs/6cOeDEGKzxb+QFM1V6PG0E57gJ+6CR3sbbLK47Xsl21sS
         HgjVwoWTg2u1OcsbjMuq9GtYPBaG4dDkBQ+uhUlwNCULsF/uJqnBpM6itFSaphE8RwB5
         k8Hj0/ntLqo50KcduxVYKyC+JONu17Eh2lVxOMrE/F0rE3gtmy23igNlKbic/gpKSyb9
         NMYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DuI0fXvwCeHjUy7xqiT+W554gaSnKqDk6rgp1MBNNnI=;
        b=P1xeOp8V7IehcsR/PlG8rLLdC0J86M22E65FSnpEIAWh7Iao1L4sgMhu3wUMnWgAuk
         wIoPAmZzw9XXnKvfg89jqWua2bH3vCTzQNc0nGxtV3RPPqo+FMBeqClkoyYPbWXjhd6Z
         JJsO1gfLgSDOkUi76Wn+318ABDmmDf93DP2uQL/207Ju9sFuF1i6CsKtKvFuLjmBpJPK
         ky0wrunvFJ7No5zM0eQA9eVRLE7DckuuOgJYe9jQ+A8E1qN6AWr6GwtTzwHACLwEUz9w
         AuRzmrpUgrz9Z3BLCtjVZWKQslGv8lHswAQbIEuz3mEw2DYkWa9jI+r30dkMR+Je52LG
         +HRQ==
X-Gm-Message-State: APf1xPAip4HzBEceNSg3LMFuC7yy+8tRGBO2S1X7aLRNc9ZPUoKr/p3p
        RvPToHF8UZEQXdzW3/pt5bt7qBb+45lKsJPvU5kIjg==
X-Google-Smtp-Source: AH8x224xBbFROrNJM/A7VfitdrSyxHimB96GbBzMzTxpwsnH0ejoAzv/wP1gTSa+O3sNiad9J93BXsAVVfyk7MD9El4=
X-Received: by 10.37.37.87 with SMTP id l84mr2361265ybl.386.1517947553331;
 Tue, 06 Feb 2018 12:05:53 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.207.9 with HTTP; Tue, 6 Feb 2018 12:05:52 -0800 (PST)
In-Reply-To: <20180206195754.GE1427@zaya.teonanacatl.net>
References: <2412A603-4382-4AF5-97D0-D16D5FAAFE28@eluvio.com> <20180206195754.GE1427@zaya.teonanacatl.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 6 Feb 2018 12:05:52 -0800
Message-ID: <CAGZ79kaxf3qUyOe6R-LCgyLtwzrwhB=y767tk2qPbC_KR473ig@mail.gmail.com>
Subject: Re: "git branch" issue in 2.16.1
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Jason Racey <jason@eluvio.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 6, 2018 at 11:57 AM, Todd Zullinger <tmz@pobox.com> wrote:
> Hi Jason,
>
> Jason Racey wrote:
>> After upgrading git from 2.16.0 to 2.16.1 (via Homebrew -
>> I=E2=80=99m on macOS) I noticed that the =E2=80=9Cgit branch=E2=80=9D co=
mmand
>> appears to display the branch listing in something similar
>> to a vi editor - though not quite the same. I don=E2=80=99t know
>> the technical term for this state. You can=E2=80=99t actually edit
>> the output of the command, but you=E2=80=99re in a state where you
>> have to type =E2=80=9Cq=E2=80=9D to exit and then the list disappears.
>> It=E2=80=99s very inconvenient and it doesn=E2=80=99t seem like it was b=
y
>> design. I=E2=80=99m using zsh in iTerm2 if that helps. Thanks.
>
> In 2.16.0 `git branch --list` is sent to a pager by default.
> (Without arguments, --list is the default, so this applies
> to `git branch`).
>
> You can set pager.branch to false to disable this in the
> config, or use git --no-pager branch to do so for a single
> invocation.
>
> I can't say why you're seeing this with 2.16.1 and not
> 2.16.0, but I'm not familiar with homebrew, so perhaps
> something didn't work as intended in 2.16.0.
>

Maybe the number of branches changed since then?
As the pager only comes to life when the output fills
more than your screen. Quick workarounds:
* buy a bigger screen
* have fewer branches.

:-)

Stefan
