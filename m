Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 755E620A29
	for <e@80x24.org>; Sun, 24 Sep 2017 16:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752474AbdIXQRL (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Sep 2017 12:17:11 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:37013 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752368AbdIXQRK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Sep 2017 12:17:10 -0400
Received: by mail-oi0-f68.google.com with SMTP id h9so2318982oia.4
        for <git@vger.kernel.org>; Sun, 24 Sep 2017 09:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=i5t54lSD0EKe23RdBf0qkaBUKzv4bqFgdStLMfQWiGI=;
        b=fkx5iTetpuEcMvn2/mRad4ERLmivQTd7lcCJK9/FW2DVx28nx8KY9ORu5+qLHx6cc4
         cFwtjwGk52JuzHXnTzOCxuwZX7ikwe47z95rskyGDe2dD1Ug8sUT5x/fJFLjLncfhYq/
         C634JhlYpqXECZfUasWsWR2GaehCr0O3Cv5iLmM4uxo8jni1fE+jBlKLk0yPqAk4db/l
         aOfx79NbNi9X/Uqc6T8b3Z14nKfHmqo+b5nASRI1+5fKtqR6GZJhE6cTc1sPDE1U4kg+
         9xR+yYGvfPHBTs/l29FgQ9bQUcmW28tj8T6toN3F6YSXexTSD2q+wmhDcG/v3Wavaz9n
         vFIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=i5t54lSD0EKe23RdBf0qkaBUKzv4bqFgdStLMfQWiGI=;
        b=c69Ibg6g3VVgijh7DEjiIZizSh6I4Dp9EHut0TPjaZwlOx8X/2kQICV0dN7qe06US9
         6qApsE8k6nQu/cNHxhCKs+eRBKucYwx1c2Zo+3ZgPIKNRKV5Y7txScwaL07WqfPtG4f+
         52wuRQhmiyzghi7JSdslFsMTSofZELdnR4cr+24yAqz6zyJyLKWdU4/6ta7+04X8Z0kk
         NTYYAChfcJZuq8XB0RKCXlAWWt0WHqdlt6Zc6ZRbBFJaKGML4tuRzpq9M2OBtfyiUbTu
         v6MIL+YCuxIhPqs+tlbxKOHDXoF5LbpLHPESik8M7m1WrHk33Vi7z1ZoJXimAyOjrlKA
         4dJQ==
X-Gm-Message-State: AHPjjUj9iW8+5iorpwmIkvyv06p3yM1dFKaU2fsR0aq00NMYMepi4sKy
        Ft/MtvJFvQ681xWfRtofZWS/aCuyFfn2DdxBYjs=
X-Google-Smtp-Source: AOwi7QBFW1LV+YQqnRYAjSugRng7SBVzHjoEoMSB7yZ2X2XbF3ZvTVF7RITEMfIJA4oXvAvM5RVrgseccvjJ7LDlZXE=
X-Received: by 10.202.229.5 with SMTP id c5mr6339402oih.82.1506269829365; Sun,
 24 Sep 2017 09:17:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.11.88 with HTTP; Sun, 24 Sep 2017 09:16:48 -0700 (PDT)
In-Reply-To: <xmqqlgl7l7ul.fsf@gitster.mtv.corp.google.com>
References: <xmqq8thgy03t.fsf@gitster.mtv.corp.google.com> <CALiud+m1PAD8r0ygoUj3g4LzQjdoPu0CmjiejyG8pHOhr3Fk=Q@mail.gmail.com>
 <xmqqpoajmtu4.fsf@gitster.mtv.corp.google.com> <xmqqlgl7l7ul.fsf@gitster.mtv.corp.google.com>
From:   Sahil Dua <sahildua2305@gmail.com>
Date:   Sun, 24 Sep 2017 18:16:48 +0200
Message-ID: <CALiud+mjN=cTg_CXWNWnE=0N5RiT-FEN5JMGbYW0byMbmexQvQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Sep 2017, #03; Fri, 15)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 22, 2017 at 5:39 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> My understanding of the next step was for those who are interested
>> in moving this topic forward to update these patches in that
>> direction.
>
> Well, I am one of those who are interested in moving this topic
> forward, not because I'm likely to use it, but because the fewer
> number of topics I have to keep in flight, the easier my work gets.
>
> So here is such an update.  As the topic is not in 'next' yet, it
> could also be implemented by replacing patch(es) in the series, but
> doing it as a follow-up fix made it easier to see what got changed
> (both in the code and in the tests), so that is how I decided to do
> this patch.
>
Awesome! Thanks for the patch. It was easier than I'd have expected it
to be. Looks like it fixes the concerns of moving head. Is there
anythign required from my side on this features / series of patches?
> -- >8 --
> Subject: [PATCH] branch: fix "copy" to never touch HEAD
>
> Probably because "git branch -c A B" piggybacked its implementation
> on "git branch -m A B", when creating a new branch B by copying the
> branch A that happens to be the current branch, it also updated HEAD
> to point at the new branch.
>
> This does not match the usual expectation.  If I were sitting on a
> blue chair, and somebody comes and repaints it to red, I would
> accept ending up sitting on a red chair, but if somebody creates a
> new red chair, modelling it after the blue chair I am sitting on, I
> do not expect to be booted off of the blue chair and ending up on
> sitting on the red one.
>
> Let's fix this strange behaviour before it hits 'next'.  Those who
> want to create a new branch and switch to it can do "git checkout B"
> after creating it by copying the current branch, or if that is so
> useful to deserve a short-hand way to do so, perhaps extend "git
> checkout -b B" to copy configurations while creating the new branch
> B.  A "copy" should remain to be "copy", not "copy and sometimes
> checkout".
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/branch.c  |  9 +++------
>  t/t3200-branch.sh | 10 +++++-----
>  2 files changed, 8 insertions(+), 11 deletions(-)
>
> diff --git a/builtin/branch.c b/builtin/branch.c
> index 89f64f4123..e2e3692838 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -506,12 +506,9 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
>                                 oldref.buf + 11);
>         }
>
> -       if (replace_each_worktree_head_symref(oldref.buf, newref.buf, logmsg.buf)) {
> -               if (copy)
> -                       die(_("Branch copied to %s, but HEAD is not updated!"), newname);
> -               else
> -                       die(_("Branch renamed to %s, but HEAD is not updated!"), newname);
> -       }
> +       if (!copy &&
> +           replace_each_worktree_head_symref(oldref.buf, newref.buf, logmsg.buf))
> +               die(_("Branch renamed to %s, but HEAD is not updated!"), newname);
>
>         strbuf_release(&logmsg);
>
> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index 5d03ad16f6..be9b3784c6 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -422,7 +422,7 @@ test_expect_success 'git branch --copy is a synonym for -c' '
>         test_cmp expect actual
>  '
>
> -test_expect_success 'git branch -c ee ef should copy and checkout branch ef' '
> +test_expect_success 'git branch -c ee ef should copy to create branch ef' '
>         git checkout -b ee &&
>         git reflog exists refs/heads/ee &&
>         git config branch.ee.dummy Hello &&
> @@ -431,7 +431,7 @@ test_expect_success 'git branch -c ee ef should copy and checkout branch ef' '
>         git reflog exists refs/heads/ef &&
>         test $(git config branch.ee.dummy) = Hello &&
>         test $(git config branch.ef.dummy) = Hello &&
> -       test $(git rev-parse --abbrev-ref HEAD) = ef
> +       test $(git rev-parse --abbrev-ref HEAD) = ee
>  '
>
>  test_expect_success 'git branch -c f/f g/g should work' '
> @@ -494,12 +494,12 @@ test_expect_success 'git branch -C c1 c2 should succeed when c1 is checked out'
>         git checkout -b c1 &&
>         git branch c2 &&
>         git branch -C c1 c2 &&
> -       test $(git rev-parse --abbrev-ref HEAD) = c2
> +       test $(git rev-parse --abbrev-ref HEAD) = c1
>  '
>
> -test_expect_success 'git branch -C c1 c2 should add entries to .git/logs/HEAD' '
> +test_expect_success 'git branch -C c1 c2 should never touch HEAD' '
>         msg="Branch: copied refs/heads/c1 to refs/heads/c2" &&
> -       grep "$msg$" .git/logs/HEAD
> +       ! grep "$msg$" .git/logs/HEAD
>  '
>
>  test_expect_success 'git branch -C master should work when master is checked out' '
> --
> 2.14.1-907-g5aa63875cf
>
>
>



-- 
Regards
Sahil Dua
Software Developer
Booking.com
Connect on LinkedIn
www.sahildua.com
