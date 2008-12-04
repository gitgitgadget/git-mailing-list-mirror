From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git rebase --continue with goofy error
Date: Thu, 4 Dec 2008 18:43:51 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0812041842150.7045@racer>
References: <5AC243B6-F048-4286-80E1-1D0E695792B9@illumaware.com> <49380639.3010508@drmicha.warpmail.net> <70AE8AF8-9353-442A-A315-047DA176B351@illumaware.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Adrian Klingel <Adrian.Klingel@illumaware.com>
X-From: git-owner@vger.kernel.org Thu Dec 04 18:46:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8IGs-0007R0-ND
	for gcvg-git-2@gmane.org; Thu, 04 Dec 2008 18:45:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755329AbYLDRoe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2008 12:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754846AbYLDRod
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Dec 2008 12:44:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:35342 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753374AbYLDRod (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2008 12:44:33 -0500
Received: (qmail invoked by alias); 04 Dec 2008 17:44:30 -0000
Received: from pD9EB33F3.dip0.t-ipconnect.de (EHLO noname) [217.235.51.243]
  by mail.gmx.net (mp016) with SMTP; 04 Dec 2008 18:44:30 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+UunkldfGU1s7SpSiEuzVfmZnyTqQeWPENbXPDfN
	yuXTijRhe6mQaz
X-X-Sender: gene099@racer
In-Reply-To: <70AE8AF8-9353-442A-A315-047DA176B351@illumaware.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.75
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102352>

Hi,

On Thu, 4 Dec 2008, Adrian Klingel wrote:

> I found out why my "git rebase --continue" was failing.  Do I need to 
> explicitly add the .dotest directory and contents after each rebase 
> failure?

You did _what_?

The directory .dotest/ contains metadata of the rebase.  That you have to 
add it probably means that your commits contain files in that directory.  
Which is bogus.

Just another proof that we were right to move .dotest/ into .git/ (which 
you will benefit from after an upgrade).

Ciao,
Dscho
