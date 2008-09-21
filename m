From: Petr Baudis <pasky@suse.cz>
Subject: Re: TopGit: how to deal with upstream inclusion
Date: Sun, 21 Sep 2008 16:19:24 +0200
Message-ID: <20080921141924.GI10360@machine.or.cz>
References: <20080914203043.GA4872@lapse.rw.madduck.net> <20080914210316.GJ10360@machine.or.cz> <20080919170406.GA22849@lapse.rw.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Sun Sep 21 16:20:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhPnh-0007N3-T0
	for gcvg-git-2@gmane.org; Sun, 21 Sep 2008 16:20:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751600AbYIUOT2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Sep 2008 10:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751658AbYIUOT2
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Sep 2008 10:19:28 -0400
Received: from w241.dkm.cz ([62.24.88.241]:48758 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751554AbYIUOT1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Sep 2008 10:19:27 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 337483939B2D; Sun, 21 Sep 2008 16:19:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080919170406.GA22849@lapse.rw.madduck.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96397>

On Fri, Sep 19, 2008 at 06:04:06PM +0100, martin f krafft wrote:
> also sprach Petr Baudis <pasky@suse.cz> [2008.09.14.2203 +0100]:
> >   (iii) Merge in RETIRED head branch with -s ours
> 
> Yes, it does. One might want to consider to make the use of -s ours
> in (iiii) configurable, but otherwise that's it.

That might be pretty dangerous, since then your topic branch will have
outstanding branches of the retired branch, but they will _NOT_ be
visible to tg patch and others since they will be in both the base and
head.

-- 
				Petr "Pasky" Baudis
The next generation of interesting software will be done
on the Macintosh, not the IBM PC.  -- Bill Gates
