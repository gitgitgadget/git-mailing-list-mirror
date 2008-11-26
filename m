From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@strlen.de>
Subject: Re: [PATCH] tg export: implement skipping empty patches for quilt
	mode
Date: Wed, 26 Nov 2008 10:47:29 +0100
Message-ID: <20081126094729.GA11169@strlen.de>
References: <1227563810-5426-1-git-send-email-u.kleine-koenig@pengutronix.de> <20081125084531.GA13122@lapse.rw.madduck.net> <20081125205440.GA28679@strlen.de> <20081126092542.GE25162@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
To: martin f krafft <madduck@debian.org>
X-From: git-owner@vger.kernel.org Wed Nov 26 10:48:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5H0p-00023G-D9
	for gcvg-git-2@gmane.org; Wed, 26 Nov 2008 10:48:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751677AbYKZJrb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Nov 2008 04:47:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750879AbYKZJrb
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Nov 2008 04:47:31 -0500
Received: from Chamillionaire.breakpoint.cc ([85.10.199.196]:40016 "EHLO
	Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751157AbYKZJrb (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Nov 2008 04:47:31 -0500
Received: id: ukleinek by Chamillionaire.breakpoint.cc authenticated by ukleinek with local
	(easymta 1.00 BETA 1)
	id 1L5GzZ-0002uP-Aw; Wed, 26 Nov 2008 10:47:29 +0100
Content-Disposition: inline
In-Reply-To: <20081126092542.GE25162@piper.oerlikon.madduck.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101718>

On Wed, Nov 26, 2008 at 10:25:42AM +0100, martin f krafft wrote:
> also sprach Uwe Kleine-K=F6nig <ukleinek@strlen.de> [2008.11.25.2154 =
+0100]:
> > 	TODO: -n option to prevent exporting of empty patches
> >=20
> > I'm not sure if this was meant for collapse or quilt or both.  I as=
sumed
> > the last and implemented -n as suggested.
>=20
> Hm, except...
>=20
> +! "$skipempty" || [ "$driver" =3D "quilt" ] ||
> +       die "-n is only implemented for the quilt driver"
> +
>=20
> so you assumed "quilt", not both.
hmm, I *implemented* it only for quilt.  That's also the reason for not
having deleted the todo item.
=20
> Anyway, Petr, I'd make this default for all drivers, unless you objec=
t.
Ack.

If you want I can prepare a patch, but probably it's easier for you to
amend!?

Best regards
Uwe
