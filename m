From: Jeff King <peff@peff.net>
Subject: Re: t5541: Bad file descriptor
Date: Mon, 9 May 2011 10:50:01 -0400
Message-ID: <20110509145001.GB11362@sigill.intra.peff.net>
References: <3340686A-18D8-4279-87F0-580262DD4DFA@gernhardtsoftware.com>
 <7voc3hbtgu.fsf@alter.siamese.dyndns.org>
 <20110505054611.GA29033@sigill.intra.peff.net>
 <20110505061634.GB29033@sigill.intra.peff.net>
 <BANLkTin8YUwoMmxXLske=5nuvW+idBOuig@mail.gmail.com>
 <BANLkTi=y+34s+yO9LVuiUxB5Xz3v7Pc2Mw@mail.gmail.com>
 <BANLkTin82XVOQaE4i9BJu3Eyr5v_8MOaOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Avery Pennarun <apenwarr@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	"git@vger.kernel.org List" <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 09 16:50:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJRmo-0001HA-8i
	for gcvg-git-2@lo.gmane.org; Mon, 09 May 2011 16:50:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752591Ab1EIOuF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 May 2011 10:50:05 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58043
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751692Ab1EIOuE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2011 10:50:04 -0400
Received: (qmail 9949 invoked by uid 107); 9 May 2011 14:52:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 09 May 2011 10:52:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 May 2011 10:50:01 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTin82XVOQaE4i9BJu3Eyr5v_8MOaOg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173236>

On Thu, May 05, 2011 at 08:51:29PM +0200, Sverre Rabbelier wrote:

> Heya,
>=20
> On Thu, May 5, 2011 at 19:59, Avery Pennarun <apenwarr@gmail.com> wro=
te:
> > I was running one, didn't think anybody cared about it though. =C2=A0=
Please
> > point me at the necessary docs for this test and I can set up a new
> > one in my copious spare time (tm). =C2=A0I can't promise to monitor=
 it
> > though, so that might be more of a problem :) =C2=A0gitbuilder does=
 produce
> > rss feeds that are easy to track.
>=20
> I don't think there are any docs as such, but see t/lib-httpd.sh.
> Should be easy enough to deduce which variables to set to what from
> that.

Just setting GIT_TEST_HTTPD=3D1 in the environment would turn on those
tests. But you need apache installed, too. The scripts should take care
of any config.

-Peff
