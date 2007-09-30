From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: A tour of git: the basics (and notes on some unfriendly messages)
Date: Sun, 30 Sep 2007 13:44:48 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709301343000.28395@racer.site>
References: <87ir5us82a.wl%cworth@cworth.org> <20070929000056.GZ3099@spearce.org>
 <E5C688F2-4A8D-402A-9757-5007BE4A8B25@zib.de> <7vlkapjeir.fsf@gitster.siamese.dyndns.org>
 <E8851B12-AAA5-4B4D-9F28-C5AB5AEF0E57@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Carl Worth <cworth@cworth.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Sep 30 14:46:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbyBY-0008Qd-Sx
	for gcvg-git-2@gmane.org; Sun, 30 Sep 2007 14:46:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754940AbXI3MqE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2007 08:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755030AbXI3MqD
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Sep 2007 08:46:03 -0400
Received: from mail.gmx.net ([213.165.64.20]:38722 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754629AbXI3MqB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2007 08:46:01 -0400
Received: (qmail invoked by alias); 30 Sep 2007 12:45:59 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp010) with SMTP; 30 Sep 2007 14:45:59 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18iV0R1Uo0ig7P3GxRfM5eMrGgz748uZ8Qxp2hrHB
	8mmhGgZWu9p5cH
X-X-Sender: gene099@racer.site
In-Reply-To: <E8851B12-AAA5-4B4D-9F28-C5AB5AEF0E57@zib.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59537>

Hi,

On Sun, 30 Sep 2007, Steffen Prohaska wrote:

> 
> On Sep 30, 2007, at 12:25 AM, Junio C Hamano wrote:
> 
> > Steffen Prohaska <prohaska@zib.de> writes:
> > 
> > > - git push: prints updates of remote heads. A message about
> > >   failing to update a remote head may get lost.
> > 
> > Please do not remove the report of successful update, as people often 
> > say "git push" or "git push $there" without explicitly saying which 
> > refs to push.  When pushing out to publish, I say "git push ko" (to 
> > mean k.org) and I _want_ my positive feedback.
> 
> Yes but it's pretty technical.
> 
> A much simpler output could be easier to scan by a human
> 
> updating 'refs/heads/master' .. fast forward .. ok.
> updating 'refs/heads/pu' .. forced non-fast forward .. ok.
> updating 'refs/heads/next' ..
> ERROR: 'refs/heads/next' not updating to non-fast forward
> exit(1) here.

No, please no.  This is way too short.

If at all, please let 8c3275abcacb83ea3f4c4f4ceb2376799fc282bd be an 
example, and make git respect several different output levels, but not 
changing the default (at first).

Ciao,
Dscho
