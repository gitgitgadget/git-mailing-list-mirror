From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH] rebase -i: only automatically amend commit if HEAD did
	not change
Date: Thu, 24 Jul 2008 14:35:56 +0200
Message-ID: <20080724123556.GA7125@leksak.fem-net>
References: <alpine.DEB.1.00.0807222235520.8986@racer> <7vmyk888z5.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0807241311450.8986@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 24 14:37:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM045-0006p9-Sd
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 14:37:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752010AbYGXMgA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 08:36:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751643AbYGXMgA
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 08:36:00 -0400
Received: from mail.gmx.net ([213.165.64.20]:60576 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751431AbYGXMgA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 08:36:00 -0400
Received: (qmail invoked by alias); 24 Jul 2008 12:35:58 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp061) with SMTP; 24 Jul 2008 14:35:58 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX198iOofZTN8WNL/U7e96nnWdAPQ31fKAFLaoGXYyV
	BPqQfR2+T3TnhQ
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KM032-0000EY-Qk; Thu, 24 Jul 2008 14:35:56 +0200
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807241311450.8986@racer>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.73
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89872>

Hi,

Johannes Schindelin wrote:
> The way it runs with my patch, at least a user has a chance to fix it up 
> without a Git expert standing nearby.
> 
> I will definitely keep this in my personal fork, even in my personal 
> fork of "master" during the rc period.  But if you think it is not worth 
> it, and others seem to be utterly disinterested (instead discussing 
> behavior changes), I will not push further.

I don't know how much my opinion counts here, but I think it definitely
is worth it because I've ran into this *several* times -- "Ooops, where 
is my commit? ... ... ... Ah! F***!", which meant that I had to had to
split accidentally squashed commits.

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
