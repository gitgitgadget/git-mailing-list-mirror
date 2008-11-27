From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] bash: offer refs instead of filenames for 'git revert'
Date: Thu, 27 Nov 2008 13:30:12 -0800
Message-ID: <20081127213012.GC23984@spearce.org>
References: <1227792953-4095-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: SZEDER GGGbor <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Nov 27 22:31:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5oST-0002F2-SK
	for gcvg-git-2@gmane.org; Thu, 27 Nov 2008 22:31:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753250AbYK0VaO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Nov 2008 16:30:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753157AbYK0VaN
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Nov 2008 16:30:13 -0500
Received: from george.spearce.org ([209.20.77.23]:49060 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753198AbYK0VaN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Nov 2008 16:30:13 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 36C4138210; Thu, 27 Nov 2008 21:30:12 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1227792953-4095-1-git-send-email-szeder@ira.uka.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101840>

SZEDER GGGbor <szeder@ira.uka.de> wrote:
> The completion script for 'git revert' currently offers options and
> filenames.  However, 'git revert' doesn't take any filenames from the
> command line, but a single commit.  Therefore, it's more sane to offe=
r
> refs instead.
>=20
> Signed-off-by: SZEDER G=E1bor <szeder@ira.uka.de>

Oh, good catch.

Acked-by: Shawn O. Pearce <spearce@spearce.org>

> ---
>  contrib/completion/git-completion.bash |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/contrib/completion/git-completion.bash b/contrib/complet=
ion/git-completion.bash
> index 39bf18b..7e668d5 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1348,7 +1348,7 @@ _git_revert ()
>  		return
>  		;;
>  	esac
> -	COMPREPLY=3D()
> +	__gitcomp "$(__git_refs)"
>  }
> =20
>  _git_rm ()
> --=20
> 1.6.0.4.814.gfe502
>=20

--=20
Shawn.
