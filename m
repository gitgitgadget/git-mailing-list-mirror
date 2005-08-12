From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Clean generated files a bit more.
Date: Fri, 12 Aug 2005 06:55:53 -0700
Message-ID: <7vpssj1cpi.fsf@assigned-by-dhcp.cox.net>
References: <7v8xz75w6p.fsf@assigned-by-dhcp.cox.net>
	<20050812114053.GB29893@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 12 15:57:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3a0v-0000m2-TV
	for gcvg-git@gmane.org; Fri, 12 Aug 2005 15:56:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183AbVHLNzz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Aug 2005 09:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbVHLNzz
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Aug 2005 09:55:55 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:64975 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751183AbVHLNzy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2005 09:55:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050812135552.SBKX550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 12 Aug 2005 09:55:52 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050812114053.GB29893@pasky.ji.cz> (Petr Baudis's message of
	"Fri, 12 Aug 2005 13:40:53 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis <pasky@suse.cz> writes:

> This makes me a bit nervous - why are you making the rules more general?
> make clean removing random tarballs of mine happenning to dwell in that
> directory is fearsome.

That is a valid concern.  I'd drop that *.tar.gz part at
least and probably the *.deb *.dsc part as well.  Thanks for
sanity checking.
