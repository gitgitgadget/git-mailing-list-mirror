From: Jeff King <peff@peff.net>
Subject: Re: something like git-for-each-ref's --format for commits?
Date: Sun, 6 Jan 2008 04:05:07 -0500
Message-ID: <20080106090507.GA10965@coredump.intra.peff.net>
References: <20080106085221.GA1729@bulgaria.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brian Swetland <swetland@google.com>
X-From: git-owner@vger.kernel.org Sun Jan 06 10:06:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBRSB-0000qF-7E
	for gcvg-git-2@gmane.org; Sun, 06 Jan 2008 10:05:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752709AbYAFJFM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2008 04:05:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752686AbYAFJFL
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jan 2008 04:05:11 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4209 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752563AbYAFJFK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2008 04:05:10 -0500
Received: (qmail 27468 invoked by uid 111); 6 Jan 2008 09:05:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 06 Jan 2008 04:05:08 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 06 Jan 2008 04:05:07 -0500
Content-Disposition: inline
In-Reply-To: <20080106085221.GA1729@bulgaria.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69719>

On Sun, Jan 06, 2008 at 12:52:21AM -0800, Brian Swetland wrote:

> The --pretty=format:... option for git-log, etc has the annoying
> property of giving you <unknown> instead of an empty string if an
> item isn't example (say if you use %b on a commit with no body).
> 
> Am I missing some obvious solution here?  

I think --pretty=format: is what you are looking for. The "<unknown>"
behavior is fixed in the upcoming v1.5.4 (you get the empty string for
your example).

-Peff
