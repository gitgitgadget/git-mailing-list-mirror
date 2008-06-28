From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] shrink git-shell by avoiding redundant dependencies
Date: Sat, 28 Jun 2008 18:31:45 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806281830410.9925@racer>
References: <1214602538-7888-1-git-send-email-dpotapov@gmail.com>  <alpine.DEB.1.00.0806281542160.9925@racer> <37fcd2780806280948y143b619p60f05495ca85454b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 28 19:34:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCeJy-0000ez-Mx
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 19:34:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753207AbYF1Rdp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jun 2008 13:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753167AbYF1Rdp
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jun 2008 13:33:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:34241 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752781AbYF1Rdo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jun 2008 13:33:44 -0400
Received: (qmail invoked by alias); 28 Jun 2008 17:33:42 -0000
Received: from 87.113.36.200.plusnet.pte-ag1.dyn.plus.net (EHLO racer.local) [87.113.36.200]
  by mail.gmx.net (mp041) with SMTP; 28 Jun 2008 19:33:42 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX180E1pdzTY0r1T7uafGfRrYIFuyNFf7KK/i87RdFT
	2vhaJUYl0ooVHP
X-X-Sender: gene099@racer
In-Reply-To: <37fcd2780806280948y143b619p60f05495ca85454b@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86733>

Hi,

Thanks for the explanation.  Somehow I thought "strip" would do what an 
efficient linker should have done before, but I was wrong.

On Sat, 28 Jun 2008, Dmitry Potapov wrote:

> BTW, it is possible to reduce the "text" and "data" size twice more 
> using the whole program optimization, as it will discard some functions 
> that are not actually used, but I don't think it is worth pursuing as it 
> will complicate complication.

Heh.  Indeed, the complication will be complicated ;-)

Ciao,
Dscho
