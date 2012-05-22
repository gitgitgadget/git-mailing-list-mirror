From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH 1/2] completion: rename _git and _gitk
Date: Tue, 22 May 2012 10:24:06 +0200
Message-ID: <20120522082406.GA6001@goldbirke>
References: <1337395295-29162-1-git-send-email-felipe.contreras@gmail.com>
	<1337395295-29162-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Carsten Mattner <carstenmattner@googlemail.com>,
	Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 22 10:24:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWkOC-0003XW-Pd
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 10:24:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755876Ab2EVIYO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 May 2012 04:24:14 -0400
Received: from moutng.kundenserver.de ([212.227.17.9]:62225 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752167Ab2EVIYM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2012 04:24:12 -0400
Received: from localhost6.localdomain6 (p5B130EA7.dip0.t-ipconnect.de [91.19.14.167])
	by mrelayeu.kundenserver.de (node=mrbap0) with ESMTP (Nemesis)
	id 0MHaf6-1SVdOM3LBc-003JNC; Tue, 22 May 2012 10:24:07 +0200
Content-Disposition: inline
In-Reply-To: <1337395295-29162-2-git-send-email-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:E0kWZv9wNcjEhHLeTjaXb6f6eKTUGjTtUmUmyqe3QLm
 lWfEkEzB2/rczmYqSLzp5Cth/Ieh0F/7frE+SkagewNhy7JVgk
 KUSZLL0E77YvHnWjfUMT0RNcWgB8SGgCza5d4tN6ypyqTCqk2I
 UYzKTx5NAf2BrLYUxV5MhziP+zwDddhcY0ye4RVYKwzNm2d5IH
 OP9RNyCEoPZ5pkF+xNd1hEiyB54b3fyWfytdTvyAAxGFx6Qf2f
 NpIFYKve8k3EzfbyNEh2yXM9lWM2OMkeBjR30XkxFBkVl3qMMs
 9OpxZPOfPKBxaw0zZsyZTP6WMOAzSUQE+qKuF+TYgjkcyJ14pD
 bSNZrZj8syRSzZOfOSm0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198187>

Hi,


On Sat, May 19, 2012 at 04:41:34AM +0200, Felipe Contreras wrote:
> Would be useful to provide backwards compatibility for _git. Also, zs=
h
> completion uses _git, and it cannot be changed.
>=20
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  contrib/completion/git-completion.bash |   10 +++++-----
>  t/t9902-completion.sh                  |    2 +-
>  2 files changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/contrib/completion/git-completion.bash b/contrib/complet=
ion/git-completion.bash
> index cd92322..3cb106e 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2597,7 +2597,7 @@ _git_whatchanged ()
>  	_git_log
>  }
> =20
> -_git ()
> +_main_git ()

> -_gitk ()
> +_main_gitk ()

After all those namespace discussions the names of these functions
should start with _git or __git.


G=E1bor
