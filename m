From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 19/21] t: add basic bitmap functionality tests
Date: Sat, 21 Dec 2013 08:22:46 -0500
Message-ID: <20131221132246.GC10123@sigill.intra.peff.net>
References: <20131114124157.GA23784@sigill.intra.peff.net>
 <20131114124635.GS10757@sigill.intra.peff.net>
 <87mwkcipce.fsf@linux-1gf2.Speedport_W723_V_Typ_A_1_00_098>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	Vicent =?utf-8?B?TWFydMOt?= <vicent@github.com>
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Sat Dec 21 14:23:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VuMWO-0004qf-KL
	for gcvg-git-2@plane.gmane.org; Sat, 21 Dec 2013 14:23:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753519Ab3LUNWs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Dec 2013 08:22:48 -0500
Received: from cloud.peff.net ([50.56.180.127]:48438 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753217Ab3LUNWr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Dec 2013 08:22:47 -0500
Received: (qmail 4928 invoked by uid 102); 21 Dec 2013 13:22:47 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 21 Dec 2013 07:22:47 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 21 Dec 2013 08:22:46 -0500
Content-Disposition: inline
In-Reply-To: <87mwkcipce.fsf@linux-1gf2.Speedport_W723_V_Typ_A_1_00_098>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239591>

On Sat, Dec 07, 2013 at 05:43:29PM +0100, Thomas Rast wrote:

> One nit:
> 
> > +test_expect_success JGIT 'jgit can read our bitmaps' '
> > +	git clone . compat-us.git &&
> > +	(
> > +		cd compat-us.git &&
> 
> The name suggests a bare repo, but it is a full clone.  Not that it
> matters.

It was originally supposed to be a bare repo, but I had trouble
convincing jgit to actually run in a bare repo. The solution was to
switch to a non-bare one. :)

But obviously I forgot to update the name. I agree it's better to use a
more obvious name. Fixed.

-Peff
