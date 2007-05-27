From: Junio C Hamano <junkio@cox.net>
Subject: Re: t9107-git-svn-migrate.sh fails
Date: Sun, 27 May 2007 11:50:59 -0700
Message-ID: <7v646egkx8.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0705242315550.4648@racer.site>
	<20070526093534.GB12639@muzzle>
	<Pine.LNX.4.64.0705261123420.4648@racer.site>
	<20070527172336.GA27725@muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun May 27 20:51:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsNpb-0005S8-Fz
	for gcvg-git@gmane.org; Sun, 27 May 2007 20:51:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752590AbXE0SvD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 14:51:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752643AbXE0SvD
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 14:51:03 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:40841 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752590AbXE0SvB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2007 14:51:01 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070527185101.GTIQ13995.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Sun, 27 May 2007 14:51:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 4Jqz1X00G1kojtg0000000; Sun, 27 May 2007 14:51:00 -0400
In-Reply-To: <20070527172336.GA27725@muzzle> (Eric Wong's message of "Sun, 27
	May 2007 10:23:36 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48570>

Eric Wong <normalperson@yhbt.net> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>> 
>> Two thoughts:
>> 
>> 	- why don't you check it with readlink?
>
> I'm not sure about the portability of readlink(1).  cmp(1) is used in
> several places already, whereas readlink(1) is not.

You did a very sensible thing; avoidance of readlink has been
very deliberate.  And I'd be happier if things stayed that way.
