From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH 2/5] git-config: add --remote option for reading config from remote repo
Date: Fri, 4 May 2007 23:35:53 +0200
Message-ID: <20070504213553.GC30324@planck.djpig.de>
References: <11782762032207-git-send-email-skimo@liacs.nl> <1178276203127-git-send-email-skimo@liacs.nl> <20070504210339.GB30324@planck.djpig.de> <20070504211004.GA1719@liacs.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sven Verdoolaege <skimo@liacs.nl>
X-From: git-owner@vger.kernel.org Fri May 04 23:38:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hk5UO-0004LK-1x
	for gcvg-git@gmane.org; Fri, 04 May 2007 23:38:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161896AbXEDVik (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 17:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161938AbXEDVij
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 17:38:39 -0400
Received: from planck.djpig.de ([85.10.192.180]:3844 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161896AbXEDVii (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 17:38:38 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id A92CE274015;
	Fri,  4 May 2007 23:38:33 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OM7Mzn7OZm2V; Fri,  4 May 2007 23:37:10 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id D9AAC274013; Fri,  4 May 2007 23:35:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070504211004.GA1719@liacs.nl>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46219>

On Fri, May 04, 2007 at 11:10:05PM +0200, Sven Verdoolaege wrote:
> On Fri, May 04, 2007 at 11:03:40PM +0200, Frank Lichtenheld wrote:
> > 
> > Some comments on the documentation:
> > 
> > On Fri, May 04, 2007 at 12:56:40PM +0200, Sven Verdoolaege wrote:
> > > +'git-config' [--system | --global | --remote=[<host>:]<directory ]
> > > +	     [type] name [value [value_regex]]
> > 
> > maybe something more like
> > 
> > 'git-config' [ scope ]
> 
> Sounds reasonable, although I'd probably say [<scope>].

Note that this is inconsistent with the rest of the documentation
(e.g. it says [type], not [<type>]). 

> > > +--remote=[<host>:]<directory
> > > +	Use remote config instead of the repository .git/config.
> > > +	Only available for reading options.
> > 
> > Why did you add it to all options in the SYNOPSYS then?
> 
> Because I wasn't thinking.

Another small error: You seem to be missing a '>' after each occourence of 
'<directory'.

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
