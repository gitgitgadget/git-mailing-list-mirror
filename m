From: Jeff King <peff@peff.net>
Subject: Re: [RFC] Cache negative delta pairs
Date: Thu, 29 Jun 2006 17:35:03 -0400
Message-ID: <20060629213503.GA15604@coredump.intra.peff.net>
References: <20060628223744.GA24421@coredump.intra.peff.net> <7v4py4y7wo.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0606291053280.1213@localhost.localdomain> <20060629180011.GA4392@coredump.intra.peff.net> <Pine.LNX.4.64.0606291410420.1213@localhost.localdomain> <20060629185335.GA6704@coredump.intra.peff.net> <Pine.LNX.4.64.0606291458110.1213@localhost.localdomain> <20060629195201.GA10786@coredump.intra.peff.net> <Pine.LNX.4.64.0606291616480.1213@localhost.localdomain> <Pine.LNX.4.64.0606291352110.12404@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 29 23:35:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fw4AJ-0008GA-Ln
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 23:35:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932746AbWF2VfH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 17:35:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932745AbWF2VfG
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 17:35:06 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:30867 "HELO
	peff.net") by vger.kernel.org with SMTP id S932746AbWF2VfF (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Jun 2006 17:35:05 -0400
Received: (qmail 11034 invoked from network); 29 Jun 2006 17:34:43 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 29 Jun 2006 17:34:43 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Jun 2006 17:35:03 -0400
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606291352110.12404@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22910>

On Thu, Jun 29, 2006 at 02:04:01PM -0700, Linus Torvalds wrote:

> Instead of having a separate cache, wouldn't it be much better to just 
> take the hint from the previous pack-file?

I'd like to second Nicolas' "DOH!".

This drops my nasty load with roughly the same effect as the delta
cache, and it does the same for the kernel repo. And it doesn't consume
any extra disk space. Junio, please drop my delta-cache patch in favor
of Linus' patch.

-Peff
