From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-stash: Display help message if git-stash is run with
 wrong sub-commands
Date: Mon, 3 Dec 2007 10:25:17 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712031023480.27959@racer.site>
References: <e66701d40712021834h64bf8d0y14f0e222d0f9a617@mail.gmail.com>
 <20071203061617.GB1976@blorf.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Kevin Leung <kevinlsk@gmail.com>, Git ML <git@vger.kernel.org>
To: Wayne Davison <wayne@opencoder.net>
X-From: git-owner@vger.kernel.org Mon Dec 03 11:26:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iz8Uz-0005p1-Oc
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 11:26:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751937AbXLCKZl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 05:25:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751927AbXLCKZl
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 05:25:41 -0500
Received: from mail.gmx.net ([213.165.64.20]:53154 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751912AbXLCKZk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 05:25:40 -0500
Received: (qmail invoked by alias); 03 Dec 2007 10:25:38 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp012) with SMTP; 03 Dec 2007 11:25:38 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX185vfoEaf857X8G/GP8ALE4fJ/Hz2e678H9DylmPk
	JOL3KVmGrA4Fsd
X-X-Sender: gene099@racer.site
In-Reply-To: <20071203061617.GB1976@blorf.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66901>

Hi,

On Sun, 2 Dec 2007, Wayne Davison wrote:

> On Mon, Dec 03, 2007 at 10:34:05AM +0800, Kevin Leung wrote:
> > +USAGE='[  | save | list | show | apply | clear ]'
> 
> It seems strange to me that git stash is using sub-sub-command words 
> instead of options.  Would it make more sense to be more like git branch 
> and have a list be indicated by -l, etc.?

But those are not really options, are they?  They are commands, which 
exclude each other.  And even if they are sub-sub-commands, why should we 
not rather fix "git branch" to support a sane syntax, too?

We could even put some general support into parse-options.[ch] for 
sub-commands.

Ciao,
Dscho
