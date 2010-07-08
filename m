From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] rev-parse: fix --parse-opt --keep-dashdash
	--stop-at-non-option
Date: Thu, 8 Jul 2010 08:51:18 +0200
Message-ID: <20100708065118.GA21565@pengutronix.de>
References: <1278427565-11057-1-git-send-email-u.kleine-koenig@pengutronix.de> <7vr5jfrmuq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 08 08:51:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWkxF-0002Bi-Qu
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 08:51:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753427Ab0GHGvY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Jul 2010 02:51:24 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58045 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753264Ab0GHGvX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jul 2010 02:51:23 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.71)
	(envelope-from <ukl@pengutronix.de>)
	id 1OWkx8-0001JG-As; Thu, 08 Jul 2010 08:51:22 +0200
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1OWkx4-0007np-W1; Thu, 08 Jul 2010 08:51:18 +0200
Content-Disposition: inline
In-Reply-To: <7vr5jfrmuq.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150541>

On Wed, Jul 07, 2010 at 02:41:33PM -0700, Junio C Hamano wrote:
> Uwe Kleine-K=F6nig  <u.kleine-koenig@pengutronix.de> writes:
>=20
> > The ?: operator has a lower priority than |, so the implicit associ=
ativity
> > made the 6th argument of parse_options be PARSE_OPT_KEEP_DASHDASH i=
f
> > keep_dashdash was true discarding PARSE_OPT_STOP_AT_NON_OPTION and
> > PARSE_OPT_SHELL_EVAL.
>=20
> Wow, this is an age-old breakage dating back to 6e0800e (parse-opt: m=
ake
> PARSE_OPT_STOP_AT_NON_OPTION available to git rev-parse, 2009-06-14) =
that
> dates back to the very original --stop-at-non-option patch, isn't it?
Yeah, the author of 6e0800e should get a pat on his head and a lesson i=
n
C. :-)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
