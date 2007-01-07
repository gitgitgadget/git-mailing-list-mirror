From: Junio C Hamano <junkio@cox.net>
Subject: Re: [KORG] Re: kernel.org lies about latest -mm kernel
Date: Sun, 07 Jan 2007 13:54:31 -0800
Message-ID: <7v4pr21p0o.fsf@assigned-by-dhcp.cox.net>
References: <20061214223718.GA3816@elf.ucw.cz>
	<20061216094421.416a271e.randy.dunlap@oracle.com>
	<20061216095702.3e6f1d1f.akpm@osdl.org> <458434B0.4090506@oracle.com>
	<1166297434.26330.34.camel@localhost.localdomain>
	<1166304080.13548.8.camel@nigel.suspend2.net>
	<459152B1.9040106@zytor.com>
	<1168140954.2153.1.camel@nigel.suspend2.net>
	<45A07587.3080503@garzik.org> <20070107201146.GA21956@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 07 22:54:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3fyY-000213-FW
	for gcvg-git@gmane.org; Sun, 07 Jan 2007 22:54:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965222AbXAGVyd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 16:54:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965201AbXAGVyd
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 16:54:33 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:44490 "EHLO
	fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965222AbXAGVyc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 16:54:32 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070107215432.TGXF29122.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>;
          Sun, 7 Jan 2007 16:54:32 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 8Mti1W00D1kojtg0000000; Sun, 07 Jan 2007 16:53:43 -0500
To: Greg KH <gregkh@suse.de>
In-Reply-To: <20070107201146.GA21956@suse.de> (Greg KH's message of "Sun, 7
	Jan 2007 12:11:46 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36201>

Greg KH <gregkh@suse.de> writes:

> Any shortcut to clone or set up a repo using "alternatives" so that we
> don't have this issue at all?

"clone -l -s" has been there for quote a long time (since mid Aug
2005).  Because -s implies -l since end of November 2005, you
should be able to say

	git clone --bare -s ..../torvalds/linux-2.6.git stable-queue.git
