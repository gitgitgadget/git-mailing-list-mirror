From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: way to automatically add untracked files?
Date: Mon, 6 Aug 2007 01:17:52 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708060116590.14781@racer.site>
References: <873ayymzc1.fsf@catnip.gol.com> <fc339e4a0708042100jdf0a0f1jd1fddfb5dc1c1052@mail.gmail.com>
 <20070805041320.GH9527@spearce.org> <200708051411.25238.johan@herland.net>
 <20070805161117.GE28263@thunk.org> <C3725674-7B33-4B2F-9386-704540D51C0E@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Theodore Tso <tytso@mit.edu>, Johan Herland <johan@herland.net>,
	git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Miles Bader <miles@gnu.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Mon Aug 06 02:18:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHqIp-0000wu-Jn
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 02:18:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758317AbXHFAS3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 20:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758349AbXHFAS3
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 20:18:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:56853 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758297AbXHFAS2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 20:18:28 -0400
Received: (qmail invoked by alias); 06 Aug 2007 00:18:27 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp033) with SMTP; 06 Aug 2007 02:18:27 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/+Cd1cDjn+SafjcmhHKEjpOSB5nR8xlExyYQayM/
	1irn3zqyLUkQFz
X-X-Sender: gene099@racer.site
In-Reply-To: <C3725674-7B33-4B2F-9386-704540D51C0E@zib.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55092>

Hi,

On Sun, 5 Aug 2007, Steffen Prohaska wrote:

> 
> On Aug 5, 2007, at 6:11 PM, Theodore Tso wrote:
> 
> > On Sun, Aug 05, 2007 at 02:11:24PM +0200, Johan Herland wrote:
> > > $ hg addremove --help
> > > hg addremove [OPTION]... [FILE]...
> > > 
> > > add all new files, delete all missing files
> > > 
> > >    Add all new files and remove all missing files from the repository.
> > > 
> > >    New files are ignored if they match any of the patterns in .hgignore.
> > > As
> > >    with add, these changes take effect at the next commit.
> > > 
> > > Adding a git-addremove command should not be much work, and it would be a
> > > lot friendlier to people whose workflow is more aligned with #2 than #1.
> > 
> > Not much work at all:
> > 
> > # git config --system --add alias.addremove "git add . ; git add -u"
> 
> But how can I handle the [FILE]... from above?

See 
http://git.or.cz/gitwiki/Aliases#head-714f0aa64cb53eda636d41e16bf2b99477588685

Hth,
Dscho
