Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 337A32022A
	for <e@80x24.org>; Tue,  8 Nov 2016 17:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753802AbcKHRSo (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Nov 2016 12:18:44 -0500
Received: from mail-ua0-f179.google.com ([209.85.217.179]:36773 "EHLO
        mail-ua0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752945AbcKHRSn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2016 12:18:43 -0500
Received: by mail-ua0-f179.google.com with SMTP id b35so152557212uaa.3
        for <git@vger.kernel.org>; Tue, 08 Nov 2016 09:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=argoday-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iqZnMDw/JotCAh+VAXGBODmk3j9N/q21NKwnNMe1zG4=;
        b=dAiK4TMWdp9s+4nyfAfk0mKvbva+FUvf1qtli3dmKxX44s8rdnUW/xqr098ttC6KGc
         4juGJZAW7MFDO7KKFcY7bXy9DWydu7hW1o64BihITFG3PPu+W7ZZCq1S5F1abfbJEqo8
         GVjjOgFyIfHH90On+YToekL8HWmoRwOORwQLgsUcJEauqZKERDcgoEsCiNX+dMJzkw5r
         /LiOI1wGaLtttlqpGpkyQrDaE1h3t12zuQPfLW9bEX+yJMo/jcMiZx/PtfIOACAdovNW
         ErIPPkGFq6IUfG5JK+GK0JvDbZ/knnHfxwLhGVlJj5e1UnFXURVlxEMDwPcVK2Wq6Fkc
         UkIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iqZnMDw/JotCAh+VAXGBODmk3j9N/q21NKwnNMe1zG4=;
        b=Xw2Mud+eOZyX2tRBwTvS8eRbM3rYhdt3q4wZHJxkR0Fq0yr75Jim/dZ7Ep+fNBDxOn
         O57rmPE7I605w7I9ap2f59sLUW9cCMYRoT/tyPNFENRVOEpw2tNIFZGXNiKo1Mta7yBf
         6lLGwu8FNS3u3/NhnHW9qbDgOCGPyN/i7QB5tSUkdqnimDuMMIIrhGrNySQ/lCWNCe1d
         C/xxDJkk2XP8kIjEL28giLWeWvrT9ICUg6Fkw7cygHGg6RGc9hlFMd1PK4SNHI0C5G5c
         17uqMLf8vipvusuQF8INeMZEHegBebt6N9f6oVoAWm8dGIozGXdQwSMh4oE0ug8N2Peo
         BOFw==
X-Gm-Message-State: ABUngvc94fBoO83O1uu/29YnHOmQV8KKg7t//p1Z5iiHc8fmLCHs+sP7P5afF2ndzd7rOPLwGJzIt8oh4F5CXQ==
X-Received: by 10.176.83.151 with SMTP id k23mr9035306uaa.90.1478625522714;
 Tue, 08 Nov 2016 09:18:42 -0800 (PST)
MIME-Version: 1.0
Received: by 10.103.128.70 with HTTP; Tue, 8 Nov 2016 09:18:22 -0800 (PST)
In-Reply-To: <40608c85-f870-87f7-daee-7fa98f5d19c1@jump-ing.de>
References: <CAD9aWChH14eviop=0_Ma_2Pa-2OyWJp9KjimH8dyqy-XDn9Rhw@mail.gmail.com>
 <40608c85-f870-87f7-daee-7fa98f5d19c1@jump-ing.de>
From:   Jonathan Word <argoday@argoday.com>
Date:   Tue, 8 Nov 2016 12:18:22 -0500
Message-ID: <CAD9aWCgZkuaZNMDparVZE_WNFpOp7ud6iyCueGVbnU8s_EYtrQ@mail.gmail.com>
Subject: Re: Bug: git config does not respect read-only .gitconfig file
To:     Markus Hitter <mah@jump-ing.de>
Cc:     git@vger.kernel.org, jword@bloomberg.net
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I proposed a variant that would be fully backwards-compatible (don't
know who might rely on the functionality http://xkcd.com/1172/ )
however I'd be happy to see the change without additional config +1
... that's a call for this list as maintainers.

The root of the issue is that tempfile::rename_tempfile (
https://github.com/git/git/blob/35f6318d44379452d8d33e880d8df0267b4a0cd0/te=
mpfile.c#L288
) relies on http://man7.org/linux/man-pages/man2/rename.2.html which,
only requires directory write permissions - not file write
permissions. As you point out 'rm' is another example of this paradigm
and it works exactly the same way.

The point of confusion to users ( / my team) is that `git config`
gives the appearance of editing / modifying the .gitconfig file
in-place (where file permissions would be respected) however the
actual implementation performs the equivalent of a rm+mv which only
respects directory permissions.

The `git config` command is only one of many that leverage that
rename_tempfile function, if opting to respect file-level permissions
across the board then the desired change is probably at that level
rather than in config::git_config_set_multivar_in_file_gently which
would only add respect for file-level permissions to the one command.

Cheeers,


On Tue, Nov 8, 2016 at 11:49 AM, Markus Hitter <mah@jump-ing.de> wrote:
> Am 08.11.2016 um 16:22 schrieb Jonathan Word:
>> Proposal:
>>
>> Part 1) Add a .gitconfig variable to respect a read-only gitconfig
>> file and optional "--force" override option for the `git config`
>> command
>>
>> Such a gitconfig variable could be defined as:
>> config.respectFileMode: [ "never", "allow-override", "always" ]
>> [...]
>> Thoughts?
>
> I'd consider disrespecting file permissions to be a bug. Only very few to=
ols allow to do so ('rm' is the only other one coming to mind right now), f=
or good reason. If they do, only with additional parameters or by additiona=
l user interaction. Git should follow this strategy.
>
> Which means: respect file permissions, no additional config variable and =
only if there's very substantial reason, add a --force. KISS.
>
> That said, disrespecting permissions requires additional code, so it'd be=
 interesting to know why this code was added. The relevant commit in the gi=
t.git repo should tell.
>
>
> Markus
>
> --
> - - - - - - - - - - - - - - - - - - -
> Dipl. Ing. (FH) Markus Hitter
> http://www.jump-ing.de/
