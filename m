From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] --pretty=format: print fewer <unknown>s
Date: Wed, 28 Mar 2007 18:17:54 -0400
Message-ID: <20070328221754.GB25430@coredump.intra.peff.net>
References: <20070328220914.GA25389@coredump.intra.peff.net> <7v3b3pf245.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Mar 29 00:18:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWgSv-0005gN-0C
	for gcvg-git@gmane.org; Thu, 29 Mar 2007 00:18:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933859AbXC1WR5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Mar 2007 18:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933879AbXC1WR5
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Mar 2007 18:17:57 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2103 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933859AbXC1WR4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2007 18:17:56 -0400
Received: (qmail 14945 invoked from network); 28 Mar 2007 22:18:27 -0000
Received: from coredump.intra.peff.net (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 28 Mar 2007 22:18:27 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Mar 2007 18:17:54 -0400
Content-Disposition: inline
In-Reply-To: <7v3b3pf245.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43397>

On Wed, Mar 28, 2007 at 03:13:30PM -0700, Junio C Hamano wrote:

> > This makes empty bodies truly empty, and fills in the
> > default UTF-8 encoding for an empty encoding.
> 
> I do not think the latter is correct.  Replacing with an empty
> string might make sense, although I haven't thought through the
> issues.

Fair enough. I originally put in an empty string, but tried to be (too)
clever with UTF-8 (I was under the impression that commits without
headers were assumed to be in UTF-8, unless there is some legacy
override set). I'm fine with whatever makes sense, but I think printing
<unknown> is silly: we _do_ know.

-Peff
