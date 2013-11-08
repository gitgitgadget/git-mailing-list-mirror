From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/5] fix up 'jk/pack-bitmap' branch
Date: Fri, 8 Nov 2013 14:29:03 -0800
Message-ID: <20131108222903.GB19912@sigill.intra.peff.net>
References: <527C0CEA.4020705@ramsay1.demon.co.uk>
 <20131107221944.GA19238@sigill.intra.peff.net>
 <527D1B06.3090807@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Vicent Marti <tanoku@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Nov 08 23:29:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VeuYA-0001k2-EN
	for gcvg-git-2@plane.gmane.org; Fri, 08 Nov 2013 23:29:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757841Ab3KHW3G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Nov 2013 17:29:06 -0500
Received: from cloud.peff.net ([50.56.180.127]:35776 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757557Ab3KHW3F (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Nov 2013 17:29:05 -0500
Received: (qmail 21846 invoked by uid 102); 8 Nov 2013 22:29:05 -0000
Received: from GITHUB-INC.bar1.SanFrancisco1.Level3.net (HELO sigill.intra.peff.net) (4.53.133.38)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 08 Nov 2013 16:29:05 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Nov 2013 14:29:03 -0800
Content-Disposition: inline
In-Reply-To: <527D1B06.3090807@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237469>

On Fri, Nov 08, 2013 at 06:10:30PM +0100, Torsten B=C3=B6gershausen wro=
te:

> Side question:
> Do we have enough test coverage for htonll()/ntohll(),
> or do we want do the "module test" which I send a couple of days befo=
re ?

The series adds tests for building and using the ewah bitmaps, which in
turn rely on the htonll code. So they are being tested in the existing
series.

-Peff
