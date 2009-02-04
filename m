From: Jesse van den Kieboom <jesse@icecrew.nl>
Subject: Re: [PATCH 1/3] Fix "multi-character character constant" compile
 warning
Date: Wed, 04 Feb 2009 12:50:56 +0100
Message-ID: <1233748256.7594.3.camel@wren>
References: <20090203130818.GA20359@neumann>
	 <1233666531-21589-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	SZEDER =?ISO-8859-1?Q?G=E1bor?= <szeder@fzi.de>
To: SZEDER =?ISO-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed Feb 04 12:52:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUgIt-0001qi-Ei
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 12:52:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752415AbZBDLvB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Feb 2009 06:51:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752264AbZBDLvA
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 06:51:00 -0500
Received: from novowork.com ([87.230.85.62]:43925 "EHLO novowork.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752041AbZBDLu7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 06:50:59 -0500
Received: from [128.178.246.242] (ls-in-242.epfl.ch [128.178.246.242])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by novowork.com (Postfix) with ESMTPSA id 8F4E436709FC;
	Wed,  4 Feb 2009 12:50:57 +0100 (CET)
In-Reply-To: <1233666531-21589-1-git-send-email-szeder@ira.uka.de>
X-Mailer: Evolution 2.24.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108339>

Op dinsdag 03-02-2009 om 14:08 uur [tijdzone +0100], schreef SZEDER
G=C3=A1bor:
> From: SZEDER G=C3=A1bor <szeder@fzi.de>
>=20
> ... that was caused by a short command line option.
>=20
> Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
> ---
>  gitg/gitg.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/gitg/gitg.c b/gitg/gitg.c
> index 1b33294..69c5b56 100644
> --- a/gitg/gitg.c
> +++ b/gitg/gitg.c
> @@ -15,7 +15,7 @@ static gboolean commit_mode =3D FALSE;
> =20
>  static GOptionEntry entries[] =3D=20
>  {
> -	{ "commit", '-c', 0, G_OPTION_ARG_NONE, &commit_mode, N_("Start git=
g in commit mode") },=20
> +	{ "commit", 'c', 0, G_OPTION_ARG_NONE, &commit_mode, N_("Start gitg=
 in commit mode") },
>  	{ NULL }
>  };

This has already been fixed.


--=20
Jesse van den Kieboom

Personal: http://www.icecrew.nl
Professional: http://www.novowork.com
