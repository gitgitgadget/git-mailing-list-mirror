From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-cvsimport: Add -N option to force a new import
Date: Thu, 25 Oct 2007 10:56:36 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710251055590.25221@racer.site>
References: <1193268519.8008.11.camel@mattlaptop2>  <7vfxzz51d7.fsf@gitster.siamese.dyndns.org>
 <1193284913.2619.23.camel@mattlaptop2>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matt McCutchen <matt@mattmccutchen.net>
X-From: git-owner@vger.kernel.org Thu Oct 25 11:57:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkzTM-0006c3-EX
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 11:57:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754766AbXJYJ5L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 05:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755874AbXJYJ5J
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 05:57:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:52115 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754766AbXJYJ5I (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 05:57:08 -0400
Received: (qmail invoked by alias); 25 Oct 2007 09:57:06 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp040) with SMTP; 25 Oct 2007 11:57:06 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19LfbwsebhLvcdsXgWOJVj8fE1e7I0UEG8iOyL/36
	9xxq7K+KJOVKSL
X-X-Sender: gene099@racer.site
In-Reply-To: <1193284913.2619.23.camel@mattlaptop2>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62290>

Hi,

On Thu, 25 Oct 2007, Matt McCutchen wrote:

> On Wed, 2007-10-24 at 20:17 -0700, Junio C Hamano wrote:
> > Matt McCutchen <matt@mattmccutchen.net> writes:
> > 
> > > I had a git repository for development of rsync and wanted to start
> > > importing the upstream CVS with git-cvsimport, but git-cvsimport saw
> > > that the git repository existed and insisted on updating a previous
> > > import.  This patch adds an -N option to git-cvsimport to force a new
> > > import and updates the documentation appropriately.
> > 
> > Sounds like a useful addition.  Tests?
> 
> Are there existing tests for git-cvsimport somewhere whose example I
> could follow?  (I didn't see any in t/ .)  If not, I suppose I will just
> write a simple script that runs git-cvsimport with and without -N and
> with and without an existing, empty git repository and checks that the
> right things happen.

My best bet: t/t9200-cvsexportcommit.sh

Hth,
Dscho
