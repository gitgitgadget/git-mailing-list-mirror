From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] cogito: Avoid slowness when timewarping large trees.
Date: Sat, 25 Mar 2006 04:36:41 -0500
Message-ID: <20060325093641.GA26284@coredump.intra.peff.net>
References: <20060324084423.GA30213@coredump.intra.peff.net> <7vd5gc16u2.fsf@assigned-by-dhcp.cox.net> <20060324105543.GA2543@coredump.intra.peff.net> <7v3bh814z4.fsf@assigned-by-dhcp.cox.net> <20060324112246.GA5220@coredump.intra.peff.net> <20060324164352.GA20684@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Mar 25 10:36:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FN5CQ-0001oZ-Ix
	for gcvg-git@gmane.org; Sat, 25 Mar 2006 10:36:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbWCYJgo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Mar 2006 04:36:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751129AbWCYJgo
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Mar 2006 04:36:44 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:31711 "EHLO
	peff.net") by vger.kernel.org with ESMTP id S1751126AbWCYJgn (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Mar 2006 04:36:43 -0500
Received: (qmail 72410 invoked from network); 25 Mar 2006 09:36:41 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 0 with SMTP; 25 Mar 2006 09:36:41 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 25 Mar 2006 04:36:41 -0500
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060324164352.GA20684@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17967>

On Fri, Mar 24, 2006 at 11:43:52AM -0500, Shawn Pearce wrote:

> Now that I think about it isn't this sort of where you were before
> in cg-seek?

Yes, that's basically it. Short of Junio explaining how the manual file
removal can be avoided, I think my original patch should be applied, as
it causes an order of magnitude speed up. I will repost the cleaned-up
version.

-Peff
