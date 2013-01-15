From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] attr: fix off-by-one directory component length
 calculation
Date: Tue, 15 Jan 2013 15:24:00 -0800
Message-ID: <20130115232400.GA16147@sigill.intra.peff.net>
References: <1358256924-31578-1-git-send-email-pclouds@gmail.com>
 <201301152014.28433.avila.jn@gmail.com>
 <7vwqve2qk3.fsf@alter.siamese.dyndns.org>
 <201301152053.58561.avila.jn@gmail.com>
 <7vfw222mv2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: =?utf-8?Q?Jean-No=C3=ABl?= AVILA <avila.jn@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 00:24:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvFrr-0003S1-Ke
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 00:24:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933783Ab3AOXYG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Jan 2013 18:24:06 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:34543 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932654Ab3AOXYD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 18:24:03 -0500
Received: (qmail 6401 invoked by uid 107); 15 Jan 2013 23:25:19 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (207.86.76.198)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 15 Jan 2013 18:25:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Jan 2013 15:24:00 -0800
Content-Disposition: inline
In-Reply-To: <7vfw222mv2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213690>

On Tue, Jan 15, 2013 at 12:49:05PM -0800, Junio C Hamano wrote:

> "Jean-No=C3=ABl AVILA" <avila.jn@gmail.com> writes:
>=20
> > Btw, the test 10 to t9902 is failing on my Debian testing. Is it a =
known=20
> > issue?
>=20
> Which branch?

t9902.10 is overly sensitive to extra git commands in your PATH, as wel=
l
as cruft in your build dir (especially if you have been building 'pu',
which has git-check-ignore). Try "make clean && make test".

-Peff
