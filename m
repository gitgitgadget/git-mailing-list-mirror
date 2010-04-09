From: Jeff King <peff@peff.net>
Subject: Re: nd/setup
Date: Thu, 8 Apr 2010 20:13:22 -0400
Message-ID: <20100409001322.GB23501@coredump.intra.peff.net>
References: <7v6342ahx9.fsf@alter.siamese.dyndns.org>
 <20100408073825.GA15153@coredump.intra.peff.net>
 <20100408214233.GA32441@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 09 02:13:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O01r5-0005Mv-Lt
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 02:13:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933944Ab0DIANq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Apr 2010 20:13:46 -0400
Received: from peff.net ([208.65.91.99]:48238 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933796Ab0DIANp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Apr 2010 20:13:45 -0400
Received: (qmail 28082 invoked by uid 107); 9 Apr 2010 00:13:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 08 Apr 2010 20:13:43 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Apr 2010 20:13:22 -0400
Content-Disposition: inline
In-Reply-To: <20100408214233.GA32441@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144388>

On Thu, Apr 08, 2010 at 04:42:33PM -0500, Jonathan Nieder wrote:

> >> * nd/setup (2010-04-05) 43 commits
> [...]
> > Probably one or both
> > of us should look at it before applying it to next, but assuming it
> > passes a basic sanity check, I think the best thing will be to get =
it in
> > 'next' early so we can shake out any bugs during the next cycle.
>=20
> I don=E2=80=99t think it=E2=80=99s anywhere near master material yet.

To clarify, I don't think that either. But sitting in pu, nobody is eve=
n
running it. This seems to me like the sort of topic where there will be
a lot of unintended fallouts. Besides review, the best way to find
them is to get people running it, and 'next' is the most bleeding-edge
we have.

> when run outside any repository.  Probably the checker should be
> configured by an environment variable that indicates where to print
> its messages and whether to bail out when a problem is detected (for
> tests).

Yeah, that sounds reasonable, especially if merging this to 'next' woul=
d
make git unusable. We want to shake out bugs, not punish people running
next. :) But I haven't even really looked at the topic in detail yet.

> Sorry to be the bearer of bad tidings,

Not at all. This is exactly the sort of in-depth review that is very
helpful. Thanks.

-Peff
