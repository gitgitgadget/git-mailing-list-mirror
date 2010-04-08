From: Jeff King <peff@peff.net>
Subject: Re: ghost refs
Date: Thu, 8 Apr 2010 00:30:59 -0400
Message-ID: <20100408043059.GA28768@coredump.intra.peff.net>
References: <89030B4A18ECCD45978A3A6B639D1F24032A074E1C@FL01EXMB01.trad.tradestation.com>
 <r2h32541b131004070958pa66bb7a3g6a1ecfaea0419965@mail.gmail.com>
 <20100407210010.GB27012@coredump.intra.peff.net>
 <89030B4A18ECCD45978A3A6B639D1F24032A0750BE@FL01EXMB01.trad.tradestation.com>
 <k2p32541b131004071503g4ce66e5bjac8270b10790a2af@mail.gmail.com>
 <89030B4A18ECCD45978A3A6B639D1F24032A0750CC@FL01EXMB01.trad.tradestation.com>
 <k2x32541b131004071511i9bbe883az504547d6133aef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: John Dlugosz <JDlugosz@tradestation.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 08 06:31:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzjOp-0001rl-Uf
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 06:31:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403Ab0DHEbW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Apr 2010 00:31:22 -0400
Received: from peff.net ([208.65.91.99]:34680 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750831Ab0DHEbW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Apr 2010 00:31:22 -0400
Received: (qmail 16055 invoked by uid 107); 8 Apr 2010 04:31:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 08 Apr 2010 00:31:19 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Apr 2010 00:30:59 -0400
Content-Disposition: inline
In-Reply-To: <k2x32541b131004071511i9bbe883az504547d6133aef@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144311>

On Wed, Apr 07, 2010 at 06:11:38PM -0400, Avery Pennarun wrote:

> On Wed, Apr 7, 2010 at 6:10 PM, John Dlugosz <JDlugosz@tradestation.com> wrote:
> > So do I still have to specify that I want a reflog when I create a branch, or does that always happen with local branches too?
> 
> Why not try it and find out?
> 
> I've never asked for a reflog explicitly and I seem to get them.

We create logs for remote branches when core.logallrefupdates is set
since e19b9dd (core.logallrefupdates: log remotes/ tracking branches.,
2006-12-28).

We turned on logallrefupdates by default in non-bare repositories in
0bee591 (Enable reflogs by default in any repository with a working
directory., 2006-12-14).

Both were in v1.5.0. So it used to not be the case that we created such
reflogs, but it has been for quite some time.

-Peff
