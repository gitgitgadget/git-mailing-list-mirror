From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH Cogito] cg-init breaks if . contains sub-dir
Date: Thu, 12 May 2005 20:53:58 +0200
Message-ID: <20050512185358.GB324@pasky.ji.cz>
References: <20050509233904.GB878@osuosl.org> <pan.2005.05.10.03.41.15.683163@smurf.noris.de> <428043EB.7010004@didntduck.org> <20050510075227.GA8176@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gerst <bgerst@didntduck.org>,
	Matthias Urlichs <smurf@smurf.noris.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 20:47:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWIht-0006Ls-Sg
	for gcvg-git@gmane.org; Thu, 12 May 2005 20:46:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261370AbVELSyW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 14:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261373AbVELSyT
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 14:54:19 -0400
Received: from w241.dkm.cz ([62.24.88.241]:37336 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261368AbVELSyD (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 May 2005 14:54:03 -0400
Received: (qmail 3514 invoked by uid 2001); 12 May 2005 18:53:58 -0000
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Content-Disposition: inline
In-Reply-To: <20050510075227.GA8176@lug-owl.de>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Tue, May 10, 2005 at 09:52:27AM CEST, I got a letter
where Jan-Benedict Glaw <jbglaw@lug-owl.de> told me that...
> On Tue, 2005-05-10 01:17:31 -0400, Brian Gerst <bgerst@didntduck.org> wrote:
> > But it can handle symlinks:
> > 
> > 	find * -type f -o -type l -print0 | xargs -0r cg-add
> 
> This won't work because the explicit OR (-o) lower precedence compared
> to the implicit AND between "-type l" and "-print0", thus this find
> command will do print0 IFF the matched entry is a symlink. Use something
> like this instead:
> 
> 	find * \( -type f -o tyle l \) -print0 | ...

Thanks to all the four co-authors, applied.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
