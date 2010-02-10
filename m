From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] git-archive documentation: .gitattributes must be committed
Date: Wed, 10 Feb 2010 20:07:40 +0100
Message-ID: <4B7303FC.6070701@lsrfire.ath.cx>
References: <1265770284-14830-1-git-send-email-fmarier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Francois Marier <fmarier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 10 20:07:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfHum-0008VK-UL
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 20:07:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756506Ab0BJTHw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Feb 2010 14:07:52 -0500
Received: from india601.server4you.de ([85.25.151.105]:42949 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756502Ab0BJTHu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2010 14:07:50 -0500
Received: from [10.0.1.100] (p57B7D89D.dip.t-dialin.net [87.183.216.157])
	by india601.server4you.de (Postfix) with ESMTPSA id 539532F804E;
	Wed, 10 Feb 2010 20:07:48 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.1.7) Gecko/20100111 Thunderbird/3.0.1
In-Reply-To: <1265770284-14830-1-git-send-email-fmarier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139533>

Am 10.02.2010 03:51, schrieb Francois Marier:
> Add a note to the documentation stating that the .gitattributes
> file must be present (i.e. committed) in the named tree that is
> exported.
>=20
> This can be a bit confusing because it's different from .gitignore
> which takes effect as soon as the file is created.
>=20
> Signed-off-by: Francois Marier <fmarier@gmail.com>
> ---
>  Documentation/git-archive.txt |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
>=20
> diff --git a/Documentation/git-archive.txt b/Documentation/git-archiv=
e.txt
> index 799c8b6..fcd681d 100644
> --- a/Documentation/git-archive.txt
> +++ b/Documentation/git-archive.txt
> @@ -112,6 +112,9 @@ export-subst::
>  	expand several placeholders when adding this file to an archive.
>  	See linkgit:gitattributes[5] for details.
> =20
> +The .gitattributes file must be present in the named tree for it to =
take
> +effect. Uncommitted attributes will not be considered in exports.
> +
>  EXAMPLES
>  --------
>  git archive --format=3Dtar --prefix=3Djunk/ HEAD | (cd /var/tmp/ && =
tar xf -)::

Yeah, the description of --worktree-attributes is a bit terse.  The
lines you add make it appear almost as if this switch doesn't exist,
though; perhaps add a "unless --worktree-attributes is given" or simila=
r
to one of the new sentences?

Ren=E9
