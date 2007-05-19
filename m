From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 5/7] gitweb: Prototyp for selecting diffs in JavaScript
Date: Sat, 19 May 2007 10:27:45 +0200
Message-ID: <20070519082744.GC4489@pasky.or.cz>
References: <437446e84f3aea71f74fea7ea66db4c1c326fb6b.1176659094.git.mkoegler@auto.tuwien.ac.at> <481946c2e3cff09ed4a623b1b20b9889666aedb0.1176659095.git.mkoegler@auto.tuwien.ac.at> <20070518084935.GV4489@pasky.or.cz> <20070519075701.GA30933@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Sat May 19 10:27:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpKI5-0003I5-T2
	for gcvg-git@gmane.org; Sat, 19 May 2007 10:27:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755143AbXESI1s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 May 2007 04:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755321AbXESI1s
	(ORCPT <rfc822;git-outgoing>); Sat, 19 May 2007 04:27:48 -0400
Received: from w241.dkm.cz ([62.24.88.241]:58198 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755143AbXESI1r (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2007 04:27:47 -0400
Received: (qmail 27764 invoked by uid 2001); 19 May 2007 10:27:45 +0200
Content-Disposition: inline
In-Reply-To: <20070519075701.GA30933@auto.tuwien.ac.at>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47730>

On Sat, May 19, 2007 at 09:57:01AM CEST, Martin Koegler wrote:
> Againgst what version/repository do you want the patch?

Whatever is comfortable for you :-) - next would be ideal for me, but
can be something else as well.

> For the new version, I intend to move the JavaScript file into the
> head tag of the html page. I could integrate your incremental blame
> link rewrite as well. If I'm doing this, we could remove the blamelink
> class hack as well as the fixBlameLinks JavaScript function.

It's not clear at all yet whether incremental blame is viable idea
because I suspect Firefox might be just too horribly slow at working
with DOM for it to make sense for any files of non-trivial size. So I
wouldn't rely on this going in just yet. :-(

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
