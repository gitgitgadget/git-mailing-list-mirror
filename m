From: Marco Roeland <marco.roeland@xs4all.nl>
Subject: Re: GIT 0.99.8d
Date: Sun, 16 Oct 2005 20:55:40 +0200
Message-ID: <20051016185540.GA27162@fiberbit.xs4all.nl>
References: <7vachadnmy.fsf@assigned-by-dhcp.cox.net> <200510161024.37873.tomlins@cam.org> <7vll0txqwu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Ed Tomlinson <tomlins@cam.org>, git@vger.kernel.org,
	linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 16 20:56:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ERDfi-0000TR-MW
	for gcvg-git@gmane.org; Sun, 16 Oct 2005 20:55:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbVJPSzs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 16 Oct 2005 14:55:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbVJPSzs
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Oct 2005 14:55:48 -0400
Received: from fiberbit.xs4all.nl ([213.84.224.214]:20954 "EHLO
	fiberbit.xs4all.nl") by vger.kernel.org with ESMTP id S1751362AbVJPSzs
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Oct 2005 14:55:48 -0400
Received: from marco by fiberbit.xs4all.nl with local (Exim 4.52)
	id 1ERDfY-00074W-Db; Sun, 16 Oct 2005 20:55:40 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vll0txqwu.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10170>

On Sunday October 16th 2005 Junio C Hamano wrote:

> > Debian users beware.  This version introduces a dependency - package: 
> > libcurl3-gnutls-dev
> > is now needed to build git.
> 
> Is this really true?  The one I uploaded was built on this
> machine:
> 
> : siamese; dpkg -l libcurl\* | sed -ne 's/^ii  //p'
> libcurl3          7.14.0-2       Multi-protocol file transfer library, now wi
> libcurl3-dev      7.14.0-2       Development files and documentation for libc
> 
> Having said that, a tested patch to debian/control to adjust
> Build-Depends is much appreciated.

The present line is correct. In 'debian/control' the line reads
(word-wrapped here):

Build-Depends-Indep: libz-dev, libssl-dev,
 libcurl3-dev|libcurl3-gnutls-dev|libcurl3-openssl-dev, asciidoc (>=
 6.0.3), xmlto, debhelper (>= 4.0.0), bc

So it works correct on 'stable' versions ('libcurl3-dev') and
latest 'unstable' as well, where you have the choice of either
'libcurl3-gnutls-dev' or 'libcurl3-openssl-dev'.
-- 
Marco Roeland
