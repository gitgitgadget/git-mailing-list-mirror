From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH for "next"] pretty-formats: add 'format:<string>'
Date: Fri, 23 Feb 2007 20:53:49 +0100
Organization: Dewire
Message-ID: <200702232053.49489.robin.rosenberg.lists@dewire.com>
References: <87k61yt1x2.wl%cworth@cworth.org> <45DE3D5C.5060105@xs4all.nl> <Pine.LNX.4.63.0702230204190.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Han-Wen Nienhuys <hanwen@xs4all.nl>, git@vger.kernel.org,
	junkio@cox.net
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 23 20:52:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKgT7-0006QX-3p
	for gcvg-git@gmane.org; Fri, 23 Feb 2007 20:52:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932578AbXBWTw0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Feb 2007 14:52:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932616AbXBWTw0
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Feb 2007 14:52:26 -0500
Received: from [83.140.172.130] ([83.140.172.130]:11943 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S932578AbXBWTwZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Feb 2007 14:52:25 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 9E292802E11;
	Fri, 23 Feb 2007 20:47:24 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 16593-10; Fri, 23 Feb 2007 20:47:24 +0100 (CET)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 4B0CC802AB6;
	Fri, 23 Feb 2007 20:47:22 +0100 (CET)
User-Agent: KMail/1.9.4
In-Reply-To: <Pine.LNX.4.63.0702230204190.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40465>

fredag 23 februari 2007 02:07 skrev Johannes Schindelin:
> Hi,
> 
> On Fri, 23 Feb 2007, Han-Wen Nienhuys wrote:
> 
> > nitpick:
> > 
> >   \n
> > 
> > for newline would be nice. Similar for backslash, formfeed, alarm, etc.
> 
> Yes, I thought about that. But it would change behaviour (even if I don't 
> think it would do serious damage; the only user of interpolate.[ch] I saw 
> is git-daemon, and that does not need \n, I guess).
Other tools that come to mind, rpm and clearcase use \n vfor newline in the
format argument, which is good because I can guess that even without looking 
at the documentation. %n I'd guess would be for a number of some kind, e..g.
the ordinal number of the commit listed (in subset and order of the listed commits)

> Besides, "%n" is
> 
> - more consistent,
with...?
> - date(1) does it the same way, and
Ok, I learnt something. Never fi
> - you can put BS, FF, AL, etc. into the format string before passing 
>   it as an option to git; git does not have to help you there.
They are hard to type in shells and even harder in gui's.

-- robin
