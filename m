From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] run-command: introduce CHILD_PROCESS_INIT
Date: Sun, 17 Aug 2014 03:29:09 -0400
Message-ID: <20140817072909.GE23808@peff.net>
References: <53EFE15B.7030805@web.de>
 <20140817071230.GB23808@peff.net>
 <53F05906.9070909@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Sun Aug 17 09:29:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XIutx-0004xj-Jd
	for gcvg-git-2@plane.gmane.org; Sun, 17 Aug 2014 09:29:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751031AbaHQH3M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Aug 2014 03:29:12 -0400
Received: from cloud.peff.net ([50.56.180.127]:53536 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750959AbaHQH3L (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2014 03:29:11 -0400
Received: (qmail 6125 invoked by uid 102); 17 Aug 2014 07:29:11 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 17 Aug 2014 02:29:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 17 Aug 2014 03:29:09 -0400
Content-Disposition: inline
In-Reply-To: <53F05906.9070909@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255353>

On Sun, Aug 17, 2014 at 09:25:58AM +0200, Ren=C3=A9 Scharfe wrote:

> >I think one reason we never had an INIT macro here is that you canno=
t
> >simply use the struct after zero-ing it anyway. That's just the firs=
t
> >step, and then you have to tweak a bunch of fields to get what you w=
ant.
> >So the memset is just one setup line out of many.
>=20
> Some (or most?) of these steps could be converted to named
> initializers -- once all supported platforms provide them..

Yeah, I'd be fine with that, but I am not holding my breath on the
"once..." in your statement. :)

-Peff
