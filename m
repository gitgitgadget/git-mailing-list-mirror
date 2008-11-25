From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@strlen.de>
Subject: Re: [PATCH] tg export: implement skipping empty patches for quilt
	mode
Date: Tue, 25 Nov 2008 21:54:40 +0100
Message-ID: <20081125205440.GA28679@strlen.de>
References: <1227563810-5426-1-git-send-email-u.kleine-koenig@pengutronix.de> <20081125084531.GA13122@lapse.rw.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
To: martin f krafft <madduck@debian.org>
X-From: git-owner@vger.kernel.org Tue Nov 25 21:56:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L54wv-0005sU-MF
	for gcvg-git-2@gmane.org; Tue, 25 Nov 2008 21:55:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325AbYKYUym convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Nov 2008 15:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbYKYUym
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Nov 2008 15:54:42 -0500
Received: from Chamillionaire.breakpoint.cc ([85.10.199.196]:49677 "EHLO
	Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750769AbYKYUyl (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Nov 2008 15:54:41 -0500
Received: id: ukleinek by Chamillionaire.breakpoint.cc authenticated by ukleinek with local
	(easymta 1.00 BETA 1)
	id 1L54vg-0007T9-4z; Tue, 25 Nov 2008 21:54:40 +0100
Content-Disposition: inline
In-Reply-To: <20081125084531.GA13122@lapse.rw.madduck.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101680>

On Tue, Nov 25, 2008 at 09:45:31AM +0100, martin f krafft wrote:
> also sprach Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> [2008=
=2E11.24.2256 +0100]:
> > +skipempty=3Dfalse
>=20
> Any reason not to make it default? Why do we even need this option?
> Do empty quilt files ever have a purpose?
My first implementation did it unconditionally because I think this
should be the default, too.  Then I found in the tg-export section of
README:

	TODO: -n option to prevent exporting of empty patches

I'm not sure if this was meant for collapse or quilt or both.  I assume=
d
the last and implemented -n as suggested.

Best regards
Uwe
