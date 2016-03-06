From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] Allow "-" as a short-hand for "@{-1}" in "git branch -d @{-1}"
Date: Sun, 6 Mar 2016 14:35:55 -0500
Message-ID: <CAPig+cTHBLGjn_tnAKE2i_zv9TRxdVbNfONpxg=ZvRSz9-4t=Q@mail.gmail.com>
References: <1457268494-8394-1-git-send-email-dpdineshp2@gmail.com>
	<1457268494-8394-2-git-send-email-dpdineshp2@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Dinesh Polathula <dpdineshp2@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 06 20:36:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aceTE-0001os-LI
	for gcvg-git-2@plane.gmane.org; Sun, 06 Mar 2016 20:36:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbcCFTf5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Mar 2016 14:35:57 -0500
Received: from mail-vk0-f45.google.com ([209.85.213.45]:34201 "EHLO
	mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750755AbcCFTf4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2016 14:35:56 -0500
Received: by mail-vk0-f45.google.com with SMTP id e185so98416291vkb.1
        for <git@vger.kernel.org>; Sun, 06 Mar 2016 11:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=XkzfSKu8RyyNoL8rlHjXwU/zB+815E5tDT+lDhCcZrk=;
        b=PpqBC1feLo4jbjBvPyqfLDXtq09Cofa+ijwoVtKSkdsxLpNfzeLjbs9GqnHhnpSns8
         TE2IzPLhH7p8DR334LdNUmQobJp1jg2FKfB6OhKOYtHuJgAMm2YObmp1Jp0N5/Wvjcno
         Uu53uizy2RAMRPqCVftbPodvtGqUMp/uguV6p3TIxMPJVpU949Gu6NJqqO67LJcktkoX
         fmv6iLKC7n5j8BybO2n0sLPHeUymDQsUuShgXZua+jJfDVvCcSYWzjtIJyyY09z7k9l6
         NhpmdIhQY+c6JMftEpDtI8W2lvspwRwP82WW9ey+HCj8njT78dENHCbIy/OjP5fCLNuj
         Bi4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=XkzfSKu8RyyNoL8rlHjXwU/zB+815E5tDT+lDhCcZrk=;
        b=TvngoGZGAmJ1NChtYVhlvYIUtNwkZHgH/SoytVl1Whq1Ag2UGvpy4vY7tw5NU3d+mF
         FejBZmMfECntD276yqaZuPs4pf198Oj4gpgr6Oj07D2gjBGrHr8SqcmcBOK23AkH48Kg
         KWHjjM1zS6TbgOAZZDYPnx8J6TYj3buPjrz+wMs24rilDc/YBprjoeVcHvtlL/9n3uGn
         +li/xgw+gL7UviiGycFuFKabJGphBahPADQ04siewL1y2Y2E/yv+Aolij8UI/P88UPHc
         3bJiUnoGoAwhpoFgLDql82uLJQtpfcvo8dVCameqb1Fp9BCTsNV+A8LU1VslVP7NhM0E
         CW5A==
X-Gm-Message-State: AD7BkJJxmVRNVLNZ4RmFjT/bYjOdacj19n5tCzFb/f7AXaX1kQ5+S7/zhVNdXPyCUH4Woo1m+3JLld3GyQoCog==
X-Received: by 10.31.21.4 with SMTP id 4mr16780611vkv.151.1457292955188; Sun,
 06 Mar 2016 11:35:55 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Sun, 6 Mar 2016 11:35:55 -0800 (PST)
In-Reply-To: <1457268494-8394-2-git-send-email-dpdineshp2@gmail.com>
X-Google-Sender-Auth: TrQl0oEmGzuzdKrUUcEGOZjbuyg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288364>

On Sun, Mar 6, 2016 at 7:48 AM, Dinesh Polathula <dpdineshp2@gmail.com> wrote:
> From: Dinesh <dpdineshp2@gmail.com>

You can drop this line and let git-am pick up your name and address
from the email envelope.

> Allow "-" as a short-hand for "@{-1}" in "git branch -d @{-1}"

    branch: -d/-D: recognize "-" as short-hand for @{-1}

> The "-" shorthand can be used as a replacement for "@{-1}" to refer
> to the previous branch the user was on in the "git branch -d @{-1}"
> command.

Does/should this also apply to -D?

> Replace "-" argument with "@{-1}" when the command line arguments
> are parsed.

This final sentence isn't really needed, as it's just repeating what
the patch itself already says.

> Signed-off-by: Dinesh Polathula<dpdineshp2@gmail.com>
> ---
>  builtin/branch.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)

Does this need a documentation update? Is "-" documented for other
commands which recognize it specially or is knowledge of "-" implicit?

This change probably does deserve a new test or two.

> diff --git a/builtin/branch.c b/builtin/branch.c
> index 7b45b6b..98d2c4b 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -24,7 +24,7 @@
>  static const char * const builtin_branch_usage[] = {
>         N_("git branch [<options>] [-r | -a] [--merged | --no-merged]"),
>         N_("git branch [<options>] [-l] [-f] <branch-name> [<start-point>]"),
> -       N_("git branch [<options>] [-r] (-d | -D) <branch-name>..."),
> +       N_("git branch [<options>] [-r] (-d | -D) [-] <branch-name>..."),
>         N_("git branch [<options>] (-m | -M) [<old-branch>] <new-branch>"),
>         N_("git branch [<options>] [-r | -a] [--points-at]"),
>         NULL
> @@ -658,8 +658,13 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>         filter.abbrev = -1;
>
>         if (argc == 2 && !strcmp(argv[1], "-h"))
> -               usage_with_options(builtin_branch_usage, options);
> -
> +       {
> +               usage_with_options(builtin_branch_usage, options);
> +       }

Why add unnecessary braces (making the diff noisier, as well)?

> +       if (argc == 3 && !strcmp(argv[2], "-"))

The commit message talks about this applying only to -d (and
presumably -D), however, there doesn't seem to be any constraint
enforcing that.

Won't this logic fail if the user passes other options accepted by
git-branch, such as --quite (for instance, "git branch --quiet -d -")?
How do other Git commands which recognize "-" as alias for @{-1} deal
with this? Have you checked their implementations?

To address these issues, it seems like a more correct place to
recognize "-" as an alias would be somewhere within
builtin/branch.d:delete_branches().

> +       {
> +           argv[2] = "@{-1}";
> +       }

Style: Unnecessary braces.

>         git_config(git_branch_config, NULL);
>
>         track = git_branch_track;
> --
> 2.8.0.rc0
