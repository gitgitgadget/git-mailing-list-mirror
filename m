From: Junio C Hamano <junkio@cox.net>
Subject: Re: Branch relationships
Date: Sun, 14 May 2006 19:11:11 -0700
Message-ID: <7vbqu0xcjk.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0605131317200.3866@g5.osdl.org>
	<200605150104.46762.Josef.Weidendorfer@gmx.de>
	<7vslncyxez.fsf@assigned-by-dhcp.cox.net>
	<200605150348.53879.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 15 04:11:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfSYQ-0008Pl-AX
	for gcvg-git@gmane.org; Mon, 15 May 2006 04:11:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbWEOCLN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 May 2006 22:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbWEOCLN
	(ORCPT <rfc822;git-outgoing>); Sun, 14 May 2006 22:11:13 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:35221 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751308AbWEOCLN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 May 2006 22:11:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060515021112.PPU15069.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 14 May 2006 22:11:12 -0400
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
In-Reply-To: <200605150348.53879.Josef.Weidendorfer@gmx.de> (Josef
	Weidendorfer's message of "Mon, 15 May 2006 03:48:53 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20006>

Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:

> But not supporting this in a first step should be no problem, as
> you always can do "git pull somewhere that-head" directly.

That defeats the point of .git/remotes/ setup, and I suspect is
unacceptable to people who pull from a given branch of a given
repository repeatedly without ever tracking it.  Think of the
maintainer pulling from subsystem maintainers.
