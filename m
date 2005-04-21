From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [PATCH] Add DEST Makefile variable
Date: Fri, 22 Apr 2005 01:07:32 +0200
Message-ID: <20050421230732.GA13311@kiste.smurf.noris.de>
References: <20050421123904.9F2EB7F8AD@smurf.noris.de> <7vr7h3d9cu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 01:06:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOkkg-0003k7-6z
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 01:06:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261712AbVDUXKU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 19:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261708AbVDUXKR
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 19:10:17 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:20360 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S261682AbVDUXIk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2005 19:08:40 -0400
Received: from kiste.smurf.noris.de ([192.109.102.35] ident=mail)
	by server.smurf.noris.de with smtp (Exim 4.50)
	id 1DOklg-0005aW-AP; Fri, 22 Apr 2005 01:07:47 +0200
Received: (nullmailer pid 14229 invoked by uid 501);
	Thu, 21 Apr 2005 23:07:32 -0000
To: Junio C Hamano <junio@siamese.dyndns.org>
Content-Disposition: inline
In-Reply-To: <7vr7h3d9cu.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6+20040907i
X-Smurf-Spam-Score: -2.5 (--)
X-Smurf-Whitelist: +relay_from_hosts
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

Junio C Hamano:
> I sent essentially the same some time ago and got a comment to
> follow established naming convention.
> 
Well, for a Makefile which installs in basically one directory, that
seems to be overkill.

>     # DESTDIR=
>     BINDIR=$(HOME)/bin
>             install foobar $(DESTDIR)$(BINDIR)/
> 
That doesn't make sense; if you set DESTDIR, you are not going to
install in $HOME.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
