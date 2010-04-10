From: Jeff King <peff@peff.net>
Subject: Re: Why not show ORIG_HEAD in git-log --decorate?
Date: Sat, 10 Apr 2010 05:04:41 -0400
Message-ID: <20100410090441.GA18772@coredump.intra.peff.net>
References: <s2zea182b21004090907i9af49416za4fdb4650af5ae29@mail.gmail.com>
 <20100410012903.GA32428@coredump.intra.peff.net>
 <20100410090042.GA13109@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Yury Polyanskiy <polyanskiy@gmail.com>, git@vger.kernel.org
To: =?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Sat Apr 10 11:05:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0Wcq-0004UY-0T
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 11:05:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751653Ab0DJJFH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Apr 2010 05:05:07 -0400
Received: from peff.net ([208.65.91.99]:56707 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751122Ab0DJJFG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 05:05:06 -0400
Received: (qmail 17417 invoked by uid 107); 10 Apr 2010 09:05:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 10 Apr 2010 05:05:05 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 10 Apr 2010 05:04:41 -0400
Content-Disposition: inline
In-Reply-To: <20100410090042.GA13109@atjola.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144536>

On Sat, Apr 10, 2010 at 11:00:42AM +0200, Bj=C3=B6rn Steinbrink wrote:

> > I think most people do something like:
> >=20
> >   gitk HEAD^..ORIG_HEAD
> >=20
> > To see everything in ORIG_HEAD that isn't in HEAD^ (the first paren=
t of
> > HEAD, or what you had just before the pull).
>=20
> I guess you meant to say "gitk ORIG_HEAD.." there. ORIG_HEAD is alrea=
dy
> the pre-pull state. So if the merge actually created a merge commit,
> then HEAD^ =3D=3D ORIG_HEAD, and if it was a fast-forward, then ORIG_=
HEAD is
> either the same as HEAD^ or one of its ancestors. In either case,
> HEAD^..ORIG_HEAD will be empty.

Urgh, yes. Sorry, I was totally not thinking when I wrote that.

I never use ORIG_HEAD, as I always do a fetch + inspect + merge, rather
than pull. But I can't even figure out what thought process led me to
write what I did above.

Thanks for the correction.

-Peff
