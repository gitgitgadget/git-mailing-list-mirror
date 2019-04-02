Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D337B20248
	for <e@80x24.org>; Tue,  2 Apr 2019 20:53:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbfDBUxA (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Apr 2019 16:53:00 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34662 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfDBUxA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Apr 2019 16:53:00 -0400
Received: by mail-qk1-f196.google.com with SMTP id n68so8836431qka.1
        for <git@vger.kernel.org>; Tue, 02 Apr 2019 13:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RNNBzNA8696sEMRb75wt3w1t8KSDr5EOoSjrD32qx9w=;
        b=LbdX+jSRDTAJTac902npIHfZLt7hrejqRzpeqG1UIObOFWj1ZrJlMFh7XsJm77TULc
         +J+F+gJSLviFMh3CNbcuxt3/VwddAGbpviXSWtksM+Er948tzKo3rcFE3G/AVkHXM9WF
         QyTvCA+iitPgmBvqxqu/V6i6Q5r3Y4JEn9cUH1R25u0qo02dFfaQZvAUZ0UGJddXLL5k
         mKhtmudrMgg8XTh4dq+15nPT3LLY1HkMD5RtJllNdVU7iIkTCNBUr18peJb9SoNMLVIQ
         3GIAAiBMJk0BONgXt5aELF0luImxzf2sf3f397fvAKfMBD8IdTCRYnY2b9uuXJfUXwJh
         Z5TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RNNBzNA8696sEMRb75wt3w1t8KSDr5EOoSjrD32qx9w=;
        b=Np6UMI4/X5YUZTN8aE5YbDx3vS3cy91R3VB8AwT6gqCaAybB5SyQ+RYSKoiCnzgspj
         XbkJ6Hl68Or9CWxAcqc2vz31MVsydCiRQe1HLMDwXntZNcEoBPnqktH/V2X6aqoIlndN
         gDV/4COr057su7ShiOY4cxW2AV40LOPEMqfmSYPjqHSzYZ7/cdon95mawLO0chvKtfQQ
         X4injPaMzwxlYUgG2niSox3i4rESXoOStBDGkEruzPPi3PaXkqSnx2/pLzEZdiaBYcK3
         govbOeqbPhoMbYbkxW5w0BoBkLsgq//tMw54K6stFJS0A0DvV1YYDf+c8lMPIYGU2NN6
         eEGQ==
X-Gm-Message-State: APjAAAX2E7AbHueGmkEQps3FbBNkNyZwoYqE2VxdE42uos66cabBGkYX
        2fRjaY7iYfl6Y9ZKz8Y+3gY0lnxEViLbmocG8QbvEiDg
X-Google-Smtp-Source: APXvYqw3buQY7K0oMRfxN8BNUAnilN1aHxtao9lS1sR3cu/fSbqovR6mZFsQNGhc6rhYcRqKBZzX3W4Caax9LDszTF8=
X-Received: by 2002:ae9:df41:: with SMTP id t62mr54551387qkf.150.1554238379374;
 Tue, 02 Apr 2019 13:52:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190402014115.22478-1-khalludi123@gmail.com> <xmqqk1gdt9ke.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqk1gdt9ke.fsf@gitster-ct.c.googlers.com>
From:   Khalid Ali <khalludi123@gmail.com>
Date:   Tue, 2 Apr 2019 16:52:46 -0400
Message-ID: <CAD8q83TFHyTeVMUTfv8nJryGtBDKrz7xNbDirK3gyzYUihwzXA@mail.gmail.com>
Subject: Re: [GSoC][PATCH v1] t9811: avoid pipe in git commands in test script
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the feedback Junio.

I was wondering if I should resubmit the patch without my comments.
Also, I was wondering if I should be adding a call to check the exit codes
of this test and the file called 'actual' at the end of the script.

On Mon, Apr 1, 2019 at 10:39 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Khalid Ali <khalludi123@gmail.com> writes:
>
> > The exit code of the upstream in a pipe is ignored thus we
> > should avoid using it. By writing out the output of the git command to a
> > file, we can test the exit codes of both the commands.
>
> End the log message here by moving the next two paragraphs below the
> three-dash line.
>
> >
> > Aside from the commit message, I plan to apply for GSoC. Planning to
> > solve the rebase/cherry-pick issue or adding functionality for the
> > rebase interactive command.
> >
> > Any review on this commit would be appreciated!
> >
> > Signed-off-by: Khalid Ali <khalludi123@gmail.com>
> > ---
> >  t/t9811-git-p4-label-import.sh | 11 ++++++-----
> >  1 file changed, 6 insertions(+), 5 deletions(-)
> >
> > diff --git a/t/t9811-git-p4-label-import.sh b/t/t9811-git-p4-label-import.sh
> > index 602b0a5d5c..2f4e80ed55 100755
> > --- a/t/t9811-git-p4-label-import.sh
> > +++ b/t/t9811-git-p4-label-import.sh
> > @@ -63,7 +63,8 @@ test_expect_success 'basic p4 labels' '
> >               git checkout TAG_WITH\$_SHELL_CHAR &&
> >               test -f f1 && test -f f2 && test -f file_with_\$metachar &&
> >
> > -             git show TAG_LONG_LABEL | grep -q "A Label second line"
> > +             git show TAG_LONG_LABEL >actual &&
> > +             grep -q "A Label second line" actual
>
> There is no mention of file 'actual' before this patch, so we can
> reasonably be sure that we are not breaking expectations of existing
> test that a file with that name has contents different from what the
> above command produces.  On the other hand, if later tests have
> things like "git add ." or "git status -s" and expects that there is
> no such file called 'actual', this change may have broken the
> expectation.
>
> I *think* the above is done after going inside $git directory, which
> will be removed with "test_when_finished cleanup_git", so it is
> fairly clear that leaving an extra file 'actual' behind at this
> point is safe.
>
> This is not a problem with this conversion, but we tend to avoid
> squelching standard output to help debugging tests.  An independent
> clean-up patch may want to replace "grep -q" with just "grep".
>
> > @@ -92,9 +93,9 @@ test_expect_success 'two labels on the same changelist' '
> >               cd "$git" &&
> >               git p4 sync --import-labels &&
> >
> > -             git tag | grep TAG_F1 &&
> > -             git tag | grep -q TAG_F1_1 &&
> > -             git tag | grep -q TAG_F1_2 &&
> > +             git tag >actual && grep TAG_F1 actual &&
> > +             git tag >actual && grep -q TAG_F1_1 actual &&
> > +             git tag >actual && grep -q TAG_F1_2 actual &&
>
> Ditto.
>
> >
> >               cd main &&
> >
> > @@ -205,7 +206,7 @@ test_expect_success 'use git config to enable import/export of tags' '
> >               git p4 rebase --verbose &&
> >               git p4 submit --verbose &&
> >               git tag &&
> > -             git tag | grep TAG_F1_1
> > +             git tag >actual && grep TAG_F1_1 actual
> >       ) &&
>
> I notice that this test piece does not call cleanup_git when it is
> done.  I think that is a mistake (not introduced by this patch) that
> ma want to get fixed independently.
>
> >       (
> >               cd "$cli" &&
