From: Peter Karlsson <peter@softwolves.pp.se>
Subject: Re: Switching from CVS to GIT
Date: Tue, 16 Oct 2007 12:13:49 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <Pine.LNX.4.64.0710161209190.8571@ds9.cixit.se>
References: <1192293466.17584.95.camel@homebase.localnet> <uy7e6keyv.fsf@gnu.org>
 <1192381040.4908.57.camel@homebase.localnet> <1773C6F0-87BE-4F3C-B68A-171E1F32E242@lrde.epita.fr>
 <47125F74.9050600@op5.se> <Pine.LNX.4.64.0710141934310.25221@racer.site>
 <47126957.1020204@op5.se> <Pine.LNX.4.64.0710142112540.25221@racer.site>
 <20071014221446.GC2776@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 16 13:14:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhkN9-0006mq-8p
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 13:14:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756655AbXJPLNw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 07:13:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757345AbXJPLNw
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 07:13:52 -0400
Received: from ds9.cixit.se ([193.15.169.228]:53188 "EHLO ds9.cixit.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755098AbXJPLNv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 07:13:51 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id l9GBDnnQ027400
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 16 Oct 2007 13:13:49 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id l9GBDna3027395;
	Tue, 16 Oct 2007 13:13:49 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <20071014221446.GC2776@steel.home>
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ds9.cixit.se [127.0.0.1]); Tue, 16 Oct 2007 13:13:49 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61146>

> - it is the only OS in the world with multi-root (/a/b/c and /a/b/c
>   can be not the same, depending on what current "drive" is) and
>   multi-cwd, which hasn't had formed itself into a problem yet, but
>   surely will

It's not the only OS with drive letters (although I don't see Git
coming to my Symbian OS phone any time soon), but there is only one
root. The problem is that it isn't addressable in the file system, and
that the concept of what is the root is different depending on what you
ask (either it's above the drive letters, or "My Computer").

You can create a search path rooted in "My Computer" if you want (using
shell APIs), but you probably can't get a readable text representation
of it.

> - it has only one argument (limited in size) passed to started
>   programs, which means that there is no possible way to safely pass
>   file and text arguments on command line (more than one, that is)

Well, there are many other ways of passing arguments than on the
command line, but they are probably difficult to access from console
applications (things like DDE or whatever the current implementation is
called).

-- 
\\// Peter - http://www.softwolves.pp.se/
