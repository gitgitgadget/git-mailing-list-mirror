Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 271621F42D
	for <e@80x24.org>; Wed,  9 May 2018 08:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933862AbeEIIUQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 04:20:16 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:35227 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933715AbeEIIUO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 04:20:14 -0400
Received: by mail-ot0-f193.google.com with SMTP id h8-v6so39198734otb.2
        for <git@vger.kernel.org>; Wed, 09 May 2018 01:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ngAWKp1GF7QlS9Xfw0uhN1p3KnakvJZA2HhAC5/S6xA=;
        b=hSbIIdaBXxJndo8q/KouHSa1klQ9ZTneIaJoPg5Ar2melFnPru6kSW55/zh/oeR1rq
         //9jU2oP2u5fMhWiEGLnPpJLSYh+UkPWAh20IoF2Lk+5o94EpfIjAkvgAz4rFg+TexO0
         oHs4N8IK9tGV/yQZyuSupNqH0kWgEgW3p6Da0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ngAWKp1GF7QlS9Xfw0uhN1p3KnakvJZA2HhAC5/S6xA=;
        b=qKS6eqRqSYIdevTHII7ogGFJh9agaYhilJS+V/KEhkC0wUqiCvhI1FPqIeqwqGDO8c
         SbTbAF3LFBaMe9xe2Nm8BPTCNfM3uWHzDXNPoVkdSCDd/vqMPTVIS9AbbADYgR2+twcS
         QzLOz0geiz5ofmuAa0AUPvSBYPLTXPbp+bn2mQ5cVI/JjXI5LrX+/y3dHQzNwyvWa3zw
         VotFPi6CMs13H0/ZdWJe1GvHTAK5ucctD93SEosSfUAPxd71KXycu61w50K/ujWCYhuP
         E7/pOY6dGug7FamPoiqBOqGM1gdC5iJPkH9n1fjISPqQlhrgVzjs76mCVMMHNSECGNtw
         ks8g==
X-Gm-Message-State: ALQs6tDQ9gMEPJB/iM7ct0esHZU5HE1Fmt5TCqkd7t16+Pg+fLUyCqsY
        P+nK/h0fOwI81HtLimrQgkXUy0KAA2AfAh4XvRTEtQ==
X-Google-Smtp-Source: AB8JxZqr6xoDYdaT8aLV6mRK4nTrQaw+yE+tH/rXNffwQuO0nyj37/9md9Yq74A7+c0co7EJi51T7ul9WOIMwIgGqSE=
X-Received: by 2002:a9d:5774:: with SMTP id x49-v6mr34153852oti.314.1525854013360;
 Wed, 09 May 2018 01:20:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:3c57:0:0:0:0:0 with HTTP; Wed, 9 May 2018 01:20:12 -0700 (PDT)
In-Reply-To: <569077545.8373111.1525739857273@mail.yahoo.com>
References: <569077545.8373111.1525739857273.ref@mail.yahoo.com> <569077545.8373111.1525739857273@mail.yahoo.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Wed, 9 May 2018 09:20:12 +0100
Message-ID: <CAE5ih7_u+7BzCRe4X9HjTgp9GxK34Co1v1kY=W=7Wa65inbkEg@mail.gmail.com>
Subject: Re: [PATCH] git-p4: add options --commit and --disable-rebase
To:     Merland Romain <merlorom@yahoo.fr>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <Matthieu.Moy@imag.fr>,
        Vinicius Kursancew <viniciusalexandre@gmail.com>,
        Jeff King <peff@peff.net>,
        Fabien Boutantin <fabien.boutantin@pdgm.com>,
        Cedric Borgese <cedric.borgese@pdgm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8 May 2018 at 01:37, Merland Romain <merlorom@yahoo.fr> wrote:
> From f5229be8e2a3340af853227929818940323a8062 Mon Sep 17 00:00:00 2001
> From: Romain Merland <merlorom@yahoo.fr>
> Date: Tue, 8 May 2018 02:03:11 +0200
> Subject: [PATCH] git-p4: add options --commit and --disable-rebase
> To: git@vger.kernel.org
> Cc: Luke Diamand <luke@diamand.org>,
>     Junio C Hamano <gitster@pobox.com>,
>     Matthieu Moy <Matthieu.Moy@imag.fr>,
>     Vinicius Kursancew <viniciusalexandre@gmail.com>,
>     Jeff King <peff@peff.net>,
>     Cedric Borgese <cedric.borgese@pdgm.com>,
>     Fabien Boutantin <fabien.boutantin@pdgm.com>
> Thanks-to: Cedric Borgese
> Signed-off-by: Romain Merland
>
> On a daily work with multiple local git branches, the usual way to submit
> only a
> specified commit was to cherry-pick the commit on master then run git-p4
> submit.
> It can be very annoying to switch between local branches and master, only to
> submit one commit.
> The proposed new way is to select directly the commit you want to submit.
>
> add option --commit to command 'git-p4 submit' in order to submit only
> specified commit(s) in p4.
>
> On a daily work developping software with big compilation time, one may not
> want
> to rebase on his local git tree, in order to avoid long recompilation.
>
> add option --disable-rebase to command 'git-p4 submit' in order to disable
> rebase after submission.

Looks good to me.

I just tried it (shelving a change about 3 commits down) and it works
like a charm!

The "--disable-rebase" will also be very useful (I wonder whether a
git-config option might be a useful addition at a later date).

(You might need to resubmit your change as plain text via "git
format-patch" and "git send-email" as I'm not sure if Junio will
accept a mime-encoded patch).

Thanks
Luke

> ---
>  Documentation/git-p4.txt | 14 ++++++++++++++
>  git-p4.py                | 29 +++++++++++++++++++++++------
>  t/t9807-git-p4-submit.sh | 40 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 77 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
> index d8c8f11c9..88d109deb 100644
> --- a/Documentation/git-p4.txt
> +++ b/Documentation/git-p4.txt
> @@ -149,6 +149,12 @@ To specify a branch other than the current one, use:
>  $ git p4 submit topicbranch
>  ------------
>
> +To specify a single commit or a range of commits, use:
> +------------
> +$ git p4 submit --commit <sha1>
> +$ git p4 submit --commit <sha1..sha1>
> +------------
> +
>  The upstream reference is generally 'refs/remotes/p4/master', but can
>  be overridden using the `--origin=` command-line option.
>
> @@ -330,6 +336,14 @@ These options can be used to modify 'git p4 submit'
> behavior.
>   p4/master.  See the "Sync options" section above for more
>   information.
>
> +--commit <sha1>|<sha1..sha1>::
> +    Submit only the specified commit or range of commits, instead of the
> full
> +    list of changes that are in the current Git branch.
> +
> +--disable-rebase::
> +    Disable the automatic rebase after all commits have been successfully
> +    submitted.
> +
>  Rebase options
>  ~~~~~~~~~~~~~~
>  These options can be used to modify 'git p4 rebase' behavior.
> diff --git a/git-p4.py b/git-p4.py
> index 7bb9cadc6..f4a6f3b4c 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -1352,7 +1352,12 @@ class P4Submit(Command, P4UserMap):
>                  optparse.make_option("--update-shelve",
> dest="update_shelve", action="append", type="int",
>                                       metavar="CHANGELIST",
>                                       help="update an existing shelved
> changelist, implies --shelve, "
> -                                           "repeat in-order for multiple
> shelved changelists")
> +                                           "repeat in-order for multiple
> shelved changelists"),
> +                optparse.make_option("--commit", dest="commit",
> metavar="COMMIT",
> +                                     help="submit only the specified
> commit(s), one commit or xxx..xxx"),
> +                optparse.make_option("--disable-rebase",
> dest="disable_rebase", action="store_true",
> +                                     help="Disable rebase after submit is
> completed. Can be useful if you "
> +                                     "work from a local git branch that is
> not master")
>          ]
>          self.description = "Submit changes from git to the perforce depot."
>          self.usage += " [name of git branch to submit into perforce depot]"
> @@ -1362,6 +1367,8 @@ class P4Submit(Command, P4UserMap):
>          self.dry_run = False
>          self.shelve = False
>          self.update_shelve = list()
> +        self.commit = ""
> +        self.disable_rebase = False
>          self.prepare_p4_only = False
>          self.conflict_behavior = None
>          self.isWindows = (platform.system() == "Windows")
> @@ -2103,9 +2110,18 @@ class P4Submit(Command, P4UserMap):
>          else:
>              commitish = 'HEAD'
>
> -        for line in read_pipe_lines(["git", "rev-list", "--no-merges",
> "%s..%s" % (self.origin, commitish)]):
> -            commits.append(line.strip())
> -        commits.reverse()
> +        if self.commit != "":
> +            if self.commit.find("..") != -1:
> +                limits_ish = self.commit.split("..")
> +                for line in read_pipe_lines(["git", "rev-list",
> "--no-merges", "%s..%s" % (limits_ish[0], limits_ish[1])]):
> +                    commits.append(line.strip())
> +                commits.reverse()
> +            else:
> +                commits.append(self.commit)
> +        else:
> +            for line in read_pipe_lines(["git", "rev-list", "--no-merges",
> "%s..%s" % (self.origin, commitish)]):
> +                commits.append(line.strip())
> +            commits.reverse()
>
>          if self.preserveUser or gitConfigBool("git-p4.skipUserNameCheck"):
>              self.checkAuthorship = False
> @@ -2215,8 +2231,9 @@ class P4Submit(Command, P4UserMap):
>                  sync.branch = self.branch
>              sync.run([])
>
> -            rebase = P4Rebase()
> -            rebase.rebase()
> +            if self.disable_rebase is False:
> +                rebase = P4Rebase()
> +                rebase.rebase()
>
>          else:
>              if len(applied) == 0:
> diff --git a/t/t9807-git-p4-submit.sh b/t/t9807-git-p4-submit.sh
> index 71cae2874..2325599ee 100755
> --- a/t/t9807-git-p4-submit.sh
> +++ b/t/t9807-git-p4-submit.sh
> @@ -155,6 +155,46 @@ test_expect_success 'allow submit from branch with same
> revision but different n
>   )
>  '
>
> +# make two commits, but tell it to apply only one
> +
> +test_expect_success 'submit --commit one' '
> + test_when_finished cleanup_git &&
> + git p4 clone --dest="$git" //depot &&
> + (
> + cd "$git" &&
> + test_commit "file9" &&
> + test_commit "file10" &&
> + git config git-p4.skipSubmitEdit true &&
> + git p4 submit --commit HEAD
> + ) &&
> + (
> + cd "$cli" &&
> + test_path_is_missing "file9.t" &&
> + test_path_is_file "file10.t"
> + )
> +'
> +
> +# make three commits, but tell it to apply only range
> +
> +test_expect_success 'submit --commit range' '
> + test_when_finished cleanup_git &&
> + git p4 clone --dest="$git" //depot &&
> + (
> + cd "$git" &&
> + test_commit "file11" &&
> + test_commit "file12" &&
> + test_commit "file13" &&
> + git config git-p4.skipSubmitEdit true &&
> + git p4 submit --commit HEAD~2..HEAD
> + ) &&
> + (
> + cd "$cli" &&
> + test_path_is_missing "file11.t" &&
> + test_path_is_file "file12.t" &&
> + test_path_is_file "file13.t"
> + )
> +'
> +
>  #
>  # Basic submit tests, the five handled cases
>  #
> --
> 2.17.0
>
>
