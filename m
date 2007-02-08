From: Jeff King <peff@peff.net>
Subject: Re: git log filtering
Date: Thu, 8 Feb 2007 17:33:37 -0500
Message-ID: <20070208223336.GA9422@coredump.intra.peff.net>
References: <68948ca0702070841m76817d9el7ce2ec69835c50e@mail.gmail.com> <Pine.LNX.4.64.0702070856190.8424@woody.linux-foundation.org> <Pine.LNX.4.63.0702071822430.22628@wbgn013.biozentrum.uni-wuerzburg.de> <7v64ad7l12.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702071257490.8424@woody.linux-foundation.org> <7vps8l65fh.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702071334060.8424@woody.linux-foundation.org> <20070208061654.GA8813@coredump.intra.peff.net> <Pine.LNX.4.63.0702081905570.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 08 23:33:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFHpn-0006uP-Vk
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 23:33:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423497AbXBHWdk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 17:33:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423499AbXBHWdk
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 17:33:40 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1959 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1423497AbXBHWdj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 17:33:39 -0500
Received: (qmail 23576 invoked from network); 8 Feb 2007 17:33:41 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 8 Feb 2007 17:33:41 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Feb 2007 17:33:37 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0702081905570.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39111>

On Thu, Feb 08, 2007 at 07:06:25PM +0100, Johannes Schindelin wrote:

> May I register a complaint? This is yet _another_ dependency.

Unlike other dependencies, I think it's quite natural to make it a
conditional dependency. If you have pcre, you get more featureful
regular expressions. If you don't, you get posix regular expressions.
Do you object to a few extra lines in the Makefile?

-Peff
