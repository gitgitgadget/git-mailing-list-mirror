From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] cvsserver: suppress warnings
Date: Tue, 25 Jul 2006 13:11:35 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607251308380.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0607251247040.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <44C5FB3E.9020301@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Tue Jul 25 13:11:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5KpC-0000Ee-4O
	for gcvg-git@gmane.org; Tue, 25 Jul 2006 13:11:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932310AbWGYLLj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Jul 2006 07:11:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932312AbWGYLLj
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Jul 2006 07:11:39 -0400
Received: from mail.gmx.de ([213.165.64.21]:20406 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932310AbWGYLLi (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Jul 2006 07:11:38 -0400
Received: (qmail invoked by alias); 25 Jul 2006 11:11:37 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp024) with SMTP; 25 Jul 2006 13:11:37 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: "Martin Langhoff (CatalystIT)" <martin@catalyst.net.nz>
In-Reply-To: <44C5FB3E.9020301@catalyst.net.nz>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24167>

Hi,

On Tue, 25 Jul 2006, Martin Langhoff (CatalystIT) wrote:

> Johannes Schindelin wrote:
> 
> > 	I still get this warning:
> > 
> > 		closing dbh with active statement handles
> 
> Ack to that too. Perhaps an END block would help?

Since my BASIC days on a VC-20 (no, not the airplane), I hardly used an 
END statement ;-) Well, maybe in that Pascal course, but not in Perl, 
anyway. So, I do not understand...

> A quick check of man DBI tells me that $dbh->CachedKids will be a 
> hashref where the values are refs to the cached statement handles.
> 
> IMHO it's a DBI bug -- statement handles only referenced by $dbh->CachedKids
> should cleanup silently. prepare_cached() is a convenience method so that you
> _don't_ have to keep track of the handles manually. Forcing a manual cleanup
> throws a good part of the convenience out.

I agree fully.

Ciao,
Dscho
