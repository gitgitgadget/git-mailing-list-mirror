From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Cogito: Use git-rev-parse instead of cg-Xnormid.
Date: Mon, 4 Jul 2005 00:31:18 +0200
Message-ID: <20050703223118.GD13848@pasky.ji.cz>
References: <42C77ECE.2080903@didntduck.org> <20050703065920.GA11765@pasky.ji.cz> <42C7D925.2070007@didntduck.org> <20050703154127.GA31848@pasky.ji.cz> <20050703154049.GD18608MdfPADPa@garage.linux.student.kuleuven.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Jul 04 00:31:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DpCzt-0003kK-EQ
	for gcvg-git@gmane.org; Mon, 04 Jul 2005 00:31:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261554AbVGCWbX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jul 2005 18:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261553AbVGCWbX
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jul 2005 18:31:23 -0400
Received: from w241.dkm.cz ([62.24.88.241]:56221 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261554AbVGCWbU (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Jul 2005 18:31:20 -0400
Received: (qmail 28853 invoked by uid 2001); 3 Jul 2005 22:31:18 -0000
To: Brian Gerst <bgerst@didntduck.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050703154049.GD18608MdfPADPa@garage.linux.student.kuleuven.ac.be>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sun, Jul 03, 2005 at 05:40:49PM CEST, I got a letter
where Sven Verdoolaege <skimo@kotnet.org> told me that...
> On Sun, Jul 03, 2005 at 05:41:27PM +0200, Petr Baudis wrote:
> > That's right. Well, for everything but the short id matching we could
> > just check the ID validity by git-rev-parse instead of peeking into
> > the object store - I just did that. 
> 
> Why not use it to actually resolve ids ?
> I really miss the '^' parent notation in cogito.

I've decided to go the less troublesome way and just teach cg-Xnormid
about the ^ prefix. ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
<Espy> be careful, some twit might quote you out of context..
