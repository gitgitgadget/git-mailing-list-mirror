From: Chris Packham <judge.packham@gmail.com>
Subject: Re: [PATCH] git-submodule: remove extraneous space from error message
Date: Thu, 27 Aug 2015 21:17:00 +1200
Message-ID: <CAFOYHZBG6uBoYE=JUHhBFO=bMNmX5GJowCr4Mg6x68GAdWykQw@mail.gmail.com>
References: <1440649579-3513-1-git-send-email-alexhenrie24@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Alex Henrie <alexhenrie24@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 27 11:17:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUtIz-0000wg-K4
	for gcvg-git-2@plane.gmane.org; Thu, 27 Aug 2015 11:17:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753760AbbH0JRD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2015 05:17:03 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:37370 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751363AbbH0JRB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2015 05:17:01 -0400
Received: by igui7 with SMTP id i7so31689353igu.0
        for <git@vger.kernel.org>; Thu, 27 Aug 2015 02:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=KGFCSypxj9hmXqdr7R+wnpUXpiq6Eskf6XX89k7aN68=;
        b=RshUKA6wilAVnS+FOSsaecxfGMlxi9V/PAG2MV0VWxtAxDrnLVFQ/IoVZmE+qHYoxT
         aYsqIJbGR2Iz7f9w3/r4BmDk7aX47cXtSgjYNl3cfC9K14mlN3PSE7MOHpoZuZudgGAv
         GCViLJvfKS74nX404E/V3RK9C8dM37IdxT4lFwiKBHKIinHpThfPdVxY7XzBIlD+TmYz
         AQrFe0TS83RwVPqDYKI4oh1gAtr4IfqAS4FHvmXmSpMn6yN0i1JeZch72cQ11B9m9vrs
         h+p0cQl4sMMUQL2lV3PU6QV8c88I/RI9fh3cB3iH+aacoS+yPOZFm9IQagsqRroCaEKo
         ISqQ==
X-Received: by 10.50.117.37 with SMTP id kb5mr1066925igb.24.1440667020858;
 Thu, 27 Aug 2015 02:17:00 -0700 (PDT)
Received: by 10.79.34.138 with HTTP; Thu, 27 Aug 2015 02:17:00 -0700 (PDT)
In-Reply-To: <1440649579-3513-1-git-send-email-alexhenrie24@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276665>

On Thu, Aug 27, 2015 at 4:26 PM, Alex Henrie <alexhenrie24@gmail.com> wrote:
> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
>  git-submodule.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 36797c3..25b1ddf 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -904,7 +904,7 @@ Maybe you want to use 'update --init'?")"
>                                 ;;
>                         !*)
>                                 command="${update_module#!}"
> -                               die_msg="$(eval_gettext "Execution of '\$command \$sha1' failed in submodule  path '\$prefix\$sm_path'")"
> +                               die_msg="$(eval_gettext "Execution of '\$command \$sha1' failed in submodule path '\$prefix\$sm_path'")"
>                                 say_msg="$(eval_gettext "Submodule path '\$prefix\$sm_path': '\$command \$sha1'")"
>                                 must_die_on_failure=yes
>                                 ;;
> --
> 2.5.0
>

Looks good to me. Thanks

Reviewed-by: Chris Packham <judge.packham@gmail.com>
