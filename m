From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/10] color and pager improvements
Date: Thu, 25 Aug 2011 16:25:12 -0400
Message-ID: <20110825202512.GD6165@sigill.intra.peff.net>
References: <20110818224644.GC8481@sigill.intra.peff.net>
 <4e4e03fb.6d8e455c.bm000@wupperonline.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ingo =?utf-8?Q?Br=C3=BCckl?= <ib@wupperonline.de>
X-From: git-owner@vger.kernel.org Thu Aug 25 22:25:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwgUL-0002X1-Hd
	for gcvg-git-2@lo.gmane.org; Thu, 25 Aug 2011 22:25:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753961Ab1HYUZP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Aug 2011 16:25:15 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:46761
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753928Ab1HYUZP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2011 16:25:15 -0400
Received: (qmail 18632 invoked by uid 107); 25 Aug 2011 20:25:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 25 Aug 2011 16:25:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 25 Aug 2011 16:25:12 -0400
Content-Disposition: inline
In-Reply-To: <4e4e03fb.6d8e455c.bm000@wupperonline.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180110>

On Fri, Aug 19, 2011 at 08:34:13AM +0200, Ingo Br=C3=BCckl wrote:

> Jeff King wrote on Thu, 18 Aug 2011 15:46:44 -0700:
>=20
> > On Fri, Aug 19, 2011 at 12:33:01AM +0200, Ingo Br=C3=BCckl wrote:
>=20
> >> My goal was to be able to turn off paging for "stash list" only wh=
ile all
> >> other stash commands should continue paging.
>=20
> > Ah, OK. I think the only other stash command that pages is "stash s=
how",
> > but I don't think it's unreasonable to want paging for that but not=
 for
> > "list".
>=20
> Maybe "stash list" simply should - like other commands - not paginate=
 by
> default.

I have no real opinion on that. It only paginates as a side effect of
calling log.

I do think "git stash show" paginating by default is probably helpful,
though.

The best way to get people's attention is probably to post a patch
adding --no-pager to the git-log invocation of "git stash list". :)

-Peff
