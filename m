From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [JGIT PATCH 2/2] Make Repository.isValidRefName compatible with
 Git 1.6.3
Date: Fri, 8 May 2009 11:54:08 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0905081153050.4601@intel-tinevez-2-302>
References: <1241708714-20326-1-git-send-email-spearce@spearce.org> <1241708714-20326-2-git-send-email-spearce@spearce.org> <200905080102.44053.robin.rosenberg@dewire.com> <alpine.LFD.2.01.0905071620240.4983@localhost.localdomain> <7vprekbfik.fsf@alter.siamese.dyndns.org>
 <20090508004741.GU30527@spearce.org> <81b0412b0905080024r211864bfhe7f70acabe0880c6@mail.gmail.com> <alpine.DEB.1.00.0905081003460.18521@pacific.mpi-cbg.de> <7vljp80yt4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 08 11:54:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2Mmd-0006MW-0J
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 11:54:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753171AbZEHJyP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2009 05:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753885AbZEHJyO
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 05:54:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:48538 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752821AbZEHJyM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2009 05:54:12 -0400
Received: (qmail invoked by alias); 08 May 2009 09:54:11 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp057) with SMTP; 08 May 2009 11:54:11 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX199opoOPkB9Ci9TZAqRsDWhQaDE9pTfAWFYN0zh+q
	goDD4mydWI/txq
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <7vljp80yt4.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118596>

Hi,

On Fri, 8 May 2009, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> There must be at least some deprecation period during which also the 
> >> old .lock lockfiles are considered and created. Just imagine someone 
> >> modifying the ref with an older version, which knows nothing about 
> >> ..lck.
> >
> > As lock files are only supposed to be created by Git itself, and have 
> > a maximum lifetime until the end of the process, I think we do not 
> > need a grace period at all.
> 
> Could there be people with slightly older git and shiny new jgit (or the 
> other combination) working on the same repository?

You mean concurrently?  Sure, but do we have to care?  People doing this 
certainly know what they are doing, and live happily even with a 0.5" 
hole in their foot.

Ciao,
Dscho
