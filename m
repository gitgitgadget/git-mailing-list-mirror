From: Jeff King <peff@peff.net>
Subject: Re: Finding a branch point in git
Date: Wed, 30 May 2012 17:45:22 -0400
Message-ID: <20120530214522.GA3237@sigill.intra.peff.net>
References: <CAMP44s0f7AJPQSTDgvy0U7vx8nxzq2a3vMhSr2Tcc61fetFkJA@mail.gmail.com>
 <20120528062026.GB11174@sigill.intra.peff.net>
 <CAMP44s3pKo-Dzg6bTKNmjFsLSYvUfhXfk9NQJxOBTvFekqgrFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 30 23:45:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZqhv-0007kY-UK
	for gcvg-git-2@plane.gmane.org; Wed, 30 May 2012 23:45:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754269Ab2E3Vp2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 May 2012 17:45:28 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:36571
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753812Ab2E3Vp1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2012 17:45:27 -0400
Received: (qmail 10128 invoked by uid 107); 30 May 2012 21:45:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 30 May 2012 17:45:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 May 2012 17:45:22 -0400
Content-Disposition: inline
In-Reply-To: <CAMP44s3pKo-Dzg6bTKNmjFsLSYvUfhXfk9NQJxOBTvFekqgrFA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198838>

On Wed, May 30, 2012 at 06:52:15PM +0200, Felipe Contreras wrote:

> > --X--A--B--C--D----E--F (master)
> > =C2=A0 =C2=A0 |\ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 / =C2=A0/
> > =C2=A0 =C2=A0 | \ =C2=A0 =C2=A0 =C2=A0 =C2=A0 / =C2=A0/
> > =C2=A0 =C2=A0 =C2=A0\ G--H----I =C2=A0/ =C2=A0(branch X)
> > =C2=A0 =C2=A0 =C2=A0 \ =C2=A0 =C2=A0 =C2=A0 / =C2=A0/
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0K--L--M--O =C2=A0(branch Y)
> >
> > The only merge between master and X is F, but its merge base is M. =
We
> > missed the earlier merge to master because it actually happened acr=
oss
> > two different commits.
>=20
> I assume you mean the merge between master and Y.

Oops, yes.

-Peff
