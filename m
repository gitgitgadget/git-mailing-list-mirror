From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: history of a renamed file
Date: Wed, 23 Apr 2008 17:05:26 +0300
Message-ID: <20080423140526.GC3291@mithlond.arda.local>
References: <480F3369.5080203@melosgmbh.de> <m3y774putc.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christoph Duelli <duelli@melosgmbh.de>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 16:06:49 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jofc2-0000IQ-Dz
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 16:06:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753379AbYDWOFb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 10:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753343AbYDWOFa
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 10:05:30 -0400
Received: from pne-smtpout3-sn2.hy.skanova.net ([81.228.8.111]:60597 "EHLO
	pne-smtpout3-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753340AbYDWOFa (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Apr 2008 10:05:30 -0400
Received: from mithlond.arda.local (80.220.180.181) by pne-smtpout3-sn2.hy.skanova.net (7.3.129)
        id 478BDB96005B116D; Wed, 23 Apr 2008 16:05:27 +0200
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1JofbC-0003mw-HX; Wed, 23 Apr 2008 17:05:26 +0300
Content-Disposition: inline
In-Reply-To: <m3y774putc.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80219>

Jakub Narebski wrote (2008-04-23 06:25 -0700):

> Christoph Duelli <duelli@melosgmbh.de> writes:
> 
> > Is it possible (ideally with gitk) to view the complete history of
> > what is now new/location/x.c *including* the history of changes that
> > occurred when it stil was some/path/x.c?

> Try --follow option, see git-log(1), although I'm not sure if gitk
> supports it (it should).

gitk certainly accepts '--follow' but the option does not work as
expected. For example try

  gitk --follow -- utf8.c

in the Git repository and get surprised. :-)

I noticed the problem two weeks ago and Adam Simpkins elaborated it
a bit. See http://thread.gmane.org/gmane.comp.version-control.git/79008
