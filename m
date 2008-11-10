From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: pull --preserve-merges
Date: Mon, 10 Nov 2008 20:48:19 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811102047130.30769@pacific.mpi-cbg.de>
References: <20081107160138.aa96405c.stephen@exigencecorp.com> <20081110130518.3eb64ceb.stephen@exigencecorp.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, fg@one2team.net
To: Stephen Haberman <stephen@exigencecorp.com>
X-From: git-owner@vger.kernel.org Mon Nov 10 20:42:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzceU-0002Ka-8D
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 20:42:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751005AbYKJTlE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 14:41:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbYKJTlC
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 14:41:02 -0500
Received: from mail.gmx.net ([213.165.64.20]:49855 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750966AbYKJTlB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 14:41:01 -0500
Received: (qmail invoked by alias); 10 Nov 2008 19:40:54 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp008) with SMTP; 10 Nov 2008 20:40:54 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18KQiMvXScK1v8hnxL9NU8TiXFYD6ECz/okGlHDkN
	2SDEHrmDVpjLfq
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20081110130518.3eb64ceb.stephen@exigencecorp.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100550>

Hi,

On Mon, 10 Nov 2008, Stephen Haberman wrote:

> [citing someone, presumably himself]
>
> > Awhile ago I brought up wanting to have a "rebase with preserve 
> > merges" option for `git pull`:
> >
> > http://thread.gmane.org/gmane.comp.version-control.git/96513
> >
> > Andreas had a patch to help by supporting manually typing out `git 
> > pull --rebase --preserve-merges`:
> >
> > http://thread.gmane.org/gmane.comp.version-control.git/96593
> >
> > And then I did another small copy/paste patch on top to add a config 
> > setting of `branch.<name>.preservemerges` much like the existing 
> > `branch.<name>.rebase`.
> 
> I just noticed the `branch.<name>.mergeoptions` flag in the merge docs.
> Instead of having both `branch.<name>.rebase` and `.preservemerges`, and
> possibly even more config parameters for whatever other people what to
> configure as well, would something like `branch.<name>.pulloptions` be a
> better idea?

Or we can stay backwards-compatible and support

	[branch "<name">]
		rebase = preserve-merges

Ciao,
Dscho
