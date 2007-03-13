From: Jeff King <peff@peff.net>
Subject: Re: [RFC] git log --first-parent
Date: Tue, 13 Mar 2007 10:17:51 -0400
Message-ID: <20070313141750.GA26738@coredump.intra.peff.net>
References: <200703111505.l2BF54Kq006625@localhost.localdomain> <20070311160424.GA629@fieldses.org> <200703111815.l2BIFHbq010315@localhost.localdomain> <Pine.LNX.4.64.0703111309410.9690@woody.linux-foundation.org> <7vwt1nv6r5.fsf@assigned-by-dhcp.cox.net> <7vfy89ldyv.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Mar 13 15:18:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HR7pA-000216-Jc
	for gcvg-git@gmane.org; Tue, 13 Mar 2007 15:18:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030354AbXCMORy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Mar 2007 10:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030376AbXCMORy
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Mar 2007 10:17:54 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3507 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030354AbXCMORx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2007 10:17:53 -0400
Received: (qmail 24665 invoked from network); 13 Mar 2007 10:18:15 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 13 Mar 2007 10:18:15 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Mar 2007 10:17:51 -0400
Content-Disposition: inline
In-Reply-To: <7vfy89ldyv.fsf_-_@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42117>

On Tue, Mar 13, 2007 at 01:55:36AM -0700, Junio C Hamano wrote:

> 	$ git log --first-parent master..jc/fetch

You might recall the 25-way hydra merge I was discussing a few weeks
ago. I ended up simply making a series of pair-wise merges; this
"--first-parent" option is the perfect tool for visualizing it,
especially "gitk --first-parent". Please consider merging it.

-Peff
