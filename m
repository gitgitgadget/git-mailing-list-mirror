From: Petr Baudis <pasky@suse.cz>
Subject: Re: cygwin-latest: compile errors related to sockaddr_storage, dirent->d_type and dirent->d_ino
Date: Thu, 19 Jan 2006 13:51:55 +0100
Message-ID: <20060119125155.GZ28365@pasky.or.cz>
References: <81b0412b0601180547q4a812c8xb632de6ab13a5e62@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Jan 19 13:50:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzZFR-0003Fp-Up
	for gcvg-git@gmane.org; Thu, 19 Jan 2006 13:50:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161173AbWASMug (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jan 2006 07:50:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161186AbWASMug
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jan 2006 07:50:36 -0500
Received: from w241.dkm.cz ([62.24.88.241]:40838 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1161173AbWASMug (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jan 2006 07:50:36 -0500
Received: (qmail 21133 invoked by uid 2001); 19 Jan 2006 13:51:55 +0100
To: Alex Riesen <raa.lkml@gmail.com>
Content-Disposition: inline
In-Reply-To: <81b0412b0601180547q4a812c8xb632de6ab13a5e62@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14902>

Dear diary, on Wed, Jan 18, 2006 at 02:47:00PM CET, I got a letter
where Alex Riesen <raa.lkml@gmail.com> said that...
> For reasons unknown, cygwin decided to use our sockaddr_storage.
> As it is redefined to sockaddr_in it'd cause compilation errors in
> cygwin headers. Fixed by first patch, which uses a more git-related
> name (can we claim rights for the symbol, being first to use it? :-)

Huh? "Our"? See RFC 2553 and e.g.:

	http://www.opengroup.org/onlinepubs/009695399/basedefs/sys/socket.h.html

You have no business meddling with this identifier except working around
platforms which do not support it, but then do not complain that things
break when the platforms actually start supporting it. ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
