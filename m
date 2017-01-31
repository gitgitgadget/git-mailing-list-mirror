Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D15031F6BD
	for <e@80x24.org>; Tue, 31 Jan 2017 18:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751994AbdAaSks (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jan 2017 13:40:48 -0500
Received: from mail-wj0-f194.google.com ([209.85.210.194]:35957 "EHLO
        mail-wj0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751511AbdAaSkr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2017 13:40:47 -0500
Received: by mail-wj0-f194.google.com with SMTP id kq3so11766476wjc.3
        for <git@vger.kernel.org>; Tue, 31 Jan 2017 10:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JTwhcLSnvqd5R1BFp8HFR+VKulzd7Raijuk1hFfPYUg=;
        b=TO4p3KxW4mHh09ScyCkn2n8ef7NyYVqeaQYOBRWe3TiubbKNp+Czf2uFStTsTRe1zz
         gyC38Ik7yRLl3KCov+BUDh1oDfUr7Xhc1cbGcwwRXK9VWY7bWiOds9xoe9Izxg7KEbMA
         i2GWk1baCikSgSmSCErWe9ypDQKq9cZ7Jf/TSjpppxOkyCFfofm/6uSKPXwQ7VXcSgEw
         xJOWjaW1o46eZntCTJ5Ojt8sL7SzlnFbQTuHesnk3vX+2X9bvrP+HbFZiua1gIMO4vyY
         /N2L0oRQNlEyT8T043ZDR+nYf2EZwMAHRq0P4xzoTvXuWhgMdWCLW708Fp07WWGVoBVJ
         5Ebw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JTwhcLSnvqd5R1BFp8HFR+VKulzd7Raijuk1hFfPYUg=;
        b=RC+phw9ukwrQI8DkyUNXv6oMDVqLNL90Y2dB7ur1Y6az4NdbMyp10ozl8sW8LdUqZw
         UgLokhWW0xdGpSlRNBbmopqUviTlXwbVg63u8Wf0We6WEPgMnktKIZ67Cq+a3akNmEW9
         uW7wk3fMWvGeqKh9kCoVe3r7IDT4toRnOwU9Nbi4P86d8Sdlh+GAOkKkr1bpXdcpPZec
         QWY/cDRLE2mXLL4s9P8lHDh/V0q9v69jF9De93xVLuaT9qtA7aKRe1X4bQyP4vABTgqn
         9zNSce+QoXTVMxTAlhWfBuQvTgg1QXZAzz6SJv8QpodhkWZ2Gqqumvn2usCaeyAmNX0o
         24Mw==
X-Gm-Message-State: AIkVDXIv45/2uNaDVfih6AAFZM9BGX/c7GpZtB6SHYg72iZKZaEKBm/v4DMrLw5Xv4+rG/qZ3gdXnKj8+ZsGOg==
X-Received: by 10.223.134.218 with SMTP id 26mr24020263wry.104.1485887566231;
 Tue, 31 Jan 2017 10:32:46 -0800 (PST)
MIME-Version: 1.0
Received: by 10.194.249.8 with HTTP; Tue, 31 Jan 2017 10:32:45 -0800 (PST)
In-Reply-To: <1485809065-11978-5-git-send-email-email@benjaminfuchs.de>
References: <1485809065-11978-1-git-send-email-email@benjaminfuchs.de> <1485809065-11978-5-git-send-email-email@benjaminfuchs.de>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Tue, 31 Jan 2017 19:32:45 +0100
Message-ID: <CAM0VKj=j8Fy8AQvYbbvwPf5kkV1GYYONADNsQO5RDNTUzdYt8w@mail.gmail.com>
Subject: Re: [PATCH 4/4] git-prompt.sh: add tests for submodule indicator
To:     Benjamin Fuchs <email@benjaminfuchs.de>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        ville.skytta@iki.fi
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 30, 2017 at 9:44 PM, Benjamin Fuchs <email@benjaminfuchs.de> wrote:
> Signed-off-by: Benjamin Fuchs <email@benjaminfuchs.de>
> ---
>  t/t9903-bash-prompt.sh | 43 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>
> diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
> index 97c9b32..4dce366 100755
> --- a/t/t9903-bash-prompt.sh
> +++ b/t/t9903-bash-prompt.sh
> @@ -37,6 +37,11 @@ test_expect_success 'setup for prompt tests' '
>         git commit -m "yet another b2" file &&
>         mkdir ignored_dir &&
>         echo "ignored_dir/" >>.gitignore &&
> +       git checkout -b submodule &&
> +       git submodule add ./. sub &&

./. ?

> +       git -C sub checkout master &&
> +       git add sub &&
> +       git commit -m submodule &&
>         git checkout master
>  '
>
> @@ -755,4 +760,42 @@ test_expect_success 'prompt - hide if pwd ignored - inside gitdir (stderr)' '
>         test_cmp expected "$actual"
>  '
>
> +test_expect_success 'prompt - submodule indicator' '
> +       printf " (sub:master)" >expected &&
> +       git checkout submodule &&
> +       test_when_finished "git checkout master" &&
> +       (
> +               cd sub &&
> +               GIT_PS1_SHOWSUBMODULE=1 &&
> +               __git_ps1 >"$actual"
> +       ) &&
> +       test_cmp expected "$actual"
> +'
> +
> +test_expect_success 'prompt - submodule indicator - verify false' '

I was puzzled by the "verify false" here.  You mean "disabled", right?

> +       printf " (master)" >expected &&
> +       git checkout submodule &&
> +       test_when_finished "git checkout master" &&
> +       (
> +               cd sub &&
> +               GIT_PS1_SHOWSUBMODULE= &&
> +               __git_ps1 >"$actual"
> +       ) &&
> +       test_cmp expected "$actual"
> +'
> +
> +test_expect_success 'prompt - submodule indicator - dirty status indicator' '
> +       printf " (+sub:b1)" >expected &&
> +       git checkout submodule &&
> +       git -C sub checkout b1 &&
> +       test_when_finished "git checkout master" &&
> +       (
> +               cd sub &&
> +               GIT_PS1_SHOWSUBMODULE=1 &&
> +               __git_ps1 >"$actual"
> +       ) &&
> +       test_cmp expected "$actual"
> +'
> +
> +
>  test_done
> --
> 2.7.4
>
