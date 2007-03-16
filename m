From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: cleaner/better zlib sources?
Date: Fri, 16 Mar 2007 23:45:42 +0100
Message-ID: <200703162345.42784.Josef.Weidendorfer@gmx.de>
References: <20070316060841.19946.qmail@science.horizon.com> <Pine.LNX.4.64.0703160841360.3816@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: linux@horizon.com, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Mar 16 23:45:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSLBJ-0003tG-Is
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 23:45:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992442AbXCPWpq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 18:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992448AbXCPWpq
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 18:45:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:44726 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S2992442AbXCPWpp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 18:45:45 -0400
Received: (qmail invoked by alias); 16 Mar 2007 22:45:43 -0000
X-Provags-ID: V01U2FsdGVkX1/kDBI+IlLkvI4TxWpr4yWDa82RoXox4E6lnUMSRe
	ee+I71RHkXSLsa
User-Agent: KMail/1.9.6
In-Reply-To: <Pine.LNX.4.64.0703160841360.3816@woody.linux-foundation.org>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42402>

On Friday 16 March 2007, Linus Torvalds wrote:
> (Btw, to get this level of detail, you need to link statically, at least 
> if you are using Fedora Core. If you do the normal dynamic linking, 
> oprofile will not be able to show you which function, and will just say 
> that 50% of all time was spent in libz.so.1.2.3).

I see the same here on OpenSuse 10.2.
This is because opreport currently does not take symbols from the dynamic
symbol table into account. Patching the symbol loader (I just send a
patch to the oprofile mailing list), I get the same detail with dynamic
linking.

Josef
