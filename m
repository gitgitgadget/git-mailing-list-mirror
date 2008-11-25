From: Arafangion <thestar@fussycoder.id.au>
Subject: Re: inted problems when upgrading to 1.6.0.4
Date: Tue, 25 Nov 2008 21:54:19 +1100
Message-ID: <1227610459.3222.4.camel@therock.nsw.bigpond.net.au>
References: <492BC56A.6040506@xmos.com>
	 <1227608420.3222.2.camel@therock.nsw.bigpond.net.au>
	 <492BCFA0.5030708@xmos.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Luis Gutierrez <luis.gutierrez@xmos.com>
X-From: git-owner@vger.kernel.org Tue Nov 25 11:45:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4vPv-0003D0-BW
	for gcvg-git-2@gmane.org; Tue, 25 Nov 2008 11:45:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753341AbYKYKnk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2008 05:43:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753347AbYKYKnk
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Nov 2008 05:43:40 -0500
Received: from nschwmtas04p.mx.bigpond.com ([61.9.189.146]:16989 "EHLO
	nschwmtas04p.mx.bigpond.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752571AbYKYKnj (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Nov 2008 05:43:39 -0500
Received: from nschwotgx03p.mx.bigpond.com ([58.173.132.215])
          by nschwmtas04p.mx.bigpond.com with ESMTP
          id <20081125104336.TNRG1796.nschwmtas04p.mx.bigpond.com@nschwotgx03p.mx.bigpond.com>;
          Tue, 25 Nov 2008 10:43:36 +0000
Received: from therock.local ([58.173.132.215])
          by nschwotgx03p.mx.bigpond.com with ESMTP
          id <20081125104332.BAPZ7031.nschwotgx03p.mx.bigpond.com@therock.local>;
          Tue, 25 Nov 2008 10:43:32 +0000
In-Reply-To: <492BCFA0.5030708@xmos.com>
X-Mailer: Evolution 2.6.3 
X-RPD-ScanID: Class unknown; VirusThreatLevel unknown, RefID str=0001.0A150202.492BD6D4.0103,ss=1,fgs=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101657>

On Tue, 2008-11-25 at 10:12 +0000, Luis Gutierrez wrote:
> Arafangion wrote: 
> > On Tue, 2008-11-25 at 09:29 +0000, Luis Gutierrez wrote:
> > <snip>
> >   
> > > All push/pull/clone operations were failing with the dreaded 'fatal: The 
> > > remote end hung up unexpectedly'. After a few tests, this is what I found:
> > > 
> > > - I can clone/pull/push if I do it through ssh (ie, git clone 
> > > ssh://server/project)
> > > - I can clone/pull/push if I start git daemon on the command line through
> > > git daemon --syslog --verbose --export-all 
> > > --base-path=/vol0/git/projects --verbose --reuseaddr
> > > 
> > > But the way I had setup git, through xinetd is broken.
> > >     
> > 
> > I'm just guessing, as I'm too new to the git world to respond with more
> > expertise, but I will suggest that perhaps your problem is that your
> > $PATH is different with the xinitd configuration as contrasted with your
> > ssh configuration, as the locations of the git binaries could be
> > different.
> > 
> >   
> I've tried that, they are the same:
> 
> # which git
> /usr/local/bin/git

What about the other git-* commands?

> 
