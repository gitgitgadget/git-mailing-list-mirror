From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git-daemon on NSLU2
Date: Mon, 27 Aug 2007 09:26:23 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708270923590.25853@woody.linux-foundation.org>
References: <9e4733910708241238n1899f332j4fafbd6d7ccc48b9@mail.gmail.com>
 <alpine.LFD.0.999.0708241618070.16727@xanadu.home>
 <9e4733910708241417l44c55306xaa322afda69c6beb@mail.gmail.com>
 <alpine.LFD.0.999.0708241616390.25853@woody.linux-foundation.org>
 <9e4733910708250844n7074cb8coa5844fa6c46b40f0@mail.gmail.com>
 <20070826093331.GC30474@coredump.intra.peff.net>
 <9e4733910708260934i1381e73ftb31c7de0d23f6cae@mail.gmail.com>
 <alpine.LFD.0.999.0708260959050.25853@woody.linux-foundation.org>
 <9e4733910708261106u3fecde67m8045ddba3aa57650@mail.gmail.com>
 <alpine.LFD.0.999.0708261118260.25853@woody.linux-foundation.org>
 <20070827110318.GB4680@thunk.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Jon Smirl <jonsmirl@gmail.com>, Jeff King <peff@peff.net>,
	jnareb@gmail.com, Nicolas Pitre <nico@cam.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Mon Aug 27 18:39:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPhSF-0001hW-TI
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 18:28:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756136AbXH0Q2j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 12:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755991AbXH0Q2i
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 12:28:38 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:46162 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756026AbXH0Q2h (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Aug 2007 12:28:37 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7RGQPDj023155
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 27 Aug 2007 09:26:26 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7RGQNhk017092;
	Mon, 27 Aug 2007 09:26:24 -0700
In-Reply-To: <20070827110318.GB4680@thunk.org>
X-Spam-Status: No, hits=-2.748 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.28__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56857>



On Mon, 27 Aug 2007, Theodore Tso wrote:
> 
> What if the server sends a message which current clients interprets as
> an error, and which newer clients could interpret as, "do a clone from
> <this> URL, and then come back and talk to me".  Basically an
> automated redirect to get the "Linus base pack" somewhere else, and
> then to go back to the original server.  It certainly doesn't make
> sense to change anything about the low-level protocol, but maybe a
> higher level redirect would make sense, just as a user convenience thing.

I agree, a redirect might be a good idea regardless of whether it's 
something like "I'm a poor little NSLU2, please don't do anything but 
incremental updates", or whether it's something like "this repository has 
moved, use address xyz instead".

And it should be pretty easy from a high-level protocol, although it does 
obviously need both server and client support.

			Linus
