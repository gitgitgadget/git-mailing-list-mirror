From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v3 1/1] create_default_files(): don't set u+x bit on $GIT_DIR/config
Date: Tue, 18 Nov 2014 09:17:37 -0800
Message-ID: <CAGZ79kbTu5OGkJc4LUxKZ_4T4YpQwFB3+5b2iz8_f=r6VJ6faA@mail.gmail.com>
References: <1416318624-23048-1-git-send-email-mhagger@alum.mit.edu>
	<1416318624-23048-2-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Stefan Beller <stefanbeller@gmail.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Nov 18 18:17:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqmPP-0004yO-5X
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 18:17:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754664AbaKRRRj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 12:17:39 -0500
Received: from mail-ig0-f175.google.com ([209.85.213.175]:59203 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754349AbaKRRRi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 12:17:38 -0500
Received: by mail-ig0-f175.google.com with SMTP id h15so1373227igd.8
        for <git@vger.kernel.org>; Tue, 18 Nov 2014 09:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=lSJq3Y6YvfRKWuOmWgj20H+ZGvsrnqcrVkPM1cVBUEo=;
        b=jY4ms7WZKb56inUp8OeJ0wX5fuKr3LIAoroGUujs1kRxZ5qefWEX2n3Iaah7dNw3F1
         eWT9jemw1DTIvddwib+1kf1aKSD4BtpFZRaSpO+rsZT2RPRqsqeLAASz/iOGiBxxj4T3
         0sh2cedP8PTR5Ff6KR+P5WAaxiqzDNLobl6L3NI9kxLoYiZ7BPByjIQB/LsgIdjeygfZ
         fBLiQbp22MoPOpc+ugm3GvDYiL/0ArR/h99c2a9CHT0M58aXN/LuThIDnk3py1JY+k/k
         OjOX4ZLQWZQ2fZSngNIA8+uqFb1Wjgh3nm1o0l09fDfRrfyIItVQnQmm/LsgDxcpSark
         /fAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=lSJq3Y6YvfRKWuOmWgj20H+ZGvsrnqcrVkPM1cVBUEo=;
        b=kgqU+xckNBXQxSF1OZNp5xAjBLoamHv/4w8QF7tifWklIvev8y0jFPP+aoGkpGgiWL
         I1GAkt1DXZoKslfTZ7eX2DD5jIuDHq7txvsLevEMNU3jK6WyU/u4QTcT3HnCvWt/tDdQ
         IvUIrsUc/F5x3onvtlnXg85s6BBToajFw4ACilyQQlC5yG903HtWA2zOxsFwluHCezWQ
         f5YYxeb5WPu16Wesi+az1KEVg+mRGEWuPAZwamsL7OHTKD6DLWGiOcDZDnV77jBQrzDY
         LC7yJny/LQj1Q6/1+bl0RGT9kvcY4k+8VAhQzT+2lXMz/ik8I9NKcvGqlAQ+jss3LzFU
         az0w==
X-Gm-Message-State: ALoCoQnmvdQoULGx5KrLKBMUSzwt+gKWFL4U+YYzp8uMDYMcnTnU2x7mYoyHhGpDmrRAcfkeNWaO
X-Received: by 10.107.153.135 with SMTP id b129mr18428251ioe.49.1416331057758;
 Tue, 18 Nov 2014 09:17:37 -0800 (PST)
Received: by 10.107.46.163 with HTTP; Tue, 18 Nov 2014 09:17:37 -0800 (PST)
In-Reply-To: <1416318624-23048-2-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reviewed-by: Stefan Beller <sbeller@google.com>

On Tue, Nov 18, 2014 at 5:50 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Since time immemorial, the test of whether to set "core.filemode" has
> been done by trying to toggle the u+x bit on $GIT_DIR/config and then
> testing whether the change "took". I find it somewhat odd to use the
> config file for this test, but whatever.
>
> The test code didn't set the u+x bit back to its original state
> itself, instead relying on the subsequent call to git_config_set() to
> re-write the config file with correct permissions.
>
> But ever since
>
>     daa22c6f8d config: preserve config file permissions on edits (2014-05-06)
>
> git_config_set() copies the permissions from the old config file to
> the new one. This is a good change in and of itself, but it interacts
> badly with create_default_files()'s sloppiness, causing "git init" to
> leave the executable bit set on $GIT_DIR/config.
>
> So change create_default_files() to reset the permissions on
> $GIT_DIR/config after its test.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  builtin/init-db.c | 3 ++-
>  t/t0001-init.sh   | 7 +++++++
>  2 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/init-db.c b/builtin/init-db.c
> index 56f85e2..a6d58fd 100644
> --- a/builtin/init-db.c
> +++ b/builtin/init-db.c
> @@ -254,7 +254,8 @@ static int create_default_files(const char *template_path)
>                 struct stat st2;
>                 filemode = (!chmod(path, st1.st_mode ^ S_IXUSR) &&
>                                 !lstat(path, &st2) &&
> -                               st1.st_mode != st2.st_mode);
> +                               st1.st_mode != st2.st_mode &&
> +                               !chmod(path, st1.st_mode));
>         }
>         git_config_set("core.filemode", filemode ? "true" : "false");
>
> diff --git a/t/t0001-init.sh b/t/t0001-init.sh
> index e62c0ff..7de8d85 100755
> --- a/t/t0001-init.sh
> +++ b/t/t0001-init.sh
> @@ -12,6 +12,13 @@ check_config () {
>                 echo "expected a directory $1, a file $1/config and $1/refs"
>                 return 1
>         fi
> +
> +       if test_have_prereq POSIXPERM && test -x "$1/config"
> +       then
> +               echo "$1/config is executable?"
> +               return 1
> +       fi
> +
>         bare=$(cd "$1" && git config --bool core.bare)
>         worktree=$(cd "$1" && git config core.worktree) ||
>         worktree=unset
> --
> 2.1.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
