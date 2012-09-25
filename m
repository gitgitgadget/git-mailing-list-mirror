From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] add basic lua infrastructure
Date: Mon, 24 Sep 2012 23:42:11 -0400
Message-ID: <20120925034211.GC3656@sigill.intra.peff.net>
References: <20120925002325.GA19560@sigill.intra.peff.net>
 <20120925002511.GB19605@sigill.intra.peff.net>
 <robbat2-20120925T032006-952720661Z@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Tue Sep 25 05:42:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGM2S-0007Ia-JI
	for gcvg-git-2@plane.gmane.org; Tue, 25 Sep 2012 05:42:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752410Ab2IYDmO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2012 23:42:14 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:57595 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752134Ab2IYDmN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2012 23:42:13 -0400
Received: (qmail 9603 invoked by uid 107); 25 Sep 2012 03:42:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 24 Sep 2012 23:42:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Sep 2012 23:42:11 -0400
Content-Disposition: inline
In-Reply-To: <robbat2-20120925T032006-952720661Z@orbis-terrarum.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206344>

On Tue, Sep 25, 2012 at 03:21:10AM +0000, Robin H. Johnson wrote:

> On Mon, Sep 24, 2012 at 08:25:12PM -0400,  Jeff King wrote:
> > +ifdef USE_LUA
> > +	BASIC_CFLAGS += -DUSE_LUA `pkg-config --cflags lua5.2`
> > +	EXTLIBS += `pkg-config --libs lua5.2`
> > +endif
> Can you please hoist the packagename out to a variable? It's just plain
> "lua" on Gentoo.

Yeah. I mentioned these patches were very rough, but I didn't go into
detail on all the bad points.  That is definitely one of them. I have no
idea what the "normal" name is; my debian system sticks the version
number in to allow multiple concurrent versions.

I was hoping somebody with more Lua experience could tell me what's
usual. It would be nice if it just worked out of the box as soon as you
said USE_LUA, but that may not be realistic.

-Peff
