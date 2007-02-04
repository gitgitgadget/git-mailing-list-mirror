From: Junio C Hamano <junkio@cox.net>
Subject: Re: 'git config' vs 'git repo-config'
Date: Sun, 04 Feb 2007 01:47:33 -0800
Message-ID: <7v8xfetft6.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550702040138r6580c36agf86e8f8191a40021@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 04 10:47:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDdyG-0003yo-Q1
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 10:47:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752210AbXBDJrg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Feb 2007 04:47:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752218AbXBDJrf
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Feb 2007 04:47:35 -0500
Received: from fed1rmmtai15.cox.net ([68.230.241.44]:65292 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752210AbXBDJrf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Feb 2007 04:47:35 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070204094734.OJRX1306.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Sun, 4 Feb 2007 04:47:34 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id KMna1W0011kojtg0000000; Sun, 04 Feb 2007 04:47:34 -0500
In-Reply-To: <e5bfff550702040138r6580c36agf86e8f8191a40021@mail.gmail.com>
	(Marco Costalba's message of "Sun, 4 Feb 2007 10:38:36 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38674>

"Marco Costalba" <mcostalba@gmail.com> writes:

>  I've seen that 'git repo-config' has been renamed 'git config', but
> old name is still available for back compatibility.

Exactly.  While I do not think qgit uses them, fsck-objects and
init-db also got shorter-and-sweeter synonyms.

> Do you plan to remove it in a near future?

Not me personally.  The recent shorter-and-sweeter synonyms are
too young to kick out their original names.  We probably should
wait for at least 6 months, preferrably longer, after the first
major release that introduced them.

> Probably you already now why I'm asking this ;-)

No.  But we should certainly draw up deprecation/removal
schedule.  It simply could be "never" ;-).
