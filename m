From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH] Add --no-autostash flag to git pull --rebase
Date: Fri, 26 Feb 2016 20:47:54 +0800
Message-ID: <CACRoPnTKRwGmhQOrJsA2ys66RwRVcY1nu+hs_5_YMqgiSUbNiw@mail.gmail.com>
References: <1456485825-21309-1-git-send-email-mehul.jain2029@gmail.com>
	<1456485825-21309-2-git-send-email-mehul.jain2029@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Kevin Daudt <me@ikke.info>
To: Mehul Jain <mehul.jain2029@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 13:48:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZHoU-0003it-Ca
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 13:48:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753959AbcBZMr5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 07:47:57 -0500
Received: from mail-lb0-f181.google.com ([209.85.217.181]:34605 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751647AbcBZMr4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 07:47:56 -0500
Received: by mail-lb0-f181.google.com with SMTP id of3so45915357lbc.1
        for <git@vger.kernel.org>; Fri, 26 Feb 2016 04:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=8srLskrf4IzA4qpSoQmESg92w7vD5Pc5m3UapRLpp54=;
        b=RP4sd4eHaQ8lIQmOIhoj32N5jZvZkgb/+9oe+1/juF+PIpHi2/jgFVvIm8OblXIAA1
         4DcyzpiI4HVrgd5BPcgbYBO1ann5tuy01vtqF8ntAVsvyPtBVjQUuwROC57ueKvfHNlM
         OzAbgXEZ0LceDMiJ6sZfHgvZ/B+YuRVMFuOwX9Mg82epOvn4ka7YWDhqGzzDpMAwzwoP
         5PSl/UoeoHody7N3km7ZP+4VepLT2+RdU6yKNl+ikAtrArFghzx1T+85Mq0wUHclwS7c
         rQHIAhWJuxiEByuNgpBHAvyNvWycfN7P4OyRxwk8tNks2/cLOHFX9MTc8wIKlZO0E/E8
         U31A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=8srLskrf4IzA4qpSoQmESg92w7vD5Pc5m3UapRLpp54=;
        b=R79kb/AwuGeark4ivCJ7At4Hydw/rUYYJGEGB1cn+6zsFRE3l6n2F3J70s8iCegc2e
         gkt9qxpKj19JcVaJU254fBrfQDC/gQysOG/hI9P7Ydp24oLOMAf0voauH/O1AF/lId8x
         lAsq6589LB7AZcHX3Rgc7aAnICdyTnkmd3Jx6lg+51Ay4DrzrzE53uUzMdgQD9bW4v4Z
         os4IGQ2X1HNmPnOyJu9EUwCj/uJ61B6kjdohCRDXjphwiH+4JxhmhgNs3p4qWBZeNjep
         wfySyWsVXO5tqkDU1afaKcV2l0ycvSPoDLjGvFe1l6rKdJWr1GBzAk11pUU2AU4LCuhg
         ZVeQ==
X-Gm-Message-State: AD7BkJJ7hdwZaJqsLvvsQdzuLC6W7BCwrU65hp8uhgnHtlGmqNH5NEUywc9EyuxHNo3YLU21gJBSy2TBZTYcEg==
X-Received: by 10.112.63.200 with SMTP id i8mr552869lbs.5.1456490874671; Fri,
 26 Feb 2016 04:47:54 -0800 (PST)
Received: by 10.112.207.68 with HTTP; Fri, 26 Feb 2016 04:47:54 -0800 (PST)
In-Reply-To: <1456485825-21309-2-git-send-email-mehul.jain2029@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287575>

On Fri, Feb 26, 2016 at 7:23 PM, Mehul Jain <mehul.jain2029@gmail.com> wrote:
> Subject: [PATCH] Add --no-autostash flag to git pull --rebase

We usually don't capitalize the first word of the commit title. We
also usually prefix the commit title with the relevant subsystem, file
or command. So something like:

pull --rebase: add --[no-]autostash flag

Some grammatical/spelling nits below:

> git pull --rebase now understand --no-autostash flag.

s/understand/understands the/

> If directory is found to be dirty then command will die.

If the worktree is found to be dirty then the command will die.

(Perhaps state more clearly that the dirty worktree check is only
performed on --no-autostash or rebase.autostash=false.)

> This flag override "rebase.autostash" configuration(if set).

s/override/overrides the/

> If this flag is not passed in command line then default behaviour is choosen,

s/choosen/chosen/

> given by "rebase.autostash"(if "rebase.autostash"
> is not set then git pull --rebase will die if directory is dirty).

If "rebase.autostash" is not set or is false. Or you could shorten it
by saying that "(default is false)".

> Signed-off-by: Mehul Jain <mehul.jain2029@gmail.com>
> ---
>  builtin/pull.c          | 12 ++++++++----
>  t/t5520-pull.sh         |  8 ++++++++
>  t/t5521-pull-options.sh | 24 ++++++++++++++++++++++++
>  3 files changed, 40 insertions(+), 4 deletions(-)

I think git-pull's documentation should be updated as well to talk
about this new command-line switch.

> diff --git a/builtin/pull.c b/builtin/pull.c
> index 10eff03..9d1a3d0 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -85,6 +85,7 @@ static char *opt_squash;
>  static char *opt_commit;
>  static char *opt_edit;
>  static char *opt_ff;
> +static int opt_autostash = -1;
>  static char *opt_verify_signatures;
>  static struct argv_array opt_strategies = ARGV_ARRAY_INIT;
>  static struct argv_array opt_strategy_opts = ARGV_ARRAY_INIT;
> @@ -146,6 +147,8 @@ static struct option pull_options[] = {
>         OPT_PASSTHRU(0, "ff-only", &opt_ff, NULL,
>                 N_("abort if fast-forward is not possible"),
>                 PARSE_OPT_NOARG | PARSE_OPT_NONEG),
> +       OPT_COLOR_FLAG(0,"autostash",&opt_autostash,
> +               N_("abort if tree is dirty")),

Why OPT_COLOR_FLAG()? And --autostash is not just about aborting if
the working tree is dirty. Why not just copy the help message from
git-rebase? Something like:

"automatically stash/stash pop before and after rebase"

>         OPT_PASSTHRU(0, "verify-signatures", &opt_verify_signatures, NULL,
>                 N_("verify that the named commit has a valid GPG signature"),
>                 PARSE_OPT_NOARG),
> @@ -835,13 +838,14 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>                 hashclr(orig_head);
>
>         if (opt_rebase) {
> -               int autostash = 0;
> -
>                 if (is_null_sha1(orig_head) && !is_cache_unborn())
>                         die(_("Updating an unborn branch with changes added to the index."));
>
> -               git_config_get_bool("rebase.autostash", &autostash);
> -               if (!autostash)
> +               if(opt_autostash < 0)
> +                       if(git_config_get_bool("rebase.autostash",&opt_autostash))
> +                               opt_autostash = 0;

I wonder if this code could be shortened if we simply just called
git_config_get_bool() just before parse_options(). That way, we don't
need to check for the "-1" special value.

> +
> +               if (!opt_autostash)
>                         die_on_unclean_work_tree(prefix);

OK.

>
>                 if (get_rebase_fork_point(rebase_fork_point, repo, *refspecs))
> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
> index c952d5e..512d3bf 100755
> --- a/t/t5520-pull.sh
> +++ b/t/t5520-pull.sh
> @@ -245,6 +245,14 @@ test_expect_success '--rebase fails with multiple branches' '
>         test modified = "$(git show HEAD:file)"
>  '
>
> +test_expect_success '--rebase --no-autostash fails with dirty working directory' '

Maybe add ..."and rebase.autostash set" to the test name? Describes
the test better, and is consistent with the name of the test below.

> +       test_config rebase.autostash true &&
> +       git reset --hard before-rebase &&
> +       echo dirty >new_file &&
> +       git add new_file &&
> +       test_must_fail git pull --rebase --no-autostash . copy
> +'
> +
>  test_expect_success 'pull --rebase succeeds with dirty working directory and rebase.autostash set' '
>         test_config rebase.autostash true &&
>         git reset --hard before-rebase &&
> diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
> index 18372ca..22ff5d7 100755
> --- a/t/t5521-pull-options.sh
> +++ b/t/t5521-pull-options.sh
> @@ -62,6 +62,30 @@ test_expect_success 'git pull -v --rebase' '
>         test_must_be_empty out)
>  '
>
> +test_expect_success 'git pull --rebase --no-autostash' '
> +       mkdir clonedrbnas &&

Took me some time to realize this directory name is actually "cloned"
+ "rb" (from --rebase) and "nas" (--no-autostash) ;-)

> +       (cd clonedrbnas  && git init &&
> +       git pull --rebase --no-autostash "../parent" >out 2>err &&
> +       test -s err &&
> +       test_must_be_empty out)
> +'
> +
> +test_expect_success 'git pull -q --rebase --no-autostash' '
> +       mkdir clonedqrbnas &&
> +       (cd clonedqrbnas  && git init &&
> +       git pull -q --rebase --no-autostash "../parent" >out 2>err &&
> +       test_must_be_empty err &&
> +       test_must_be_empty out)
> +'
> +
> +test_expect_success 'git pull -v --rebase --no-autostash' '
> +       mkdir clonedvrbnas &&
> +       (cd clonedvrbnas && git init &&
> +       git pull -v --rebase --no-autostash "../parent" >out 2>err &&
> +       test -s err &&
> +       test_must_be_empty out)
> +'

While more tests are always good, I don't think we need to test for
"-q" and "-v" with --no-autostash, because it's already covered by the
test for "git pull -q --rebase". Perhaps with --autostash, but even
then I don't think we need a test for "-v".

> +
>  test_expect_success 'git pull -v -q' '
>         mkdir clonedvq &&
>         (cd clonedvq && git init &&
> --
> 2.7.1.340.g69eb491.dirty

Thanks,
Paul
