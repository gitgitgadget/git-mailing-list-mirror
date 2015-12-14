From: Jeff King <peff@peff.net>
Subject: Re: query regarding git merge
Date: Mon, 14 Dec 2015 16:13:21 -0500
Message-ID: <20151214211320.GE14788@sigill.intra.peff.net>
References: <loom.20151213T185500-631@post.gmane.org>
 <20151213181800.GK990758@vauxhall.crustytoothpaste.net>
 <CAGkBSDLMCZR=qrXJKTgpzGGQdogXHN+0Ub8qW=aPq80RjjN=5w@mail.gmail.com>
 <20151213192316.GM990758@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
To: Rohit Gupta <roborohitgupta75@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 14 22:13:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8aR1-0005xj-4p
	for gcvg-git-2@plane.gmane.org; Mon, 14 Dec 2015 22:13:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932385AbbLNVN0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 16:13:26 -0500
Received: from cloud.peff.net ([50.56.180.127]:41510 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932075AbbLNVNX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 16:13:23 -0500
Received: (qmail 18653 invoked by uid 102); 14 Dec 2015 21:13:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 14 Dec 2015 15:13:23 -0600
Received: (qmail 31756 invoked by uid 107); 14 Dec 2015 21:13:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 14 Dec 2015 16:13:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Dec 2015 16:13:21 -0500
Content-Disposition: inline
In-Reply-To: <20151213192316.GM990758@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282417>

On Sun, Dec 13, 2015 at 07:23:17PM +0000, brian m. carlson wrote:

> On Mon, Dec 14, 2015 at 12:03:18AM +0530, Rohit Gupta wrote:
> > Thanks brian. I understood my mistake in understanding the working of git
> > merge.
> > But isn't it wrong? As after merging, branch's logic can't work. How to get
> > that right then ?
> 
> If you know that the merge didn't go the way you wanted, you can either
> add a follow-up commit, or you can do "git commit --amend" on the merge
> after making the necessary changes.  In such a case, it may be useful to
> add a note to the commit message stating that you modified it from the
> original merge.

And a fundamental takeaway here is that git-merge can only find
_textual_ conflicts. It is up to the user to determine that the merge
didn't introduce any _semantic_ conflicts. For example, by building and
testing the result, which is out of git's scope.

-Peff
