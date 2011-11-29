From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Implement fast hash-collision detection
Date: Tue, 29 Nov 2011 05:29:29 -0500
Message-ID: <20111129102929.GA28024@sigill.intra.peff.net>
References: <1322546563.1719.22.camel@yos>
 <20111129090733.GA22046@sigill.intra.peff.net>
 <CACBZZX59PiO0GGfPg=Gn0h_yWFnAMxmtDtecv9Yd_Pu8Jz0gzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 29 11:29:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVKwV-0000Na-77
	for gcvg-git-2@lo.gmane.org; Tue, 29 Nov 2011 11:29:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753783Ab1K2K3e convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Nov 2011 05:29:34 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:55580
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750880Ab1K2K3e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Nov 2011 05:29:34 -0500
Received: (qmail 29987 invoked by uid 107); 29 Nov 2011 10:36:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 29 Nov 2011 05:36:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Nov 2011 05:29:29 -0500
Content-Disposition: inline
In-Reply-To: <CACBZZX59PiO0GGfPg=Gn0h_yWFnAMxmtDtecv9Yd_Pu8Jz0gzg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186052>

On Tue, Nov 29, 2011 at 11:24:18AM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:

> On Tue, Nov 29, 2011 at 10:07, Jeff King <peff@peff.net> wrote:
>=20
> > However, it may be of interest that the Sun is expected to burn out=
 in a
> > mere 10^10 years[1].
>=20
> Off topic, but it's a a lot sooner than that. The total age of the su=
n
> is is around 10^10 (10 billion) years, but we're already ~4.6 billion
> years along that line.

Yeah, I checked Wikipedia, but rounded up for simplicity. I did use 5
billion for my fun fact at the end of the email, which is close to
accurate.

> However the Sun is currently in a stage of gradual heating until it
> turns into a red giant in ~5 billion years. In around 500 million
> years the earth will be uninhabitable as we know it, and in around 1
> billion years the surface will be hot enough to have boiled all the
> oceans. In other words the earth in a billion years will probably loo=
k
> similar to how Venus looks now.

Good point. If we want an accidental collision in the next 500 million
years, we'd better step up the pace of development!

-Peff
