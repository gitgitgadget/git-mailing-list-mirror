From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-clone: use cpio's --quiet flag
Date: Sat, 4 Aug 2007 13:52:40 -0400
Message-ID: <20070804175240.GB17113@sigill.intra.peff.net>
References: <20070804070308.GA6493@coredump.intra.peff.net> <Pine.LNX.4.64.0708041636290.14781@racer.site> <20070804160409.GA16326@sigill.intra.peff.net> <7vwswbgphu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 04 19:52:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHNo8-0005y5-U0
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 19:52:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764944AbXHDRwp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 13:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764923AbXHDRwp
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 13:52:45 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1543 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764943AbXHDRwo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 13:52:44 -0400
Received: (qmail 1223 invoked from network); 4 Aug 2007 17:52:48 -0000
Received: from unknown (HELO sigill.intra.peff.net) (10.0.0.7)
  by peff.net with (DHE-RSA-AES256-SHA encrypted) SMTP; 4 Aug 2007 17:52:48 -0000
Received: (qmail 17318 invoked by uid 1000); 4 Aug 2007 17:52:40 -0000
Content-Disposition: inline
In-Reply-To: <7vwswbgphu.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54890>

On Sat, Aug 04, 2007 at 10:48:29AM -0700, Junio C Hamano wrote:

> I was hoping that we can say that the output is analogous to the
> native transport reporting "Conting objects: XXXX" and stuff...

It always says "0 blocks" for me, which looks a bit like an error (but
the clone seems to work fine).

-Peff
