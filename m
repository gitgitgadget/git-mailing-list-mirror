From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] t/t7502-commit.sh : remove a repeated test
Date: Thu, 10 Mar 2016 18:21:44 -0500
Message-ID: <CAPig+cQbT3R_t=OfaueYZe2YQEdDbZWtyUFf-k=2_5S6vJuyMw@mail.gmail.com>
References: <0102015362ba5bb6-8212f758-f2fa-4272-8337-1cc669e7e8f4-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 11 00:21:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ae9tu-0002MN-6z
	for gcvg-git-2@plane.gmane.org; Fri, 11 Mar 2016 00:21:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932805AbcCJXVq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2016 18:21:46 -0500
Received: from mail-vk0-f51.google.com ([209.85.213.51]:35863 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753838AbcCJXVp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2016 18:21:45 -0500
Received: by mail-vk0-f51.google.com with SMTP id c3so114995894vkb.3
        for <git@vger.kernel.org>; Thu, 10 Mar 2016 15:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=qWNN8gxbppnywVyuReurOa1lwFan3Gzc9iN09187rMk=;
        b=pfc7cIJ52VlBNznlfxfZkifXMJbVzvdmwSqRD2LFr7JVuCBS8Rfz/18pJRlqPoav9L
         p1G9zAf49c+QUHQNV4n0DjtjohJRdIox0C9gL6Zhu1JX14UFkYmlanYx5hxe1MjCNnmq
         B1BocmKbMrz3WeYcs4zywmANXqB/sh3lGMKt60XdhntcN9Xgfc5FGgtUDhRBk+zGsbuu
         /Zi6pA/V0iTaYZrYJnPW5iNvUEBRLMI/sGPOfhzoEapJCF7cPY6aOIPZGOCYYatFdut3
         KGo5N6mDf6w/EWNAYB8NP9YSras57vdiEiL+hD1eMCAQMDVtA6/P+V9Andg4Up+q99SQ
         9tjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=qWNN8gxbppnywVyuReurOa1lwFan3Gzc9iN09187rMk=;
        b=WuKH5auJTkDfQcSCxUNAye5d4nO9LQHaBMzQJ9QS9Q8MOVh0b27yv958B784ebDGmd
         8WUVHBCuxRu09cWdHlByysxh2hiUZXHPsvFD2O05MFW3cXHgtmD/FN4CydSM7hEyLr+1
         IfwE7vI2pgO+HpwxROKWUVsFPOPpU81DnFZS1yOKF/bAS/Dv34wjUa3/VbHtOucArdaG
         whHVE6SKF6BPVxGySH8oIyJpDoB5kEc4uToqKbAmL5QJIBPVZLmPGMD//gqlJ5OOgefb
         mYHuaojSPLbSXiQHfHewuxROkLzSWK4F5wXJAk2Y0M4NWgJ3LtMNlZ63phiipWH7IeDJ
         zEtQ==
X-Gm-Message-State: AD7BkJIvnmK6BnAqD2/GOb3NLB111gakqMvcC9TNgmS8m4m5QfF1IaWI+kbWzhR1QXL9mhDTOFX6/jIlOhAu2w==
X-Received: by 10.31.8.142 with SMTP id 136mr6647059vki.14.1457652104607; Thu,
 10 Mar 2016 15:21:44 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Thu, 10 Mar 2016 15:21:44 -0800 (PST)
In-Reply-To: <0102015362ba5bb6-8212f758-f2fa-4272-8337-1cc669e7e8f4-000000@eu-west-1.amazonses.com>
X-Google-Sender-Auth: U6XcJ328EAKvELB2DyWHM27foBk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288663>

On Thu, Mar 10, 2016 at 5:51 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> t/t7502-commit.sh : remove a repeated test

Or:

    t7502: drop duplicate test

> This extra test was introducted in the commit f9c01817

We normally add some parenthetical context when mentioning commits:

    This extra test was introduced erroneously by
    f9c0181 (t7502: test commit.status, --status and
    --no-status, 2010-01-13)

The patch itself makes sense. Thanks.

> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> ---
>  t/t7502-commit.sh | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
> index b39e313..725687d 100755
> --- a/t/t7502-commit.sh
> +++ b/t/t7502-commit.sh
> @@ -527,11 +527,6 @@ try_commit_status_combo () {
>                 test_i18ngrep "^# Changes to be committed:" .git/COMMIT_EDITMSG
>         '
>
> -       test_expect_success 'commit' '
> -               try_commit "" &&
> -               test_i18ngrep "^# Changes to be committed:" .git/COMMIT_EDITMSG
> -       '
> -
>         test_expect_success 'commit --status' '
>                 try_commit --status &&
>                 test_i18ngrep "^# Changes to be committed:" .git/COMMIT_EDITMSG
>
> --
