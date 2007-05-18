From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] gitweb: Extra columns in blame
Date: Sat, 19 May 2007 00:19:16 +0200
Message-ID: <20070518221916.GZ4489@pasky.or.cz>
References: <20070518191725.10460.83338.stgit@rover> <7vy7jl4zjm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 19 00:19:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpAnH-0002rw-63
	for gcvg-git@gmane.org; Sat, 19 May 2007 00:19:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760540AbXERWTT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 18:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761865AbXERWTT
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 18:19:19 -0400
Received: from w241.dkm.cz ([62.24.88.241]:54228 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760540AbXERWTS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 18:19:18 -0400
Received: (qmail 12080 invoked by uid 2001); 19 May 2007 00:19:16 +0200
Content-Disposition: inline
In-Reply-To: <7vy7jl4zjm.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47667>

On Fri, May 18, 2007 at 11:01:01PM CEST, Junio C Hamano wrote:
> Good job, except that I think you should also show the filename
> especially as you seem to run with -C (I haven't looked at the
> code yet, though).
> 
> E.g.
> 
> http://repo.or.cz/w/linux-2.6.git?a=blame_incremental;f=block/ll_rw_blk.c;h=6b5173ac81313d8adb5c1d7b521559f565bb209b;hb=347b4599dd6ffef27e18c227532d1ec66556000b
> 
> the first few hunks that came from 1da177e4 are from a different
> file, drivers/block/ll_rw_blk.c.

I don't use git-blame -C - I pass virtually no extra parameters to
git-blame (except some output controlling). Passing -C to git-blame
might be an interesting idea but the possible performance hit is a bit
scary; when the dust settles and this gets merged or something, I can
experiment with it a bit further...

(Also, I fear a bit about making it _too_ wide even with the extra
columns; there should be reasonable portion of line still visible on
usual resolutions with usual font sizes. Might be nice UI challenge.

> Also the incremental thing using JavaScript does not seem to
> work for me incrementally for some reason, although if I wait
> long enough I get the fully blamed picture that seems to match
> nonincremental one.  While I am waiting, the browser goes silent
> and does not even let me switch to other tabs, so it is not all
> that useful to me in its current shape.

Strange, what browser are you using?

The trouble is, I'm not really very good at this kind of web development
because I have access only to a rather narrow portion of the browser
market - Firefox at Linux, at work also Galeon, Epiphany and Konqueror,
and of course ELinks. I have theoretical access to MSIE at work but it's
quite a hassle. With all browser I've tested it with, it worked without
a problem, so I'm not sure how much will I be able to debug it (and I'm
really bad at debugging javascript anyway).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
