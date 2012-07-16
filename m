From: Jeff King <peff@peff.net>
Subject: Re: merge recursive and code movement
Date: Mon, 16 Jul 2012 08:26:40 -0400
Message-ID: <20120716122640.GC4962@sigill.intra.peff.net>
References: <AANLkTi=h6jUsjqXofd0QeWbNBjc9DeodJJ3FN7caW4XC@mail.gmail.com>
 <20110325093758.GA9047@sigill.intra.peff.net>
 <20110325101204.GB9047@sigill.intra.peff.net>
 <20110325111225.GC9047@sigill.intra.peff.net>
 <20110325160013.GA25851@sigill.intra.peff.net>
 <loom.20120716T021344-246@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Techlive Zheng <techlivezheng@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 16 14:26:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SqkO3-0002hs-L1
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jul 2012 14:26:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753202Ab2GPM0q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jul 2012 08:26:46 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:33141
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751484Ab2GPM0n (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2012 08:26:43 -0400
Received: (qmail 28948 invoked by uid 107); 16 Jul 2012 12:26:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 16 Jul 2012 08:26:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Jul 2012 08:26:40 -0400
Content-Disposition: inline
In-Reply-To: <loom.20120716T021344-246@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201516>

On Mon, Jul 16, 2012 at 12:17:26AM +0000, Techlive Zheng wrote:

> So, Is there any progress on these patches, I am currently need this
> functionality very much, will these be merged into master?

No. Turning on break detection in merge-recursive triggered bugs
elsewhere in merge-recursive. See these followup posts:

  http://article.gmane.org/gmane.comp.version-control.git/175932

  http://article.gmane.org/gmane.comp.version-control.git/175990

The merge-recursive code is sufficiently horrific that I have been
successfully putting off digging back into the problem for a whole
year. :)

Until those problems are resolved, the patches have too many regressions
to go into master.

-Peff

PS If you are going to reply to a year-old thread, it is probably a good
idea to give some context in your message, and to cc the involved
parties. Most of us use threaded mail readers, but not everybody keeps a
year of archives around. The original discussion and patches were here:

  http://thread.gmane.org/gmane.comp.version-control.git/169944
