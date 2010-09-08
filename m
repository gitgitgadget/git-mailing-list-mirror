From: Jan =?UTF-8?B?S3LDvGdlcg==?= <jk@jk.gs>
Subject: Re: [PATCH] Add explicit --src/dst-prefix to git-formt-patch in
 git-rebase.sh for the case of "diff.noprefix" in git-config
Date: Wed, 8 Sep 2010 23:07:39 +0200
Message-ID: <20100908230739.1b8831f1@jk.gs>
References: <1283954045-8326-1-git-send-email-ods15@ods15.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Oded Shimon <ods15@ods15.dyndns.org>
X-From: git-owner@vger.kernel.org Wed Sep 08 23:08:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtRs1-0002NN-K9
	for gcvg-git-2@lo.gmane.org; Wed, 08 Sep 2010 23:07:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755083Ab0IHVHp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Sep 2010 17:07:45 -0400
Received: from zoidberg.org ([88.198.6.61]:41642 "EHLO cthulhu.zoidberg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754721Ab0IHVHo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Sep 2010 17:07:44 -0400
Received: from jk.gs (p508A2F6F.dip.t-dialin.net [::ffff:80.138.47.111])
  (AUTH: LOGIN jast, TLS: TLSv1/SSLv3,128bits,AES128-SHA)
  by cthulhu.zoidberg.org with esmtp; Wed, 08 Sep 2010 23:07:41 +0200
  id 00400317.4C87FB1D.00000DF6
In-Reply-To: <1283954045-8326-1-git-send-email-ods15@ods15.dyndns.org>
X-Mailer: Claws Mail 3.7.6 (GTK+ 2.20.1; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155814>

Oded Shimon <ods15@ods15.dyndns.org> wrote:

> ---

A shorter summary (subject) and more of a commit message body might be a
good idea. People tend to like patch summaries that fit into one line
on a terminal, and shorter is even better for those tools that output
additional fields on the same line.

Signoff is missing, please see Documentation/SubmittingPatches for
details (including the reason why we need one in the first place).

I can't comment on the patch itself since I'm not familiar with the
whole diff machinery nor the innards of rebase.

>  git-rebase.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/git-rebase.sh b/git-rebase.sh
> index 7508463..e83a0cf 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -565,7 +565,7 @@ fi
>  
>  if test -z "$do_merge"
>  then
> -	git format-patch -k --stdout --full-index
> --ignore-if-in-upstream \
> +	git format-patch -k --stdout --full-index
> --ignore-if-in-upstream --src-prefix=a/ --dst-prefix=b/ \
> --no-renames $root_flag "$revisions" | git am $git_am_opt --rebasing
> --resolvemsg="$RESOLVEMSG" && move_to_original_branch

-Jan
