From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: git-svn set-tree bug
Date: Sun, 10 Jun 2007 19:27:38 +0200
Organization: Transmode AB
Message-ID: <1181496458.30670.117.camel@gentoo-jocke.transmode.se>
References: <1181323515.30670.110.camel@gentoo-jocke.transmode.se>
	 <20070610014734.GA542@muzzle>
	 <1181496086.30670.115.camel@gentoo-jocke.transmode.se>
Reply-To: joakim.tjernlund@transmode.se
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Jun 10 19:27:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxRCY-0002qp-Tl
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 19:27:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757895AbXFJR1l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 13:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757409AbXFJR1l
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 13:27:41 -0400
Received: from mail.transmode.se ([83.241.175.147]:53588 "EHLO
	tmnt04.transmode.se" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756064AbXFJR1l (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 13:27:41 -0400
Received: mail.transmode.se 192.168.46.15 from 192.168.1.15 192.168.1.15 via HTTP with MS-WebStorage 6.0.6249
Received: from gentoo-jocke by mail.transmode.se; 10 Jun 2007 19:27:38 +0200
In-Reply-To: <1181496086.30670.115.camel@gentoo-jocke.transmode.se>
X-Mailer: Evolution 2.8.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49750>

On Sun, 2007-06-10 at 19:21 +0200, Joakim Tjernlund wrote:
> On Sat, 2007-06-09 at 18:47 -0700, Eric Wong wrote:
> > Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:
> > > trying to do git-svn set-tree remotes/trunk..svn
> > > in my new git-svn repo I get:
> > > config --get svn-remote.svn.fetch :refs/remotes/git-svn$: command returned error: 1
> > 
> > You need to specify "-i trunk" in the command-line
> > 
> > git-svn set-tree -i trunk remotes/trunk..svn
> > 
> 
> Thanks

[SNIP script]

forgot:
 git version 1.5.2.1
 subversion version 1.4.3

 Jocke
