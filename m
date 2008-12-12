From: Jeff King <peff@peff.net>
Subject: Re: user-manual.html invalid HTML
Date: Thu, 11 Dec 2008 21:30:04 -0500
Message-ID: <20081212023003.GD23128@sigill.intra.peff.net>
References: <87ej0qf3gx.fsf@jidanni.org> <87skouzc4w.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: jidanni@jidanni.org
X-From: git-owner@vger.kernel.org Fri Dec 12 03:31:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAxoP-0001To-Hb
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 03:31:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756986AbYLLCaK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 21:30:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757089AbYLLCaK
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 21:30:10 -0500
Received: from peff.net ([208.65.91.99]:3263 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756940AbYLLCaJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2008 21:30:09 -0500
Received: (qmail 31511 invoked by uid 111); 12 Dec 2008 02:30:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 11 Dec 2008 21:30:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Dec 2008 21:30:04 -0500
Content-Disposition: inline
In-Reply-To: <87skouzc4w.fsf@jidanni.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102862>

On Fri, Dec 12, 2008 at 04:32:15AM +0800, jidanni@jidanni.org wrote:

> Please see http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=507476
> Which it turns out didn't get forwarded to git@vger.kernel.org after all. 

The versions I build locally have:

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN"
    "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">

in each HTML file, which is added by asciidoc.  Maybe the package you
are looking at was built with an older version of asciidoc that doesn't
do this (I don't actually know the history of this feature, but it seems
to me that this is something asciidoc should be doing, not git).

-Peff
