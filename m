From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [msysGit] Re: [PATCHv2] Compile fix for MSVC
Date: Tue, 1 Nov 2011 17:40:41 -0500 (CDT)
Message-ID: <alpine.DEB.1.00.1111011738550.32316@s15462909.onlinehome-server.info>
References: <1320088364-25916-1-git-send-email-vfr@lyx.org> <7vd3dcq4s5.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.1110311908240.1930@bonsai2> <CABPQNSaCRRRpEQPG1Mb4DovkMdQSBhHTm-i7y5M4iT+ndHX4XA@mail.gmail.com> <alpine.DEB.1.00.1111011332400.32316@s15462909.onlinehome-server.info>
 <CAAH6HY8WfOQQ4g54y7mriq6BKoJCWYsVPrQUTMndqpKdniLAtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: ramsay@ramsay1.demon.co.uk, msysgit@googlegroups.com,
	Karsten Blees <blees@dcon.de>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Vincent van Ravesteijn <vfr@lyx.org>
X-From: git-owner@vger.kernel.org Tue Nov 01 23:40:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLN0i-0002Ze-Hm
	for gcvg-git-2@lo.gmane.org; Tue, 01 Nov 2011 23:40:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753905Ab1KAWko (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Nov 2011 18:40:44 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:60060 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752676Ab1KAWkn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Nov 2011 18:40:43 -0400
Received: (qmail invoked by alias); 01 Nov 2011 22:40:42 -0000
Received: from s15462909.onlinehome-server.info (EHLO s15462909.onlinehome-server.info) [87.106.4.80]
  by mail.gmx.net (mp036) with SMTP; 01 Nov 2011 23:40:42 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/DyEdu0QPDNEpuWvaV2EaH+X3IDaK/tOLL+8a0xc
	XLk6FH7Z/swznd
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <CAAH6HY8WfOQQ4g54y7mriq6BKoJCWYsVPrQUTMndqpKdniLAtw@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184604>

Hi,

On Tue, 1 Nov 2011, Vincent van Ravesteijn wrote:

> > Maybe if someone donates Jenkins resources, we could make an automatic 
> > branch in the future that has git.sln in it (similar to the 'html' 
> > branch in git.git).
> 
> As long as this means to just run a not so complicated perl script, this 
> Could even be done in a commit hook.

I actually was thinking about something automatic which does not require 
any of the busy msysGit developers to do something manual every once in a 
while.

> Just another question. How does the (msys)git community feel about 
> adding CMake support ? I can probably do that quite easily.

There was somebody who strongly favored CMake over any other solution but 
was not willing to maintain it in the long run (also, I have to admit that 
I have had quite a few problems with CMake, but maybe I am just pampered 
by projects that Just Compile...)

Ciao,
Johannes
