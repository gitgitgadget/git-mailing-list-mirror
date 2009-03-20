From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4] Introduce %<branch> as shortcut to the tracked
	branch
Date: Fri, 20 Mar 2009 16:50:27 -0400
Message-ID: <20090320205027.GA28804@coredump.intra.peff.net>
References: <alpine.DEB.1.00.0903200121330.10279@pacific.mpi-cbg.de> <alpine.DEB.1.00.0903200137230.10279@pacific.mpi-cbg.de> <20090320004029.GX23521@spearce.org> <20090320004450.GY23521@spearce.org> <alpine.DEB.1.00.0903201027450.10279@pacific.mpi-cbg.de> <alpine.DEB.1.00.0903201714020.10279@pacific.mpi-cbg.de> <7v7i2ki0sw.fsf@gitster.siamese.dyndns.org> <7vwsakgjie.fsf@gitster.siamese.dyndns.org> <20090320193650.GA26934@coredump.intra.peff.net> <alpine.LNX.2.00.0903202022560.12211@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Petr Baudis <pasky@suse.cz>,
	Andreas Gruenbacher <agruen@suse.de>, B.Steinbrink@gmx.de,
	git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Fri Mar 20 21:52:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lklhc-0008DF-O0
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 21:52:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbZCTUum (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 16:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753150AbZCTUul
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 16:50:41 -0400
Received: from peff.net ([208.65.91.99]:37433 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753018AbZCTUuk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2009 16:50:40 -0400
Received: (qmail 10888 invoked by uid 107); 20 Mar 2009 20:50:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 20 Mar 2009 16:50:49 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Mar 2009 16:50:27 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.0903202022560.12211@reaper.quantumfyre.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114005>

On Fri, Mar 20, 2009 at 08:28:28PM +0000, Julian Phillips wrote:

>> I think that is quite clever and doesn't have any meaning for a revision
>> specifier already. I like it.
>
> I considered suggesting this earlier, but didn't as the behaviour is not  
> consistent.  If you have a user named master then you have to type  
> '~master' (including quotes), if you don't you can type ~master, and you  
> always have to type '~' instead of ~.  I didn't particularly fancy typing  
> all those quotes, and certainly not explaining the behaviour to people not 
> overly familiar with unix shell behaviour.

Oh, good point. I wasn't thinking it through. My initial thought was
that there is no problem conflicting with a file ~master/foo, since you
generally don't want to use absolute paths that are likely outside your
git repository. But of course the shell doesn't know this and will screw
you, which I failed to consider.

-Peff
