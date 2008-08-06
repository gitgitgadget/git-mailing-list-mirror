From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] bash: remove redundant check for 'git stash apply'
	options
Date: Wed, 6 Aug 2008 08:47:10 -0700
Message-ID: <20080806154710.GB28749@spearce.org>
References: <1217915438-6838-6-git-send-email-lee.marlow@gmail.com> <1218037523-32266-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Lee Marlow <lee.marlow@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: SZEDER GGGbor <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed Aug 06 17:48:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQlFg-00077k-AD
	for gcvg-git-2@gmane.org; Wed, 06 Aug 2008 17:48:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762143AbYHFPrO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Aug 2008 11:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762119AbYHFPrN
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Aug 2008 11:47:13 -0400
Received: from george.spearce.org ([209.20.77.23]:54943 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762085AbYHFPrM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2008 11:47:12 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id F40EB38420; Wed,  6 Aug 2008 15:47:10 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1218037523-32266-1-git-send-email-szeder@ira.uka.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91524>

SZEDER GGGbor <szeder@ira.uka.de> wrote:
> It will never trigger anyway because of the first check, and even if =
it
> would, it would not offer the command line option.
>=20
> Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>

Oops.  I should have caught that.  ACK.

> diff --git a/contrib/completion/git-completion.bash b/contrib/complet=
ion/git-completion.bash
> index 447cb06..5d60f82 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1427,7 +1427,7 @@ _git_stash ()
>  		apply,--*)
>  			__gitcomp "--index"
>  			;;
> -		show,--*|apply,--*|drop,--*|pop,--*|branch,--*)
> +		show,--*|drop,--*|pop,--*|branch,--*)
>  			COMPREPLY=3D()
>  			;;
>  		show,*|apply,*|drop,*|pop,*|branch,*)

--=20
Shawn.
