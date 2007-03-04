From: Junio C Hamano <junkio@cox.net>
Subject: Re: Creating attachments using git-format-patch
Date: Sat, 03 Mar 2007 19:43:15 -0800
Message-ID: <7vslcl7jxo.fsf@assigned-by-dhcp.cox.net>
References: <loom.20070303T215950-974@post.gmane.org>
	<7vhct27xk2.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0703032356050.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Panagiotis Issaris <takis.issaris@uhasselt.be>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Mar 04 04:43:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNhd2-0007fC-Fd
	for gcvg-git@gmane.org; Sun, 04 Mar 2007 04:43:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbXCDDnR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Mar 2007 22:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbXCDDnR
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Mar 2007 22:43:17 -0500
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:62922 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750704AbXCDDnR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2007 22:43:17 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070304034316.FFRP1226.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Sat, 3 Mar 2007 22:43:16 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id WTjG1W00B1kojtg0000000; Sat, 03 Mar 2007 22:43:16 -0500
In-Reply-To: <Pine.LNX.4.63.0703032356050.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sat, 3 Mar 2007 23:56:35 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41345>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sat, 3 Mar 2007, Junio C Hamano wrote:
>
>> We could introduce a new option "--inline" that does what the
>> current "--attach" does, and make "--attach" write "attachment;"
>> instead of "inline;" there, but that changes the behaviour, and
>> people who are used to use "--attach" to send out patches to
>> mailing lists suddenly start sending more cumbersome-to-read
>> variant, so...
>
> ... so we should introduce an option "--no-inline"!

Yes, but this time around I _think_ we should admit that the
current option is misnamed and make it right.
