From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Dec 2011, #02; Mon, 5)
Date: Tue, 6 Dec 2011 13:52:18 -0500
Message-ID: <20111206185218.GB9492@sigill.intra.peff.net>
References: <7v8vmqi98f.fsf@alter.siamese.dyndns.org>
 <20111206055239.GA20671@sigill.intra.peff.net>
 <CABPQNSbOReM71HaPmce3v_98NDu17fT3YnySR4pWzJEDa-RKnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>, Stephan Beyer <s-beyer@gmx.net>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 06 19:52:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RY07t-0003N1-Bf
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 19:52:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751999Ab1LFSwV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Dec 2011 13:52:21 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41438
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751320Ab1LFSwU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2011 13:52:20 -0500
Received: (qmail 7069 invoked by uid 107); 6 Dec 2011 18:58:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 06 Dec 2011 13:58:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Dec 2011 13:52:18 -0500
Content-Disposition: inline
In-Reply-To: <CABPQNSbOReM71HaPmce3v_98NDu17fT3YnySR4pWzJEDa-RKnA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186368>

On Tue, Dec 06, 2011 at 12:22:06PM +0100, Erik Faye-Lund wrote:

> >> * jk/upload-archive-use-start-command (2011-11-21) 1 commit
> >> =C2=A0- upload-archive: use start_command instead of fork
> >>
> >> What's the status of this one?
> >
> > I think what you have in pu is good, but of course I didn't actuall=
y
> > test it on Windows. Erik?
> >
>=20
> I tried to check out ee27ca4 and build, and got hit by a wall of warn=
ings:

I think you are on the wrong topic. ee27ca4 is the maint topic for
"don't let remote clients get unreachable commits", and is based on the
ancient 1.6.2. Which is why you are getting all of those warnings.

The topic in question is jk/upload-archive-use-start-command, which is
at 1bc01ef, and should be based on recent-ish master.

-Peff
