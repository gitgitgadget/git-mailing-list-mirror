Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E57120899
	for <e@80x24.org>; Tue,  8 Aug 2017 18:33:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752138AbdHHSd2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 14:33:28 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33331 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751833AbdHHSd1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 14:33:27 -0400
Received: by mail-pg0-f65.google.com with SMTP id u185so3788659pgb.0
        for <git@vger.kernel.org>; Tue, 08 Aug 2017 11:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=i663ItVgXikAY0cCI62tCQ8n+L2Djxtp8v8lX6gB8UU=;
        b=TiKsYcFiQXNPdoquY5KPLH1a70ho2prmsWgHxIm6fRXWjnaPKk7IWYm0VnpJidFXTT
         +weH7Kmf37LEG4Y5d7UpU8wboJU+nMj3k64kha2VffcR/4Jn2y31kW5+R+D4zfYBuEk5
         oiH06iLMGVDYDoHocVPuLE2m7VVrBNb2TpKxOO8vJQbFUgGd5HDLqqIcdEJumJJLlxog
         wntwvklSGvmv/z4cOs8bIsd1Q2e/7w386E12slDbN/x8g9ax3xBHH2cwW7jf4Tq72w9n
         gqCC/DW9xx7f66ph7CyyAMTLcpsTOrjGMCyLvmEOOPtNyt7cDC5nzasGI2F5ZQE+KROA
         TTJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=i663ItVgXikAY0cCI62tCQ8n+L2Djxtp8v8lX6gB8UU=;
        b=gzApSATXunMaPPwZzAtA8iSSLXjIJQlOBv5e/gU/gE5ZwLWLzOlLpJNSFmp74h3m1L
         P8U6FdhlKr2bMdSuvgqVxwKAwH8FvmIptN0/B1+UaBFzJ8BCBxvg1zDsiMGu5WT0J5va
         VMFGSPi9HfFSU387xkocetKwUuNSSCvb+9T1tt0STPTg71QYqwuPHT2WJdp3vTPdGAxf
         s2G/UXqCkx2PUVwIYzlRFv/IUhho36kdcB42oC6KBcuGmQPJ4gVwiRbEyx9KU5hMm2bD
         FBgLzmnAczvchNs3UFQiLeGhZ3k+fnPkOiLBbUIhgCE1F/buJUA9S1SLNU3QK5CumeIz
         olQQ==
X-Gm-Message-State: AHYfb5j0hHPZ5eJgx9/4myYUgmE1d0+nswBVHTMZQOCepUtGLsyXV6fr
        zV4c0bBEKQST8sBCpotglo7LBJ5rqw==
X-Received: by 10.99.112.16 with SMTP id l16mr4926956pgc.143.1502217206605;
 Tue, 08 Aug 2017 11:33:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.165.238 with HTTP; Tue, 8 Aug 2017 11:33:26 -0700 (PDT)
In-Reply-To: <20170808171136.31168-1-kaarticsivaraam91196@gmail.com>
References: <xmqq60dzp00l.fsf@gitster.mtv.corp.google.com> <20170808171136.31168-1-kaarticsivaraam91196@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 8 Aug 2017 20:33:26 +0200
Message-ID: <CAN0heSqbAdYy-2c0CfO2OxijtvncGWe432bFmkpHZugKDrx-pw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2 / RFC] builtin/branch: stop supporting the use of
 --set-upstream option
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8 August 2017 at 19:11, Kaartic Sivaraam
<kaarticsivaraam91196@gmail.com> wrote:
> The '--set-upstream' option of branch was deprecated in,
>
>     b347d06bf branch: deprecate --set-upstream and show help if we
>     detect possible mistaken use (Thu, 30 Aug 2012 19:23:13 +0200)
>
> It was deprecated for the reasons specified in the commit message of
> the referenced commit.
>
> Refactor 'branch' so that it dies with an appropraite error message
> when the '--set-upstream' is used.

appropriate. (Also, is this really a refactoring?)

>
> Note that there's a reason behind "dying with an error message" instead of
> "not accepting the '--set-upstream'". ;git branch' would still *accept*
> '--set-upstream' even after it's removal as a consequence of "unique
> prefix can be abbrievated in option names" AND '--set-upstream' is a unique
> prefix of '--set-upstream-to' when '--set-upstream' has been removed. In
> order to smooth the transition for users due to the "prefix issue" it was
> decided to make branch die when seeing the '--set-upstream' flag for a few
> years and let the users know that it would be removed some time in the future.
>
> The before/after behaviour for a simple case follows,
>
>     $ git remote
>     origin
>
> Before,
>
>     $ git branch
>     * master
>
>     $ git branch --set-upstream origin/master
>     The --set-upstream flag is deprecated and will be removed. Consider using --track or --set-upstream-to
>     Branch origin/master set up to track local branch master.
>
>     $ echo $?
>     0
>
>     $ git branch
>     * master
>       origin/master
>
> After,
>
>     $ git branch
>     * master
>
>     $ git branch --set-upstream origin/master
>     fatal: the '--set-upstream' flag is no longer supported and will be removed. Consider using '--track' or '--set-upstream-to'
>
>     $ echo $?
>     128
>
>     $ git branch
>     * master
>
> Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
> ---
>  Changes in v2:
>
>  The previous patch removed the concerned option while the current patch
>  makes 'git branch' die on seeing the option.
>
>  The possibility of '--set-upstream' becoming an alias of  '--set-upstream-to'
>  was documented.
>
>  Documentation/git-branch.txt |  8 +++----
>  builtin/branch.c             | 21 +------------------
>  t/t3200-branch.sh            | 50 ++++----------------------------------------
>  t/t6040-tracking-info.sh     | 16 +++++++-------
>  4 files changed, 17 insertions(+), 78 deletions(-)
>
> diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
> index 81bd0a7b7..372107e0c 100644
> --- a/Documentation/git-branch.txt
> +++ b/Documentation/git-branch.txt
> @@ -195,10 +195,10 @@ start-point is either a local or remote-tracking branch.
>         branch.autoSetupMerge configuration variable is true.
>
>  --set-upstream::
> -       If specified branch does not exist yet or if `--force` has been
> -       given, acts exactly like `--track`. Otherwise sets up configuration
> -       like `--track` would when creating the branch, except that where
> -       branch points to is not changed.
> +       This option is no longer supported and will be removed in the future.
> +       Consider using --track or --set-upstream-to instead.
> ++
> +Note: This could possibly become an alias of --set-upstream-to in the future.

Maybe the final note could be removed? Someone who is looking up
--set-upstream because Git just "crashed" on them will only want to know
what they should do instead. Our thoughts about the future are perhaps
not that interesting. (I sort of wonder if this option needs to be
documented at all, especially if this doesn't say anything more than
the die() just did.)

Also, I'm wondering if it should be "has been removed" instead of "will
be removed"? /Implementation-wise/, it has not been removed yet, but to
the user, it has. So maybe just "This option has been removed. Consider
using --track or --set-upstream-to instead." The same below.

I don't know if it's worth trying to use PARSE_OPT_HIDDEN in the
options-struct?

Martin

>  -u <upstream>::
>  --set-upstream-to=<upstream>::
> diff --git a/builtin/branch.c b/builtin/branch.c
> index a3bd2262b..2fcb6f7e5 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -755,8 +755,6 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>                 strbuf_release(&buf);
>         } else if (argc > 0 && argc <= 2) {
>                 struct branch *branch = branch_get(argv[0]);
> -               int branch_existed = 0, remote_tracking = 0;
> -               struct strbuf buf = STRBUF_INIT;
>
>                 if (!strcmp(argv[0], "HEAD"))
>                         die(_("it does not make sense to create 'HEAD' manually"));
> @@ -768,28 +766,11 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>                         die(_("-a and -r options to 'git branch' do not make sense with a branch name"));
>
>                 if (track == BRANCH_TRACK_OVERRIDE)
> -                       fprintf(stderr, _("The --set-upstream flag is deprecated and will be removed. Consider using --track or --set-upstream-to\n"));
> +                       die(_("the '--set-upstream' flag is no longer supported and will be removed. Consider using '--track' or '--set-upstream-to'"));
>
> -               strbuf_addf(&buf, "refs/remotes/%s", branch->name);
> -               remote_tracking = ref_exists(buf.buf);
> -               strbuf_release(&buf);
> -
> -               branch_existed = ref_exists(branch->refname);
>                 create_branch(argv[0], (argc == 2) ? argv[1] : head,
>                               force, reflog, 0, quiet, track);
>
> -               /*
> -                * We only show the instructions if the user gave us
> -                * one branch which doesn't exist locally, but is the
> -                * name of a remote-tracking branch.
> -                */
> -               if (argc == 1 && track == BRANCH_TRACK_OVERRIDE &&
> -                   !branch_existed && remote_tracking) {
> -                       fprintf(stderr, _("\nIf you wanted to make '%s' track '%s', do this:\n\n"), head, branch->name);
> -                       fprintf(stderr, "    git branch -d %s\n", branch->name);
> -                       fprintf(stderr, "    git branch --set-upstream-to %s\n", branch->name);
> -               }
> -
>         } else
>                 usage_with_options(builtin_branch_usage, options);
