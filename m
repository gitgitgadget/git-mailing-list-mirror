Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69C6C2095B
	for <e@80x24.org>; Sat, 18 Mar 2017 17:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751444AbdCRRIt (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 13:08:49 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:35984 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751320AbdCRRIt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 13:08:49 -0400
Received: by mail-it0-f49.google.com with SMTP id w124so52133081itb.1
        for <git@vger.kernel.org>; Sat, 18 Mar 2017 10:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+6yohXYNB3MG0yV3/Eh1sjtbrUsupJDuOhshgjQDsYk=;
        b=GClnk1f/bE2+dj7Fwjltz9HijdM39H1WYaXUv9TFzwnkBEzt6Xzt/xPu398zxcknyY
         C1TJKUpMqCcJgsd0KQZSIN0BH3jEnAM9ggxmFYGHxkEx3tb75nU0865pEVluuAO062dn
         lncKcIz7RCY3yTuRmzLXb0ktJU5ejtchYW9bz/RsXC/K5U4AZD8KQ0bwiL0lToQ9C5VW
         MauSj8ENbRbiD85dOfqkTAMj/SX609Ye6vltksIVhjLYuRL9jdLxUg6s9i8ItvS+iljl
         YeFtamvF27o3Phbnh2es58bwYHGJiIho1G+3KW4DW6B/GlsI4vi5ghinY0WPnnhbFpuh
         z+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+6yohXYNB3MG0yV3/Eh1sjtbrUsupJDuOhshgjQDsYk=;
        b=fAj+iFmOm200JXKz6yNxdyAEh/NblQ9SqJMi/KGYnxd/az2COA1zeCSOLEZKQ9tvwJ
         lcRWcOttp1W9Pxpcw/A2CB1K3euAo0Ru+SS0Z0Dj3fzORy6iKjOp2/birc9bPUVR1aRw
         D7q0iZk3e/AgxL4C5Hp/wNKqxF5SK4pIc/NyqMGPtlcee7fe4o4cRHCj5qgj1pWciIY/
         uJClJeK6/7B8BVcbFIw6ZI+HnAtpZJPNEt1QcyzgzDvM3Kvbxzbv8u/HnGzVFpu65prn
         wGhoMVPHezq/EFc8K3LUfAhsFaUJl6UruiuImNTR9biXe7s8FB7OcdLhoqKIq72WNfQZ
         GF/w==
X-Gm-Message-State: AFeK/H3941UL9PG8+CqDkS5ZBikGcS5g2oGUs9GWAOC/vjTuAWfdjRMKLKDVP8xzl7NxEP0tzbgBXOmXLgHF3w==
X-Received: by 10.36.224.195 with SMTP id c186mr3753910ith.24.1489856927773;
 Sat, 18 Mar 2017 10:08:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Sat, 18 Mar 2017 10:08:27 -0700 (PDT)
In-Reply-To: <nycvar.QRO.7.75.62.1703180750460.3797@qynat-yncgbc>
References: <nycvar.QRO.7.75.62.1703180724490.3797@qynat-yncgbc>
 <CACBZZX5FMdjuxxNru+XfTQdSXEQ_b0OP2rngGZLf1sSHR_D8Ng@mail.gmail.com> <nycvar.QRO.7.75.62.1703180750460.3797@qynat-yncgbc>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sat, 18 Mar 2017 18:08:27 +0100
Message-ID: <CACBZZX7G=C84kz4n26VTnWWUTKRv1rVvms=8AvELtMSCviu1kQ@mail.gmail.com>
Subject: Re: Is there a way to have a local version of a header file?
To:     David Lang <david@lang.hm>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 18, 2017 at 3:58 PM, David Lang <david@lang.hm> wrote:
> On Sat, 18 Mar 2017, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> On Sat, Mar 18, 2017 at 3:29 PM, David Lang <david@lang.hm> wrote:
>>>
>>> for an embedded project built inside the Arduino IDE, (alternate firmwa=
re
>>> for a home automation project) there is a need to set a number of
>>> parameters
>>> that we really don't want in the main repo (wifi network IDs/passwords)
>>>
>>> right now, we have these things set as #defines in a header file.
>>>
>>> We need to distribute a base version of this file for new people to get
>>> started.
>>>
>>> Is there any way to have git define a file in such a way that if it
>>> doesn't
>>> exist in the worktree it gets populated, but if it does exist it doesn'=
t
>>> get
>>> overwritten? (as I type this, I'm thinking a trigger may work, but we
>>> need
>>> it to work on Linux, Windows and OSX)
>>>
>>> Any thoughts on a sane way to handle this situation?
>>
>>
>> There's no sane way to do what you're describing without renaming the
>> file.
>>
>> But the sanest way to do this is to have a config.h.example
>>
>> Then you have "/config.h" in the .gitignore file.
>>
>> And you tell the users to copy the *.example file to *.h, and your
>> program then includes the *.h file.
>>
>> If you wanted to provide defaults you could just #include the
>> config.h.example first, so #defines in the *.h file would clobber
>> those in the *.example.
>
>
> That's what we currently have (user_config.h and user_config_override.h)
>
> I was hoping to not have the situation where downloading and trying to
> compile will complain about a missing include file (if the users don't co=
py
> user_config_override_example.h to user_config_override.h) while letting u=
s
> do a .gitignore on user_config_override.h
>
> for many people using this project, this is the first time they have ever
> compiled anything, and we have the typical set of people not reading
> instructions :-/
>
> Darn, I was hoping that the scenario of needing to have a config file
> provided in the repo, while not overwriting local changes to it was commo=
n
> enough that there were some tricks available. This is a little harder as =
the
> running code doesn't have a filesystem so we are limited to what we can d=
o
> in the compiler and git (no makefile even, the Arduino folks consider tha=
t
> too complicated, it just slurps up all .ino files in a directory and
> compiles them)

There might be some way I haven't thought of, in particular maybe you
can use gitattributes to define a custom diff/merge driver that always
reports no changes, or some ways to (ab)use the index to make git
ignore any changes to the file.
