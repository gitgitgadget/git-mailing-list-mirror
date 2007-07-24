From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git log -g: Complain, but do not fail, when no reflogs
 are there
Date: Tue, 24 Jul 2007 10:16:21 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707241014500.14781@racer.site>
References: <Pine.LNX.4.64.0707240039300.14781@racer.site>
 <81b0412b0707240026v4321a709wcbbbd7b67a4c506b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 11:16:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDGVW-0007W4-UG
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 11:16:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759461AbXGXJQk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 05:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759321AbXGXJQk
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 05:16:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:37414 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756769AbXGXJQj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 05:16:39 -0400
Received: (qmail invoked by alias); 24 Jul 2007 09:16:37 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp056) with SMTP; 24 Jul 2007 11:16:37 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/i3Q16mEXiRXdulTKPGuNaK5qUYWwtAlPGkJFxEm
	+fPgimARXmfe39
X-X-Sender: gene099@racer.site
In-Reply-To: <81b0412b0707240026v4321a709wcbbbd7b67a4c506b@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53541>

Hi,

On Tue, 24 Jul 2007, Alex Riesen wrote:

> On 7/24/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > 
> > When asking "git log -g --all", clearly you want to see only those refs
> > that do have reflogs, but you do not want it to fail, either.
> > 
> > So instead of die()ing, complain about it, but move on to the other refs.
> > 
> 
> I believe you wont even see these complaints: the pager will start shortly
> afterwards and fill the screen with commits, completely hiding the errors.

You can see it briefly, but it is hidden by default.  Which is a good 
thing.  If you set the pager to "cat" (which is happily not the default!) 
you can see them clearly.  Until you are swamped by the rest of the 
output.

Maybe this is a feature?

Ciao,
Dscho
