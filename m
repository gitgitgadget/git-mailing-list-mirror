From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-push of new, tiny branch doing more work than necessary?
Date: Fri, 22 Sep 2006 00:34:56 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0609220031570.19042@wbgn013.biozentrum.uni-wuerzburg.de>
References: <87fyekkg5r.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 22 00:35:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQX8L-0003Vj-N5
	for gcvg-git@gmane.org; Fri, 22 Sep 2006 00:35:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbWIUWfA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Sep 2006 18:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932079AbWIUWfA
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Sep 2006 18:35:00 -0400
Received: from mail.gmx.net ([213.165.64.20]:15266 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932075AbWIUWe7 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Sep 2006 18:34:59 -0400
Received: (qmail invoked by alias); 21 Sep 2006 22:34:58 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp029) with SMTP; 22 Sep 2006 00:34:58 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Carl Worth <cworth@cworth.org>
In-Reply-To: <87fyekkg5r.wl%cworth@cworth.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27507>

Hi,

On Thu, 21 Sep 2006, Carl Worth wrote:

> I've run through something quite like the following scenario a few
> times lately:
> 
> 	git pull origin
> 	git checkout -b experiment
> 	# hack a file or two
> 	git commit -a -m "new experiment"
> 	git push origin experiment
> 
> What I expect at this point is for git to push the few newly created
> objects out to the repository. Instead it talks about generating,
> deltifying, transferring, and unpacking thousands of objects (see
> below).

I experienced something like this, too, but did not have the time to debug 
it. But alas, some time (I think last week) it started working as expected 
again.

> git version 1.4.2.rc2.gef1d9

Please try a more recent version (yours is from Jul 27).

Ciao,
Dscho
