Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0642F1F404
	for <e@80x24.org>; Mon, 29 Jan 2018 21:02:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751941AbeA2VCV (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 16:02:21 -0500
Received: from mail-vk0-f47.google.com ([209.85.213.47]:39906 "EHLO
        mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751755AbeA2VCT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 16:02:19 -0500
Received: by mail-vk0-f47.google.com with SMTP id a63so5426279vkg.6
        for <git@vger.kernel.org>; Mon, 29 Jan 2018 13:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YGFchahv9yc3QO5kMD/+aDoUMxAzJHJnZihcaLxMUjw=;
        b=g8itAd4D+qDPu4IwdkWFxpKs2F7FslidCjZxUMmiKRnDBbgkgdwOVP6F4ysCh1Kis4
         eGUQpx8cUtIybElsmgLoNojcjA5SFR2QETIdMo7dB9zD8j8a8FRefAxULjdvT9dG11Wk
         0VjV9sYbcC0aJAryA7lREtDX6WVHu80ZhemQe3ImdwYj7JbwSc+EKhx04y17RoJH68YX
         wE/17OnbH0l7U8VkQX7Mb5eS+oBcxdMCM0bd6pYylxIcIORLMOD+//+PiDgBetULQ0ck
         9XlC9toBtR88YCqiCi/ycNs/R2qJNxpsA7JfURtTgmAPSDHj8+OSv7mcIWghC9CGgERb
         G4GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YGFchahv9yc3QO5kMD/+aDoUMxAzJHJnZihcaLxMUjw=;
        b=ZrDMYqlTL/1IJDhUUPrF2bF8UHMPk0GAWoELVyMJhva1OYGE6wadbQDzOyZV+icAcr
         xLzNFrwIABwJa4NcNzjkkH6gPTgTXjrZhyN9uMi7wc7qIG1/FyXa2RZwv9cs2BfJ2PLG
         Vf74Jc4/FkyMULEMZiiZrf4+gj358c+YGgFlmyJZcSzURiSc7qPI0RNGL+7LTC2iv9Sm
         qbECQWMBQpueOX0LWBIAd6TwVYAwRZOWq2e/+095cHhpEeYTEmBAO7GYQRIb4Kg2C1RI
         /0ZQd7Z0sZs+xbvNQ47gRpqj+V2Y86PnDf/14ZutJscttSbzPaPLKIwYiFDcwCTKr5sh
         FOwA==
X-Gm-Message-State: AKwxytd3J4llXkmtIR6pi8pR4JqMt7ySnpWzR1hHdhyPw1wJwCyWjlqC
        0grBr7COdABiqFQSweG1JSCKcr05PrXYN/v/Uy0XEg==
X-Google-Smtp-Source: AH8x226kMKG0Wp3WmH0Mhc4RwUZ5zPaU7zUsawYDnA++rg15isQ9TgLdEt3ObG9nP/uv1S2a1bhQ/alq/msABNv8mQY=
X-Received: by 10.31.213.7 with SMTP id m7mr19662415vkg.44.1517259737886; Mon,
 29 Jan 2018 13:02:17 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.2.237 with HTTP; Mon, 29 Jan 2018 13:02:17 -0800 (PST)
In-Reply-To: <baf15388-adb4-ddce-889f-3e71b1574044@meddatainc.com>
References: <baf15388-adb4-ddce-889f-3e71b1574044@meddatainc.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Mon, 29 Jan 2018 13:02:17 -0800
Message-ID: <CAGyf7-GeEaCFeY7q3=-7cN6aLaWUBwbNAMAbtfHw6ZXanAy3hw@mail.gmail.com>
Subject: Re: Location limits on development, staging and production environments
To:     H <agents@meddatainc.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 29, 2018 at 11:08 AM, H <agents@meddatainc.com> wrote:
> I am a newcomer to git looking to set up a web development environment wh=
ere individual computers are used for development, the development.git, sta=
ging.git and production.git repositories are stored on an external server r=
eachable by password-less ssh and the staging and production websites are o=
n yet another server, also reachable by password-less ssh from the git-serv=
er (and the development machines).
>
> Locating the three git repositories on an external server works fine but =
I have not been able to have the staging and production deployment files on=
 another server. I believe this is what is referred by GIT_WORK_TREE and ba=
sed on what I found on the web I created a post-receive hook of staging.git=
 with the two lines:
>
> #!/bin/sh
> GIT_WORK_TREE=3Duser@1.2.3.4:/var/www/html/dev.whatever git checkout -f m=
aster
>
> I believe this should deploy the files from the development work tree.
>
> The above, however, fails. Should it work? I am running git 1.7.1 on Cent=
OS 6.

No, I wouldn't expect that to work. GIT_WORK_TREE is not remote-aware
in that way. It's expected to be a normal-ish filesystem path.

Based on your description, and the hook you've written, it seems like
your intention is for the source to automatically be fetched and
checked out on the staging environment after each push. (This is
dangerous, and likely _not_ what you actually want, but I'll get to
that in a moment.)

One option would be to setup something like NFS, so the git-server can
mount the filesystems from the staging and production nodes.

A different, likely better, option would be to have the post-receive
script on the git-server use straight ssh to trigger a checkout script
on the staging server, e.g.:
#!/bin/sh
ssh example@staging-server -C /opt/deploy-staging.sh

Your deploy-staging script would then do something like:
#!/bin/sh
GIT_WORK_TREE=3D/var/www/html/dev.whatever git pull origin

That said, though, having such a simple script is dangerous because
Git is fully capable of having receiving multiple pushes concurrently,
and they can all succeed as long as they're updating different
branches. Since your script isn't considering what branches were
changed by the push, it could end up triggering simultaneous git
processes on the staging server all attempting to deploy concurrently.

The stdin for the post-receive hook receives details about which refs
were changed, and you'll likely want to update your script to parse
stdin and only try to deploy staging if a specific, relevant branch
(master in your example) has changed.

Lastly, I'll note that using post-receive will make the pushing
(remote) user wait while the staging server is deployed. If that
process is likely to take very long, you might want to decouple the
two somehow.

Hope this helps!
