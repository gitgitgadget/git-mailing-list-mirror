From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Documentation - pt-BR.
Date: Thu, 1 Oct 2009 08:22:52 -0400
Message-ID: <20091001122252.GA31919@sigill.intra.peff.net>
References: <1253730339-11146-1-git-send-email-tfransosi@gmail.com>
 <a4c8a6d00909301518v43784d7ah6364be0134a6e7d@mail.gmail.com>
 <20091001080206.GB13436@coredump.intra.peff.net>
 <20091001115846.GA5583@Pilar.aei.mpg.de>
 <20091001120711.GB5583@Pilar.aei.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thiago Farina <tfransosi@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: "Carlos R. Mafra" <crmafra2@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 01 14:23:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MtKgZ-0005fK-73
	for gcvg-git-2@lo.gmane.org; Thu, 01 Oct 2009 14:23:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756539AbZJAMWw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Oct 2009 08:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756534AbZJAMWw
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Oct 2009 08:22:52 -0400
Received: from peff.net ([208.65.91.99]:55828 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756533AbZJAMWv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Oct 2009 08:22:51 -0400
Received: (qmail 16389 invoked by uid 107); 1 Oct 2009 12:26:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 01 Oct 2009 08:26:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Oct 2009 08:22:53 -0400
Content-Disposition: inline
In-Reply-To: <20091001120711.GB5583@Pilar.aei.mpg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129389>

On Thu, Oct 01, 2009 at 02:07:11PM +0200, Carlos R. Mafra wrote:

> On Thu  1.Oct'09 at 13:58:46 +0200, Carlos R. Mafra wrote:
> > I read the patch. The changes are correct and improve the quality
> > of the text.
>=20
> From the Portuguese point of view the change below is
> correct,
>=20
> -cabe=C3=A7alho Subject: e o resto no corpo.
> +cabe=C3=A7alho "Assunto:", e o resto no corpo.
>=20
> but I don't know if "Subject:" should be translated in
> this context. Does git-am accept "Assunto:" instead
> of "Subject:" if one is using a Portuguese locale?

No, it doesn't. It must be in English as it is an rfc2822 header. It is
probably best for it to remain in English here, then, as we are
specifically referring to the literal "Subject" mail header, as opposed
to the more abstract concept of a subject. I think putting it in quotes
makes sense, though, to indicate clearly that it is a literal technical
term. I.e.:

-cabe=C3=A7alho Subject: e o resto no corpo.
+cabe=C3=A7alho "Subject:" e o resto no corpo.

The patch in my tree has been updated in this way.

Thanks, Carlos, for the review.

-Peff
