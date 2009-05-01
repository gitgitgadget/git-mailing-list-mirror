From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Fix a bunch of pointer declarations (codestyle)
Date: Fri, 1 May 2009 16:39:10 -0400
Message-ID: <20090501203910.GA15549@coredump.intra.peff.net>
References: <1241168796-7222-1-git-send-email-felipe.contreras@gmail.com> <780e0a6b0905011220g42d9784dp186cc7ff7669081e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 01 22:40:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzzWb-0000NW-Qe
	for gcvg-git-2@gmane.org; Fri, 01 May 2009 22:40:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765475AbZEAUjO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 May 2009 16:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763915AbZEAUjN
	(ORCPT <rfc822;git-outgoing>); Fri, 1 May 2009 16:39:13 -0400
Received: from peff.net ([208.65.91.99]:33525 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753840AbZEAUjM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2009 16:39:12 -0400
Received: (qmail 26882 invoked by uid 107); 1 May 2009 20:39:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 01 May 2009 16:39:26 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 01 May 2009 16:39:10 -0400
Content-Disposition: inline
In-Reply-To: <780e0a6b0905011220g42d9784dp186cc7ff7669081e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118095>

On Fri, May 01, 2009 at 12:20:08PM -0700, Stephen Boyd wrote:

> On Fri, May 1, 2009 at 2:06 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> >
> > - =C2=A0 =C2=A0 =C2=A0 *argv =3D xmalloc(sizeof(char*) * size);
> > + =C2=A0 =C2=A0 =C2=A0 *argv =3D xmalloc(sizeof(char *) * size);
> >
>=20
> I don't think this is what the coding guidelines is talking about. A
> pointer isn't being declared here plus there isn't any variable the
> star should be sticking to.

Besides that, don't we usually prefer sizeof() on the actual variable
instead of the type, which is less error prone? IOW,

  *argv =3D xmalloc(sizeof(**argv) * size);

-Peff
