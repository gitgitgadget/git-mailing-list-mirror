From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Git cancel work
Date: Sun, 24 Apr 2005 14:49:30 +0200
Message-ID: <20050424124930.GE1507@pasky.ji.cz>
References: <Pine.LNX.4.62.0504240033230.1980@mirrorlynx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 24 14:44:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPgTd-0006T9-N3
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 14:44:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262323AbVDXMti (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 08:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262324AbVDXMti
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 08:49:38 -0400
Received: from w241.dkm.cz ([62.24.88.241]:60355 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262323AbVDXMtb (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Apr 2005 08:49:31 -0400
Received: (qmail 15767 invoked by uid 2001); 24 Apr 2005 12:49:30 -0000
To: Dan Weber <dan@mirrorlynx.com>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0504240033230.1980@mirrorlynx.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sun, Apr 24, 2005 at 06:34:44AM CEST, I got a letter
where Dan Weber <dan@mirrorlynx.com> told me that...
> I noticed that git cancel was always doing a full checkout.  So I figured, 
> "what about just checking out the modified files?".  Attached is a patch 
> to do so.

But that is what checkout-cache -f -a does:

        if (!stat(path, &st)) {
                unsigned changed = cache_match_stat(ce, &st);
                if (!changed)
                        return 0;

in checkout_entry().

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
