From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: suggestion for git stash
Date: Sun, 30 Sep 2007 22:29:05 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709302226270.28395@racer.site>
References: <200709302050.41273.bruno@clisp.org> <7vfy0vhqkl.fsf@gitster.siamese.dyndns.org>
 <200709302259.11731.bruno@clisp.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Bruno Haible <bruno@clisp.org>
X-From: git-owner@vger.kernel.org Sun Sep 30 23:30:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ic6Mt-000713-CK
	for gcvg-git-2@gmane.org; Sun, 30 Sep 2007 23:30:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752347AbXI3VaU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2007 17:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752325AbXI3VaS
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Sep 2007 17:30:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:60024 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752347AbXI3VaR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2007 17:30:17 -0400
Received: (qmail invoked by alias); 30 Sep 2007 21:30:15 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp052) with SMTP; 30 Sep 2007 23:30:15 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18VyYNjsu0V3aR4lZw0CE+5QWvfiR1dGeO9/DoPnd
	ZWBh8N3LqdknQh
X-X-Sender: gene099@racer.site
In-Reply-To: <200709302259.11731.bruno@clisp.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59570>

Hi,

On Sun, 30 Sep 2007, Bruno Haible wrote:

> I don't know what "git stash apply --index" does, since it's not 
> documented.

It's documented in code ;-)

No, really, what it does is trying to reinstate not only the working 
tree's changes, but also the index' ones.  However, this can fail, when 
you have conflicts (which are stored in the index, where you therefore can 
no longer apply the changes as they were originally).

Now that you know what --index is supposed to do, maybe you are nice 
enough to extend the documentation and post a patch?

Thanks,
Dscho
