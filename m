From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/10] color and pager improvements
Date: Thu, 18 Aug 2011 15:46:44 -0700
Message-ID: <20110818224644.GC8481@sigill.intra.peff.net>
References: <20110818215820.GA7767@sigill.intra.peff.net>
 <4e4d94bb.00b9e5c4.bm000@wupperonline.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ingo =?utf-8?Q?Br=C3=BCckl?= <ib@wupperonline.de>
X-From: git-owner@vger.kernel.org Fri Aug 19 00:46:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuBMS-0003jD-Gs
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 00:46:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754734Ab1HRWqs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Aug 2011 18:46:48 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33476
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754313Ab1HRWqr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 18:46:47 -0400
Received: (qmail 26465 invoked by uid 107); 18 Aug 2011 22:47:27 -0000
Received: from 173-164-171-125-SFBA.hfc.comcastbusiness.net (HELO sigill.intra.peff.net) (173.164.171.125)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 18 Aug 2011 18:47:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Aug 2011 15:46:44 -0700
Content-Disposition: inline
In-Reply-To: <4e4d94bb.00b9e5c4.bm000@wupperonline.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179651>

On Fri, Aug 19, 2011 at 12:33:01AM +0200, Ingo Br=C3=BCckl wrote:

> Jeff King wrote on Thu, 18 Aug 2011 14:58:20 -0700:
>=20
> > I think Ingo's original complaint was simply that pager.stash didn'=
t
> > actually do anything, not that he wanted some separate config for t=
he
> > various subcommands.
>=20
> No, you're wrong.
>=20
> My goal was to be able to turn off paging for "stash list" only while=
 all
> other stash commands should continue paging.

Ah, OK. I think the only other stash command that pages is "stash show"=
,
but I don't think it's unreasonable to want paging for that but not for
"list".

I'll take a look at implementing something for that. Though I'll be
traveling for the next few days, so it probably won't be for a bit.

-Peff
