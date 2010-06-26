From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] fetch: don't output non-errors on stderr
Date: Sat, 26 Jun 2010 12:46:18 -0400
Message-ID: <20100626164618.GA18517@coredump.intra.peff.net>
References: <AANLkTingtgeWuTrocesTIhTPsVz4dfU8CbwZF1TEl6AI@mail.gmail.com>
 <1277418881-11286-1-git-send-email-avarab@gmail.com>
 <7v1vbvkorf.fsf@alter.siamese.dyndns.org>
 <AANLkTilToJ2ekKVgIeka5qx9_lasw6DKSy8bOhTrP4dC@mail.gmail.com>
 <7v1vbukcu8.fsf@alter.siamese.dyndns.org>
 <20100626061305.GB10290@coredump.intra.peff.net>
 <AANLkTik6jbcOtyXJ5JJav1xnLEO6RSmYTHpsX6yYaB5_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 26 18:46:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSYWW-00016n-VU
	for gcvg-git-2@lo.gmane.org; Sat, 26 Jun 2010 18:46:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753140Ab0FZQq1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Jun 2010 12:46:27 -0400
Received: from peff.net ([208.65.91.99]:54923 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753012Ab0FZQq0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jun 2010 12:46:26 -0400
Received: (qmail 21325 invoked by uid 107); 26 Jun 2010 16:47:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 26 Jun 2010 12:47:16 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 26 Jun 2010 12:46:18 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTik6jbcOtyXJ5JJav1xnLEO6RSmYTHpsX6yYaB5_@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149761>

On Sat, Jun 26, 2010 at 12:14:59PM +0000, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:

> On Sat, Jun 26, 2010 at 06:13, Jeff King <peff@peff.net> wrote:
>=20
> > Or even easier: is there a reason that "git fetch -q" would not do =
what
> > you (=C3=86var) want?
>=20
> That'd reduce the verbosity level, which'd skip some messages that I
> might want. E.g.:
>=20
> 		if (verbosity >=3D 0) {
> 			fprintf(stderr, " x %-*s %-*s -> %s\n",
> 				TRANSPORT_SUMMARY_WIDTH, "[deleted]",
> 				REFCOL_WIDTH, "(none)", prettify_refname(ref->name));

Wait, what? Isn't that line also part of the same human-readable status
table? What makes the status of a pruned ref any different than the
status of an updated ref? I don't see how that is an error message, but
the other lines are not.

-Peff
