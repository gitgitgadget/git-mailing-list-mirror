From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: Partial checkouts / submodules
Date: Tue, 20 Nov 2007 18:33:50 +0100
Message-ID: <20071120173350.GA2261MdfPADPa@greensroom.kotnet.org>
References: <20071120155922.GA6271@pvv.org>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Tue Nov 20 18:34:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuWzB-0004KH-Ox
	for gcvg-git-2@gmane.org; Tue, 20 Nov 2007 18:34:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751775AbXKTRdw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2007 12:33:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751616AbXKTRdw
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Nov 2007 12:33:52 -0500
Received: from psmtp08.wxs.nl ([195.121.247.22]:37689 "EHLO psmtp08.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751404AbXKTRdv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2007 12:33:51 -0500
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp08.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JRT005B9FGESW@psmtp08.wxs.nl> for git@vger.kernel.org; Tue,
 20 Nov 2007 18:33:50 +0100 (MET)
Received: (qmail 10596 invoked by uid 500); Tue, 20 Nov 2007 17:33:50 +0000
In-reply-to: <20071120155922.GA6271@pvv.org>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65552>

On Tue, Nov 20, 2007 at 04:59:22PM +0100, Finn Arne Gangstad wrote:
> I looked into the current git submodules to see if they support what I
> think we need, but it seems like they do not really cut it (If I'm
> wrong about this, please educate me).

Maybe you could explain why you think they don't cut it.

> You pull the supermodule, and initialize random collection of
> submodules, e.g. locally you have:
> 
> supermodule/
>    submodule13
>    submodule71
>    submodule102

Just "submodule init" and "submodule update" these submodules and
it looks like you would get what you want...

> If I make a branch on submodule71, the branch is made in all submodules &
> the supermodule.

... except this one.
It's not clear why you would even want this.

skimo
