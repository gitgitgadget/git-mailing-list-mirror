From: Jeff King <peff@peff.net>
Subject: Re: ghost refs
Date: Thu, 8 Apr 2010 15:49:08 -0400
Message-ID: <20100408194908.GB4222@sigill.intra.peff.net>
References: <89030B4A18ECCD45978A3A6B639D1F24032A074E1C@FL01EXMB01.trad.tradestation.com>
 <r2h32541b131004070958pa66bb7a3g6a1ecfaea0419965@mail.gmail.com>
 <20100407210010.GB27012@coredump.intra.peff.net>
 <89030B4A18ECCD45978A3A6B639D1F24032A0750BE@FL01EXMB01.trad.tradestation.com>
 <k2p32541b131004071503g4ce66e5bjac8270b10790a2af@mail.gmail.com>
 <89030B4A18ECCD45978A3A6B639D1F24032A0750CC@FL01EXMB01.trad.tradestation.com>
 <k2x32541b131004071511i9bbe883az504547d6133aef@mail.gmail.com>
 <20100408043059.GA28768@coredump.intra.peff.net>
 <89030B4A18ECCD45978A3A6B639D1F24032A075390@FL01EXMB01.trad.tradestation.com>
 <7vwrwh6fz8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: John Dlugosz <JDlugosz@TradeStation.com>, git@vger.kernel.org,
	Avery Pennarun <apenwarr@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 08 21:49:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nzxj4-0007yl-5e
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 21:49:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933144Ab0DHTtM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Apr 2010 15:49:12 -0400
Received: from peff.net ([208.65.91.99]:51951 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933028Ab0DHTtL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Apr 2010 15:49:11 -0400
Received: (qmail 26060 invoked by uid 107); 8 Apr 2010 19:49:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 08 Apr 2010 15:49:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Apr 2010 15:49:09 -0400
Content-Disposition: inline
In-Reply-To: <7vwrwh6fz8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144376>

On Thu, Apr 08, 2010 at 09:55:55AM -0700, Junio C Hamano wrote:

> John Dlugosz <JDlugosz@TradeStation.com> writes:
> 
> > In git-branch,
> >
> > 	-l
> >
> > 	    Create the branch's reflog. This activates recording of all
> > 	    changes made to the branch ref, enabling use of date based
> > 	    sha1 expressions such as "<branchname>@{yesterday}".
> 
> That is how you selectively enable reflog for that particular branch when
> you have explicitly disabled "reflog by default" with the configuration.

Maybe:

-- >8 --
Subject: [PATCH] docs: clarify "branch -l"

This option is mostly useless these days because we turn on
reflogs by default in non-bare repos.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-branch.txt |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 903a690..d78f4c7 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -72,6 +72,8 @@ OPTIONS
 	Create the branch's reflog.  This activates recording of
 	all changes made to the branch ref, enabling use of date
 	based sha1 expressions such as "<branchname>@\{yesterday}".
+	Note that in non-bare repositories, reflogs are usually
+	enabled by default by the `core.logallrefupdates` config option.
 
 -f::
 --force::
-- 
1.7.1.rc0.248.g055378.dirty
