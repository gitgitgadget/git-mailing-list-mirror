From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git pull opinion
Date: Tue, 6 Nov 2007 18:28:52 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711061828380.4362@racer.site>
References: <3abd05a90711051352t2f6be00bsa862585abd370fb1@mail.gmail.com>
 <fgo5dt$avh$1@ger.gmane.org> <Pine.LNX.4.64.0711060007010.4362@racer.site>
 <3abd05a90711052022j590f1faesb85f4646afd9acec@mail.gmail.com>
 <Pine.LNX.4.64.0711061159240.4362@racer.site> <7v1wb3i6nx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Aghiles <aghilesk@gmail.com>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 06 19:30:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpTCC-0007lC-GO
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 19:30:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754723AbXKFS3u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 13:29:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754650AbXKFS3u
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 13:29:50 -0500
Received: from mail.gmx.net ([213.165.64.20]:33846 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754503AbXKFS3t (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 13:29:49 -0500
Received: (qmail invoked by alias); 06 Nov 2007 18:29:47 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp005) with SMTP; 06 Nov 2007 19:29:47 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19LcZlQdkNLdUoSW1x71tHyEIp0k7tibVhcTGWcXD
	kyv+PeOv44Mr8p
X-X-Sender: gene099@racer.site
In-Reply-To: <7v1wb3i6nx.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63699>

Hi,

On Tue, 6 Nov 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > A pull is just a fetch and a merge.  And a merge is a commit with more 
> > than one parent.  So you can use the command "git reset --hard HEAD^" to 
> > undo a merge, just as you can undo any other commit.
> 
> *DANGER*
> 
> A pull is usually just a fetch and a merge, but sometimes it can fast 
> forward.  ORIG_HEAD, not HEAD^, points at the previous HEAD location in 
> both cases.

Oops. Right.

Thanks,
Dscho
