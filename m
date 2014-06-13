From: Jeff King <peff@peff.net>
Subject: Re: git rebase --skip stuck in a loop
Date: Fri, 13 Jun 2014 03:34:46 -0400
Message-ID: <20140613073446.GF7908@sigill.intra.peff.net>
References: <5397551C.4030709@ubuntu.com>
 <539A151C.50307@ubuntu.com>
 <20140613010256.GD368384@vauxhall.crustytoothpaste.net>
 <539A50F2.40206@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Phillip Susi <psusi@ubuntu.com>
X-From: git-owner@vger.kernel.org Fri Jun 13 09:34:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvM0h-0004qV-Nl
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 09:34:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbaFMHes (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 03:34:48 -0400
Received: from cloud.peff.net ([50.56.180.127]:43244 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750784AbaFMHer (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 03:34:47 -0400
Received: (qmail 9651 invoked by uid 102); 13 Jun 2014 07:34:48 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 13 Jun 2014 02:34:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Jun 2014 03:34:46 -0400
Content-Disposition: inline
In-Reply-To: <539A50F2.40206@ubuntu.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251526>

On Thu, Jun 12, 2014 at 09:16:34PM -0400, Phillip Susi wrote:

> > I'm assuming this works in the general case, because we have tests
> > for it.  Do you perhaps have a repository and a set of reproduction
> > steps we could use to try to reproduce this?
> > 
> > If you can get that information, I'm interested in trying to fix
> > it.
> 
> I don't have a set of reproduction steps, but I do still have the repo
> that is in this stuck state if there is any data you might want me to
> pull out of it ( .git/rebase-apply? ).

Thanks for saving the stuck state.

If it's possible to share the whole repo, it might be worth seeing (then
we can all just run "git rebase --continue" ourselves). If it's too big
or is confidential, just tarring up .git/rebase-apply and making it
available is probably a good first step.

-Peff
