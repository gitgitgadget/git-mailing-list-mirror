From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3/GSoC 2/5] path.c: implement xdg_runtime_dir()
Date: Fri, 25 Mar 2016 13:59:47 -0400
Message-ID: <20160325175947.GC10563@sigill.intra.peff.net>
References: <1458728005-22555-1-git-send-email-huiyiqun@gmail.com>
 <1458728005-22555-2-git-send-email-huiyiqun@gmail.com>
 <20160325095923.GB8880@sigill.intra.peff.net>
 <CAKqreux8FHdJoKDishjQkbi9g1oUc265EUK4nOJ_sgeFivGSNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Your friend <pickfire@riseup.net>
To: =?utf-8?B?5oOg6L22576k?= <huiyiqun@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 18:59:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajW1a-0000yS-Ge
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 18:59:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754018AbcCYR7u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Mar 2016 13:59:50 -0400
Received: from cloud.peff.net ([50.56.180.127]:38427 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753793AbcCYR7u (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 13:59:50 -0400
Received: (qmail 4677 invoked by uid 102); 25 Mar 2016 17:59:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 25 Mar 2016 13:59:49 -0400
Received: (qmail 26150 invoked by uid 107); 25 Mar 2016 18:00:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 25 Mar 2016 14:00:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 Mar 2016 13:59:47 -0400
Content-Disposition: inline
In-Reply-To: <CAKqreux8FHdJoKDishjQkbi9g1oUc265EUK4nOJ_sgeFivGSNA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289919>

On Fri, Mar 25, 2016 at 10:21:48PM +0800, =E6=83=A0=E8=BD=B6=E7=BE=A4 w=
rote:

> > There are some minor English problems here (and elsewhere). E.g., y=
ou
> > probably want "So we just issue a warning and leave it to the user =
to
> > solve.".
>=20
> Sorry for my English.

Thanks. And sorry if that sounded too harsh. I know that working in a
non-native language is tough. Usually in a review I'll try to provide
specific English fixes, but in this case, I think a lot of these
messages are still in flux, so I I didn't want to waste either of our
time going over specifics if the content is just going to change later.

> > These ones leak, too.
>=20
> I will deal with it.
>=20
> I find there are some similar leakage in this file. I'll fix them in
> another patch.

Great, thanks.

-Peff
