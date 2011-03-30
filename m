From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: GSOC idea: build in scripts and cleanups
Date: Wed, 30 Mar 2011 17:39:12 +0200
Message-ID: <201103301739.12691.trast@student.ethz.ch>
References: <201103260141.20798.robert.david.public@gmail.com> <201103281055.23578.robert.david.public@gmail.com> <20110328142121.GB14763@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Robert David <robert.david.public@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 30 17:39:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4xUO-0002vG-Ul
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 17:39:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755117Ab1C3PjP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 11:39:15 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:39942 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754807Ab1C3PjO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2011 11:39:14 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.289.1; Wed, 30 Mar
 2011 17:39:05 +0200
Received: from thomas.inf.ethz.ch (129.132.209.131) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.1.289.1; Wed, 30 Mar
 2011 17:39:12 +0200
User-Agent: KMail/1.13.6 (Linux/2.6.38-18-desktop; KDE/4.6.0; x86_64; ; )
In-Reply-To: <20110328142121.GB14763@sigill.intra.peff.net>
X-Originating-IP: [129.132.209.131]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170389>

Jeff King wrote:
> On Mon, Mar 28, 2011 at 10:55:22AM +0200, Robert David wrote:
> 
> > > As far as cleanup versus features, I think Thomas would have to comment
> > > on that. He is the one who did the most work on patch-mode, and
> > > therefore the one who most thinks it needs cleaned up. :)
> > 
> > Is Thomas going to be a mentor in this task?
> 
> I hope so. I can also co-mentor if it helps.

I'm certainly ready; I didn't propose any projects that I would not
also mentor.  (However, I won't mentor more than one...)

Note that while it's certainly a bonus, porting it to C probably makes
the project more difficult and time-consuming.  We'll have to see in
the proposal timelines however.

As for cleanup, my gut feeling right now is that the Perl code can
probably cope with incremental cleanups as required for each feature.
On the other hand, the C port should start from a clean redesign so as
to not rewrite it twice.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
