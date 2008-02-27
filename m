From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Re: [PATCH] Prompt to continue when editing during rebase --interactive
Date: Wed, 27 Feb 2008 14:22:33 +0100
Message-ID: <4d8e3fd30802270522v21da6c6cx73988361de4aae5@mail.gmail.com>
References: <57518fd10802270450r27e7339cs7612eab733d4e94e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Jonathan del Strother" <maillist@steelskies.com>
X-From: git-owner@vger.kernel.org Wed Feb 27 14:23:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUMFb-00030Z-9c
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 14:23:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750937AbYB0NWe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 08:22:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbYB0NWe
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 08:22:34 -0500
Received: from wf-out-1314.google.com ([209.85.200.174]:27089 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750790AbYB0NWd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 08:22:33 -0500
Received: by wf-out-1314.google.com with SMTP id 28so2156437wff.4
        for <git@vger.kernel.org>; Wed, 27 Feb 2008 05:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=KhdoW4aesE8MIfig6h1UzfOhLAiahfKADC/MhHZJ0WI=;
        b=vwfcPbCH1sYEVpWssJsxUlU05M3cF9MrkKXS4YGT1aV9OeMnkQ7FPQzwxL4Pu+/Nk1xNyKoXxqww7PvdLXdwU6UN9/onvGM1A8la/6UUTO2VhSGHUimw5KnKH1YBWkNqtnBeUnpqEqKPJXbmcL9JnayLqWPWfLM3jBgwzZPkJcA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GXkGoswY7V2ulMmsHplZV+RLv/G7dPwxeI0tXNvD1gaW5P1MLwbgXCQAt0n2r9+mhCTRvudfj0C4r5x3vQWAsfBAr1Uj3xSaVXbGh1V16G/bhHOBmba9aJ1280g9DvIf+dNZowY/CiEY3nm2vS3P+dY4cEPedCbx+dHG8a+nNQw=
Received: by 10.143.8.10 with SMTP id l10mr5196737wfi.181.1204118553432;
        Wed, 27 Feb 2008 05:22:33 -0800 (PST)
Received: by 10.143.196.10 with HTTP; Wed, 27 Feb 2008 05:22:33 -0800 (PST)
In-Reply-To: <57518fd10802270450r27e7339cs7612eab733d4e94e@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75229>

On Wed, Feb 27, 2008 at 1:50 PM, Jonathan del Strother
<maillist@steelskies.com> wrote:
> On hitting an edit point in an interactive rebase, git should prompt
>  the user to run "git rebase --continue"

Very nice, I hit the same UI defect a few days ago but I didn't have time
to try to fix it.

>  Signed-off-by: Jonathan del Strother <jon.delStrother@bestbefore.tv>

FWIW,
Acked-by: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>

>
>   git-rebase--interactive.sh |    4 ++++
>   1 files changed, 4 insertions(+), 0 deletions(-)
>
>  diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
>  index fb12b03..c2bedd6 100755
>  --- a/git-rebase--interactive.sh
>  +++ b/git-rebase--interactive.sh
>  @@ -268,6 +268,10 @@ do_next () {
>                 warn
>                 warn "  git commit --amend"
>                 warn
>  +               warn "Once you are satisfied with your changes, run"
>  +               warn
>  +               warn "  git rebase --continue"
>  +               warn
>                 exit 0
>                 ;;
>         squash|s)
>  --
>  1.5.4.1.97.g40aab
>  -
>  To unsubscribe from this list: send the line "unsubscribe git" in
>  the body of a message to majordomo@vger.kernel.org
>  More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Paolo
http://paolo.ciarrocchi.googlepages.com/
