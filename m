From: Jeff King <peff@peff.net>
Subject: Re: Git thinks a failing command doesn't exist
Date: Wed, 11 Aug 2010 15:48:41 -0400
Message-ID: <20100811194841.GA8689@coredump.intra.peff.net>
References: <AANLkTin7E-v9TYd1KoD73knnSwSMy-V-pvS0TmpQd72M@mail.gmail.com>
 <20100811192554.GA8106@coredump.intra.peff.net>
 <AANLkTik3QmyP3sygbd36VhUQtdK-z81vqVAoAcPofFO+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 11 21:48:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjHIB-00040T-C1
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 21:48:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758436Ab0HKTsp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Aug 2010 15:48:45 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:56085 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756390Ab0HKTsp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Aug 2010 15:48:45 -0400
Received: (qmail 6643 invoked by uid 111); 11 Aug 2010 19:48:44 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO coredump.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) ESMTPSA; Wed, 11 Aug 2010 19:48:44 +0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Aug 2010 15:48:41 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTik3QmyP3sygbd36VhUQtdK-z81vqVAoAcPofFO+@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153295>

On Wed, Aug 11, 2010 at 07:45:14PM +0000, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:

> > So either your shell is producing that exit code for a different ca=
se,
> > or git is broken.
>=20
> My shell is Debian /bin/dash 0.5.5.1-6.

Hmm, I can't reproduce here, and I am also using dash as my shell.

> Unfortunately the error with rebase was some one-off thing that I
> couldn't reproduce. I'm not even sure /what/ I did to make it happen.

OK. The code is _supposed_ to work as you expected, so if it happens
again, I guess try to reproduce and we'll go from there.

-Peff
