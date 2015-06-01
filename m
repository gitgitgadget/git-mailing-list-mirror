From: Jeff King <peff@peff.net>
Subject: Re: git gc gives "error: Could not read..."
Date: Mon, 1 Jun 2015 05:58:51 -0400
Message-ID: <20150601095850.GD31389@peff.net>
References: <556C0BAD.80106@atlas-elektronik.com>
 <20150601081450.GA32634@peff.net>
 <556C1A95.9010704@atlas-elektronik.com>
 <20150601085226.GA20537@peff.net>
 <556C2273.4030405@atlas-elektronik.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Stefan =?utf-8?B?TsOkd2U=?= <stefan.naewe@atlas-elektronik.com>
X-From: git-owner@vger.kernel.org Mon Jun 01 11:59:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzMVF-0004Fj-1s
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 11:59:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753096AbbFAJ67 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Jun 2015 05:58:59 -0400
Received: from cloud.peff.net ([50.56.180.127]:38681 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752022AbbFAJ6y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 05:58:54 -0400
Received: (qmail 23049 invoked by uid 102); 1 Jun 2015 09:58:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 Jun 2015 04:58:53 -0500
Received: (qmail 27807 invoked by uid 107); 1 Jun 2015 09:58:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 Jun 2015 05:58:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Jun 2015 05:58:51 -0400
Content-Disposition: inline
In-Reply-To: <556C2273.4030405@atlas-elektronik.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270391>

On Mon, Jun 01, 2015 at 11:14:27AM +0200, Stefan N=C3=A4we wrote:

> Maybe this one:
>=20
>    d3038d (prune: keep objects reachable from recent objects)

Yes, exactly.

> It would be really helpful if you sent the patch as an attachment.
> I know that's not the normal wokflow but our mail server garbles ever=
y
> message so that I can't (or don't know how to...) use 'git am' to tes=
t
> the patch, which I'm willing to do!

It ended up as a patch series. However, you can fetch it from:

  git://github.com/peff/git.git jk/silence-unreachable-broken-links

which is perhaps even easier.

-Peff
