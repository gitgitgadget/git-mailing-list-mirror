From: Edgar Toernig <froese@gmx.de>
Subject: Re: [PATCH Cogito] Make use of external editor work like CVS
Date: Mon, 9 May 2005 05:28:14 +0200
Message-ID: <20050509052814.617dceac.froese@gmx.de>
References: <20050508155656.GV9495@pasky.ji.cz>
	<1115568937.9031.129.camel@pegasus>
	<20050508171209.GX9495@pasky.ji.cz>
	<1115572667.9031.139.camel@pegasus>
	<20050508173003.GY9495@pasky.ji.cz>
	<1115574035.9031.145.camel@pegasus>
	<20050508175156.GA9495@pasky.ji.cz>
	<1115578658.8949.9.camel@pegasus>
	<20050508200334.GG9495@pasky.ji.cz>
	<1115584015.8949.43.camel@pegasus>
	<20050508210857.GL9495@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Marcel Holtmann <marcel@holtmann.org>,
	GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 09 05:21:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUypf-0000kG-Cm
	for gcvg-git@gmane.org; Mon, 09 May 2005 05:21:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263030AbVEID2W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 May 2005 23:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263032AbVEID2W
	(ORCPT <rfc822;git-outgoing>); Sun, 8 May 2005 23:28:22 -0400
Received: from pop.gmx.de ([213.165.64.20]:1932 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263030AbVEID2T (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 May 2005 23:28:19 -0400
Received: (qmail invoked by alias); 09 May 2005 03:28:18 -0000
Received: from p50906243.dip.t-dialin.net (EHLO dialup) [80.144.98.67]
  by mail.gmx.net (mp029) with SMTP; 09 May 2005 05:28:18 +0200
X-Authenticated: #271361
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050508210857.GL9495@pasky.ji.cz>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis wrote:
>
> > +               if ! [ $LOGMSG2 -nt $LOGMSG ]; then
> > +                       rm $LOGMSG $LOGMSG2
> > +                       die 'Commit message not modified, commit aborted'
> > +               fi

Just in case you come to a conclusion some day, how about changing the
if-test to

	if cmp -s $LOGMSG LOGMSG2; then

?  :-)  IMHO much better then comparing only the date.

Ciao, ET.
