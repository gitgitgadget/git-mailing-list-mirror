From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] Documentation/git-add.txt: add `add.ginore-errors`
 configuration variable
Date: Mon, 26 Jan 2015 16:58:20 -0500
Message-ID: <CAPig+cT9hC=n7WkANno9Eif-+RUCeA6mQioUhOSkDEx_vdmN1Q@mail.gmail.com>
References: <1422291325-4332-1-git-send-email-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Alexander Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 26 22:58:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YFrfw-0002y5-3G
	for gcvg-git-2@plane.gmane.org; Mon, 26 Jan 2015 22:58:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753976AbbAZV6X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2015 16:58:23 -0500
Received: from mail-yh0-f46.google.com ([209.85.213.46]:54158 "EHLO
	mail-yh0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752749AbbAZV6W (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2015 16:58:22 -0500
Received: by mail-yh0-f46.google.com with SMTP id c41so4654802yho.5
        for <git@vger.kernel.org>; Mon, 26 Jan 2015 13:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=VuTBUmGtS2Ok2P1KuFtqfL3qIu+fX84Et/FNYfJAxO8=;
        b=XlkKH8OvS7aJQVIdte62G4jDjWbQY1El7ZnxLYhTzVAftgUNTebKDQo9sm3tMguZ3/
         4LesvLz5hQPEZAXO95I6fhan1CZN6f+aoHRbTtj78gMW6ZeLAgJZfxsqK63s4DyACNIX
         uUK9dkZg4EXF0nb5T4QpFgrYT/pl8xQ1uhlwqDDY69pfFKkpioLWHuF+n0QcqPRDswUK
         7YLi7GhlAFs3BcgnJbTSatMV9uWpugORmKqDin4WnRqzVzokEGQeScNxaPURVVtCQ3XR
         xKVY4M/FvCTt4IWAV4Ya1VlWRftqLGyMHUDZoxrEpN3Fd0UNXYyDKy1jBWNq5geQA3Nm
         C93A==
X-Received: by 10.236.70.100 with SMTP id o64mr10292640yhd.94.1422309500907;
 Mon, 26 Jan 2015 13:58:20 -0800 (PST)
Received: by 10.170.73.7 with HTTP; Mon, 26 Jan 2015 13:58:20 -0800 (PST)
In-Reply-To: <1422291325-4332-1-git-send-email-kuleshovmail@gmail.com>
X-Google-Sender-Auth: 9KnNuR8kZ3PWJClgxFyG1YbHoew
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263050>

On Mon, Jan 26, 2015 at 11:55 AM, Alexander Kuleshov
<kuleshovmail@gmail.com> wrote:
> 'git add' supports not only `add.ignoreErrors`, but also `add.ignore-errors`
> configuration variable.

See 6b3020a2 (add: introduce add.ignoreerrors synonym for
add.ignore-errors,  2010-12-01) for why this patch is undesirable.

> Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
> ---
>  Documentation/git-add.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
> index 1c74907..f68c2a2 100644
> --- a/Documentation/git-add.txt
> +++ b/Documentation/git-add.txt
> @@ -155,8 +155,8 @@ for "git add --no-all <pathspec>...", i.e. ignored removed files.
>         If some files could not be added because of errors indexing
>         them, do not abort the operation, but continue adding the
>         others. The command shall still exit with non-zero status.
> -       The configuration variable `add.ignoreErrors` can be set to
> -       true to make this the default behaviour.
> +       The configuration variable `add.ignoreErrors` or `add.ignore-errors`
> +       can be set to true to make this the default behaviour.
>
>  --ignore-missing::
>         This option can only be used together with --dry-run. By using
> --
> 2.3.0.rc1.275.g028c360
