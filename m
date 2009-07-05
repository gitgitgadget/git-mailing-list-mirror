From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH v2] completion: Add --full-diff to log options
Date: Sun, 5 Jul 2009 01:35:01 -0700
Message-ID: <20090705083501.GA13068@dcvr.yhbt.net>
References: <pan.2009.06.02.00.34.36@fedoraproject.org> <7vzlcrihew.fsf@alter.siamese.dyndns.org> <20090603122230.GZ28808@inocybe.localdomain> <200906031630.09962.trast@student.ethz.ch> <20090603202058.GA28808@inocybe.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Todd Zullinger <tmz@pobox.com>,
	Thomas Spura <tomspur@fedoraproject.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 05 10:35:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MNNCF-00052U-KT
	for gcvg-git-2@gmane.org; Sun, 05 Jul 2009 10:35:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753653AbZGEIe7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jul 2009 04:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753619AbZGEIe7
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jul 2009 04:34:59 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:42103 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753589AbZGEIe6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jul 2009 04:34:58 -0400
Received: from localhost (user-118bg3a.cable.mindspring.com [66.133.192.106])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id B65421F794;
	Sun,  5 Jul 2009 08:35:01 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20090603202058.GA28808@inocybe.localdomain>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122737>

Todd Zullinger <tmz@pobox.com> wrote:
> Signed-off-by: Todd Zullinger <tmz@pobox.com>

I was just missing this completion for "git log" myself.

Acked-by: Eric Wong <normalperson@yhbt.net>

> ---
>  contrib/completion/git-completion.bash |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 98b9cbe..79a99af 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1157,7 +1157,7 @@ _git_log ()
>  			$__git_log_shortlog_options
>  			$__git_log_gitk_options
>  			--root --topo-order --date-order --reverse
> -			--follow
> +			--follow --full-diff
>  			--abbrev-commit --abbrev=
>  			--relative-date --date=
>  			--pretty= --format= --oneline
> -- 
