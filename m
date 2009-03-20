From: Jeff King <peff@peff.net>
Subject: Re: git am from scratch
Date: Fri, 20 Mar 2009 00:39:22 -0400
Message-ID: <20090320043922.GB27160@coredump.intra.peff.net>
References: <200903191609.24812.agruen@suse.de> <200903192142.49754.agruen@suse.de> <20090319210214.GA17589@coredump.intra.peff.net> <200903200206.24555.agruen@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Andreas Gruenbacher <agruen@suse.de>
X-From: git-owner@vger.kernel.org Fri Mar 20 05:41:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkWXV-0002GM-I2
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 05:41:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751681AbZCTEjd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 00:39:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751048AbZCTEjc
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 00:39:32 -0400
Received: from peff.net ([208.65.91.99]:46220 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750703AbZCTEjc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2009 00:39:32 -0400
Received: (qmail 6576 invoked by uid 107); 20 Mar 2009 04:39:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 20 Mar 2009 00:39:40 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Mar 2009 00:39:22 -0400
Content-Disposition: inline
In-Reply-To: <200903200206.24555.agruen@suse.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113893>

On Fri, Mar 20, 2009 at 02:06:24AM +0100, Andreas Gruenbacher wrote:

> On Thursday, 19 March 2009 22:02:14 Jeff King wrote:
> > Yikes. Out of curiosity, what did you use to do the CVS import?
> 
> git-cvsimport

Ah. It sounds like you have already resolved all of your issues by
munging the resulting history, but you may have better success on a
complex history with a different tool like cvs2git or parsecvs (even if
you have fixed it, you may want to investigate them to double-check your
result).

-Peff
