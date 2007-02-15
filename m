From: Mark Wooding <mdw@distorted.org.uk>
Subject: Re: OT: data destruction classics (was: Re: Error converting from 1.4.4.1 to 1.5.0?)
Date: Thu, 15 Feb 2007 14:30:36 +0000 (UTC)
Organization: Straylight/Edgeware development
Message-ID: <slrnet8rkc.sbe.mdw@metalzone.distorted.org.uk>
References: <17875.13564.622087.63653@lisa.zopyra.com> <17875.36879.872210.264473@lisa.zopyra.com> <45D3B4E7.8050408@fs.ei.tum.de> <200702150914.01361.andyparkins@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 15 15:30:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHhdE-0003xs-7k
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 15:30:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932824AbXBOOak (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Feb 2007 09:30:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932821AbXBOOak
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Feb 2007 09:30:40 -0500
Received: from distorted.demon.co.uk ([80.177.3.76]:61024 "HELO
	metalzone.distorted.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with SMTP id S932824AbXBOOaj (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Feb 2007 09:30:39 -0500
Received: (qmail 5343 invoked by uid 110); 15 Feb 2007 14:30:37 -0000
Received: (qmail 5327 invoked by uid 9); 15 Feb 2007 14:30:37 -0000
Path: not-for-mail
Newsgroups: mail.vger.git
NNTP-Posting-Host: metalzone.distorted.org.uk
X-Trace: metalzone.distorted.org.uk 1171549836 5154 172.29.199.2 (15 Feb 2007 14:30:36 GMT)
X-Complaints-To: usenet@distorted.org.uk
NNTP-Posting-Date: Thu, 15 Feb 2007 14:30:36 +0000 (UTC)
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39829>

Andy Parkins <andyparkins@gmail.com> wrote:

> 4) rm -rf .*

I'm nowhere near that impressive, unfortunately.

Once upon a time, I was trying to build some package (I forget which)
from its source distribution.  It was an GNU-y Autoconf kind of thing.
I didn't want to install it globally at that point, just in my home
directory.  So I said

  $ ./configure --prefix=~
  $ make
  $ make install

So far, so good.  Now try to run the thing.

  $ foo
  bash: foo: command not found

Oh.  Where's it gone?

  $ ls

That's annoying.  Bad shell.  It's failed to expand `~', and just put
everything in a directory called `~' in my build tree.  Bugger.  I don't
want it there.

  $ rm -rf ~

I wonder why it's taking so lo... ^C^C^C^C

-- [mdw]
