Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61DA81FBB0
	for <e@80x24.org>; Thu,  8 Dec 2016 14:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751702AbcLHOAh (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 09:00:37 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:35033 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751367AbcLHOAh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 09:00:37 -0500
Received: by mail-wm0-f42.google.com with SMTP id a197so218031778wmd.0
        for <git@vger.kernel.org>; Thu, 08 Dec 2016 06:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bossastudios-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=eBF0l+w3NrEj7pijyvnxldXuKxm1WgKmBJiDHbvBzHg=;
        b=tQLLLvGKU7p5XVqb/Qkzc13PsNHvX9XCAcxMKbJv9kxP2uoBBdFl9qr0nISoCn2xWI
         AmTT1bvecQfkIFHFEAc6nHPgojuda2gb6DFAYctF1vgd0bfrAHSEf/RcUzl4Iy2YL7jo
         RQqqB+58ni/RaBQ0DQABg1i05U8I7L22jNdu1M0aJ6vv3fS1l/xgdxtJ++hH7Gd7K8fW
         jaEY1DeZz/qDx7iC9tVmw7cToB7nQ/a6LAQvp/qBtW0OcDMqZGX1aNrAJ7Sc2pukp2fZ
         8mG1BY4VVt5r5FoBa45NDRNpszm1q51rX7R/P8dsyEE7SJpqkofMv7H/FV+HdvBpaXhY
         ZUSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=eBF0l+w3NrEj7pijyvnxldXuKxm1WgKmBJiDHbvBzHg=;
        b=Vux9gf4kbQ3WM0Bx8fV9QuY+TEV7OLFWbEw2x74N/uc4rlJF54o7kgJ6OBPiu/NVUI
         Cf1I96fJRY4K5VaUdzE0Z5/5bkE+WuYzyfeHqCJqUKfjuVUyU6sTkqA7zG60cxmQKj/W
         /1ZDI6OV6kklC0thmXk0EUV35i36pZS+4nZMzvMSNjNr+HEGkD9jhmyM6i3nbpdRfZ3B
         +1fvuUjyD4Ft7vW1gyt6P1jbiFPPmX/q4tewWzxFQKqIr5r4tes1vrtz3OjEgp7touho
         5tK9YLa+GOH8UMuIGpEJSbNbDOXrSjz0wDF+fMqY5qybYF8MUNz8lJ/2X+bAagctPx+4
         re9g==
X-Gm-Message-State: AKaTC03WnHlPDcB41+ddvE7N5XwfKDJQHDg9hamV1TCMO8etLwM47nF2cnmk8NTv27qXC7lKzzkJRL+C64qb9gNn
X-Received: by 10.28.39.199 with SMTP id n190mr2276380wmn.124.1481205635474;
 Thu, 08 Dec 2016 06:00:35 -0800 (PST)
MIME-Version: 1.0
Received: by 10.28.14.9 with HTTP; Thu, 8 Dec 2016 06:00:34 -0800 (PST)
In-Reply-To: <06520F42-BD49-4349-83B3-74DCA1E260CD@gmail.com>
References: <CABW+60x0PSw7uNQZg4SeN7EAbNpraR_HWvnVFz1-fVLYX=B8RQ@mail.gmail.com>
 <06520F42-BD49-4349-83B3-74DCA1E260CD@gmail.com>
From:   Nick Warr <nick.warr@bossastudios.com>
Date:   Thu, 8 Dec 2016 14:00:34 +0000
Message-ID: <CABW+60za0shXucPgg_jGYt4f8QbkLzLmS5GRf8czE67Taqd+zw@mail.gmail.com>
Subject: Re: Serious bug with Git-2.11.0-64-bit and Git-LFS
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

That looks pretty much like the error we're dealing with, any reason
why going back a point version on Git (not git-lfs) would resolve the
issue however?

On 8 December 2016 at 13:57, Lars Schneider <larsxschneider@gmail.com> wrote:
>
>> On 08 Dec 2016, at 12:46, Nick Warr <nick.warr@bossastudios.com> wrote:
>>
>> Using Git-2.11.0 with the latest git-lfs 1.5.2 (also tested with
>> 1.5.3) cloning from our locally hosted gitlab CE server via HTTPS.
>>
>> When cloning a repo (large, 3.3 gig in git, 10.3 in LFS)  for the
>> first time the clone will finish the checkout of the git part, then
>> when it starts downloading the LFS parts it will reliably finish with
>> a smudge filter error.
>>
>> This leaves the repo in an unstable condition, you can then fetch the
>> lfs part without issue, but checking out the lfs files or trying a git
>> reset --hard will continue to spit out the same error. As you can see,
>> the actual error is not particularly useful.
>>
>> fatal: workers/unity/Assets/3rdPartyAssets/FORGE3D/Sci-Fi
>> Effects/Effects/Debris/Meshes/debris_junk.FBX: smudge filter lfs
>> failed
>> Unknown command ""
>>
>> Possibly it's due to the file extension being all capital letters, we
>> did manage to change the error by recommitting the file with a
>> lowercase extension, but it failed on the next file (which also had a
>> capital letter extension).
>>
>> This has happened on multiple fresh windows 10 64 bit installs,
>> different machines and target directories (to hopefully remove the
>> possibility of file permissions) where cloning is taking place.
>>
>> The solution is to back level to Git 2.10.2 and the error disappears.
>>
>> More than willing to provide any further information,
>
> Hi Nick,
>
> debris_junk.FBX is not stored properly in Git LFS.
> I explained the problem in detail here:
> https://github.com/git-lfs/git-lfs/issues/1729
>
> You should add the file properly to GitLFS to fix the problem.
> However, I think this is a regression in GitLFS and I hope it will
> be fixed in the next version.
>
> No change/fix in Git is required.
>
> Cheers,
> Lars
