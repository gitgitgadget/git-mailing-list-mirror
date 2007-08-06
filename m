From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: way to automatically add untracked files?
Date: Mon, 6 Aug 2007 01:16:46 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708060112330.14781@racer.site>
References: <873ayymzc1.fsf@catnip.gol.com> <200708051411.25238.johan@herland.net>
 <20070805161117.GE28263@thunk.org> <200708052116.04140.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Miles Bader <miles@gnu.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Aug 06 02:17:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHqHm-0000lc-Tm
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 02:17:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751592AbXHFARY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 20:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757940AbXHFARY
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 20:17:24 -0400
Received: from mail.gmx.net ([213.165.64.20]:41036 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751568AbXHFARX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 20:17:23 -0400
Received: (qmail invoked by alias); 06 Aug 2007 00:17:21 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp004) with SMTP; 06 Aug 2007 02:17:21 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+TWcUKZJKTKQe1F2/aQ3+cLb6yrhMILT8Mc/QckD
	Jhgch1GOwdWkpA
X-X-Sender: gene099@racer.site
In-Reply-To: <200708052116.04140.johan@herland.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55091>

Hi,

On Sun, 5 Aug 2007, Johan Herland wrote:

> On Sunday 05 August 2007, Theodore Tso wrote:
> > On Sun, Aug 05, 2007 at 02:11:24PM +0200, Johan Herland wrote:
> > > Adding a git-addremove command should not be much work, and it would be
> > > a lot friendlier to people whose workflow is more aligned with #2 than 
> > > #1. 
> > Not much work at all:
> > 
> > # git config --system --add alias.addremove "git add . ; git add -u"

Note that this will not work: you have to add an exclamation mark before 
"git add", because it has to execute two commands.

Note also that I do _not_ suggest using --system.  This option forces you 
to run git as root on sane systems, which I think is wrong.  Rather use 
"--global" to make it globally available to _you_.

> But I'm wondering whether we'd want to include it in git by default 
> (instead of having to tell confused users to add the alias).

I recommend against that, too.  All too often, I have some temporary files 
in the working tree, and I'll be dimmed if I'm the only one.  So 
"addremove" adds too much possibility for pilot errors.

My opinion here is not set in stone, though.  Maybe you can convince me.

Ciao,
Dscho
