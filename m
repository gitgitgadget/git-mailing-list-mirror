From: Jeff King <peff@peff.net>
Subject: Re: Confusing git pull error message
Date: Sat, 12 Sep 2009 18:31:37 -0400
Message-ID: <20090912223137.GA8748@coredump.intra.peff.net>
References: <43d8ce650909121301i4450489dhf475ff6894394a5f@mail.gmail.com>
 <20090912211119.GA30966@coredump.intra.peff.net>
 <fabb9a1e0909121437q4eb432e3idde98993ac552b5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: John Tapsell <johnflux@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 13 00:32:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mmb8w-0002zx-H7
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 00:32:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752750AbZILWbk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Sep 2009 18:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752631AbZILWbj
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Sep 2009 18:31:39 -0400
Received: from peff.net ([208.65.91.99]:50339 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751393AbZILWbi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2009 18:31:38 -0400
Received: (qmail 14677 invoked by uid 107); 12 Sep 2009 22:31:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 12 Sep 2009 18:31:59 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 12 Sep 2009 18:31:37 -0400
Content-Disposition: inline
In-Reply-To: <fabb9a1e0909121437q4eb432e3idde98993ac552b5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128305>

On Sat, Sep 12, 2009 at 11:37:47PM +0200, Sverre Rabbelier wrote:

> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo "Your confi=
guration specified for us to pull the ref"
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo "'$upstream=
_short', but we were unable to fetch it from"
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo "the remote=
=2E"
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0fi
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0exit 1
> > =C2=A0}
>=20
> Pretty bad case of multiple personality disorder here? At first
> there's a "me", then again a "me", and then all of a sudden a "we"?

=46air enough. I'll change it to "I was unable to fetch" in the re-roll=
=2E

-Peff
