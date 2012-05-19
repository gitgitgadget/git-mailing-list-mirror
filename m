From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/2] completion: backwards compatibility fix
Date: Sat, 19 May 2012 11:31:34 -0400
Message-ID: <20120519153134.GB6979@sigill.intra.peff.net>
References: <1337395295-29162-1-git-send-email-felipe.contreras@gmail.com>
 <20120519024503.GA2801@sigill.intra.peff.net>
 <CACY+Hvp-G4odbftiFeu1u+1icROD36M=CzSn3DKu_TEaqNB3OQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Carsten Mattner <carstenmattner@googlemail.com>
X-From: git-owner@vger.kernel.org Sat May 19 17:31:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVld9-0000Iv-8S
	for gcvg-git-2@plane.gmane.org; Sat, 19 May 2012 17:31:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755008Ab2ESPbj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 May 2012 11:31:39 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49523
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754237Ab2ESPbi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2012 11:31:38 -0400
Received: (qmail 16789 invoked by uid 107); 19 May 2012 15:32:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 19 May 2012 11:32:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 19 May 2012 11:31:34 -0400
Content-Disposition: inline
In-Reply-To: <CACY+Hvp-G4odbftiFeu1u+1icROD36M=CzSn3DKu_TEaqNB3OQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198035>

On Sat, May 19, 2012 at 09:54:28AM +0200, Carsten Mattner wrote:

> >> Felipe Contreras (2):
> >> =C2=A0 completion: rename _git and _gitk
> >> =C2=A0 completion: add support for backwards compatibilit
> >
> > Thanks. This looks like the obviously correct solution. Even if we =
end
> > up with a public _GIT_complete or whatever, the backwards-compatibi=
lity
> > is worth it.
>=20
> Cool. Just though the patches now. Felipe, which variant should I use
> to define _main_git completion for the alias g with the 2 patches
> applied to git_completion.bash? Using bash-4.2.28.

I think the point of the patches is that you can continue to use your
same "complete ... -F _git g" line as always (with these patches you
could also say "__git_complete g _main_git", but that is not backwards
compatible to older versions, if you use the same bashrc on multiple
machines).

-Peff
