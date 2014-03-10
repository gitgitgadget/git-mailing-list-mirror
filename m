From: Sandy Carter <sandy.carter@savoirfairelinux.com>
Subject: Re: [PATCH v2 2/2] i18n: assure command not corrupted by _() process
Date: Mon, 10 Mar 2014 08:51:21 -0400
Message-ID: <531DB549.5060304@savoirfairelinux.com>
References: <1393620766-17582-1-git-send-email-sandy.carter@savoirfairelinux.com> <1393858554-4392-1-git-send-email-sandy.carter@savoirfairelinux.com> <1393858554-4392-2-git-send-email-sandy.carter@savoirfairelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: jn.avila@free.fr
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 10 13:49:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WMzeG-0001Hb-Cy
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 13:49:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753415AbaCJMtg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Mar 2014 08:49:36 -0400
Received: from mail.savoirfairelinux.com ([209.172.62.77]:54635 "EHLO
	mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752608AbaCJMtf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2014 08:49:35 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id DF38410D6288;
	Mon, 10 Mar 2014 08:49:34 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xUHBMO2E4caq; Mon, 10 Mar 2014 08:49:34 -0400 (EDT)
Received: from [192.168.49.85] (mtl.savoirfairelinux.net [208.88.110.46])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id AA94610D6287;
	Mon, 10 Mar 2014 08:49:34 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <1393858554-4392-2-git-send-email-sandy.carter@savoirfairelinux.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243756>

Is there any update on this patch?

Le 2014-03-03 09:55, Sandy Carter a =E9crit :
> Separate message from command examples to avoid translation issues
> such as a dash being omitted in a translation.
>
> Signed-off-by: Sandy Carter <sandy.carter@savoirfairelinux.com>
> ---
>   builtin/branch.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/branch.c b/builtin/branch.c
> index b4d7716..b304da8 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -1022,11 +1022,13 @@ int cmd_branch(int argc, const char **argv, c=
onst char *prefix)
>   		 */
>   		if (argc =3D=3D 1 && track =3D=3D BRANCH_TRACK_OVERRIDE &&
>   		    !branch_existed && remote_tracking) {
> -			fprintf(stderr, _("\nIf you wanted to make '%s' track '%s', do th=
is:\n\n"), head, branch->name);
> -			fprintf(stderr, _("    git branch -d %s\n"), branch->name);
> -			fprintf(stderr, _("    git branch --set-upstream-to %s\n"), branc=
h->name);
> +			fprintf(stderr, "\n");
> +			fprintf(stderr, _("If you wanted to make '%s' track '%s', do this=
:"), head, branch->name);
> +			fprintf(stderr, "\n\n");
> +			fprintf(stderr, "    git branch -d %s\n", branch->name);
> +			fprintf(stderr, "    git branch --set-upstream-to %s\n", branch->=
name);
> +			fprintf(stderr, "\n");
>   		}
> -
>   	} else
>   		usage_with_options(builtin_branch_usage, options);
>
>
