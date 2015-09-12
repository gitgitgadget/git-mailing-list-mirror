From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH] pull: don't mark values for option "rebase" for translation
Date: Sat, 12 Sep 2015 22:59:41 +0800
Message-ID: <CANYiYbGJCMBArD_DcCbDRqveUx99fvrstc4SXZXbF3dOC84mvQ@mail.gmail.com>
References: <1441986797-21734-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Paul Tan <pyokagan@gmail.com>
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 12 16:59:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZamHM-0000II-Sd
	for gcvg-git-2@plane.gmane.org; Sat, 12 Sep 2015 16:59:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754710AbbILO7o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2015 10:59:44 -0400
Received: from mail-wi0-f179.google.com ([209.85.212.179]:34357 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754652AbbILO7n (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2015 10:59:43 -0400
Received: by wicfx3 with SMTP id fx3so93122059wic.1
        for <git@vger.kernel.org>; Sat, 12 Sep 2015 07:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ch08rghrW9bAyMcwx60cX3cuWPXeb7tDKPxGX6zCEs4=;
        b=SaqEPZdg6n7k03EIlfdjp+o03SzEjBEINJafzkJIKeCRDxmWxCEA05YwQqoH0tspyH
         xaPxKE9vYedTfV8MVwsLVuD1cnXMrZgKsEBe9rG6dhOEm5knpEpn+NTJZkd9Ha+fc5kP
         Gu1GhVQpTMV6OReiNGwUmVUSm5N0++mBtYFV/04aip0ufwasJ552T2j0g071ikFnbgBw
         b82PYjZwXLrY0sjfoeJ9OBrcZm3pPW5yYoUp/gCiRDsNBeyxoinWgvLz6t47of2bky7O
         ipcANO/9bgg43NL+Mb5fiuspfQLpGGcCXl4UcIXs3WZOMYvHzJlPJ3Dwh16kKTTMQcuV
         nFKw==
X-Received: by 10.195.13.5 with SMTP id eu5mr8466381wjd.135.1442069982058;
 Sat, 12 Sep 2015 07:59:42 -0700 (PDT)
Received: by 10.194.76.230 with HTTP; Sat, 12 Sep 2015 07:59:41 -0700 (PDT)
In-Reply-To: <1441986797-21734-1-git-send-email-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277728>

2015-09-11 23:53 GMT+08:00 Ralf Thielow <ralf.thielow@gmail.com>:
> "false|true|preserve" are actual values for option "rebase"
> of the "git-pull" command and should therefore not be marked
> for translation.

Agree, I see those who have already finished this round of l10n
(including vi, fr, and zh_CN) not translate it and leave as it is.

> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
> ---
>  builtin/pull.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/pull.c b/builtin/pull.c
> index 7e3c11e..a39bb0a 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -112,7 +112,7 @@ static struct option pull_options[] = {
>         /* Options passed to git-merge or git-rebase */
>         OPT_GROUP(N_("Options related to merging")),
>         { OPTION_CALLBACK, 'r', "rebase", &opt_rebase,
> -         N_("false|true|preserve"),
> +         "false|true|preserve",
>           N_("incorporate changes by rebasing rather than merging"),
>           PARSE_OPT_OPTARG, parse_opt_rebase },
>         OPT_PASSTHRU('n', NULL, &opt_diffstat, NULL,
> --
> 2.6.0.rc1.199.g678474c
>


--
Jiang Xin
