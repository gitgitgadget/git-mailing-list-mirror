Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F5CC34047
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 14:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8775A2465D
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 14:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="dxn8TTl1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgBSO2j (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 09:28:39 -0500
Received: from mout.gmx.net ([212.227.15.19]:38753 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726736AbgBSO2j (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 09:28:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582122517;
        bh=7x9lkxVUO3uLSPolTF+DaTprFFNZAEEEpFuEimAnyFU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=dxn8TTl1hIjUPMYHHohIkcpSCIQ5bUCfIoM2y42IGKqeGOd3loHiEVgSagDoNV0Gs
         PRVFFM3SP5RtLtxspQbMDm5+Zd7Al12FNSBEdXNxBUkuceENH0KPf2ONPsMWlKmiLM
         X3xE9fWPTgAtifb8xx/kq4nC+CtXpF4hifM4mo54=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.86]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N6KUd-1jWsUW0EJd-016gQh; Wed, 19
 Feb 2020 15:28:37 +0100
Date:   Wed, 19 Feb 2020 15:28:35 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Emily Shaffer <emilyshaffer@google.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH v7 07/15] bugreport: add git-remote-https version
In-Reply-To: <20200214015343.201946-8-emilyshaffer@google.com>
Message-ID: <nycvar.QRO.7.76.6.2002191524460.46@tvgsbejvaqbjf.bet>
References: <20200214015343.201946-1-emilyshaffer@google.com> <20200214015343.201946-8-emilyshaffer@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:g2yZvgXON5Lqr6s8itCyghYxcQ9aeeoG2L2Pcj2/Yw3XlJpagzE
 wWh+9e2FKacNYYzzSlO91vInYJoNqzZI48W6xF1fbASk2VvMsyjNAx1qSc7ZaM8nsYCErR0
 uKMsv254H+xlBD5GU1yGnGxYLuFXsS8WHXc2dnLp2p+/TVgKp9pz6h6LVHKZzFmz3XS3QIE
 gmEzO5wGHIKb5lz9xOe5g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7sWOwY8bqzU=:LusSG2SWnG5WVgKaFGoDDy
 CWAtvIm5nWcE2rkeG+OsmxfZH2liVQ8T65O1UGsMSg1CoU0kLPaw0JufMFRp9M9n/QtJd6+DI
 bvm7sdj0heCgREPFQFvsM5SCrMP9kwscgkSUNsyWN9OitE0ffZBN7hczvQayj9Jiom9cNum/4
 JFszDfSjezrD1HpK7j7mwH3fxoBGUEkennGU486JxuYzg6/DdB6NqCkIfNRbtFGpbfeOJXq1b
 pQZqqbMLujC/MNOLVxj2LlQwQm7iYqY5QDTxwE+z1ZRCBfa1RKzvC45RWF1GXfPPAq/9ZOZ9l
 meGOD6Oi4a7YYRTxqjq7EvitZQ+b7rph+D/CyKRlv/gzVU2x0aLlwusRkAsQoq5r2ThTzYKUt
 beBjdZa+WiMNPz0oYqK8mgWAHyJqbXnr8t7zO0m7Qm8Zi4sfnJXYQKP5p+4QICeFdk7WLoVrR
 YJEOP7T3roMMVC+r+MSKY5fXWvh1M3OClfgXrX5L+fBT8RTe1A6skQTBOn/2nAH/nA+b/2zBD
 N0iR4UwWtBgN2Azuz1KB/t5DDTfJSjukuh3YXdfX8kLr86KK8kcdLoBQn7LElqkOLYKKeRTRB
 TN+T0Sqvb7zAxQXh+e4I6LjLItN3xUjpptMw4QfijQTSZX/hhg1dVmauHp2lK14GYi9pVAWzc
 52DyJpiwB16z737CYyAcgsb45Op3WcogrFcI2vOyQEjyWXczRbI7xyp3Ut2spGwNWlQ2qcl7A
 M7B9kjY4nhwF5msm7AYpvjto8LfYaQCc5KwUa6XpKLVC/4CqtapByV449Csk0xXXgyzwV78O7
 wzBBTTgffhxpqDcb9GhWhRxRXipmgXqWqd2vA9cWAXIxpsfQ5+QMoq5Nb6+dcxoYOZ4HmLiDo
 /P/d7sj4eDV8CvcF5tFPFezHMsSR6qKuyB73CC+r6CNhM7R2dqtgUZPVcY4HlPAW8qPQsbntc
 SHmJPL+XEMBH53oH0Q3xQiNZi3E7emf9BXOIk/mhK+m/HwnSzd8rcRzNJXoPXYG6zqM8EP5QU
 C/hWvKBlBHRg5p/qRHJ/qs9vBePfyHgva8Y/FbN3cGkDaq7Pvc41ARDpYwnnJAPgpzDZnnedV
 GNS6/d6YWTI3JZQyREXsHdipvB0jRJJ6p5jaavqY6RITmJyIe7nu56cEaXYa/Qvv10to5YCyW
 l41cF5sMZYeKzbt01SlrjgMxHQ0WrSeFU9mYihMAIr44XnMuHRKH/xIIhHO0XKyAQNcyR4sQh
 NjRYfIkv83QN8dbIH
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Emily,

On Thu, 13 Feb 2020, Emily Shaffer wrote:

> diff --git a/bugreport.c b/bugreport.c
> index 4f9101caeb..bfdff33368 100644
> --- a/bugreport.c
> +++ b/bugreport.c
> @@ -5,6 +5,18 @@
>  #include "time.h"
>  #include "help.h"
>  #include "compat/compiler.h"
> +#include "run-command.h"
> +
> +static void get_git_remote_https_version_info(struct strbuf *version_in=
fo)
> +{
> +	struct child_process cp =3D CHILD_PROCESS_INIT;
> +
> +	argv_array_push(&cp.args, "git");
> +	argv_array_push(&cp.args, "remote-https");
> +	argv_array_push(&cp.args, "--build-info");
> +	if (capture_command(&cp, version_info, 0))

Let's use RUN_GIT_CMD instead of adding `"git"` explicitly; It documents
that we're interested in a Git command, and if we ever build a
single-binary version of Git (as some Git for Windows users already asked
for), it will make things easier.

> +	    strbuf_addstr(version_info, "'git-remote-https --build-info' not s=
upported\n");
> +}
>
>  static void get_system_info(struct strbuf *sys_info)
>  {
> diff --git a/remote-curl.c b/remote-curl.c
> index 350d92a074..c590fbfae3 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -1374,6 +1375,13 @@ int cmd_main(int argc, const char **argv)
>  	string_list_init(&options.deepen_not, 1);
>  	string_list_init(&options.push_options, 1);
>
> +	if (!strcmp("--build-info", argv[1])) {

The context does not say this, but at this point, we already verified that
`argc` is larger than 1. Good.

Also, in keeping with the existing code, we would need to use
`--build-options` here (this is what `git version` calls the equivalent
mode).

_However_.

I like your `--build-info` a lot more than `--build-options` (because the
latter is very misleading: the commit and the date of the build are not
"options" at all).

Thanks,
Dscho

> +		printf("git-http-fetch version: %s\n", git_version_string);
> +		printf("built from commit: %s\n", git_built_from_commit_string);
> +		printf("curl version: %s\n", curl_version());
> +		return 0;
> +	}
> +
>  	/*
>  	 * Just report "remote-curl" here (folding all the various aliases
>  	 * ("git-remote-http", "git-remote-https", and etc.) here since they
> --
> 2.25.0.265.gbab2e86ba0-goog
>
>
