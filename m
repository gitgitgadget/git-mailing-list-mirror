From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: name-rev does not show the shortest path
Date: Sat, 25 Aug 2007 17:04:33 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0708251701150.16728@wbgn129.biozentrum.uni-wuerzburg.de>
References: <20070823103817.GF6573@informatik.uni-freiburg.de>
 <Pine.LNX.4.64.0708241253050.8987@reaper.quantumfyre.co.uk>
 <20070824125230.GA12030@informatik.uni-freiburg.de>
 <Pine.LNX.4.64.0708241615040.7313@reaper.quantumfyre.co.uk>
 <7v6434eq9o.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Julian Phillips <julian@quantumfyre.co.uk>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<ukleinek@informatik.uni-freiburg.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 25 17:05:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOxCD-0007dw-Ff
	for gcvg-git@gmane.org; Sat, 25 Aug 2007 17:05:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760767AbXHYPEh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Aug 2007 11:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761511AbXHYPEh
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Aug 2007 11:04:37 -0400
Received: from mail.gmx.net ([213.165.64.20]:35906 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759153AbXHYPEg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Aug 2007 11:04:36 -0400
Received: (qmail invoked by alias); 25 Aug 2007 15:04:34 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp056) with SMTP; 25 Aug 2007 17:04:34 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/sPABUSWrsXHMi1ruuDSfHggsg7y5LoHLNkVyIxw
	uIcrjeDZrREnvp
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <7v6434eq9o.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56640>

Hi,

On Fri, 24 Aug 2007, Junio C Hamano wrote:

> I _think_ name-rev goes for shorter-to-type tags and does not have any 
> other heuristics.  Dscho?

I briefly looked into this, and did not find out why it is behaving that 
way.  It _should_ pick the closer one with this code:

        } else if (name->merge_traversals > merge_traversals ||
                        (name->merge_traversals == merge_traversals &&
                         name->generation > generation)) {

However, it did not even get to that code in my tests.  I'll have to look 
at that problem closer in a quiet moment (which I will not have for at 
least another 24 hours).

Ciao,
Dscho
