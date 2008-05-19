From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/3] git-cvsserver: Add support for some binary files
Date: Mon, 19 May 2008 10:34:47 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805191033080.30431@racer>
References: <1210826148-8708-1-git-send-email-mmogilvi_git@miniinfo.net> <7v7idteqzn.fsf@gitster.siamese.dyndns.org> <46a038f90805181538v56aee5b8y33d68b226a62494f@mail.gmail.com> <20080519073535.GA2885@comcast.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Junio C Hamano <junio@pobox.com>, git@vger.kernel.org,
	Martin Langhoff <martin@catalyst.net.nz>,
	Frank Lichtenheld <djpig@debian.org>
To: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
X-From: git-owner@vger.kernel.org Mon May 19 11:36:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jy1mh-0002uP-EM
	for gcvg-git-2@gmane.org; Mon, 19 May 2008 11:35:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754067AbYESJeo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2008 05:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752350AbYESJeo
	(ORCPT <rfc822;git-outgoing>); Mon, 19 May 2008 05:34:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:42650 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751173AbYESJen (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2008 05:34:43 -0400
Received: (qmail invoked by alias); 19 May 2008 09:34:40 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO racer.local) [132.187.25.128]
  by mail.gmx.net (mp006) with SMTP; 19 May 2008 11:34:40 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/qHg95T4Hq3v6fSHNfVjJ1JzAKmkjmdIwAlLUcCt
	88dP3qmQSefmRN
X-X-Sender: gene099@racer
In-Reply-To: <20080519073535.GA2885@comcast.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82421>

Hi,

On Mon, 19 May 2008, Matthew Ogilvie wrote:

> I perceive one remaining big issue for git-cvsserver to be a good 
> replacement for real CVS: The ability to properly support "cvs update -r 
> VERSION", where VERSION could be any branch, tag, CVS version number, or 
> git commit hash. Git-cvsserver can partially support this by checking 
> out a totally different sandbox as "cvs checkout VERSION" (notice no 
> -r), but without the ability to switch versions in place, that is an 
> awkward workaround at best.

I might be missing something obvious, but would it not be better to _not_ 
check out anything, but serve every object straight from the object 
database (possibly with CR/LF mangling)?

Ciao,
Dscho
