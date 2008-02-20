From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Minor annoyance with git push
Date: Wed, 20 Feb 2008 13:06:59 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802201305350.17164@racer.site>
References: <46a038f90802072044u3329fd33w575c689cba2917ee@mail.gmail.com> <20080209030046.GA10470@coredump.intra.peff.net> <6B804F0D-9C3B-46F3-B922-7A5CBEF55522@zib.de> <alpine.LSU.1.00.0802091307160.11591@racer.site> <7v7ihd7ee1.fsf@gitster.siamese.dyndns.org>
 <alpine.LSU.1.00.0802100213330.11591@racer.site> <20080210101756.GB26568@coredump.intra.peff.net> <alpine.LSU.1.00.0802101219280.11591@racer.site> <20080210122321.GA31009@coredump.intra.peff.net> <alpine.LSU.1.00.0802101303140.11591@racer.site>
 <7vzltwavf9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Steffen Prohaska <prohaska@zib.de>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 20 14:08:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRofz-0006oj-7o
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 14:07:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752039AbYBTNHT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2008 08:07:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751727AbYBTNHS
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 08:07:18 -0500
Received: from mail.gmx.net ([213.165.64.20]:36509 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751666AbYBTNHR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2008 08:07:17 -0500
Received: (qmail invoked by alias); 20 Feb 2008 13:07:15 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp055) with SMTP; 20 Feb 2008 14:07:15 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19sLjsA/jtsmh9V3og+OdBxcd1EGRM9X2zbvLWjpz
	bO7B2r6EaCKVsW
X-X-Sender: gene099@racer.site
In-Reply-To: <7vzltwavf9.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74512>

Hi,

On Wed, 20 Feb 2008, Junio C Hamano wrote:

> Putting this "push = HEAD" by default when "git clone" and "git remote 
> add" creates the [remote "$remote"] section is probably possible, and at 
> that stage we may even be able to do the "if the other end is shared, 
> then set this up automagically", as the result of the magic can be 
> inspected in the resulting config file.

I think this is too magic, both of it.  Once people get used to "git push" 
being implicitly "git push origin HEAD", why should they not expect "git 
push <somewhere-else>" to push "HEAD" implicitly, too?

Ciao,
Dscho
