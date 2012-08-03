From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Fix 'No newline...' annotation in rewrite diffs.
Date: Fri, 3 Aug 2012 12:02:30 -0400
Message-ID: <20120803160229.GA13094@sigill.intra.peff.net>
References: <85f291cec03411c61ddf8808e53621ae@imap.force9.net>
 <20120802213346.GA575@sigill.intra.peff.net>
 <7vipd1c66f.fsf@alter.siamese.dyndns.org>
 <20120802221404.GA1682@sigill.intra.peff.net>
 <loom.20120803T094115-721@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 18:03:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SxKLL-0002IX-AZ
	for gcvg-git-2@plane.gmane.org; Fri, 03 Aug 2012 18:03:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753071Ab2HCQDH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Aug 2012 12:03:07 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:50702 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752398Ab2HCQCh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2012 12:02:37 -0400
Received: (qmail 25669 invoked by uid 107); 3 Aug 2012 16:02:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 03 Aug 2012 12:02:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Aug 2012 12:02:30 -0400
Content-Disposition: inline
In-Reply-To: <loom.20120803T094115-721@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202838>

On Fri, Aug 03, 2012 at 07:49:47AM +0000, Micha=C5=82 Kiedrowicz wrote:

> Jeff King <peff <at> peff.net> writes:
>=20
> > -		for i in $(seq 1 $GIT_PERF_REPEAT_COUNT); do
> > +		for i in $("$PERL_PATH" -le "print for 1..$GIT_PERF_REPEAT_COUNT=
"); do
>=20
> Maybe you could introduce "test_seq" instead.

I don't have a strong preference, as there are only two callsites. Do
you want to make a patch?

-Peff
