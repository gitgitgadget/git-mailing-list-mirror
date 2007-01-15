From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-pull: disallow implicit merging to detached HEAD
Date: Mon, 15 Jan 2007 17:28:54 -0500
Message-ID: <20070115222854.GA12950@coredump.intra.peff.net>
References: <7vk5zo0ws1.fsf@assigned-by-dhcp.cox.net> <20070115222533.GA12928@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 15 23:29:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6aK3-0007To-PY
	for gcvg-git@gmane.org; Mon, 15 Jan 2007 23:29:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbXAOW25 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Jan 2007 17:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751489AbXAOW25
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 17:28:57 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2894 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751460AbXAOW24 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 17:28:56 -0500
Received: (qmail 1691 invoked from network); 15 Jan 2007 17:29:12 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 15 Jan 2007 17:29:12 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Jan 2007 17:28:54 -0500
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20070115222533.GA12928@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36897>

On Mon, Jan 15, 2007 at 05:25:33PM -0500, Jeff King wrote:

> +	  1) echo >&2 "You are not currently on a branch; you must explicitly"
> +	     echo >&2 "indicate which branch you wish to merge with"
> +	     echo >&2 "  git pull <remote> <branch>"

Urgh. Apparently using --amend is too challenging for me. I think it is
slightly clearer for the second line to read:
  "specify which branch you wish to merge:"

-Peff
