From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git-daemon on NSLU2
Date: Sun, 26 Aug 2007 13:19:31 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708261318140.25853@woody.linux-foundation.org>
References: <9e4733910708232254w4e74ca72o917c7cadae4ee0f4@mail.gmail.com> 
 <alpine.LFD.0.999.0708241618070.16727@xanadu.home> 
 <9e4733910708241417l44c55306xaa322afda69c6beb@mail.gmail.com> 
 <alpine.LFD.0.999.0708241616390.25853@woody.linux-foundation.org> 
 <9e4733910708250844n7074cb8coa5844fa6c46b40f0@mail.gmail.com> 
 <20070826093331.GC30474@coredump.intra.peff.net> 
 <9e4733910708260934i1381e73ftb31c7de0d23f6cae@mail.gmail.com> 
 <alpine.LFD.0.999.0708260959050.25853@woody.linux-foundation.org> 
 <9e4733910708261106u3fecde67m8045ddba3aa57650@mail.gmail.com> 
 <alpine.LFD.0.999.0708261118260.25853@woody.linux-foundation.org>
 <9e4733910708261200m5e4c3019g490ffc29b171ef08@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Jeff King <peff@peff.net>, jnareb@gmail.com,
	Nicolas Pitre <nico@cam.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 26 22:20:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPOae-0004Do-CT
	for gcvg-git@gmane.org; Sun, 26 Aug 2007 22:20:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753263AbXHZUUF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Aug 2007 16:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753154AbXHZUUE
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Aug 2007 16:20:04 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:48341 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753035AbXHZUUB (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Aug 2007 16:20:01 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7QKJWHW008301
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 26 Aug 2007 13:19:38 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7QKJVGZ009416;
	Sun, 26 Aug 2007 13:19:31 -0700
In-Reply-To: <9e4733910708261200m5e4c3019g490ffc29b171ef08@mail.gmail.com>
X-Spam-Status: No, hits=-2.749 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.28__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56712>



On Sun, 26 Aug 2007, Jon Smirl wrote:
> 
> A really simple change to the git protocol would be to make the client
> loop on the request. On the first request the server would see that
> the client has no objects and send the "base Linus pack". The client
> would then loop around and repeat the process which will trigger the
> current pack building process.

Jon, just give it up. The fact is, the git protocol works the right way 
already.

> I'm not buying the security argument. If you want something kept hidden 
> get it out of the public db. If I know the sha of the hidden object 
> can't I just add a head for it and git-deamon will happily send it and 
> the chain up to it to me?

That's a particularly idiotic statement.

If you know the SHA1, there can *by*definition* not be any hidden objects. 
The SHA1 depends on the object chain.

		Linus
