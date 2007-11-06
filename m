From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-revert is one of the most misunderstood command in
 git, help users out.
Date: Tue, 6 Nov 2007 12:16:21 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711061214520.4362@racer.site>
References: <1194289301-7800-1-git-send-email-madcoder@debian.org>
 <CD2E6759-9E7E-41E6-8B58-AB6CA9604111@midwinter.com>
 <7vlk9cmiyq.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711052325090.4362@racer.site>
 <7vsl3kjdct.fsf@gitster.siamese.dyndns.org> <7vk5oviqbe.fsf@gitster.siamese.dyndns.org>
 <47305536.5010308@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Steven Grimm <koreth@midwinter.com>,
	Pierre Habouzit <madcoder@debian.org>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Nov 06 13:17:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpNN8-0003yv-3A
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 13:17:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756281AbXKFMRT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 07:17:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756276AbXKFMRT
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 07:17:19 -0500
Received: from mail.gmx.net ([213.165.64.20]:55038 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750999AbXKFMRS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 07:17:18 -0500
Received: (qmail invoked by alias); 06 Nov 2007 12:17:16 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp042) with SMTP; 06 Nov 2007 13:17:16 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19c1w5Dm4RcE688aQ8YXAHuq+gasnXFfOQ2ZfK5Gf
	+ved5Tun6IFtAF
X-X-Sender: gene099@racer.site
In-Reply-To: <47305536.5010308@viscovery.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63667>

Hi,

On Tue, 6 Nov 2007, Johannes Sixt wrote:

> Junio C Hamano schrieb:
> > I am wondering what "git cherry-pick -- <paths>" should do.  My
> > current thinking is that it would not make any sense at all.
> 
> IMO, at least "git cherry-pick -n -- <paths>" makes tons of sense.

I guess you missed that Junio did not specify any commit.  With a commit, 
I agree, it makes tons of sense.

Without a commit, it would default to... uhm... HEAD?  And applying the 
changes to a given file, which are already in HEAD, no, that does not make 
sense.

Ciao,
Dscho
