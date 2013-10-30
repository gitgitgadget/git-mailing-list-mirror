From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 18/19] t: add basic bitmap functionality tests
Date: Wed, 30 Oct 2013 03:39:14 -0400
Message-ID: <20131030073913.GI11317@sigill.intra.peff.net>
References: <20131025055521.GD11810@sigill.intra.peff.net>
 <20131025060438.GP23098@sigill.intra.peff.net>
 <20131028221347.GA32479@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Vicent Marti <vicent@github.com>
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed Oct 30 08:39:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbQN7-0000HX-5q
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 08:39:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752024Ab3J3HjR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Oct 2013 03:39:17 -0400
Received: from cloud.peff.net ([50.56.180.127]:58269 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751702Ab3J3HjQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Oct 2013 03:39:16 -0400
Received: (qmail 16298 invoked by uid 102); 30 Oct 2013 07:39:16 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 30 Oct 2013 02:39:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Oct 2013 03:39:14 -0400
Content-Disposition: inline
In-Reply-To: <20131028221347.GA32479@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236995>

On Mon, Oct 28, 2013 at 11:13:47PM +0100, SZEDER G=C3=A1bor wrote:

> > +	for i in `test_seq 1 10`; do
> > +		test_commit side-$i
> > +	done &&
>=20
> Sorry, style nitpick: could you rewrite this command substitution
> using $() like a few lines above?

That is a nitpick. :P

But sure, I've squashed it in.

-Peff
