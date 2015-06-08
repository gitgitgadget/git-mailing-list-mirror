From: Christian Couder <christian.couder@gmail.com>
Subject: Re: PATCH [git/contrib] Avoid failing to create ${__git_tcsh_completion_script}
 when 'set noclobber' is in effect (af7333c)
Date: Mon, 8 Jun 2015 21:31:23 +0200
Message-ID: <CAP8UFD0mmHAbXtcJZNhnhGtTv82zQV3j+OcSSa_xeLrEJzCqyA@mail.gmail.com>
References: <arielf/git/commit/af7333c176401601d67ea67cb961332ee4ef3574@github.com>
	<arielf/git/commit/af7333c176401601d67ea67cb961332ee4ef3574/11557888@github.com>
	<20150607195451.GA23551@yendor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: github.2009@yendor.com
X-From: git-owner@vger.kernel.org Mon Jun 08 21:31:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z22lt-0003z6-Bf
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 21:31:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753268AbbFHTbb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 15:31:31 -0400
Received: from mail-wg0-f45.google.com ([74.125.82.45]:33184 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753059AbbFHTbZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 15:31:25 -0400
Received: by wgez8 with SMTP id z8so111104364wge.0
        for <git@vger.kernel.org>; Mon, 08 Jun 2015 12:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=J0F01MW8XWloGfHgBV+6NJYNFQnjRX8RZg5Q9n8Y79Q=;
        b=WvMawTsujkRH7NXIPKPm02Q+K8my39WLNktnSgvtAX4ZhHZz+1B5MoVtI9WOiixuiw
         7x8hDFHC2fH3RNzt9/y9A+WgIKEvYcFF99sd1GZj8YRaZbp9Gx763CvmqsZL0GRU94dY
         Gg2YFXeMWFlFT7rxZLoUfsRBHTeCh/8NISJiqQWGRxM/fY6VXHjDbCgRGhdPJ+BGoNvr
         W9AYXH6QnPhIWYThnc5xd1ejgBv/etc4BXp/1WsaOuUDJ9SKVWQ44KXq13LUi0lZV4YN
         PT8NAEa56NyJ8mxZ4rgKya2Qv7gEsAV5TgXvjrZ/4imaQg2+bFbAvzX4Mi4kxaseHtB9
         sWyA==
X-Received: by 10.180.88.99 with SMTP id bf3mr1208494wib.75.1433791883724;
 Mon, 08 Jun 2015 12:31:23 -0700 (PDT)
Received: by 10.194.40.8 with HTTP; Mon, 8 Jun 2015 12:31:23 -0700 (PDT)
In-Reply-To: <20150607195451.GA23551@yendor.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271115>

Please use a subject that is shorter and looks more like others on this list.

On Sun, Jun 7, 2015 at 9:54 PM, Ariel Faigon <github.2009@yendor.com> wrote:
>
> Junio,
>
> This is my 1st time doing this, sorry.
> I hope this satisfies the git Sign Off procedure.

The above lines should not be there, otherwise they will be in the
commit message and will not be useful there.

> Problem Description:

Please loose the above header.

> tcsh users who happen to have 'set noclobber' elsewhere in their ~/.tcshrc or ~/.cshrc startup files get a 'File exist' error,

When do they get that error?

> and the tcsh completion file doesn't get generated/updated.  Adding a `!` in the redirect works correctly for both clobber and noclobber users.
>
> Developer's Certificate of Origin 1.1
>
>         By making a contribution to this project, I certify that:
>
>         (a) The contribution was created in whole or in part by me and I
>             have the right to submit it under the open source license
>             indicated in the file; or
>
>         (b) The contribution is based upon previous work that, to the best
>             of my knowledge, is covered under an appropriate open source
>             license and I have the right under that license to submit that
>             work with modifications, whether created in whole or in part
>             by me, under the same open source license (unless I am
>             permitted to submit under a different license), as indicated
>             in the file; or
>
>         (c) The contribution was provided directly to me by some other
>             person who certified (a), (b) or (c) and I have not modified
>             it.
>
>         (d) I understand and agree that this project and the contribution
>             are public and that a record of the contribution (including all
>             personal information I submit with it, including my sign-off) is
>             maintained indefinitely and may be redistributed consistent with
>             this project or the open source license(s) involved.

You don't need to copy the Developer's Certificate of Origin in your
patch even if it's the first time. Your signed-off-by below is enough.

>  Signed-off-by: Ariel Faigon <github.2009@yendor.com>
>
>  git patch follows.

Please put nothing after your signed-off-by and before the three dashes below.

> ---

Here, just after the three dashes, is the right place to put personnal
comments and stuff that should not go into the commit message.

>  contrib/completion/git-completion.tcsh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/completion/git-completion.tcsh b/contrib/completion/git-completion.tcsh
> index 6104a42..4a790d8 100644
> --- a/contrib/completion/git-completion.tcsh
> +++ b/contrib/completion/git-completion.tcsh
> @@ -41,7 +41,7 @@ if ( ! -e ${__git_tcsh_completion_original_script} ) then
>         exit
>  endif
>
> -cat << EOF > ${__git_tcsh_completion_script}
> +cat << EOF >! ${__git_tcsh_completion_script}
>  #!bash
>  #
>  # This script is GENERATED and will be overwritten automatically.

Thanks,
Christian.
