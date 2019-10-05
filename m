Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2BD91F4BD
	for <e@80x24.org>; Sat,  5 Oct 2019 10:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbfJEKvo (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Oct 2019 06:51:44 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:45865 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727597AbfJEKvo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Oct 2019 06:51:44 -0400
Received: by mail-vk1-f195.google.com with SMTP id q25so1999242vkn.12
        for <git@vger.kernel.org>; Sat, 05 Oct 2019 03:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0xeLkTfkgWrBOHlSVxRAZoThvlE3Ns5vzSZScfKn54U=;
        b=OIYWbHRxhD56nO7GeEtg41Ac4nCz7kr3nkWlBhA39HzST6Z3vVHR0wLNj0/qAIakeL
         UtycN0+po45w68jNbhOweF0thP/YMhu3aXvKzltidnD0jMZ7rW2VX0gYQOfz15GMjWrU
         T6AZfmawzgKMG9YZMY21Piafhk3PSwErIGSy0O0NBwRfpOr1l5G37Pal565VkrMPlMtr
         FJ7B5BG+RP+jTun1o+C7lbfnYE0jUjgUEQvh6zGxvJzPmUdhQOerGQAMLCy5C09EHRP0
         uIdxqrVWFwuLI2MGatbAKr6LGqTzxLApAoe+MQS1RG1Axzf78xMijO2ymk4DeKJELwh8
         K0xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0xeLkTfkgWrBOHlSVxRAZoThvlE3Ns5vzSZScfKn54U=;
        b=ueX0VYY3rRi3LviTpZj/Gw4Zo9lwGuZ6thM67ZZLvIKikzAUb20h5DfS04BrxxGoHr
         NaXfdKYkY4/Tz6y/sLgcDB0XQ7A6UTf9c0SX2q6lr+jSp9LbcngjssiZYkv4XCumH7vZ
         QWcyEwHrmJPUwzPJeSp4ygNK6eWKynTX+VPck1w6KLEbwQqu+xe99E7InSw47q0Fyvt2
         ybTWIKtqhT0S2a59N0WoaA4w4PHdGFmtL4NmPJ8rnqDND6MTTq5LMnb7vXUhfU0W/MWY
         +Sv9IV0Z18Q/CdffEqJ/is4f9LYg7NYzWwxQJ38cGR8SddUKDwA2Ulz/T3LKkI1mrDsu
         Qfyw==
X-Gm-Message-State: APjAAAUA19al0rquRBGuPzhWbh81yqfquiMTPspLtAXynOtd0MjNOe9X
        fOK4wS8FC05KPRwxOcNsANPGTOaHIYBtlTW1yS4=
X-Google-Smtp-Source: APXvYqzxD1mbA+1MZB3E/U4edgvTs3Dn0R+F25OcIJdlF4GrJGQv+KxFPT96TfuGI6KyKWIY27Kt+5H5c9Z68KWRPHs=
X-Received: by 2002:a1f:2987:: with SMTP id p129mr785182vkp.23.1570272702448;
 Sat, 05 Oct 2019 03:51:42 -0700 (PDT)
MIME-Version: 1.0
References: <20191004221052.23313-1-me@yadavpratyush.com>
In-Reply-To: <20191004221052.23313-1-me@yadavpratyush.com>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Sat, 5 Oct 2019 12:51:31 +0200
Message-ID: <CAKPyHN0ERLroxwPebVrXJNa3pMA3Uxv-vHbvKAhSB52xRcS=oA@mail.gmail.com>
Subject: Re: [PATCH] git-gui: add a readme
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 5, 2019 at 12:10 AM Pratyush Yadav <me@yadavpratyush.com> wrote:
>
> It is a good idea to have a readme so people finding the project can
> know more about it, and know how they can get involved.
>
> Signed-off-by: Pratyush Yadav <me@yadavpratyush.com>
> ---
>
> I don't have much experience writing this kind of readme or
> documentation, so comments are appreciated. Please feel free to chime in
> with suggestions and things that can also be added.
>
>  README.md | 128 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 128 insertions(+)
>  create mode 100644 README.md
>
> diff --git a/README.md b/README.md
> new file mode 100644
> index 0000000..d76122d
> --- /dev/null
> +++ b/README.md
> @@ -0,0 +1,128 @@
> +# Git Gui - A graphical user interface for Git
> +
> +Git Gui is a GUI for [git](https://git-scm.com/) written in Tcl/Tk. It allows
> +you to use the git source control management tools via a GUI. This includes
> +staging, commiting, adding, pushing, etc. It can also be used as a blame
> +viewer, a tree browser, and a citool (make exactly one commit before exiting
> +and returning to shell). More details about git-gui can be found in its manual
> +page by either running `man git-gui`, or by visiting the [online manual
> +page](https://git-scm.com/docs/git-gui).
> +
> +Git Gui was initially written by Shawn O. Pearce, and is distributed with the
> +standard git installation.
> +
> +# Building and installing
> +
> +Most of Git Gui is written in Tcl, so there is not much compilation involved.
> +Still, some things do need to be done, so you do need to "build" it.
> +
> +You can build Git Gui using:
> +
> +```
> +make
> +```
> +
> +And then install it using:
> +
> +```
> +make install
> +```
> +
> +You probably need to have root/admin permissions to install.
> +
> +# Contributing
> +
> +The project is currently maintained by Pratyush Yadav over at
> +https://github.com/prati0100/git-gui. Even though the project is hosted at
> +GitHub, the development does not happen over GitHub Issues and Pull Requests.
> +Instead, an email based workflow is used. The git mailing list
> +[git@vger.kernel.org](mailto:git@vger.kernel.org) is where the patches are
> +discussed and reviewed.
> +
> +More information about the git mailing list and instructions to subscribe can
> +be found [here](https://git.wiki.kernel.org/index.php/GitCommunity).
> +
> +## Sending your changes
> +
> +Since the development happens over email, you need to send in your commits in
> +text format. Commits can be converted to emails via the two tools provided by
> +git: `git-send-email` and `git-format-patch`.
> +
> +If you are sending multiple patches, it is recommended to include a cover
> +letter. A cover letter is an email explaining in brief what the series is
> +supposed to do. A cover letter template can be generated by passing
> +`--cover-letter` to `git-format-patch`.
> +
> +After you send your patches, you might get a review suggesting some changes.
> +Make those changes, and re-send your patch(es) in reply to the first patch of
> +your initial version. Also please mention the version of the patch. This can be
> +done by passing `-v X` to `git-format-patch`, where 'X' is the version number
> +of the patch(es).
> +
> +### Using git-send-email
> +
> +You can use `git-send-email` to send patches via email. A pretty good guide to
> +configuring and using `git-send-email` can be found
> +[here](https://www.freedesktop.org/wiki/Software/PulseAudio/HowToUseGitSendEmail/)
> +
> +### Using your email client
> +
> +If your email client supports sending mbox format emails, you can use
> +`git-format-patch` to get an mbox file for each commit, and then send them. If
> +there is more than one patch in the series, then all patches after the first
> +patch (or the cover letter) need to be sent as replies to the first.
> +`git-send-email` does this by default.
> +

Junio mentioned (at least?) once [1], that using only git-send-email
is not a good workflow. Instead one should use git-format-patch to
generate the patches, audit them. and then use git-send-email. I
second this.

Please switch these two sections to encompass this.

Thanks.

Bert

[1] https://public-inbox.org/git/xmqqh9n241el.fsf@gitster.mtv.corp.google.com/

> +### Using GitGitGadget
> +
> +Since some people prefer a GitHub pull request based workflow, they can use
> +[GitGitGadget](https://gitgitgadget.github.io/) to send in patches. The tool
> +was originally written for sending patches to the Git project, but it now also
> +supports sending patches for git-gui.
> +
> +Instructions for using GitGitGadget to send git-gui patches, courtesy of
> +Johannes Schindelin:
> +
> +If you don't already have a fork of the [git/git](https://github.com/git/git)
> +repo, you need to make one. Then clone your fork:
> +
> +```
> +git clone https://github.com/<your-username>/git
> +```
> +
> +Then add GitGitGadget as a remote:
> +
> +```
> +git remote add gitgitgadget https://github.com/gitgitgadget/git
> +```
> +
> +Then fetch the git-gui branch:
> +
> +```
> +git fetch gitgitgadget git-gui/master
> +```
> +
> +Then create a new branch based on git-gui/master:
> +
> +```
> +git checkout -b <your-branch-name> git-gui/master
> +```
> +
> +Make whatever commits you need to, push them to your fork, and then head over
> +to https://github.com/gitgitgadget/git/pulls and open a Pull Request targeting
> +git-gui/master.
> +
> +GitGitGadget will welcome you with a (hopefully) helpful message.
> +
> +## Signing off
> +
> +You need to sign off your commits before sending them to the list. You can do
> +that by passing the `-s` option to `git-commit`. You can also use the "Sign
> +Off" option in Git Gui.
> +
> +A sign-off is a simple 'Signed-off-by: A U Thor \<author@example.com\>' line at
> +the end of the commit message, after your explanation of the commit.
> +
> +A sign-off means that you are legally allowed to send the code, and it serves
> +as a certificate of origin. More information can be found at
> +[developercertificate.org](https://developercertificate.org/).
> --
> 2.21.0
>
