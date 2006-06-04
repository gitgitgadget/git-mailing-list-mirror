From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Importing Mozilla CVS into git
Date: Sun, 4 Jun 2006 13:00:15 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606041256480.5498@g5.osdl.org>
References: <9e4733910606011521n106f8f24s6c7053ce51e3791e@mail.gmail.com>
 <e5u0o0$3rm$1@sea.gmane.org> <Pine.LNX.4.64.0606041050010.5498@g5.osdl.org>
 <200606042144.45385.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 04 22:01:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FmymJ-0000Ot-Bu
	for gcvg-git@gmane.org; Sun, 04 Jun 2006 22:00:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbWFDUAl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Jun 2006 16:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750764AbWFDUAl
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jun 2006 16:00:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60104 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750749AbWFDUAk (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Jun 2006 16:00:40 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k54K0P2g007048
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 4 Jun 2006 13:00:28 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k54K0G9G023075;
	Sun, 4 Jun 2006 13:00:20 -0700
To: "Robin Rosenberg (list subscriber)" 
	<robin.rosenberg.lists@dewire.com>
In-Reply-To: <200606042144.45385.robin.rosenberg.lists@dewire.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21280>



On Sun, 4 Jun 2006, Robin Rosenberg (list subscriber) wrote:
> 
> Other version control systems simply treat text and binary files differently. 
> No smart(ass) logic doing the wrong thing.

Treating text and binary file differently _is_ the "smart(ass) logic doing 
the wrong thing".

Git really shouldn't do that. The patch was meant to show how you really 
don't need to - the internal objects would never be "binary vs text", 
there would be a way to just basically map one onto another.

> > I'm absolutely _not_ suggesting merging that patch as-is or even in any
> > form very close to it. It clearly needs a config file entry with filename
> > patterns etc at a minimum.
> 
> Do people apply your patches right away, like it's some god-like commandments?

What's your problem here, exactly? 

I was just trying to point out that my patch was an example, where 
somebody who cares (not me) can use it as a starting point.

If you can't be civil, at least be quiet, ok?

		Linus
