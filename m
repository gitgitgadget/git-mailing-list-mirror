From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git gc and git repack
Date: Tue, 6 Mar 2007 22:13:19 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703062211450.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <loom.20070306T165455-693@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Sergio Callegari <scallegari@arces.unibo.it>
X-From: git-owner@vger.kernel.org Tue Mar 06 22:13:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOgyL-000254-48
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 22:13:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273AbXCFVNV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 16:13:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932334AbXCFVNV
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 16:13:21 -0500
Received: from mail.gmx.net ([213.165.64.20]:43826 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932273AbXCFVNU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 16:13:20 -0500
Received: (qmail invoked by alias); 06 Mar 2007 21:13:19 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp016) with SMTP; 06 Mar 2007 22:13:19 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18P1/UVWmcPbxyLOEYDFjUNaom/LmvkbNj7OKNKfr
	UxRKnmAV3uSTgB
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <loom.20070306T165455-693@post.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41593>

Hi,

On Tue, 6 Mar 2007, Sergio Callegari wrote:

> I am puzzled by a different behavior when doing housekeeping with git-gc and
> git-repack:
>
> [...] 
> Done counting 75 objects.
> [...]
>
> while git repack -a -d gives
> 
> Done counting 143 objects.
> 
> I suspect, this has to to with my repository using alternates... (in 
> fact git-gc and git-repack start behaving identically if I pass the -l 
> (local) option to repack...  can anyone confirm that this is the only 
> difference?

Yes. And if you look in git-gc, you'll see as to why: it uses the -l flag.

> Also can anybody confirm whether git repack -a -d actually includes in 
> the pack also _all_ the "borrowed" objects? I.e. if it is in fact a way 
> to convert a repository that borrows objects into one that is 
> self-standing?

Yes exactly.

Ciao,
Dscho
