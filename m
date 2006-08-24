From: Jon Loeliger <jdl@freescale.com>
Subject: Re: [PATCH] git-daemon virtual hosting implementation.
Date: Thu, 24 Aug 2006 15:34:36 -0500
Message-ID: <1156451675.10054.285.camel@cashmere.sps.mot.com>
References: <11563591572194-git-send-email-madcoder@debian.org>
	 <7vmz9vgqlm.fsf@assigned-by-dhcp.cox.net>
	 <200608232256.10108.madcoder@debian.org>
	 <1156450516.10054.276.camel@cashmere.sps.mot.com>
	 <7vejv598iq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 24 22:41:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGM0h-0003wH-5F
	for gcvg-git@gmane.org; Thu, 24 Aug 2006 22:41:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422645AbWHXUlE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Aug 2006 16:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422646AbWHXUlD
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Aug 2006 16:41:03 -0400
Received: from az33egw01.freescale.net ([192.88.158.102]:34692 "EHLO
	az33egw01.freescale.net") by vger.kernel.org with ESMTP
	id S1422645AbWHXUlB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Aug 2006 16:41:01 -0400
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id k7OKewI9019490;
	Thu, 24 Aug 2006 13:40:58 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k7OKewA5017975;
	Thu, 24 Aug 2006 15:40:58 -0500 (CDT)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vejv598iq.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.ydl.1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25977>

On Thu, 2006-08-24 at 15:35, Junio C Hamano wrote:
> Where is the patch ;-)?

Heh.

Well, I rewrote the interpolation code.  As you pointed
out earlier, it was crap.  I can send that in; no problem.

There was some outstanding debate if this was actually
the right way to go about things.  Specifically, the
problem of canonical hostname.  A proposal was to use
peer IP addresses instead, and I just haven't gotten
around to messing with that yet.  So that is why I
hadn't sent it in yet.  Sorry.

But, I'll rebase it and send it in this evening.

jdl
