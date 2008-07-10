From: Petr Baudis <pasky@suse.cz>
Subject: Re: git pull is slow
Date: Thu, 10 Jul 2008 17:50:16 +0200
Message-ID: <20080710155016.GC32184@machine.or.cz>
References: <g5570s$d5m$1@ger.gmane.org> <48762B27.90004@viscovery.net> <48762E8A.7070203@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>
To: Stephan Hennig <mailing_list@arcor.de>
X-From: git-owner@vger.kernel.org Thu Jul 10 17:52:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGyRc-0005Gh-9u
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 17:52:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758944AbYGJPuX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 11:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758932AbYGJPuW
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 11:50:22 -0400
Received: from w241.dkm.cz ([62.24.88.241]:33598 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758918AbYGJPuV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 11:50:21 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 65F672C4C02F; Thu, 10 Jul 2008 17:50:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48762E8A.7070203@arcor.de>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87986>

On Thu, Jul 10, 2008 at 05:45:14PM +0200, Stephan Hennig wrote:
> Johannes Sixt schrieb:
> > Stephan Hennig schrieb:
> >> I am observing very large data transfers when pulling from the 
> >> repository at <URL:http://repo.or.cz/w/wortliste.git>.  This
> >> repository contains one 13 MB text file that compressed is roughly
> >> 3 MB large.
> > 
> > Do you by any chance use a http URL to pull? Don't do that. Use git
> > protocol.
> 
> No, I'm already using git+ssh.

Oh, ok. By the way, how long are you hitting this issue? Just today,
I have upgraded the chroot Git from some anonymous 2007-12-08 version
to the almost-latest #next.

-- 
				Petr "Pasky" Baudis
The last good thing written in C++ was the Pachelbel Canon. -- J. Olson
