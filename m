From: Jeff King <peff@peff.net>
Subject: Re: Consistent terminology: cached/staged/index
Date: Sun, 27 Feb 2011 03:43:17 -0500
Message-ID: <20110227084317.GB3356@sigill.intra.peff.net>
References: <AANLkTi=9OWqz66Ab6O9tc4eYSrhZZ1YC_+ta9sutAn30@mail.gmail.com>
 <20110213193738.GA26868@elie>
 <7v8vxjwnhj.fsf@alter.siamese.dyndns.org>
 <AANLkTim4UKxYwRagCk3R20e7wsRb7CxvS_ze9b8MfWjL@mail.gmail.com>
 <20110214231920.GA24814@elie>
 <AANLkTik-jc0ZX9S4bCYV8VBgPXJZsX0U08W2H+jufO8r@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 27 09:43:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtcDt-0001kr-PC
	for gcvg-git-2@lo.gmane.org; Sun, 27 Feb 2011 09:43:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751816Ab1B0InU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Feb 2011 03:43:20 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:35586 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751528Ab1B0InU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Feb 2011 03:43:20 -0500
Received: (qmail 14447 invoked by uid 111); 27 Feb 2011 08:43:19 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sun, 27 Feb 2011 08:43:19 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 27 Feb 2011 03:43:17 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTik-jc0ZX9S4bCYV8VBgPXJZsX0U08W2H+jufO8r@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168012>

On Sat, Feb 26, 2011 at 11:09:14PM +0200, Felipe Contreras wrote:

> On Tue, Feb 15, 2011 at 1:19 AM, Jonathan Nieder <jrnieder@gmail.com>=
 wrote:
> > When people talk about the staging area I tend to get confused. =C2=
=A0I
> > think there's an idea that because it sounds more concrete, there i=
s
> > less to explain --- or maybe I am just wired the wrong way.
>=20
> I don't like the phrase "staging area". A "stage" already has an area=
=2E
> You put things on the stage. Sometimes there are multiple stages.

As a native English speaker, this makes no sense to me. A stage as a
noun is either:

  1. a raised platform where you give performances

  2. a phase that some process goes through (e.g., "the early stages of
     Alzheimer's disease")

Whereas the term "staging area" is a stopping point on a journey for
collecting and organizing items. I couldn't find a definite etymology
online, but it seems to be military in origin (e.g., you would send all
your tanks to a staging area, then once assembled and organized, begin
your attack). You can't just call it "staging", which is not a noun, an=
d
the term "stage" is not a synonym. "Staging area" has a very particular
meaning.

So the term "staging area" makes perfect sense to me; it is where we
collect changes to make a commit. I am willing to accept that does not
to others (native English speakers or no), and that we may need to come
up with a better term. But I think just calling it "the stage" is even
worse; it loses the concept that it is a place for collecting and
organizing.

-Peff
