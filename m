From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Smart fetch via HTTP?
Date: Fri, 18 May 2007 11:27:22 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0705181123590.3890@woody.linux-foundation.org>
References: <20070515201006.GD3653@efreet.light.src> <20070517124006.GO4489@pasky.or.cz>
 <vpqlkfnipjl.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri May 18 20:29:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hp7Cb-0007eQ-7r
	for gcvg-git@gmane.org; Fri, 18 May 2007 20:29:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756516AbXERS26 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 14:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756325AbXERS26
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 14:28:58 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:55264 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756549AbXERS25 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 May 2007 14:28:57 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l4IIRR3c003409
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 18 May 2007 11:28:03 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l4IIRMWm020822;
	Fri, 18 May 2007 11:27:23 -0700
In-Reply-To: <vpqlkfnipjl.fsf@bauges.imag.fr>
X-Spam-Status: No, hits=-2.906 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.180 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47624>



On Thu, 17 May 2007, Matthieu Moy wrote:
> 
> Many (if not most?) of the people working in a big company, I'd say.
> Year, it sucks, but people having used a paranoid firewall with a
> not-less-paranoid and broken proxy understand what I mean.

Well, we could try to support the git protocol over port 80..

IOW, it's probably easier to try to get people to use

	git clone git://some.host:80/project

and just run git-daemon on port 80, than it is to try to set of magic cgi 
scripts etc.

Doing that with virtual hosts etc should be pretty trivial. Much more so 
than trying to make a git-cgi script.

And yes, I do realize that in theory you can have http-aware firewalls 
that expect to see the normal http sequences in the first few packets in 
order to pass things through, but I seriously doubt it's very common.

			Linus
