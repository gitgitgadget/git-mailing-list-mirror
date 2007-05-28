From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFC/PATCH] gitweb: Create special from-file/to-file header for combined diff
Date: Mon, 28 May 2007 15:29:59 +0200
Message-ID: <20070528132959.GT4489@pasky.or.cz>
References: <11803077771867-git-send-email-jnareb@gmail.com> <11803077792064-git-send-email-jnareb@gmail.com> <7v1wh1en8k.fsf@assigned-by-dhcp.cox.net> <200705280850.52323.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 28 15:30:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsfIl-0003ps-8O
	for gcvg-git@gmane.org; Mon, 28 May 2007 15:30:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759609AbXE1NaF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 May 2007 09:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762176AbXE1NaE
	(ORCPT <rfc822;git-outgoing>); Mon, 28 May 2007 09:30:04 -0400
Received: from w241.dkm.cz ([62.24.88.241]:54674 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762073AbXE1NaB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2007 09:30:01 -0400
Received: (qmail 22102 invoked by uid 2001); 28 May 2007 15:29:59 +0200
Content-Disposition: inline
In-Reply-To: <200705280850.52323.jnareb@gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48618>

On Mon, May 28, 2007 at 08:50:51AM CEST, Jakub Narebski wrote:
> Junio C Hamano wrote:
> > Jakub Narebski <jnareb@gmail.com> writes:
> > 
> >> Instead of using default, diff(1) like from-file/to-file header for
> >> combined diff (for a merge commit), which looks like:
> >>
> >>   --- a/git-gui/git-gui.sh
> >>   +++ b/_git-gui/git-gui.sh_
> >>
> >> (where _link_ denotes [hidden] hyperlink), create from-file(n)/to-file
> >> header, using n/file for each or parents, e.g.:
> >>
> >>   --- 1/_git-gui/git-gui.sh_
> >>   --- 2/_git-gui.sh_
> >>   +++ b/_git-gui/git-gui.sh_
> > 
> > Sounds quite straightforward to implement, and diff with 1/
> > would be useful to recreate what the person who did the merge
> > pulled in, for most of the time.  I suspect diff with 2/ is
> > almost always uninteresting, though.

I like it too.

> Errr... it _is_ implemented in this patch, although code is not perfect
> and has some unnecessary repetitions.

It just shows links to older versions of the blob, doesn't it? Links to
diffs themselves would be useful too.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
