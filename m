From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Using Origin hashes to improve rebase behavior
Date: Sat, 12 Feb 2011 15:36:25 +0100
Message-ID: <201102121536.25789.trast@student.ethz.ch>
References: <m21v3fvbix.fsf@hermes.luannocracy.com> <20110210225428.GA21335@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: John Wiegley <johnw@boostpro.com>, <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 12 15:36:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PoGaV-0007JA-2A
	for gcvg-git-2@lo.gmane.org; Sat, 12 Feb 2011 15:36:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752945Ab1BLOgd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Feb 2011 09:36:33 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:22150 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752729Ab1BLOgb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Feb 2011 09:36:31 -0500
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.270.1; Sat, 12 Feb
 2011 15:36:23 +0100
Received: from pctrast.inf.ethz.ch (129.132.210.239) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.270.1; Sat, 12 Feb
 2011 15:36:29 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.37-9-desktop; KDE/4.5.4; x86_64; ; )
In-Reply-To: <20110210225428.GA21335@sigill.intra.peff.net>
X-Originating-IP: [129.132.210.239]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166614>

[I skipped most of the thread, so here's just one minor point.]

Jeff King wrote:
> I hadn't thought about merge --squash as a commit copying operation, but
> I think it is. I wonder if squash merges (or squash rebases) should also
> be copying notes (or if they do already, I haven't checked).

Squash rebases do but squash merges don't.  Doing it "elegantly" would
probably involve caching the list of commits since the merge-bases,
which would be a bit of work.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
