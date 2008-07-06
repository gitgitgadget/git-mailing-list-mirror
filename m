From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Allow cherry-picking root commits
Date: Sun, 6 Jul 2008 14:48:17 +0200 (CEST)
Message-ID: <alpine.LSU.1.00.0807061446160.3486@wbgn129.biozentrum.uni-wuerzburg.de>
References: <alpine.DEB.1.00.0807031142540.9925@racer> <1214879914-17866-1-git-send-email-s-beyer@gmx.net> <1214879914-17866-2-git-send-email-s-beyer@gmx.net> <7vbq1f68rh.fsf@gitster.siamese.dyndns.org> <20080703210950.GC6677@leksak.fem-net>
 <alpine.DEB.1.00.0807040138090.2849@eeepc-johanness> <20080704003857.GG6677@leksak.fem-net> <alpine.DEB.1.00.0807040252490.2849@eeepc-johanness> <20080704015326.GI6677@leksak.fem-net> <alpine.DEB.1.00.0807041617320.9925@racer>
 <20080706113548.GC6731@leksak.fem-net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Sun Jul 06 14:49:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFTg4-0003i9-UE
	for gcvg-git-2@gmane.org; Sun, 06 Jul 2008 14:49:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757122AbYGFMsV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2008 08:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757089AbYGFMsU
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jul 2008 08:48:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:40806 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757063AbYGFMsT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2008 08:48:19 -0400
Received: (qmail invoked by alias); 06 Jul 2008 12:48:18 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp065) with SMTP; 06 Jul 2008 14:48:18 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/WvllCmXfW9k2+3JKJUWj5pkDZ95gz6lVcakYPk6
	XG+zQBWygw2YdR
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <20080706113548.GC6731@leksak.fem-net>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.75
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87524>

Hi,

On Sun, 6 Jul 2008, Stephan Beyer wrote:

> And yes, there may even be no use case for reverting root commits.

That weighs much heavier than that it would be hard to implement.  
When writing the patch, I spent 2 minutes thinking about a possible case 
where reverting a root commit would make sense.  And I came up with none.

It can be sensible to undo _parts_ of it, but then it is no longer about 
reverting the root commit, but about applying a partial patch with a new 
commit message, and we support that quite nicely already.

Ciao,
Dscho
