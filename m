From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add new git-graph command
Date: Mon, 31 Mar 2008 00:54:32 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0803310052400.2919@eeepc-johanness>
References: <20080330195840.GA8695@adamsimpkins.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Adam Simpkins <adam@adamsimpkins.net>
X-From: git-owner@vger.kernel.org Mon Mar 31 00:55:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jg6Qv-0000Hv-Ov
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 00:55:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759152AbYC3Wyp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Mar 2008 18:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759144AbYC3Wyp
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Mar 2008 18:54:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:39852 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756937AbYC3Wyn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Mar 2008 18:54:43 -0400
Received: (qmail invoked by alias); 30 Mar 2008 22:54:41 -0000
Received: from host86-139-218-102.range86-139.btcentralplus.com (EHLO eeepc-johanness.home) [86.139.218.102]
  by mail.gmx.net (mp020) with SMTP; 31 Mar 2008 00:54:41 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/vaMhBhKjvICSm3R9UdKIZsMoc8mU1LheOA78lCc
	56vMT4AH9bB/Gg
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20080330195840.GA8695@adamsimpkins.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78520>

Hi,

On Sun, 30 Mar 2008, Adam Simpkins wrote:

> This is a first pass at a command to print a text-based graph of the 
> commit history.  It is similar to the history graph shown by gitk, but 
> doesn't require a windowing system.
> 
> Signed-off-by: Adam Simpkins <adam@adamsimpkins.net>
> ---
> 
> I added this since I really like gitk, but don't always have easy access 
> to an X display on some of the systems I use.  I tried using tig, but I 
> found its graph output very hard to read.  The graph produced by 
> git-graph is less compact, but much more readable.
> 
> Ultimately, it would probably be better to integrate this functionality 
> into git-log, instead of having it as a standalone command.  For 
> example, a new --graph option could be added to cause the graph to be 
> displayed alongside the existing git log output. However, this would 
> require tighter integration between the graphing code and the log_tree.c 
> and pretty.c code, which I'm not all that familiar with.

Funny.  Some time ago, Shawn and I mused how involved it would be to write 
some tool very similar to this, only that the output could be read back by 
git-gui.  This would be needed for a sensible "rebase -i" implementation 
in git-gui.

Ciao,
Dscho
