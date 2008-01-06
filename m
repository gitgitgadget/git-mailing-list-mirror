From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] filter-branch: work correctly with ambiguous
 refnames
Date: Sun, 6 Jan 2008 09:14:15 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801060912310.10101@racer.site>
References: <Pine.LNX.4.64.0712301700580.14355@wbgn129.biozentrum.uni-wuerzburg.de> <1199040667-31850-1-git-send-email-dpotapov@gmail.com> <7v7iiqppkw.fsf@gitster.siamese.dyndns.org> <20080104155114.GS3373@dpotapov.dyndns.org> <7vr6gxjpyn.fsf@gitster.siamese.dyndns.org>
 <alpine.LSU.1.00.0801051601490.10101@racer.site> <7vabnk81aw.fsf_-_@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0801060154150.10101@racer.site> <7v8x337jgn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 06 10:14:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBRaj-0002xo-4E
	for gcvg-git-2@gmane.org; Sun, 06 Jan 2008 10:14:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753098AbYAFJOW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2008 04:14:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbYAFJOW
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jan 2008 04:14:22 -0500
Received: from mail.gmx.net ([213.165.64.20]:36894 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752864AbYAFJOU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2008 04:14:20 -0500
Received: (qmail invoked by alias); 06 Jan 2008 09:14:17 -0000
Received: from R3e32.r.pppool.de (EHLO [192.168.220.101]) [89.54.62.50]
  by mail.gmx.net (mp006) with SMTP; 06 Jan 2008 10:14:17 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX182YJMHnH82SO0dR0kQHp0/P1VgdNC+YzoMYMdB9V
	jrT54rg9Qcqx0Q
X-X-Sender: gene099@racer.site
In-Reply-To: <7v8x337jgn.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69720>

Hi Junio,

On Sat, 5 Jan 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > In any case, from a cursory look I like the 2 patches (except for the 
> > curly brackets around the single-line "else" clause, but I know your 
> > opinion about this, so I will not object).
> 
> And obviously I care more about correctness, so I'd appreciate a review 
> with non cursory look if you have time.

I will be in the train for 5.5 hours tomorrow, and hope to do a less 
cursory review then.

Ciao,
Dscho
