From: Jeff King <peff@peff.net>
Subject: Re: cvsimport does not work with passwords ?
Date: Thu, 28 Apr 2011 18:45:10 -0400
Message-ID: <20110428224510.GA16065@sigill.intra.peff.net>
References: <ipckgd$krd$2@dough.gmane.org>
 <ipcmjp$krd$4@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Marcin =?utf-8?B?V2nFm25pY2tp?= <mwisnicki@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 29 00:45:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFZxZ-0002ZJ-0y
	for gcvg-git-2@lo.gmane.org; Fri, 29 Apr 2011 00:45:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933503Ab1D1WpO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Apr 2011 18:45:14 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:46620
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757142Ab1D1WpM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2011 18:45:12 -0400
Received: (qmail 6856 invoked by uid 107); 28 Apr 2011 22:46:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 28 Apr 2011 18:46:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Apr 2011 18:45:10 -0400
Content-Disposition: inline
In-Reply-To: <ipcmjp$krd$4@dough.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172415>

On Thu, Apr 28, 2011 at 09:35:53PM +0000, Marcin Wi=C5=9Bnicki wrote:

> I have tried another mirror that uses ssh:
>=20
> > export CVSROOT=3D:ext:anoncvs@anoncvs1.FreeBSD.org:/home/ncvs
> > export SSH_RSH=3Dssh
>=20
> And this also does not work because git tries to use rsh.
> According to google this should work.
>=20
> Any ideas why cvsimport is so broken for me ?

It has (thankfully) been a long time since I've had to touch CVS, but
shouldn't that be CVS_RSH on the second line?

-Peff
