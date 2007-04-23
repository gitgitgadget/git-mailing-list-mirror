From: Junio C Hamano <junkio@cox.net>
Subject: Re: t4201-shortlog.sh does bad things to my terminal
Date: Mon, 23 Apr 2007 11:37:39 -0700
Message-ID: <7vmz0zey30.fsf@assigned-by-dhcp.cox.net>
References: <20070423170301.GL955MdfPADPa@greensroom.kotnet.org>
	<Pine.LNX.4.64.0704231928270.8822@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sven Verdoolaege <skimo@kotnet.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 23 20:38:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hg3QV-0004CY-Ax
	for gcvg-git@gmane.org; Mon, 23 Apr 2007 20:38:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161327AbXDWShm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 14:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161371AbXDWShm
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 14:37:42 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:52824 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161327AbXDWShl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 14:37:41 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070423183741.EDOV1268.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Mon, 23 Apr 2007 14:37:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id qidf1W00p1kojtg0000000; Mon, 23 Apr 2007 14:37:40 -0400
In-Reply-To: <Pine.LNX.4.64.0704231928270.8822@racer.site> (Johannes
	Schindelin's message of "Mon, 23 Apr 2007 19:29:29 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45348>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Mon, 23 Apr 2007, Sven Verdoolaege wrote:
>
>> It appears that this message is printing a control character to turn off 
>> echoing, because the terminal appears completely unresponsive 
>> afterwards. Typing "reset" restores the terminal.
>> 
>> Is this really necessary?
>
> On both accounts, no. I did not dream of these bytes being interpreted as 
> control characters.
>
> OTOH, you should not need to use --verbose anyway.

I think it's not Sven but you; you should use --quiet in your
git commit if the log message has annoying characters.
