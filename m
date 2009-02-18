From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Use DIFF_XDL_SET/DIFF_OPT_SET instead of raw
 bit-masking
Date: Wed, 18 Feb 2009 22:22:11 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902182219370.10279@pacific.mpi-cbg.de>
References: <1234841209-3960-1-git-send-email-keith@cs.ucla.edu> <alpine.DEB.1.00.0902171304130.6185@intel-tinevez-2-302> <alpine.GSO.2.00.0902170918180.27811@kiwi.cs.ucla.edu> <alpine.DEB.1.00.0902172354570.10279@pacific.mpi-cbg.de>
 <alpine.GSO.2.00.0902181238320.29723@kiwi.cs.ucla.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@madism.org>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Keith Cascio <keith@CS.UCLA.EDU>
X-From: git-owner@vger.kernel.org Wed Feb 18 22:22:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZtsQ-0002PP-5t
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 22:22:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753689AbZBRVVN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 16:21:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752491AbZBRVVN
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 16:21:13 -0500
Received: from mail.gmx.net ([213.165.64.20]:38656 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752020AbZBRVVM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 16:21:12 -0500
Received: (qmail invoked by alias); 18 Feb 2009 21:21:10 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp047) with SMTP; 18 Feb 2009 22:21:10 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX187Lbtn3RI7Dfny3frDQSChizma39b8TCfLUIrf2I
	Wy2knnv0Bf5lwf
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.GSO.2.00.0902181238320.29723@kiwi.cs.ucla.edu>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110579>

Hi,

On Wed, 18 Feb 2009, Keith Cascio wrote:

> On Tue, 17 Feb 2009, Johannes Schindelin wrote:
> 
> > > >  diff.h |    3 +++
> > > >  diff.c |   17 ++++++++++-------
> > > >  2 files changed, 13 insertions(+), 7 deletions(-)
> > 
> > If you had not so conveniently clipped what I quoted just before the 
> > three dots, I could point out that it adds roughly double the number 
> > of lines as it removes.
> 
> Didn't they say on Mount Sinai?
> 
> "Thou shalt not judge a patch on the diffstat alone."

Okay, you asked for it.  I tried to be gentle.

I see _no_ value in your changes, and the diffstat as a _very_ real 
downside.

If the code would become clearer with your patch, I would not mind.  But I 
find that the result is not more readable than the original.

As part of a parse-optification, I would not mind.  But before that, no.

Ciao,
Dscho
