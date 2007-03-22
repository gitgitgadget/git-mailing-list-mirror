From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] bisect: show the maximal number of commits to be tested
Date: Thu, 22 Mar 2007 03:15:20 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703220314440.4045@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070317141209.GA7838@cepheus>
 <Pine.LNX.4.63.0703171845541.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070317195840.GA20735@informatik.uni-freiburg.de> <20070321210454.GA2844@lala>
 <Pine.LNX.4.64.0703211521290.6730@woody.linux-foundation.org>
 <Pine.LNX.4.63.0703220240590.4045@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vhcsexcc3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148973799-1202942512-1174529720=:4045"
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Uwe =?utf-8?Q?Kleine-?= =?utf-8?Q?K=C3=B6nig?= 
	<ukleinek@informatik.uni-freiburg.de>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Mar 22 03:15:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUCq0-0001MH-7z
	for gcvg-git@gmane.org; Thu, 22 Mar 2007 03:15:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974AbXCVCPW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Mar 2007 22:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751856AbXCVCPW
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Mar 2007 22:15:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:58937 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751004AbXCVCPW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2007 22:15:22 -0400
Received: (qmail invoked by alias); 22 Mar 2007 02:15:20 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp031) with SMTP; 22 Mar 2007 03:15:20 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+je79W92ejM2BG+fJv5AuChcMDxtrk6LHVUtBEfi
	/Tr+30BMxqw0KK
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vhcsexcc3.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42833>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148973799-1202942512-1174529720=:4045
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Wed, 21 Mar 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Since git-bisect already asks rev-list to find the midpoint (and rev-list
> > consequently counts the number of commits), rev-list can pass it the
> > maximal number of commits.
> >
> > As a bonus, this avoids an extra call to rev-list.
> >
> > Miscalculation noticed by Uwe, implementation suggested by Linus.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >
> > 	On Wed, 21 Mar 2007, Linus Torvalds wrote:
> >
> > 	> On Wed, 21 Mar 2007, Uwe Kleine-König wrote:
> > 	> >
> > 	> > Up to now the number printed was calculated assuming that the 
> > 	> > current revision to test is bad.  Given that it's not possible 
> > 	> > that this always matches the number of suspicious revs if the 
> > 	> > current one is good, the maximum of both is taken now.
> > 	> 
> > 	> How about adding a new flag to "git-rev-list", to make it count 
> > 	> both ways?
> >
> > 	Did I understand you correctly?
> 
> Why not show both, or at least total?
> 
> This and the earlier optimization patch steps on each others
> toes, ouch ;-).

Yes... on both accounts. I'll let your patches settle first, and resubmit.

Ciao,
Dscho

---1148973799-1202942512-1174529720=:4045--
