From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH v2 00/12] add --ff option to cherry-pick
Date: Sun, 28 Feb 2010 23:42:43 -0500 (EST)
Message-ID: <alpine.LNX.2.00.1002282327470.14365@iabervon.org>
References: <20100228222038.2260.25016.chriscool@tuxfamily.org> <7v3a0kg0qv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Paolo Bonzini <bonzini@gnu.org>,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 01 05:42:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlxT7-00058R-VA
	for gcvg-git-2@lo.gmane.org; Mon, 01 Mar 2010 05:42:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753624Ab0CAEmv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2010 23:42:51 -0500
Received: from iabervon.org ([66.92.72.58]:47338 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753090Ab0CAEmu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2010 23:42:50 -0500
Received: (qmail 2443 invoked by uid 1000); 1 Mar 2010 04:42:43 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 1 Mar 2010 04:42:43 -0000
In-Reply-To: <7v3a0kg0qv.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141298>

On Sun, 28 Feb 2010, Junio C Hamano wrote:

> Given that "rebase--interactive", which is the sole in-tree user of
> cherry-pick, has its own fast-forwarding logic to skip call to it, it
> seems to take too much time out of me to deal with the code churn for
> dubious benefit---the series does not seem to solve any real problem.

"git cherry-pick" is a porcelain command, so it shouldn't be evaluated on 
the basis of in-tree users, but on whether people running it from the 
command line would find it helpful.

Of course, I don't think it's especially high-value there, either.

	-Daniel
*This .sig left intentionally blank*
