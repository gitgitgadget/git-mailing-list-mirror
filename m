From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git describe origin ?
Date: Sat, 7 Jul 2007 17:33:15 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707071728330.4093@racer.site>
References: <38b2ab8a0707070851m25d615bdn4f7286cbadaf1316@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 07 18:40:36 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7DKk-0007G6-A6
	for gcvg-git@gmane.org; Sat, 07 Jul 2007 18:40:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752176AbXGGQk2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jul 2007 12:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752149AbXGGQk1
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jul 2007 12:40:27 -0400
Received: from mail.gmx.net ([213.165.64.20]:51365 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752138AbXGGQk1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jul 2007 12:40:27 -0400
Received: (qmail invoked by alias); 07 Jul 2007 16:40:25 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp041) with SMTP; 07 Jul 2007 18:40:25 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+wU1R+7CiwUw/ideDQzxOmy1aV3+y+eCJsuYgXu+
	JvxaQtwllks5yC
X-X-Sender: gene099@racer.site
In-Reply-To: <38b2ab8a0707070851m25d615bdn4f7286cbadaf1316@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51822>

Hi,

On Sat, 7 Jul 2007, Francis Moreau wrote:

> I was wondering what does 'git describe origin' command mean on a git
> repo. Does it mean ?
> 
>    a/ git describe origin/HEAD
>    b/ git describe origin/master
>    c/ something else

This is completely unrelated to "git describe". It is about naming 
commits AKA "specifying revisions". You might find the section "SPECIFYING 
REVISIONS" in Documentation/git-rev-parse.txt especially helpful. FWIW 
this section is hinted at in the section "Symbolic Identifiers" in 
Documentation/git.txt.

If you're too lazy to read, it's a/.

> I also played with git remote and did something silly like: 
> $ git remote add bob /tmp/dummy # dummy does not exist
> $ git remote show bob
> fatal: '/tmp/toto': unable to chdir or not a git archive
> fatal: The remote end hung up unexpectedly
> ls-remote --heads /tmp/toto: command returned error: 1
> 
> Maybe the output could be improved to be more readable.

The first line is very helpful IMHO:

	fatal: '/tmp/toto': unable to chdir or not a git archive

Ciao,
Dscho
