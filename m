From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [GSoC] What is status of Git's Google Summer of Code 2008
	projects?
Date: Mon, 21 Jul 2008 00:57:22 +0200
Message-ID: <20080720225722.GC5950@leksak.fem-net>
References: <200807080227.43515.jnareb@gmail.com> <200807210029.31543.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sam Vilain <sam@vilain.net>,
	Joshua Roys <roysjosh@gmail.com>,
	Sverre Rabbelier <alturin@gmail.com>,
	Sverre Rabbelier <sverre@rabbelier.nl>,
	David Symonds <dsymonds@gmail.com>,
	Lea Wiemann <LeWiemann@gmail.com>,
	John Hawley <warthog19@eaglescrag.net>,
	Marek Zawirski <marek.zawirski@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 21 00:58:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKhrH-0002Jj-B6
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 00:58:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752943AbYGTW52 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 18:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752218AbYGTW52
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 18:57:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:44341 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752183AbYGTW52 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 18:57:28 -0400
Received: (qmail invoked by alias); 20 Jul 2008 22:57:26 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp032) with SMTP; 21 Jul 2008 00:57:26 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1/AHbJPLRHA0RG3qEhfE7GODXiFUwD3QGcgcooSX+
	drVh35Z414DFGL
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KKhqE-0004Ly-NZ; Mon, 21 Jul 2008 00:57:22 +0200
Content-Disposition: inline
In-Reply-To: <200807210029.31543.jnareb@gmail.com>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89257>

Hi,

what you write is quite detailed :)

Jakub Narebski wrote:
> 6. git-sequencer
> 
[...]
> There were some problems with sequencer based implementation of
> "git am --rebasing", or sequencer based patch application driven
> ordinary rebase, but I think there were resolved.

They were resolved, but there is a new problem that occured in the
am --abort thread of Junio: the sequencer-based git-am does not work
on dirty working tree.

I've also fixed some other minor issues and have not yet sent this to
the list (because I think I stumble over even more while writing the
builtin-sequencer.)

> Stephen have started the builtin sequencer (but till now no patches
> were sent to list: seems to be work in progress).

Right.

> Some performance benchmarks:
>  * applying 45 patches with git-am 
>    - 3 seconds using the original 
>    - 8 seconds using the (scripted) sequencer-based one
>  * rebasing 100 commits
>    -  4.8 seconds using the original
>    - 10.1 seconds using the (scripted) sequencer-based one
>    -  1.7 seconds using builtin sequencer

:)
I think I'm going to format-patch the same 100 test commits and then I
change the "applying 45 patches with git-am" part on the Wiki.

Regards.

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
