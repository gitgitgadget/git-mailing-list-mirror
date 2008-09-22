From: Petr Baudis <pasky@suse.cz>
Subject: Re: [TopGit PATCH] tg-patch: add From/Date: line to header and
	print to file
Date: Mon, 22 Sep 2008 17:39:38 +0200
Message-ID: <20080922153938.GP10360@machine.or.cz>
References: <1221818101-14333-1-git-send-email-bert.wesarg@googlemail.com> <1221818101-14333-2-git-send-email-bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Sep 22 17:40:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhnWw-0004eP-7F
	for gcvg-git-2@gmane.org; Mon, 22 Sep 2008 17:40:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752938AbYIVPjl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2008 11:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752881AbYIVPjl
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Sep 2008 11:39:41 -0400
Received: from w241.dkm.cz ([62.24.88.241]:39093 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752733AbYIVPjl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2008 11:39:41 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id C0AA9393A2DD; Mon, 22 Sep 2008 17:39:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1221818101-14333-2-git-send-email-bert.wesarg@googlemail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96484>

On Fri, Sep 19, 2008 at 11:55:01AM +0200, Bert Wesarg wrote:
> To make this more similar to git format-patch, I added a 'From' and
> a 'Date:' header and let 'tg patch' print to a file (which is shown as output).
> 
> Regards
> Bert
> 
> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

I dislike the anyway completely bogus From line. If you want mbox
format, you should call (hypothetical) tg mail. Also, IMHO Date: should
be simply always printed at the end of the header, it's distracting if
it is higher.

Also, the writing to file is confusing to me. What are you trying to
achieve? If you want to export patches, why not use 'tg export' which
already has this functionality? To me, 'tg patch' is basically
equivalent of 'git show' for the whole branch.

-- 
				Petr "Pasky" Baudis
The next generation of interesting software will be done
on the Macintosh, not the IBM PC.  -- Bill Gates
