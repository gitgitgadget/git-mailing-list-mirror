From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH] git-checkout: disable guides how to switch branches with ui.guide
Date: Thu, 1 Feb 2007 22:23:06 +0100
Message-ID: <20070201212306.GA14152@moooo.ath.cx>
References: <Pine.LNX.4.64.0701311405430.3021@xanadu.home> <20070131231942.GB31145@coredump.intra.peff.net> <Pine.LNX.4.64.0701311907500.3021@xanadu.home> <20070201030030.GA1979@coredump.intra.peff.net> <7vd54ur26u.fsf@assigned-by-dhcp.cox.net> <7vlkjip7mu.fsf_-_@assigned-by-dhcp.cox.net> <20070201184403.GA6326@moooo.ath.cx> <7vabzxpq2t.fsf@assigned-by-dhcp.cox.net> <20070201205145.GA13439@moooo.ath.cx> <7vabzxoaed.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Feb 01 22:23:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCjOj-0006QO-5v
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 22:23:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423020AbXBAVXJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 16:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423019AbXBAVXJ
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 16:23:09 -0500
Received: from mail.gmx.net ([213.165.64.20]:44861 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1423020AbXBAVXI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 16:23:08 -0500
Received: (qmail invoked by alias); 01 Feb 2007 21:23:07 -0000
Received: from pD9EB9AC1.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.154.193]
  by mail.gmx.net (mp037) with SMTP; 01 Feb 2007 22:23:07 +0100
X-Authenticated: #5358227
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vabzxoaed.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38407>

Junio C Hamano <junkio@cox.net> wrote:
> The error message you quoted [..]
Ok, I thought you were refering to the first one.  Right, for the
second one it is ok, one will get used to do -b or -f.

But I also quoted (and patched) the other one for switching to
detached heads:
> Note: you are not on any branch and are at commit "v1.1.2"
> If you want to create a new branch from this checkout, you may do so
> (now or later) by using -b with the checkout command again. Example:
>   git checkout -b <new_branch_name>
This one is a bit shorter but the last three lines are still a guide
what to do in case you don't know what's going an.
