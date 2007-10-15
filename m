From: Brian Dessent <brian@dessent.net>
Subject: Re: Switching from CVS to GIT
Date: Mon, 15 Oct 2007 11:37:27 -0700
Organization: My own little world...
Message-ID: <4713B367.52CEC7E2@dessent.net>
References: <1773C6F0-87BE-4F3C-B68A-171E1F32E242@lrde.epita.fr> <47125F74.9050600@op5.se> <Pine.LNX.4.64.0710141934310.25221@racer.site> <47126957.1020204@op5.se> <Pine.LNX.4.64.0710142112540.25221@racer.site> <20071014221446.GC2776@steel.home> <u7ilpjp3x.fsf@gnu.org> <Pine.LNX.4.64.0710150039120.25221@racer.site> <4712B616.165BBF8D@dessent.net> <Pine.LNX.4.64.0710150217120.25221@racer.site> <20071015175606.GE2966@steel.home>
Reply-To: git@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Eli Zaretskii <eliz@gnu.org>, ae@op5.se,
	tsuna@lrde.epita.fr, make-w32@gnu.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 15 20:51:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhUp9-00012q-KI
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 20:37:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934258AbXJOShj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 14:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934090AbXJOShi
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 14:37:38 -0400
Received: from dessent.net ([69.60.119.225]:43547 "EHLO dessent.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934177AbXJOShg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 14:37:36 -0400
Received: from localhost ([127.0.0.1] helo=dessent.net)
	by dessent.net with esmtp (Exim 4.50)
	id 1IhUok-0000sA-Lj; Mon, 15 Oct 2007 18:37:30 +0000
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
X-Accept-Language: en,en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61019>

Alex Riesen wrote:

> He misunderstood. It is not what you meant. You cannot remove the open
> file. What he talks about is removing the file after it is _closed_.
> Junk.

I did not misunderstand.  The semantics are equivalent to the POSIX
case: you end up with a handle to an open file that is exclusive to that
process (it cannot be opened by any other process, even root) and that
is automatically reclaimed by the filesystem when all open handles are
closed, without any explicit action by the user.  It's not "unlinking an
open file", no, but it's the same result.

Brian
