From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1] autoconf: Use autoconf to write installation directories to config.mak.autogen
Date: Sun, 02 Jul 2006 17:13:01 -0700
Message-ID: <7vslljzgtu.fsf@assigned-by-dhcp.cox.net>
References: <200607030156.50455.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 03 02:13:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxC3n-0003k4-Eh
	for gcvg-git@gmane.org; Mon, 03 Jul 2006 02:13:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbWGCAND (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Jul 2006 20:13:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbWGCAND
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Jul 2006 20:13:03 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:5841 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1750736AbWGCANC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jul 2006 20:13:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060703001302.GLYM18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 2 Jul 2006 20:13:02 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200607030156.50455.jnareb@gmail.com> (Jakub Narebski's message
	of "Mon, 3 Jul 2006 01:56:48 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23143>

Jakub Narebski <jnareb@gmail.com> writes:

> This is beginning of patch series introducing installation configuration
> using autoconf (and no other autotools) to git. The idea is to generate
> config.mak.autogen using ./configure (generated from configure.ac by running
> autoconf) from config.mak.in, so one can use autoconf as an _alternative_ to
> ordinary Makefile, and creating one's own config.mak. Local settings in
> config.mak override generated settings in config.mak.autogen

Thanks.  Applied with some trailing whitespace stripped, but not
merged to "next" yet nor pushed out.
