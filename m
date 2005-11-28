From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: rebase problems
Date: Mon, 28 Nov 2005 21:24:29 +0100
Message-ID: <20051128202428.GA8383MdfPADPa@greensroom.kotnet.org>
References: <20051128145814.GW8383MdfPADPa@greensroom.kotnet.org>
 <7v4q5wttib.fsf@assigned-by-dhcp.cox.net>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 28 21:26:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgpYB-0006fd-Md
	for gcvg-git@gmane.org; Mon, 28 Nov 2005 21:24:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbVK1UYd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Nov 2005 15:24:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932236AbVK1UYd
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Nov 2005 15:24:33 -0500
Received: from psmtp02.wxs.nl ([195.121.247.11]:14054 "EHLO psmtp02.wxs.nl")
	by vger.kernel.org with ESMTP id S932232AbVK1UYc (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Nov 2005 15:24:32 -0500
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp02.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.02 (built Oct 21 2004))
 with SMTP id <0IQO00JXRM0T0Z@psmtp02.wxs.nl> for git@vger.kernel.org; Mon,
 28 Nov 2005 21:24:29 +0100 (MET)
Received: (qmail 29689 invoked by uid 500); Mon, 28 Nov 2005 20:24:29 +0000
In-reply-to: <7v4q5wttib.fsf@assigned-by-dhcp.cox.net>
To: Junio C Hamano <junkio@cox.net>
Mail-followup-to: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12902>

On Mon, Nov 28, 2005 at 12:19:40PM -0800, Junio C Hamano wrote:
> The output seems very inconsistent I am not sure why the first
> message says "Applying HEAD~2", not HEAD~6.    What patches do
> you see in .dotest/ directory, and are they numbered in the
> right order?  HEAD~6 should be numbered 0001 and that should be
> the first one that was applied.

Ah!  It seems .dotest still contained some stuff from a previous
(expectedly) failed rebase.

Rebase worked after rm -rf'ing .dotest

Maybe rebase should clean up .dotest or at least warn about
an existing .dotest ?

Thanks,
skimo
