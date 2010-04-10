From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Why not show ORIG_HEAD in git-log --decorate?
Date: Sat, 10 Apr 2010 11:00:42 +0200
Message-ID: <20100410090042.GA13109@atjola.homenet>
References: <s2zea182b21004090907i9af49416za4fdb4650af5ae29@mail.gmail.com>
 <20100410012903.GA32428@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Yury Polyanskiy <polyanskiy@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 10 11:00:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0WYi-0003Fq-7q
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 11:00:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751635Ab0DJJAt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Apr 2010 05:00:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:36034 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751137Ab0DJJAs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 05:00:48 -0400
Received: (qmail invoked by alias); 10 Apr 2010 09:00:45 -0000
Received: from i59F569CE.versanet.de (EHLO atjola.homenet) [89.245.105.206]
  by mail.gmx.net (mp065) with SMTP; 10 Apr 2010 11:00:45 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19tA/8/APVtR3juMmOf9qFqBgYO9h2iilRAM1Ja8R
	rPyuzxTvTu8IWF
Content-Disposition: inline
In-Reply-To: <20100410012903.GA32428@coredump.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59999999999999998
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144535>

On 2010.04.09 21:29:03 -0400, Jeff King wrote:
> On Fri, Apr 09, 2010 at 12:07:00PM -0400, Yury Polyanskiy wrote:
>=20
> > It would be very convenient if after git-pull I could see the new
> > merged-in commits in the git-log. The simplest solution for this is=
 to
> > simply mark ORIG_HEAD in the output of git-log --decorate (and idea=
lly
> > also in gitk).
>=20
> I think most people do something like:
>=20
>   gitk HEAD^..ORIG_HEAD
>=20
> To see everything in ORIG_HEAD that isn't in HEAD^ (the first parent =
of
> HEAD, or what you had just before the pull).

I guess you meant to say "gitk ORIG_HEAD.." there. ORIG_HEAD is already
the pre-pull state. So if the merge actually created a merge commit,
then HEAD^ =3D=3D ORIG_HEAD, and if it was a fast-forward, then ORIG_HE=
AD is
either the same as HEAD^ or one of its ancestors. In either case,
HEAD^..ORIG_HEAD will be empty.

Bj=F6rn
