From: Jeff King <peff@peff.net>
Subject: Re: git diff with add/modified codes
Date: Sat, 28 Jul 2007 00:39:01 -0400
Message-ID: <20070728043901.GB11916@coredump.intra.peff.net>
References: <9e4733910707271505x4eac928axe639308afed20cb3@mail.gmail.com> <7vir85whxy.fsf@assigned-by-dhcp.cox.net> <9e4733910707271717q5ea33b55r227d8dbb1023de47@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 28 06:39:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEe5N-0004jF-F2
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 06:39:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750989AbXG1EjG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jul 2007 00:39:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750917AbXG1EjF
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jul 2007 00:39:05 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4443 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750887AbXG1EjE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2007 00:39:04 -0400
Received: (qmail 10917 invoked from network); 28 Jul 2007 04:39:02 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 28 Jul 2007 04:39:02 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 28 Jul 2007 00:39:01 -0400
Content-Disposition: inline
In-Reply-To: <9e4733910707271717q5ea33b55r227d8dbb1023de47@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53991>

On Fri, Jul 27, 2007 at 08:17:54PM -0400, Jon Smirl wrote:

> That's not what I want. I'm looking a report that indicates new files
> vs modified ones in a single list. These old patches I am working with
> often create 100 files and modify another 200.
> 
> Adding a code like (Added (A), Copied (C), Deleted (D), Modified (M),
> Renamed (R))  to --stat would be perfect.

How about --name-status?

-Peff
