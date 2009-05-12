From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Supporting hashes other than SHA-1
Date: Tue, 12 May 2009 16:06:17 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0905121604560.4447@intel-tinevez-2-302>
References: <20090511195242.GA14756@foursquare.net> <m3zldjl5bq.fsf@localhost.localdomain> <m3vdo6lbuy.fsf@localhost.localdomain> <4A0980C8.7060106@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>,
	Chris Frey <cdfrey@foursquare.net>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue May 12 16:07:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3sd1-0006aQ-Q0
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 16:06:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752327AbZELOGU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2009 10:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752189AbZELOGT
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 10:06:19 -0400
Received: from mail.gmx.net ([213.165.64.20]:34022 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751388AbZELOGT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2009 10:06:19 -0400
Received: (qmail invoked by alias); 12 May 2009 14:06:18 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp059) with SMTP; 12 May 2009 16:06:18 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19pgQx2gWlpobk2rnpULWOa6Ggv4sR20VFe0ApMSf
	GqLcRFSiO4mk2V
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <4A0980C8.7060106@op5.se>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118897>

Hi,

On Tue, 12 May 2009, Andreas Ericsson wrote:

> Jakub Narebski wrote:
> > Jakub Narebski <jnareb@gmail.com> writes:
> > 
> > > Chris Frey <cdfrey@foursquare.net> writes:
> > >
> > > > Considering the recent news regarding SHA-1's newly found weaknesses,
> > > > is there any general interest in making git flexible enough to support
> > > > other hashes in the future?
> > > First, there isn't as far as I know any 'known preimage' attack
> > > against SHA-1, and only that would truly matter for Git.
> > >
> > > Second, this issue was discussed in depth in the past; check git
> > > mailing list archives, please...
> > 
> > See also this blog entry (and comments):
> >   http://kitenet.net/~joey/blog/entry/sha-1/
> > 
> 
> It's a bit harder than that, since both pre-images have to be the same
> size.

They don't.  The pre-images prefixed by the type identifier and the size 
in ASCII need to have the same hash.  There is a difference.

Ciao,
Dscho
