From: Jeff King <peff@peff.net>
Subject: Re: per-ref data storage (was: Storing additional information in
 commit headers)
Date: Wed, 3 Aug 2011 21:41:14 -0600
Message-ID: <20110804034114.GB4534@sigill.intra.peff.net>
References: <20110801182015.GA3100@fishbowl.rw.madduck.net>
 <20110801201301.GA17111@sigill.intra.peff.net>
 <20110801211104.GC15401@fishbowl.rw.madduck.net>
 <20110802035056.GB17494@sigill.intra.peff.net>
 <20110802082810.GC29887@fishbowl.rw.madduck.net>
 <20110802185154.GA2499@sigill.intra.peff.net>
 <20110802190645.GB17322@fishbowl.rw.madduck.net>
 <20110802192727.GB20239@fishbowl.rw.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git discussion list <git@vger.kernel.org>,
	Petr Baudis <pasky@ucw.cz>, Clemens Buchacher <drizzd@aon.at>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Thu Aug 04 05:41:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoooE-00030z-Cv
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 05:41:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755949Ab1HDDlS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Aug 2011 23:41:18 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60282
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755844Ab1HDDlR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 23:41:17 -0400
Received: (qmail 13882 invoked by uid 107); 4 Aug 2011 03:41:51 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 03 Aug 2011 23:41:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Aug 2011 21:41:14 -0600
Content-Disposition: inline
In-Reply-To: <20110802192727.GB20239@fishbowl.rw.madduck.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178666>

On Tue, Aug 02, 2011 at 09:27:28PM +0200, martin f krafft wrote:

> [sorry, my previous message was a total reply FAIL]
>=20
> also sprach martin f krafft <madduck@madduck.net> [2011.08.02.2106 +0=
200]:
> > It just seems to me that per-ref storage is a lot further away than
> > per-commit storage, and I'd really like to move forward with TopGit=
=E2=80=A6
>=20
> refs/heads/master is a file, containing its payload in the first
> line by format definition, right?
>=20
> I mean: the storage is right there, isn't it?

Yes, and I think git will even ignore other stuff in the file. But I
don't think you can count on git not obliterating the other stuff when
it updates the ref. Nor would it be passed over a clone or fetch.

> Of course this opens a whole new can of worms: merging per-ref data.

Yes. That's the tricky part. And that's something you'll have to deal
with no matter how you store it, I expect.

-Peff
