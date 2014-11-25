From: Jeff King <peff@peff.net>
Subject: Re: How safe are signed git tags? Only as safe as SHA-1 or somehow
 safer?
Date: Mon, 24 Nov 2014 22:47:31 -0500
Message-ID: <20141125034730.GB19161@peff.net>
References: <5468C33E.2080108@whonix.org>
 <20141117212657.GC15880@peff.net>
 <CAK3OfOgko5Fb5FMGCKw3+12fAzMVEHuUriaiBNGi8nb28bNTQA@mail.gmail.com>
 <CACsJy8BMNXUinfK=YcJPkx98tYv_e40N0_mqqnzMLxDN6hkruA@mail.gmail.com>
 <20141125012359.GR6527@google.com>
 <CACsJy8C3Bfruy=usn9MajmLP_10s2zf8AFZJmxyeGSPDS9SwVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Nico Williams <nico@cryptonector.com>,
	git discussion list <git@vger.kernel.org>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 25 04:47:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xt76F-00083r-TM
	for gcvg-git-2@plane.gmane.org; Tue, 25 Nov 2014 04:47:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751789AbaKYDrc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2014 22:47:32 -0500
Received: from cloud.peff.net ([50.56.180.127]:44604 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750770AbaKYDrb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2014 22:47:31 -0500
Received: (qmail 27216 invoked by uid 102); 25 Nov 2014 03:47:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 24 Nov 2014 21:47:32 -0600
Received: (qmail 26385 invoked by uid 107); 25 Nov 2014 03:47:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 24 Nov 2014 22:47:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Nov 2014 22:47:31 -0500
Content-Disposition: inline
In-Reply-To: <CACsJy8C3Bfruy=usn9MajmLP_10s2zf8AFZJmxyeGSPDS9SwVQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260187>

On Tue, Nov 25, 2014 at 08:52:58AM +0700, Duy Nguyen wrote:

> On Tue, Nov 25, 2014 at 8:23 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> > I think the biggest obstacle is the upgrade path. ;-)
> 
> In the worst case we can always treat new repos as a different VCS. So
> people will need a migration from SHA-1 to the new format, just like
> they migrate from SVN/CVS to Git. Painful but simple.

Maybe we can fix the tree-sorting order while we are at it. :)

More seriously, there may come a day when we are ready to break
compatibility completely with a new "Git v3.0" (2.0 is already taken, of
course). I do not have immediate plans for it, but it's possible that
multiple factors may make such a move desirable sometime in the next 10
years, and that would be a good time to jump hash algorithms, as well.

So it's possible that procrastinating on SHA-1 issues may be the least
painful route. Or it may just be pushing off the day of pain. :)

-Peff
