From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: git send-email woes
Date: Mon, 25 Sep 2006 20:32:21 +0200
Message-ID: <20060925183221.GE2490@uranus.ravnborg.org>
References: <20060924224316.GA28051@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Sep 25 20:28:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRvAd-0001bQ-Am
	for gcvg-git@gmane.org; Mon, 25 Sep 2006 20:27:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbWIYS1H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Sep 2006 14:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751449AbWIYS1H
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Sep 2006 14:27:07 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:22411 "EHLO pasmtpB.tele.dk")
	by vger.kernel.org with ESMTP id S1751202AbWIYS1F (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Sep 2006 14:27:05 -0400
Received: from ravnborg.org (0x535d98d8.vgnxx8.adsl-dhcp.tele.dk [83.93.152.216])
	by pasmtpB.tele.dk (Postfix) with ESMTP id 54794E3083C
	for <git@vger.kernel.org>; Mon, 25 Sep 2006 20:27:04 +0200 (CEST)
Received: by ravnborg.org (Postfix, from userid 500)
	id A2847580D2; Mon, 25 Sep 2006 20:32:21 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060924224316.GA28051@uranus.ravnborg.org>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27750>

On Mon, Sep 25, 2006 at 12:43:16AM +0200, Sam Ravnborg wrote:
> I stumbled on two issues with git-send-email today.
> First of I forgot to tell where to find the patch files to send.
> But git-send-email only complained _after_ I had given all
> the information manually.
> It would have been niver to check that all mandatory arguments
> was present before being interactive.
> 
> The second issue are best explained quoting a mail from Matti Arnio:
> > > The GIT is at times producing emails that are not
> > > utterly strictly speaking kosher RFC-(2)822 format.
> > >
> > > It might be a surprise to you that unquoted dots in
> > > people's names cause syntax scanner indigestion,
> > > because said character has very special meaning in
> > > RFC-822 syntax.  All would be fine if
> > >     Example J.P. Example <example@example.net>
> > > had couple quotes:
> > >     "Example J.P. Example" <example@example.net>
> 
> What I could see was that git-send-email takes mail address
> verbatim from "Signed-off-by:" lines and use it.
The patches in quistion did not have a "Signed-off-by: tag so
that mail address has been from the author instead.
And this mail address was still invalid as per RFC2822.

> Would it be possible to always quote it except when quoted
> or to do a more intelligent RFC2822 check?
> 
> That would keep suprises lower.
> 
> I'm not good a perlish so I have not attempted fixing it myself...

	Sam
