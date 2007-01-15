From: Jeff King <peff@peff.net>
Subject: Re: git-fetch while on "(no branch)"
Date: Mon, 15 Jan 2007 17:01:11 -0500
Message-ID: <20070115220111.GA7933@coredump.intra.peff.net>
References: <200701151009.51868.andyparkins@gmail.com> <7vzm8k0xai.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 15 23:01:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6ZtE-0007je-HD
	for gcvg-git@gmane.org; Mon, 15 Jan 2007 23:01:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbXAOWBO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Jan 2007 17:01:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbXAOWBO
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 17:01:14 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3779 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751363AbXAOWBN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 17:01:13 -0500
Received: (qmail 31849 invoked from network); 15 Jan 2007 17:01:28 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 15 Jan 2007 17:01:28 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Jan 2007 17:01:11 -0500
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vzm8k0xai.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36889>

On Mon, Jan 15, 2007 at 01:56:05PM -0800, Junio C Hamano wrote:

> -'git-symbolic-ref' <name> [<ref>]
> +'git-symbolic-ref' [-q] <name> [<ref>]

Please ignore my patch in this thread; yours is much more sensible.
However, if you do go this route, note that git-pull needs to use the
'-q' flag as well.

-Peff
