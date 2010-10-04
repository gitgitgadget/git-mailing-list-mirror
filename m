From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2] Documentation/git-clone: describe --mirror more
 verbose
Date: Mon, 04 Oct 2010 08:47:34 -0400
Message-ID: <1286196454.6750.60.camel@gandalf.stny.rr.com>
References: <4CA99E43.1000204@drmicha.warpmail.net>
	 <1286185878-23795-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Darren 'Some People' Hart <darren@dvhart.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Mon Oct 04 14:47:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2kSF-0001TY-JL
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 14:47:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755702Ab0JDMri convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Oct 2010 08:47:38 -0400
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.123]:45762 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755608Ab0JDMrh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 08:47:37 -0400
X-Authority-Analysis: v=1.1 cv=QISHQ+x4xS+apxgDHgAvNvlUjyrXCzYsHvuXcbPYiKg= c=1 sm=0 a=f7pM5c20qXkA:10 a=Q9fys5e9bTEA:10 a=OPBmh+XkhLl+Enan7BmTLg==:17 a=meVymXHHAAAA:8 a=vA1A1dOfAAAA:8 a=cCri8_SAAAAA:8 a=7CgbFfVN-DeGS60FE04A:9 a=GKkxJvknshElR_bqYSsA:7 a=G4t7m_H5tjH7NOvGoIbC7FwNXAoA:4 a=PUjeQqilurYA:10 a=jeBq3FmKZ4MA:10 a=mAV_wwoo0HwA:10 a=XNN-oNMjSfgA:10 a=OPBmh+XkhLl+Enan7BmTLg==:117
X-Cloudmark-Score: 0
X-Originating-IP: 67.242.120.143
Received: from [67.242.120.143] ([67.242.120.143:56860] helo=[192.168.23.10])
	by hrndva-oedge04.mail.rr.com (envelope-from <rostedt@goodmis.org>)
	(ecelerity 2.2.3.46 r()) with ESMTP
	id C7/08-11377-7ECC9AC4; Mon, 04 Oct 2010 12:47:36 +0000
In-Reply-To: <1286185878-23795-1-git-send-email-u.kleine-koenig@pengutronix.de>
X-Mailer: Evolution 2.30.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158041>

On Mon, 2010-10-04 at 11:51 +0200, Uwe Kleine-K=F6nig wrote:
> Some people in #linux-rt claimed that you cannot define "--mirror" wi=
th
> "mirror" only.
>=20

Acked-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve

> Cc: Darren 'Some People' Hart <darren@dvhart.com>
> Cc: Michael J Gruber <git@drmicha.warpmail.net>
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> ---
>  Documentation/git-clone.txt |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)
>=20
> diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.tx=
t
> index dc7d3d1..524a080 100644
> --- a/Documentation/git-clone.txt
> +++ b/Documentation/git-clone.txt
> @@ -128,7 +128,12 @@ objects from the source repository into a pack i=
n the cloned repository.
>  	configuration variables are created.
> =20
>  --mirror::
> -	Set up a mirror of the remote repository.  This implies `--bare`.
> +	Set up a mirror of the source repository.  This implies `--bare`.
> +	Compared to `--bare`, `--mirror` does not only map local branches o=
f
> +	the source to local branches of the target but all refs (including
> +	remote branches, notes etc.) and sets up a refspec configuration su=
ch
> +	that all these refs are overwritten by a `git remote update` in the
> +	target repository.
> =20
>  --origin <name>::
>  -o <name>::
