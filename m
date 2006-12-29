From: Robert Fitzsimons <robfitz@273k.net>
Subject: Re: read-for-fill and caching in gitweb (Re: kernel.org mirroring)
Date: Fri, 29 Dec 2006 03:21:26 +0000
Message-ID: <20061229032126.GE6558@localhost>
References: <46a038f90612281245s52bdd868h8c421951c7abeb84@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jeff@garzik.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Rogan Dawes <discard@dawes.za.net>,
	Kernel Org Admin <ftpadmin@kernel.org>,
	Git Mailing List <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 29 04:22:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1H08Jm-0003sZ-1c
	for gcvg-git@gmane.org; Fri, 29 Dec 2006 04:22:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753559AbWL2DV5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Dec 2006 22:21:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753552AbWL2DV4
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Dec 2006 22:21:56 -0500
Received: from igraine.blacknight.ie ([81.17.252.25]:37426 "EHLO
	igraine.blacknight.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753312AbWL2DV4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Dec 2006 22:21:56 -0500
Received: from 213-202-135-153.bas502.dsl.esat.net ([213.202.135.153] helo=localhost)
	by igraine.blacknight.ie with esmtp (Exim 4.60)
	(envelope-from <robfitz@273k.net>)
	id 1H08J1-00022c-TM; Fri, 29 Dec 2006 03:21:16 +0000
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <46a038f90612281245s52bdd868h8c421951c7abeb84@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-blacknight-igraine-MailScanner-Information: Please contact the ISP for more information
X-blacknight-igraine-MailScanner: Found to be clean
X-blacknight-igraine-MailScanner-SpamCheck: not spam,
	SpamAssassin (not cached, score=-0.012, required 7,
	autolearn=disabled, RCVD_IN_NERDS_IE -2.00, RCVD_IN_SORBS_DUL 1.99)
X-MailScanner-From: robfitz@273k.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35576>

> I will probably try to implement caching for the
> projects, summary & log/shortlog pages using Cache::FastMap

Here are the mean (and standard deviation) in milliseconds for those
pages using a few different versions of gitweb.

                 project_list   summary  shortlog        log
v267                  173 1.6  1141 8.8   795 5.0   919  1.9
1.4.4.3               220 2.3   397 2.4   930 4.2  1113 56.9
1.5.0.rc0.g4a4d       226 1.9   292 1.7   352 4.0   491  6.7
1.5.0.rc0.g4a4d        60 1.0   131 0.7   195 1.2   347  3.7
(mod_perl)
 
I think there would be a benefit in deploying a more recent version of
gitweb on kernel.org and and even bigger benefit if it use mod_perl.  I
would be happy to help, if I can.

I'll look into the increase in time for the project_list in more recent
versions of gitweb, tomorrow.

Robert
