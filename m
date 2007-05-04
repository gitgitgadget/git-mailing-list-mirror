From: Sven Verdoolaege <skimo@liacs.nl>
Subject: Re: [PATCH 2/5] git-config: add --remote option for reading config from remote repo
Date: Fri, 4 May 2007 23:10:05 +0200
Message-ID: <20070504211004.GA1719@liacs.nl>
References: <11782762032207-git-send-email-skimo@liacs.nl> <1178276203127-git-send-email-skimo@liacs.nl> <20070504210339.GB30324@planck.djpig.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Fri May 04 23:10:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hk52o-0007Gz-6N
	for gcvg-git@gmane.org; Fri, 04 May 2007 23:10:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S376157AbXEDVKX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 17:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161544AbXEDVKX
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 17:10:23 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:51776 "EHLO rhodium.liacs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161531AbXEDVKW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 17:10:22 -0400
Received: from pc117b.liacs.nl (pc117b.liacs.nl [132.229.129.143])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id l44LA5XS015006;
	Fri, 4 May 2007 23:10:10 +0200
Received: by pc117b.liacs.nl (Postfix, from userid 17122)
	id BCCED7DD9C; Fri,  4 May 2007 23:10:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070504210339.GB30324@planck.djpig.de>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46216>

On Fri, May 04, 2007 at 11:03:40PM +0200, Frank Lichtenheld wrote:
> 
> Some comments on the documentation:
> 
> On Fri, May 04, 2007 at 12:56:40PM +0200, Sven Verdoolaege wrote:
> > +'git-config' [--system | --global | --remote=[<host>:]<directory ]
> > +	     [type] name [value [value_regex]]
> 
> maybe something more like
> 
> 'git-config' [ scope ]

Sounds reasonable, although I'd probably say [<scope>].

> > +--remote=[<host>:]<directory
> > +	Use remote config instead of the repository .git/config.
> > +	Only available for reading options.
> 
> Why did you add it to all options in the SYNOPSYS then?

Because I wasn't thinking.

skimo
