From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] cmd_reset: don't trash uncommitted changes unless told
 to
Date: Thu, 26 Jun 2008 18:49:33 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806261848230.9925@racer>
References: <20080624222105.GA24549@dervierte>  <7vwskea2ik.fsf@gitster.siamese.dyndns.org>  <48620C1A.6000509@panasas.com>  <alpine.DEB.1.00.0806251109380.9925@racer>  <486220CE.3070103@viscovery.net>  <alpine.DEB.1.00.0806251334060.9925@racer> 
 <20080625135100.GF20361@mit.edu>  <7v63rx2zwf.fsf@gitster.siamese.dyndns.org>  <20080626115550.GA23058@atjola.homenet>  <alpine.DEB.1.00.0806261306060.9925@racer> <32541b130806260855o691d444bpc0843e5f51639430@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Theodore Tso <tytso@mit.edu>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Boaz Harrosh <bharrosh@panasas.com>,
	Steven Walter <stevenrwalter@gmail.com>, git@vger.kernel.org,
	jeske@google.com
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 26 19:53:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBveb-0006Wr-1C
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 19:53:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758886AbYFZRvi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 13:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758818AbYFZRvh
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 13:51:37 -0400
Received: from mail.gmx.net ([213.165.64.20]:55590 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754617AbYFZRvf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 13:51:35 -0400
Received: (qmail invoked by alias); 26 Jun 2008 17:51:32 -0000
Received: from almond.st-and.ac.uk (EHLO almond.st-and.ac.uk) [138.251.155.241]
  by mail.gmx.net (mp011) with SMTP; 26 Jun 2008 19:51:32 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18tCHR+U7QtND0+slZh2PTp53iwu5izL9ZzZpZjQX
	3i6YvN6BO21Nxt
X-X-Sender: gene099@racer
In-Reply-To: <32541b130806260855o691d444bpc0843e5f51639430@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86465>

Hi,

On Thu, 26 Jun 2008, Avery Pennarun wrote:

> On 6/26/08, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > While we are nit-picking: Ted's version does not respect autocrlf, 
> > while Junio's does.
> 
> Is it intentional that git-show doesn't respect autocrlf, or just an 
> oversight?

Funny.  I seem to have answered exactly the same question a few days ago.

"git show" is meant to show the contents of an object.  It does not 
operate on a working directory.  It does not even _need_ a working 
directory.

So, no, it is _not_ an oversight.

Hth,
Dscho
