From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Teach "approxidate" about weekday syntax
Date: Fri, 18 Nov 2005 09:00:38 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511180857170.13959@g5.osdl.org>
References: <Pine.LNX.4.64.0511171223110.13959@g5.osdl.org>
 <7v1x1eubpr.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0511171505080.13959@g5.osdl.org>
 <Pine.LNX.4.64.0511171520390.13959@g5.osdl.org> <20051118121210.GA19714@abridgegame.org>
 <Pine.LNX.4.63.0511181419340.28109@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.58.0511180806550.25159@shark.he.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	David Roundy <droundy@abridgegame.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 19 00:52:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by deer.gmane.org with esmtp (Exim 3.35 #1 (Debian))
	id 1EdASO-0008ME-00
	for <gcvg-git@gmane.org>; Fri, 18 Nov 2005 18:55:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964816AbVKRRBA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 12:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964820AbVKRRA7
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 12:00:59 -0500
Received: from smtp.osdl.org ([65.172.181.4]:31701 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964816AbVKRRA7 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Nov 2005 12:00:59 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAIH0knO017490
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 18 Nov 2005 09:00:46 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAIH0dAJ018861;
	Fri, 18 Nov 2005 09:00:41 -0800
To: "Randy.Dunlap" <rdunlap@xenotime.net>
In-Reply-To: <Pine.LNX.4.58.0511180806550.25159@shark.he.net>
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12292>



On Fri, 18 Nov 2005, Randy.Dunlap wrote:
>
> ~Randy  [who would just use ISO standard date format]

That actually _does_ work, and has done so since the beginning:

   [torvalds@g5 git]$ ./test-date "2005-11-02 14:45:00"
   2005-11-02 14:45:00 -> 1130971500 -0800 -> Wed Nov  2 14:45:00 2005
   2005-11-02 14:45:00 -> Wed Nov  2 14:45:00 2005

ie both the exact and the fuzzy date parsing will happily accept ISO 
standard date format and exact times.

But when you want to know what happened since high tea yesterday, the 
fuzzy format is unbeatable.

			Linus
