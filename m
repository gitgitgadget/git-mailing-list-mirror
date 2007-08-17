From: Rene Herman <rene.herman@gmail.com>
Subject: Re: [PATCH] [1/2many] - FInd the maintainer(s) for a patch - scripts/get_maintainer.pl
Date: Fri, 17 Aug 2007 06:24:21 +0200
Message-ID: <46C522F5.9080802@gmail.com>
References: <1187026955.2688.4.camel@laptopd505.fenrus.org>	<1187037445.6628.98.camel@heimdal.trondhjem.org>	<1187054366.2757.0.camel@laptopd505.fenrus.org>	<46C10AA8.3090505@gmail.com>	<20070814102033.604c8695@the-village.bc.nu>	<46C1CFFE.4000001@gmail.com> <1187110824.32555.76.camel@localhost>	<46C1EE6F.2080807@gmail.com> <1187116082.32555.122.camel@localhost>	<alpine.LFD.0.999.0708141131140.30176@woody.linux-foundation.org>	<20070814193333.GI21089@ftp.linux.org.uk> <46C2548D.80605@gmail.com>	<alpine.LFD.0.999.0708151846130.16414@enigma.security.iitk.ac.in>	<46C30220.6060007@gmail.com>	<68B09015-4411-470A-BA88-732969469AA2@mac.com>	<46C42DCB.1060502@gmail.com> <7v7invjodw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Kyle Moffett <mrmacman_g4@mac.com>,
	Satyam Sharma <satyam@infradead.org>,
	Al Viro <viro@ftp.linux.org.uk>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Joe Perches <joe@perches.com>, git@vger.kernel.org,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Arjan van de Ven <arjan@infradead.org>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Mariusz Kozlowski <m.kozlowski@tuxland.pl>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 17 06:29:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILtSK-0005HQ-8m
	for gcvg-git@gmane.org; Fri, 17 Aug 2007 06:29:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753519AbXHQE3A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Aug 2007 00:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753215AbXHQE27
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Aug 2007 00:28:59 -0400
Received: from smtpq2.groni1.gr.home.nl ([213.51.130.201]:54077 "EHLO
	smtpq2.groni1.gr.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752916AbXHQE25 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2007 00:28:57 -0400
Received: from [213.51.130.188] (port=35761 helo=smtp3.groni1.gr.home.nl)
	by smtpq2.groni1.gr.home.nl with esmtp (Exim 4.30)
	id 1ILtRn-00018p-Ca; Fri, 17 Aug 2007 06:28:31 +0200
Received: from cc334381-b.groni1.gr.home.nl ([82.73.12.33]:60166 helo=[192.168.0.3])
	by smtp3.groni1.gr.home.nl with esmtp (Exim 4.30)
	id 1ILtRl-0001lW-Jv; Fri, 17 Aug 2007 06:28:29 +0200
User-Agent: Thunderbird 2.0.0.6 (X11/20070728)
In-Reply-To: <7v7invjodw.fsf@gitster.siamese.dyndns.org>
X-AtHome-MailScanner-Information: Please contact support@home.nl for more information
X-AtHome-MailScanner: Found to be clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56045>

On 08/16/2007 09:00 PM, Junio C Hamano wrote:

> Git or no git, I think a file that can be viewed with less,
> edited with regular editor and processed with sed/perl/grep
> tools is the way to go.  I do not think adding 600+ patches to
> the single MAINTAINERS list is workable in the longer term, as
> it would become the single file many subsystem people need to
> update and is asking for merge conflicts, but I think a file
> with known name (say, "CcMe.txt") sprinkled in relevant
> subdirectories, perhaps with the same format originally
> suggested for MAINTAINERS, would make a lot more sense.
> 
> That would give people who work with tarballs and patches, or a
> subsystem managed with something other than git (one of the most
> important one is quilt), the equal access to the necessary data.

That is ofcourse an argument but I believe a bit of a non-argument at the 
same time in practice.

There's really not much point in pretending that non-git users are still 
first class citizens anyway; Linus' own suggestion of using git-blame would 
tie things to git as well, as do for example frequent requests to bisect a 
problem. I moreover feel there's absolutely nothing wrong with that, given 
that there's nothing wrong with git.

It's the kernel's source code management tool, is included out of the box in 
most distributions nowadays and is GPLd meaning that the tool (itself) won't 
keep anyone from exporting data from it and importing it into something else 
if someone cares to. Also, I never managed to stay un-annoyed at source code 
management tools long enough to understand why I wanted to use them but have 
been using git for months now so as far as I am concerned, it appears to 
even be a good tool.

But, well, anyways, I did look at a git repo a bit but will unfortunately 
not be able to follow up the proposal with actual (good) code in a sensible 
timeframe, let alone "quickly", which means I was hoping others would agree. 
I believe these properties make for an elegant setup with many possible uses 
including the maintainers information, but if you disagree I guess I'm going 
to shelve it...

> Even with git, it is my understanding that kernel community
> works largely on patches exchanged over e-mails, between people
> who do use git and people who do not.  You would want to have
> something you can easily transfer over e-mail in the patch
> form.
> 
> We _could_ invent a new "patches to properties" git diff output
> format that "git apply" can understand to propagate that
> information

Yes, not unlike the current git move "meta-diffs" ...

> but that approach is making it less interoperable with others, and you 
> need to demonstrate the benefit far outweighs that.  I do not see it for 
> this particular application.
> 
> There may be places for "properties" that would be useful to git, but I 
> do not think the "find whom to send patches to" is one of them.

The important reason for wiring this into git directly would be keeping the 
meta-data in sync with the data it refers to in an automated fashion. With 
manual intervention, there's much more opportunity for things to grow stale.

In practice, it may not be a huge problem. It certainly is with the current 
MAINTAINERS file but if one does finer-grained data around the tree, that 
will probably help.

It's also not a now or never thing fortunately. If git does ever grow these 
properties, the issue can be revisited, perhaps at that time both with the 
experience of what the finer-grained in-tree solution did not solve and even 
fewer people around that care about not making git even more of an intrinsic 
part of development.

Rene.
