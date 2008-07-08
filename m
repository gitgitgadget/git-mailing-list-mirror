From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] completion: add branch options --contains --merged
	--no-merged
Date: Tue, 8 Jul 2008 04:49:22 +0000
Message-ID: <20080708044922.GD2542@spearce.org>
References: <279b37b20807071341k3551e61cl10c5969600ba8218@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, szeder@ira.uka.de
To: Eric Raible <raible@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 08 06:50:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KG59k-0008Nd-Uj
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 06:50:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753993AbYGHEtZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 00:49:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753914AbYGHEtY
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 00:49:24 -0400
Received: from george.spearce.org ([209.20.77.23]:50735 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753843AbYGHEtX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 00:49:23 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id DD4763821F; Tue,  8 Jul 2008 04:49:22 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <279b37b20807071341k3551e61cl10c5969600ba8218@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87711>

Eric Raible <raible@gmail.com> wrote:
> Signed-off-by: Eric Raible <raible@gmail.com>

Trivially-Acked-by: Shawn O. Pearce <spearce@spearce.org>

;-)

More completion support that probably should go to maint, as the
functionality in git-branch is in 1.5.6 but we (again) forgot to
make sure the completion was up-to-date prior to release.

> ---
>  contrib/completion/git-completion.bash |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/contrib/completion/git-completion.bash
> b/contrib/completion/git-completion.bash
> index 0eb8df0..22e109d 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -546,7 +546,7 @@ _git_branch ()
>  	--*)
>  		__gitcomp "
>  			--color --no-color --verbose --abbrev= --no-abbrev
> -			--track --no-track
> +			--track --no-track --contains --merged --no-merged
>  			"
>  		;;
>  	*)
> -- 
> 1.5.6.1.1071.g76fb.dirty

-- 
Shawn.
