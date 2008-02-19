From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] http-push: push <remote> :<branch> deletes remote
 branch
Date: Tue, 19 Feb 2008 22:25:10 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802192224370.7826@racer.site>
References: <20080218130726.GA26854@localhost> <alpine.LSU.1.00.0802181339470.30505@racer.site> <20080218155546.GA8934@localhost> <alpine.LSU.1.00.0802181733400.30505@racer.site> <20080219125840.GA14049@localhost> <alpine.LSU.1.00.0802191313290.30505@racer.site>
 <20080219132410.GA6553@glandium.org> <alpine.LSU.1.00.0802191328040.30505@racer.site> <7v4pc4iq94.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mike Hommey <mh@glandium.org>, Clemens Buchacher <drizzd@aon.at>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 23:26:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRauY-0001Ti-DU
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 23:26:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759592AbYBSWZ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 17:25:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759268AbYBSWZ0
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 17:25:26 -0500
Received: from mail.gmx.net ([213.165.64.20]:36211 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756254AbYBSWZZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 17:25:25 -0500
Received: (qmail invoked by alias); 19 Feb 2008 22:25:23 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp020) with SMTP; 19 Feb 2008 23:25:23 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18gAhtJjtkgFj/XmI6Ysz1iMjDYZL0WsvsoE7am5O
	qTg6lmryRS0R9U
X-X-Sender: gene099@racer.site
In-Reply-To: <7v4pc4iq94.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74470>

Hi,

On Tue, 19 Feb 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > I think this would not be too much of a hassle.  These days, an 
> > Apache2 is installed on many machines, and it is better to have tests, 
> > than to have no tests, even if they are not exercised everywhere, 
> > right?
> 
> I think a sensible guideline would be:
> 
>  - the core tools are tested by default everywhere;
> 
>  - i18n bits and foreign SCM interface are tested by default,
>    but should allow opting-out;
> 
>  - networking test that needs to open listening ports should be
>    off by default but should allow opting-in.

Fair enough.  Although there is nothing there to debate about, yet.

Ciao,
Dscho
