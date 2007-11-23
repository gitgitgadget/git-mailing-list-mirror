From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [WIP PATCH] Add 'git fast-export', the sister of 'git fast-import'
Date: Fri, 23 Nov 2007 02:11:05 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711230149430.27959@racer.site>
References: <Pine.LNX.4.64.0711210336210.27959@racer.site>  <fi5743$32p$1@ger.gmane.org>
  <Pine.LNX.4.64.0711230050270.27959@racer.site>
 <f329bf540711221723g2754ce03r4da6d429c45668c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: hanwen@xs4all.nl
X-From: git-owner@vger.kernel.org Fri Nov 23 03:11:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvO0v-00039T-WB
	for gcvg-git-2@gmane.org; Fri, 23 Nov 2007 03:11:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752292AbXKWCLM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 21:11:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752232AbXKWCLL
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 21:11:11 -0500
Received: from mail.gmx.net ([213.165.64.20]:46494 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752072AbXKWCLK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 21:11:10 -0500
Received: (qmail invoked by alias); 23 Nov 2007 02:11:08 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp016) with SMTP; 23 Nov 2007 03:11:08 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+mNa5vy+qmVYC27k+r9/7umXENHhZdpTmTFv20iS
	TX/MznnBOsnQ40
X-X-Sender: gene099@racer.site
In-Reply-To: <f329bf540711221723g2754ce03r4da6d429c45668c@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65869>

Hi,

On Thu, 22 Nov 2007, Han-Wen Nienhuys wrote:

> Maybe I'm misunderstanding you, but fast-export just does not seem a 
> mirror of fast-import; perhaps you can name it 'dump-all' or something?

It is a mirror.  It does not necessarily dump all.

> > Maybe you want to specify if all blobs should be output first, and 
> > then the commits?  Or files should be used?  But all of these things 
> > seem to be useless to me.
> 
> No, I want the program to wait for me to tell it what 
> blobs/commits/trees I want. The commit I want to see secondly may depend 
> on the output I read in the first request blob. Right now, for each data 
> dependency I have to start a new git process.

It does not seem like you want a mirror of fast-import, but rather a 
driver.  You might be happy to hear that you can do that already.  Today.
However, you probably want to query different programs about certain 
states of the repository.  This will not change.

> > > Besides being a nuisance, I actually run git on NFS, and every git 
> > > process has to go to NFS a couple times to retrieve the same 
> > > information. This has a noticeable performance impact.
> >
> > Why don't you just work on a local clone?  If it is really performance 
> > critical, and I/O is an issue, you are better off working in a tmpfs.
> 
> In a company setting, NFS is the easiest way to share information with 
> colleagues without breaking access control and making our security staff 
> nervous.  It's also snapshotted and backed up automatically.

So?

How does that prevent you from following my suggestion to do the intensive 
tasks locally, and push when you finished?

Ciao,
Dscho
