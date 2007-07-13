From: Jeff King <peff@peff.net>
Subject: Re: failing to send patches to the list
Date: Fri, 13 Jul 2007 11:55:16 -0400
Message-ID: <20070713155516.GA2712@sigill.intra.peff.net>
References: <20070713093050.GA18001@lapse.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 13 17:55:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9NUH-000551-PM
	for gcvg-git@gmane.org; Fri, 13 Jul 2007 17:55:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760525AbXGMPzS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jul 2007 11:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757673AbXGMPzR
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jul 2007 11:55:17 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2019 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757594AbXGMPzQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2007 11:55:16 -0400
Received: (qmail 16394 invoked from network); 13 Jul 2007 15:55:42 -0000
Received: from unknown (HELO sigill.intra.peff.net) (10.0.0.7)
  by peff.net with (DHE-RSA-AES256-SHA encrypted) SMTP; 13 Jul 2007 15:55:42 -0000
Received: (qmail 2875 invoked by uid 1000); 13 Jul 2007 15:55:16 -0000
Content-Disposition: inline
In-Reply-To: <20070713093050.GA18001@lapse.madduck.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52400>

On Fri, Jul 13, 2007 at 11:30:50AM +0200, martin f krafft wrote:

>   git format-patch -s --stdout | sendmail git@vger.kernel.org
> 
> Even though my mail server seems to have delivered them correctly:
> [...]
> they never made it onto the list.

vger will reject messages without a message-id. git-format-patch by
default does not generate a message-id, so unless sendmail generates one
on the fly, that is your problem.

In general, git-format-patch output is probably not suitable for direct
sending...have you looked at git-send-email?

-Peff
