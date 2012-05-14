From: Jeff King <peff@peff.net>
Subject: Re: how to clone/checkout branch/tag vesion from GIT repository
Date: Mon, 14 May 2012 13:33:58 -0400
Message-ID: <20120514173358.GA32368@sigill.intra.peff.net>
References: <1336657187852-7546744.post@n2.nabble.com>
 <20120510135605.GA1495@sigill.intra.peff.net>
 <49A2AA38871E7B41841AA7D659D626A62E2098A2@njexch01.imany.com>
 <20120510143911.GB14711@sigill.intra.peff.net>
 <1336740319206-7550370.post@n2.nabble.com>
 <20120511172214.GC26916@sigill.intra.peff.net>
 <1336818392259-7553161.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sitaram Chamarty <sitaramc@gmail.com>, git@vger.kernel.org
To: supadhyay <supadhyay@imany.com>
X-From: git-owner@vger.kernel.org Mon May 14 19:34:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1STz9r-0002Hr-Md
	for gcvg-git-2@plane.gmane.org; Mon, 14 May 2012 19:34:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757365Ab2ENReB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 May 2012 13:34:01 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:42912
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756604Ab2ENReA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2012 13:34:00 -0400
Received: (qmail 23249 invoked by uid 107); 14 May 2012 17:34:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 14 May 2012 13:34:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 May 2012 13:33:58 -0400
Content-Disposition: inline
In-Reply-To: <1336818392259-7553161.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197790>

On Sat, May 12, 2012 at 03:26:32AM -0700, supadhyay wrote:

> 2- from gitolite_home I run below command
> git clone ssh://git@mygitserver.com/ora/data/test.git
> (tis is do the clone of my repository so I can see the actual data inside
> the repository)

As I mentioned before, this should probably be a --mirror clone to get
all of the remote branches, and to create a bare repository. I don't use
gitolite, so perhaps there is some need I don't know about for it to
have a working tree. But in general, I would think having a non-bare
repository would be a problem here, as it would prevent pushes to the
checked-out branch (but again, maybe there is some gitolite-specific
thing I am missing).

-Peff
