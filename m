From: Jeff King <peff@peff.net>
Subject: Re: Git fetch/pull stopped working
Date: Tue, 8 May 2012 16:18:32 -0400
Message-ID: <20120508201832.GA15287@sigill.intra.peff.net>
References: <CADB4Qb1BhWpm1mAwiHy+edySvo7P+YcvrSiTSc8dVzKQsnNCfQ@mail.gmail.com>
 <7vehqv36aw.fsf@alter.siamese.dyndns.org>
 <20120508001018.GB5067@centaur.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Egor Ryabkov <egor.ryabkov@gmail.com>, git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Tue May 08 22:18:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRqs0-0001GF-OE
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 22:18:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757111Ab2EHUSt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 May 2012 16:18:49 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:34378
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757219Ab2EHUSf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 16:18:35 -0400
Received: (qmail 7878 invoked by uid 107); 8 May 2012 20:18:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 08 May 2012 16:18:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 May 2012 16:18:32 -0400
Content-Disposition: inline
In-Reply-To: <20120508001018.GB5067@centaur.lab.cmartin.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197419>

On Tue, May 08, 2012 at 02:10:18AM +0200, Carlos Mart=C3=ADn Nieto wrot=
e:

> I can reproduce this issue. It happens somewhere between my phone jac=
k
> and rackspace.
>=20
> I can perform 'git fetch' on other hosts and ssh -T git@github.com
> works fine. However, trying to fetch from github gives me an error.
>=20
> Not only this, but trying to browse to github.com or rubygems.org,
> both of which seem to be hosted on the same datacentre gives me
> timeouts or takes really long to answer. Routing traffic through my
> server in the next country over makes it work, as does fetching from
> that host.

I can't reproduce this behavior at all. Neither from rackspace's DFW
data center, nor from the IAD one (the latter is where github.com is
located).

> Yeah... It looks like the Internet is being silly. So much for routin=
g
> around damage. What I'm not sure is how this would also affect AWS;
> maybe the Irish one?

If it was a routing issue, I wonder if it has gone away. Are you still
seeing problems?

If there's further discussion, we should probably take it off the git
list. Routing issues are definitely not a git-core problem. :)

-Peff
