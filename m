From: fork0@t-online.de (Alex Riesen)
Subject: Re: [Patch] Using 'perl' in *.sh
Date: Sun, 9 Jul 2006 11:46:30 +0200
Message-ID: <20060709094630.GB5919@steel.home>
References: <200607081732.04273.michal.rokos@nextsoft.cz> <7v3bdcq7dy.fsf@assigned-by-dhcp.cox.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michal Rokos <michal.rokos@nextsoft.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 09 11:46:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzVsJ-0003GL-J7
	for gcvg-git@gmane.org; Sun, 09 Jul 2006 11:46:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964825AbWGIJqs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Jul 2006 05:46:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbWGIJqs
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Jul 2006 05:46:48 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:41687 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1751311AbWGIJqr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jul 2006 05:46:47 -0400
Received: from fwd34.aul.t-online.de 
	by mailout02.sul.t-online.com with smtp 
	id 1FzVs9-0006Z7-06; Sun, 09 Jul 2006 11:46:41 +0200
Received: from tigra.home (r4+CKcZfZeVdzf4zFoC-2oSkXDiVXgyRBN4uT87gsm7qLzdEd4QYks@[84.160.119.250]) by fwd34.sul.t-online.de
	with esmtp id 1FzVry-1P0bSq0; Sun, 9 Jul 2006 11:46:30 +0200
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 36E0E277AF;
	Sun,  9 Jul 2006 11:46:30 +0200 (CEST)
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1FzVry-0001bP-3C; Sun, 09 Jul 2006 11:46:30 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v3bdcq7dy.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6i
X-ID: r4+CKcZfZeVdzf4zFoC-2oSkXDiVXgyRBN4uT87gsm7qLzdEd4QYks
X-TOI-MSGID: d53fcfd7-099f-4b90-a1cd-47e567008a76
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23536>

Junio C Hamano, Sat, Jul 08, 2006 20:27:37 +0200:
> >
> > some GIT's shell script are using bare 'perl' for perl invocation. It's 
> > causing me problems... I compile git with PERL_PATH set and I'd suggest to 
> > use it everywhere.
> >
> > So @@PERL@@ would be replaced with PERL_PATH_SQ instead.
> >
> > What do you think?
> 
> Absolutely.

Now imagine a non-posix system where an upgrade was made. Amongst
other things perl was moved, i.e. from /opt/perl-5.8.8 to
/usr/local/{bin,lib}. Suddenly git breaks.
