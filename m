From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: minimize_url in git-svn?
Date: Tue, 8 May 2007 13:28:23 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0705081327260.4167@racer.site>
References: <C05C5EF4-EC68-490B-946E-630117393F4E@drhanson.net>
 <463F6A95.30207@midwinter.com> <9fb1551c0705072048u3ff85ea7n5166596855b8f322@mail.gmail.com>
 <464023D4.5060101@midwinter.com> <7v4pmn4oxj.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue May 08 13:28:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlNrq-0005Km-Fr
	for gcvg-git@gmane.org; Tue, 08 May 2007 13:28:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934230AbXEHL2K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 07:28:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934516AbXEHL2K
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 07:28:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:58193 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934230AbXEHL2J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 07:28:09 -0400
Received: (qmail invoked by alias); 08 May 2007 11:28:07 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp037) with SMTP; 08 May 2007 13:28:07 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19M0zQzkk5MX4iG4GNKNfzs3Dj4HKgyc3xgZN5xis
	yQgHOgTXIJlf06
X-X-Sender: gene099@racer.site
In-Reply-To: <7v4pmn4oxj.fsf_-_@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46567>

Hi,

On Tue, 8 May 2007, Junio C Hamano wrote:

> I was trying to run git-svn against this:
> 
> 	https://repo.socialtext.net:8999/svn/socialtext/trunk
> 
> This is an open source project [*1*] and the trunk is supposed
> to be readable by everybody, but it seems that anything outside
> that area needs authentication.  If I mimick the example in
> git-svn.txt manual page to clone from there, it creates trunk,
> trunk/.git, and then asks for password:
> 
> 	$ URL=https://repo.socialtext.net:8999/svn/socialtext/trunk
> 	$ git-svn clone $URL
>         Authentication realm: <https://repo.socialtext.net:8999> Auth for SVN
> 	Password for 'junio': ^C

FWIW I encountered the same problem with tailor.

Ciao,
Dscho
