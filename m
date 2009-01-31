From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] utf8: add utf8_strwidth()
Date: Sat, 31 Jan 2009 03:56:52 -0500
Message-ID: <20090131085652.GA6484@coredump.intra.peff.net>
References: <1233308489-2656-1-git-send-email-geofft@mit.edu> <20090131071711.GA3710@coredump.intra.peff.net> <alpine.DEB.2.00.0901310348000.3373@vinegar-pot.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Geoffrey Thomas <geofft@MIT.EDU>
X-From: git-owner@vger.kernel.org Sat Jan 31 10:00:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTBgC-0001Vo-Gw
	for gcvg-git-2@gmane.org; Sat, 31 Jan 2009 09:58:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751896AbZAaI4z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jan 2009 03:56:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751861AbZAaI4y
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Jan 2009 03:56:54 -0500
Received: from peff.net ([208.65.91.99]:56956 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751698AbZAaI4y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jan 2009 03:56:54 -0500
Received: (qmail 10946 invoked by uid 107); 31 Jan 2009 08:57:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 31 Jan 2009 03:57:04 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 31 Jan 2009 03:56:52 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.0901310348000.3373@vinegar-pot.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107915>

On Sat, Jan 31, 2009 at 03:51:48AM -0500, Geoffrey Thomas wrote:

> On Sat, 31 Jan 2009, Jeff King wrote:
>> I know next to nothing about our encoding functions, but this seems
>> suspiciously similar to utf8_width in utf8.c. There is also a
>> git_wcwidth, but I don't know how they relate.
>
> git_wcwidth determines the screen columns of a single ucs_char_t.  
> utf8_width returns the git_wcwidth of the first character in a string.  
> utf8_strwidth (the function added by this patch) is a simple loop around  
> utf8_width, because writing the loop every time would be silly.

Urgh. Sorry. If I had taken 3 seconds to actually _look_ at your patch,
I would have seen that (instead I thought "don't we already have
something that does this" and went straight to the existing code).

But no, it looks like we don't already have this, so your patch is fine.
Sorry for the noise.

-Peff
