From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFC] gitweb wishlist and TODO list
Date: Tue, 20 Jun 2006 19:55:05 +0200
Message-ID: <20060620175505.GR2609@pasky.or.cz>
References: <e79921$u0e$1@sea.gmane.org> <87r71jspeo.wl%cworth@cworth.org> <e79c8t$8sd$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 20 19:55:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FskRL-0005Rx-Ns
	for gcvg-git@gmane.org; Tue, 20 Jun 2006 19:55:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbWFTRy7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Jun 2006 13:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbWFTRy7
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jun 2006 13:54:59 -0400
Received: from w241.dkm.cz ([62.24.88.241]:20201 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750745AbWFTRy7 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Jun 2006 13:54:59 -0400
Received: (qmail 15687 invoked by uid 2001); 20 Jun 2006 19:55:05 +0200
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <e79c8t$8sd$1@sea.gmane.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22216>

Dear diary, on Tue, Jun 20, 2006 at 07:46:11PM CEST, I got a letter
where Jakub Narebski <jnareb@gmail.com> said that...
> Add to that the fact that above needs some support from web server
> (e.g. Apache's mod_rewrite) and web server configuration, while gitweb tries
> to be server agnostic...

Nope, you get the stuff in $PATH_INFO. And having at least just the
project name in the path part would be quite nice, it's my common gripe
with cvsweb as I frequently get to mangle with the query part manually
(can be much faster than clicking around) and I have to carefully evade
the project name part, which is something I would really expect to be in
the "static" part of the URL.

When we are talking about URLs, it would be quite nice if the query
parameter names would be actually meaningful instead of some cryptic
'h', 'pg' and whatnot.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
A person is just about as big as the things that make them angry.
