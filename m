From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH 4/4] Add support for 'namespace' history simplification
Date: Tue, 4 Nov 2008 22:33:35 +0100
Message-ID: <20081104213335.GA19886@localhost>
References: <200811031439.12111.brian.foster@innova-card.com> <alpine.LFD.2.00.0811031129060.3419@nehalem.linux-foundation.org> <alpine.LFD.2.00.0811031132520.3419@nehalem.linux-foundation.org> <alpine.LFD.2.00.0811031133590.3419@nehalem.linux-foundation.org> <alpine.LFD.2.00.0811031135410.3419@nehalem.linux-foundation.org> <alpine.LFD.2.00.0811031139520.3419@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Foster <brian.foster@innova-card.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Nov 04 22:34:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxTY2-00012j-HG
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 22:34:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753731AbYKDVdg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 16:33:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753236AbYKDVdg
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 16:33:36 -0500
Received: from postman.fh-hagenberg.at ([193.170.124.96]:15856 "EHLO
	mail.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752472AbYKDVdg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 16:33:36 -0500
Received: from darc.dyndns.org ([84.154.77.179]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 4 Nov 2008 22:33:31 +0100
Received: from drizzd by darc.dyndns.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1KxTWp-0005J5-GW; Tue, 04 Nov 2008 22:33:35 +0100
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0811031139520.3419@nehalem.linux-foundation.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 04 Nov 2008 21:33:34.0295 (UTC) FILETIME=[FD6B4E70:01C93EC4]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100107>

On Mon, Nov 03, 2008 at 11:43:00AM -0800, Linus Torvalds wrote:
> 	gitk --simplify-namespace

Very nice. git log --graph seems to give slightly different results though.
In particular, in git.git if I do

git for-each-ref --format="%(refname)" refs/remotes/origin | \
xargs git log --simplify-namespace --graph --pretty='format:%H%n' | \
git name-rev --stdin --name-only | \
less

some of the history is not connected. Is this a known limitation of
git log --graph?
