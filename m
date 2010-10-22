From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] diff: don't presume empty file when corresponding
	object is missing
Date: Fri, 22 Oct 2010 09:04:46 +0200
Message-ID: <20101022070446.GA19834@pengutronix.de>
References: <alpine.LFD.2.00.1010212353550.2764@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Oct 22 09:05:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9BgP-0006mP-KE
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 09:04:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752890Ab0JVHEu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Oct 2010 03:04:50 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58995 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752019Ab0JVHEu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 03:04:50 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.71)
	(envelope-from <ukl@pengutronix.de>)
	id 1P9BgG-0004DC-6S; Fri, 22 Oct 2010 09:04:48 +0200
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1P9BgE-00008b-7k; Fri, 22 Oct 2010 09:04:46 +0200
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1010212353550.2764@xanadu.home>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159659>

Hi Nicolas,

On Fri, Oct 22, 2010 at 12:02:27AM -0400, Nicolas Pitre wrote:
> The low-level diff code will happily produce totally bogus diff outpu=
t=20
> with a broken repository via format-patch and friends by treating mis=
sing
> objects as empty files.  Let's prevent that from happening any longer=
=2E
>=20
> Reported-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
Great, this fixes format-patch to fail in my tree as advertised.
Tested-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

> Signed-off-by: Nicolas Pitre <nico@fluxnic.net>

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
