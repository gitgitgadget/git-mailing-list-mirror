From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] bash: offer only paths after '--' for 'git checkout'
Date: Fri, 25 Jul 2008 15:34:10 -0500
Message-ID: <20080725203410.GA23202@spearce.org>
References: <1216808133-31919-2-git-send-email-madcoder@debian.org> <1216813762-23511-1-git-send-email-szeder@ira.uka.de> <1216813762-23511-2-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>,
	gitster@pobox.com
To: SZEDER GGGbor <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Jul 25 22:35:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMU0U-0004lV-IH
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 22:35:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755307AbYGYUeM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Jul 2008 16:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755222AbYGYUeM
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 16:34:12 -0400
Received: from george.spearce.org ([209.20.77.23]:38962 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754957AbYGYUeK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 16:34:10 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 2B5B5383A5; Fri, 25 Jul 2008 20:34:10 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1216813762-23511-2-git-send-email-szeder@ira.uka.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90111>

SZEDER GGGbor <szeder@ira.uka.de> wrote:
> Commit d773c631 (bash: offer only paths after '--', 2008-07-08) did t=
he
> same for several other git commands, but 'git checkout' went unnotice=
d.
>=20
> Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>

Acked-by: Shawn O. Pearce <spearce@spearce.org>

> diff --git a/contrib/completion/git-completion.bash b/contrib/complet=
ion/git-completion.bash
> index 2edb341..9b51fda 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -626,6 +626,8 @@ _git_bundle ()
> =20
>  _git_checkout ()
>  {
> +	__git_has_doubledash && return
> +
>  	__gitcomp "$(__git_refs)"
>  }
> =20

--=20
Shawn.
