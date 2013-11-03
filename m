From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH] remote: unify main and subcommand usage strings
Date: Sun, 3 Nov 2013 16:03:34 +0800
Message-ID: <CANYiYbGh-HR+hJcLg9AGbdXU=ypW8YwFqVcyVactJMYg4OOF7w@mail.gmail.com>
References: <52746664.1050806@gmail.com>
	<c2d51c4014545f037bb9399dba7b378d6d79d18b.1383407880.git.tr@thomasrast.ch>
	<CANYiYbGD=VJ64pESwxkMYy8HxESyW_2N0Q5M92rCJF2E1FD-bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Sun Nov 03 09:03:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vcset-0003aZ-6e
	for gcvg-git-2@plane.gmane.org; Sun, 03 Nov 2013 09:03:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752698Ab3KCIDj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Nov 2013 03:03:39 -0500
Received: from mail-wi0-f172.google.com ([209.85.212.172]:58136 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752631Ab3KCIDg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Nov 2013 03:03:36 -0500
Received: by mail-wi0-f172.google.com with SMTP id ez12so2597367wid.17
        for <git@vger.kernel.org>; Sun, 03 Nov 2013 01:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=C07KpxPssjHPw/edUGYQxVX7jtzjZJ4hj16CpDrGHu8=;
        b=vxUNJSZk9GKpFWH2AAGtRrn2by/CWOBlyNBVucRVCF4x5xCRpVhPfOqR7BFEWLIWXz
         CPgO8aaMrWPSN2FlAlLJODMMLXI6CPprzsqMhhQOmwK3UrW6ann8tN4hh2MeWUFhEuSd
         rRKR/PnTcMmq5pX6aHpG5s3o5Ka5Ud2Dpu+wybjFZR6FKdfMiV8p1z0k2k6ISTO7AQQd
         ziA8YWp7R1L/wBKnku6YhgB9rMkmZaPfTjASZMQH44LYWXzqVafizF7lJ6MkZEwOdeNS
         mSI/6ECg3oy3c+dqUhkKE3bO8bGvGnE/hu4xSqLGgh6vWfadOQlNg81B0sb97511BhM2
         TSLA==
X-Received: by 10.180.85.42 with SMTP id e10mr8158743wiz.1.1383465814349; Sun,
 03 Nov 2013 01:03:34 -0700 (PDT)
Received: by 10.216.122.202 with HTTP; Sun, 3 Nov 2013 01:03:34 -0700 (PDT)
In-Reply-To: <CANYiYbGD=VJ64pESwxkMYy8HxESyW_2N0Q5M92rCJF2E1FD-bw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237256>

2013/11/3 Jiang Xin <worldhello.net@gmail.com>:
> 2013/11/3 Thomas Rast <tr@thomasrast.ch>:
>> Note that this patch changes the usage strings for the following
>> subcommands:
>
> Differences of git-remote usages after applied your patch.
>
> diff -u before/git-remote-add-usage after/git-remote-add-usage
> --- before/git-remote-add-usage 2013-11-03 15:10:06.000000000 +0800
> +++ after/git-remote-add-usage 2013-11-03 15:11:32.000000000 +0800
> @@ -1,4 +1,4 @@
> -usage: git remote add [<options>] <name> <url>
> +usage: git remote add [-t <branch>] [-m <master>] [-f]
> [--tags|--no-tags] [--mirror=<fetch|push>] <name> <url>
>
>      -f, --fetch           fetch the remote branches
>      --tags                import all tags and associated objects when fetching
>
> diff -u before/git-remote-prune-usage after/git-remote-prune-usage
> --- before/git-remote-prune-usage 2013-11-03 15:10:06.000000000 +0800
> +++ after/git-remote-prune-usage 2013-11-03 15:11:32.000000000 +0800
> @@ -1,4 +1,4 @@
> -usage: git remote prune [<options>] <name>
> +usage: git remote prune [-n | --dry-run] <name>
>
>      -n, --dry-run         dry run
>
> diff -u before/git-remote-set-branches-usage after/git-remote-set-branches-usage
> --- before/git-remote-set-branches-usage 2013-11-03 15:10:06.000000000 +0800
> +++ after/git-remote-set-branches-usage 2013-11-03 15:11:32.000000000 +0800
> @@ -1,5 +1,4 @@
> -usage: git remote set-branches <name> <branch>...
> -   or: git remote set-branches --add <name> <branch>...
> +usage: git remote set-branches [--add] <name> <branch>...
>
>      --add                 add branch
>
> diff -u before/git-remote-show-usage after/git-remote-show-usage
> --- before/git-remote-show-usage 2013-11-03 15:10:06.000000000 +0800
> +++ after/git-remote-show-usage 2013-11-03 15:11:32.000000000 +0800
> @@ -1,4 +1,4 @@
> -usage: git remote show [<options>] <name>
> +usage: git remote [-v | --verbose] show [-n] <name>
>
>      -n                    do not query remotes
>
> diff -u before/git-remote-update-usage after/git-remote-update-usage
> --- before/git-remote-update-usage 2013-11-03 15:10:06.000000000 +0800
> +++ after/git-remote-update-usage 2013-11-03 15:11:32.000000000 +0800
> @@ -1,4 +1,4 @@
> -usage: git remote update [<options>] [<group> | <remote>]...
> +usage: git remote [-v | --verbose] update [-p | --prune] [(<group> |
> <remote>)...]
>
>      -p, --prune           prune remotes after fetching
>

In order to get the differences of git-remote usages, I write a script.

    # SCRIPT to save git remote usage in files.
    for cmd in add set-head show prune update set-branches set-url; do
            git remote $cmd -h > $DIR/git-remote-$cmd-usage
    done
    git remote -h > $DIR/git-remote-usage
    git remote remove  > $DIR/git-remote-remove-usage 2>&1
    git remote rename  > $DIR/git-remote-rename-usage  2>&1

Then I find two subcommands (remove and rename) are strange.

 * All other subcommands output usages to STDIN, but subcommands
    "remove" and "rename" send their usages to STDERR.

 * I can get the help message of all other subcommands using:
   "git remote <subcmd> -h", but not "git remote rm -h"

        $ git remote rm -h
        error: Could not remove config section 'remote.-h'

Later I know it's a side-effect that all other subcommands could
print usages if provide a unkown "-h/--help" option.

What if add a parse_options call for both "rm" and "mv" functions
in builtin/remote.c?

diff --git a/builtin/remote.c b/builtin/remote.c
index 2f6366a..171d1a8 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -651,6 +651,8 @@ static int mv(int argc, const char **argv)
        struct rename_info rename;
        int i, refspec_updated = 0;

+       argc = parse_options(argc, argv, NULL, options,
+                            builtin_remote_rename_usage, 0);
        if (argc != 3)
                usage_with_options(builtin_remote_rename_usage, options);

@@ -808,6 +810,8 @@ static int rm(int argc, const char **argv)
        cb_data.skipped = &skipped;
        cb_data.keep = &known_remotes;

+       argc = parse_options(argc, argv, NULL, options,
+                            builtin_remote_rm_usage,0);
        if (argc != 2)
                usage_with_options(builtin_remote_rm_usage, options);


-- 
Jiang Xin
