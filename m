From: Jeff King <peff@peff.net>
Subject: Re: auto commit merge using the default merge message
Date: Fri, 24 Apr 2009 10:06:06 -0400
Message-ID: <20090424140606.GB10761@coredump.intra.peff.net>
References: <81bfc67a0904230046j48ed06b7s5693406332ee52dc@mail.gmail.com> <81b0412b0904230057k1653d039vfc3962e6affda584@mail.gmail.com> <49F025E7.7090404@drmicha.warpmail.net> <7vocunwz1n.fsf@gitster.siamese.dyndns.org> <81bfc67a0904231831y31bfb057pa5eaa86d0e153824@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Caleb Cushing <xenoterracide@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 24 16:13:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxM4M-0002SX-Ex
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 16:07:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759342AbZDXOGN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Apr 2009 10:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757648AbZDXOGN
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 10:06:13 -0400
Received: from peff.net ([208.65.91.99]:49332 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754266AbZDXOGM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 10:06:12 -0400
Received: (qmail 28589 invoked by uid 107); 24 Apr 2009 14:06:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 24 Apr 2009 10:06:22 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Apr 2009 10:06:06 -0400
Content-Disposition: inline
In-Reply-To: <81bfc67a0904231831y31bfb057pa5eaa86d0e153824@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117438>

On Thu, Apr 23, 2009 at 09:31:10PM -0400, Caleb Cushing wrote:

> On Thu, Apr 23, 2009 at 4:32 AM, Junio C Hamano <gitster@pobox.com> w=
rote:
> > Use "GIT_EDITOR=3D:" instead. =C2=A0It also is *true* just like /bi=
n/true, but
> > git knows a simple magic about this and avoids an extra fork+exec.
> >
>=20
> So I could put
>=20
> GIT_EDITOR=3D:
>=20
> at the top of my shell script, and then whenever I need to do a
> commit, just git commit and it'll work (assuming the commit has a
> default message).

You need to also

  export GIT_EDITOR

for "git commit" to see it.

-Peff
