From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH 3/3] http-push: send out fetch requests on queue
Date: Sat, 30 May 2009 11:37:17 +0200
Message-ID: <20090530093717.GA22129@localhost>
References: <49F1EA6D.8080406@gmail.com> <20090530091755.GA13578@localhost> <be6fef0d0905300231k5167f3efle9a450419bdfa1cb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 30 11:37:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAL0Q-00089H-F1
	for gcvg-git-2@gmane.org; Sat, 30 May 2009 11:37:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754819AbZE3Jh0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 May 2009 05:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754355AbZE3JhZ
	(ORCPT <rfc822;git-outgoing>); Sat, 30 May 2009 05:37:25 -0400
Received: from postman.fh-hagenberg.at ([193.170.124.96]:40077 "EHLO
	mail.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752661AbZE3JhY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 May 2009 05:37:24 -0400
Received: from darc.dnsalias.org ([80.123.242.182]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 30 May 2009 11:37:24 +0200
Received: from drizzd by darc.dnsalias.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1MAL09-0006Pz-Rb; Sat, 30 May 2009 11:37:17 +0200
Content-Disposition: inline
In-Reply-To: <be6fef0d0905300231k5167f3efle9a450419bdfa1cb@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 30 May 2009 09:37:25.0759 (UTC) FILETIME=[3DAF48F0:01C9E10A]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120342>

On Sat, May 30, 2009 at 05:31:36PM +0800, Tay Ray Chuan wrote:
> On Sat, May 30, 2009 at 5:17 PM, Clemens Buchacher <drizzd@aon.at> wrote:
> > The "http-push fetches packed objects" test of t5540 on pu either segfaults
> > or hangs indefinitely on my machine [1]. The bug is revealed by the added
> > line above in commit 0d71b15 (http-push: send out fetch requests on queue).
> 
> if you don't mind, could you try running this test on the
> http-fix-push-fetching branch in git://github.com/rctay/git.git and
> see if this still happens? It contains these patches only, applied on
> master.

Sure. The same thing happens.
