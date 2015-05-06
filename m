From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH] branch: -r -d(D) should say "remote-tracking branch"
Date: Wed, 6 May 2015 19:49:19 +0200
Message-ID: <CAN0XMOJ8QJ14B15BoFrr7d7L-jE06yUbquo8pW3OCj4wmUk2Rw@mail.gmail.com>
References: <CAMbsUu5pKiQ76WrCXvziQ8zER-Mc5oVt7tGnC7Q3RMVX2r8ZXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Danny Lin <danny0838@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 06 19:49:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yq3Rv-0006sm-Uj
	for gcvg-git-2@plane.gmane.org; Wed, 06 May 2015 19:49:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752342AbbEFRta (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2015 13:49:30 -0400
Received: from mail-wi0-f174.google.com ([209.85.212.174]:36467 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752130AbbEFRtU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2015 13:49:20 -0400
Received: by wizk4 with SMTP id k4so212052369wiz.1
        for <git@vger.kernel.org>; Wed, 06 May 2015 10:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=LEXlFXG+g6vU2wwAyGD6xI79r0CT6eXinuxqcuuknM0=;
        b=VpjFtyCvULjtbao0qoNhowU8QWFXgi3kaZt5yBJ3mXoCaTMluHgcWCmyfTEK+2tR5r
         aTGYml6insZJHTdvu31vRnWcA2UxUi9Rnno7uaOx6MYYwrIKfv+7E3TFvC/FtomLaYu1
         K4HXjNSNak5IPtWUysFZopktDYHEIqNV/qjrgYdkao0xUbZePFDvDqlYnBlrlLuD8LbT
         zouSLgKviyIJcZfNj6T4NlCUADjkMwCRlF7cz2L8sAgZlcVTvUDk6i5efsZHF8BxQjsh
         8ytzZmK4AgnmEAwSiKHm02uPCxKlMvQh7euKY82eWteJAhPpss5K4arG2uyXaa9eHwGq
         h5mQ==
X-Received: by 10.180.90.236 with SMTP id bz12mr15867195wib.33.1430934559231;
 Wed, 06 May 2015 10:49:19 -0700 (PDT)
Received: by 10.194.72.6 with HTTP; Wed, 6 May 2015 10:49:19 -0700 (PDT)
In-Reply-To: <CAMbsUu5pKiQ76WrCXvziQ8zER-Mc5oVt7tGnC7Q3RMVX2r8ZXQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268475>

Danny Lin <danny0838@gmail.com> wrote:
> git branch -r -d(D) currently says "delete remote branch",
> which should be "remote-tracking branch".
> ---

No "Signed-off-by" line. (see Documentation/SubmittingPatches)

>  builtin/branch.c | 6 +++---
>  po/bg.po         | 6 +++---
>  po/ca.po         | 6 +++---
>  po/de.po         | 6 +++---
>  po/fr.po         | 6 +++---
>  po/git.pot       | 6 +++---
>  po/it.po         | 6 +++---
>  po/pt_PT.po      | 6 +++---
>  po/sv.po         | 6 +++---
>  po/vi.po         | 6 +++---
>  po/zh_CN.po      | 6 +++---
>  11 files changed, 33 insertions(+), 33 deletions(-)
>

You don't need to update messages within "po/*" as they're
updated by the l10n coordinator and translators.

> diff --git a/builtin/branch.c b/builtin/branch.c
> index dc6f0b2..3560c51 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -242,7 +242,7 @@ static int delete_branches(int argc, const char
> **argv, int force, int kinds,
>                          sha1, &flags);
>          if (!target) {
>              error(remote_branch
> -                  ? _("remote branch '%s' not found.")
> +                  ? _("remote-tracking branch '%s' not found.")
>                    : _("branch '%s' not found."), bname.buf);
>              ret = 1;
>              continue;
> @@ -257,7 +257,7 @@ static int delete_branches(int argc, const char
> **argv, int force, int kinds,
>
>          if (delete_ref(name, sha1, REF_NODEREF)) {
>              error(remote_branch
> -                  ? _("Error deleting remote branch '%s'")
> +                  ? _("Error deleting remote-tracking branch '%s'")
>                    : _("Error deleting branch '%s'"),
>                    bname.buf);
>              ret = 1;
> @@ -265,7 +265,7 @@ static int delete_branches(int argc, const char
> **argv, int force, int kinds,
>          }
>          if (!quiet) {
>              printf(remote_branch
> -                   ? _("Deleted remote branch %s (was %s).\n")
> +                   ? _("Deleted remote-tracking branch %s (was %s).\n")
>                     : _("Deleted branch %s (was %s).\n"),
>                     bname.buf,
>                     (flags & REF_ISBROKEN) ? "broken"

Looks good to me.
