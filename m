From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-cget: prints elements of C code in the git
 repository
Date: Tue, 24 Mar 2009 15:56:23 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903241555360.7493@intel-tinevez-2-302>
References: <49C8B159.2040600@gmail.com>  <alpine.DEB.1.00.0903241257430.7493@intel-tinevez-2-302>  <49C8E074.4030808@gmail.com>  <20090324135906.GA10644@coredump.intra.peff.net> <e2b179460903240738x272c884q62a666931ce99c2f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1211386942-1237906584=:7493"
Cc: Jeff King <peff@peff.net>, Roel Kluin <roel.kluin@gmail.com>,
	git@vger.kernel.org
To: Mike Ralphson <mike.ralphson@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 15:58:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lm84l-0004Am-MV
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 15:58:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755763AbZCXO42 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 10:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754372AbZCXO42
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 10:56:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:41988 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754902AbZCXO41 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 10:56:27 -0400
Received: (qmail invoked by alias); 24 Mar 2009 14:56:24 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp070) with SMTP; 24 Mar 2009 15:56:24 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/wb2oqV7fw0zkqm/eOCyZBHhoS5Sk4ga7XoVJe7n
	OpmuFzr3TLr3xe
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <e2b179460903240738x272c884q62a666931ce99c2f@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114464>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1211386942-1237906584=:7493
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Tue, 24 Mar 2009, Mike Ralphson wrote:

> 2009/3/24 Jeff King <peff@peff.net>:
> > Wouldn't it be a lot easier to base this on something like ctags, which
> > already knows how to do all the parsing of C quirky C?
> >
> > I.e.:
> >
> >  git ls-files | xargs ctags
> >  vi -t get_sha1
> >
> > Where you can replace "vi" with your editor of choice.
> 
> This kind of pipeline has the benefit that it can actually work on the 
> *repository*, and not just the working copy (as per the posted script).

Did I miss something?  git ls-files pipes only the names to xargs, not the 
full contents, right?

Ciao,
Dscho

--8323329-1211386942-1237906584=:7493--
