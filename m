From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH] Ignore duplicated slashes in git-log
Date: Sat, 9 Feb 2008 15:16:45 +0100
Message-ID: <20080209141645.GB22569@one.firstfloor.org>
References: <20080209125457.GA5686@basil.nowhere.org> <alpine.LSU.1.00.0802091323550.11591@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andi Kleen <andi@firstfloor.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Feb 09 14:42:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNpy4-0001U0-32
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 14:42:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754292AbYBINlc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 08:41:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754661AbYBINlc
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 08:41:32 -0500
Received: from one.firstfloor.org ([213.235.205.2]:58877 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752920AbYBINlb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 08:41:31 -0500
Received: by one.firstfloor.org (Postfix, from userid 503)
	id 2F8A11AA0001; Sat,  9 Feb 2008 15:16:45 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0802091323550.11591@racer.site>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73227>

On Sat, Feb 09, 2008 at 01:24:56PM +0000, Johannes Schindelin wrote:
> Hi,
> 
> On Sat, 9 Feb 2008, Andi Kleen wrote:
> 
> > When I use git-log ... path/name I seem to regularly typo path/name as 
> > path//name (with duplicated slashes) The normal kernel ignores these 
> > duplicated slashes according to POSIX so it's typically no problem, but 
> > git fails and cannot find the correct file name when this happens.
> 
> This is only one case you want to fix.  There are absolute paths, too, and 
> series of "../".

It's hard to imagine anyone typoing sequences of ../ or ./, so at least
I personally didn't feel the need to handle that.

> 
> Alas, Junio was quicker than you:
> 
> http://repo.or.cz/w/git.git?a=commitdiff;h=d089ebaad5315325d67db30176df1bbd7754fda9

Great.

-Andi
