From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] Fix cogito handling of timezones
Date: Sat, 11 Jun 2005 00:19:36 +0200
Message-ID: <20050610221936.GA22111@pasky.ji.cz>
References: <1118353230.2825.10.camel@dv> <42A825C2.1060302@gmail.com> <20050609091909.GF29665@pasky.ji.cz> <42A81584.90605@antselovich.com> <42A83F0C.5020809@gmail.com> <20050609205503.GJ5324@shell0.pdx.osdl.net> <20050609210641.GK5324@shell0.pdx.osdl.net> <42A7BA17.5050707@tuxrocks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 11 00:15:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dgrms-0003Bt-Tb
	for gcvg-git@gmane.org; Sat, 11 Jun 2005 00:15:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261279AbVFJWTy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Jun 2005 18:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261284AbVFJWTy
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jun 2005 18:19:54 -0400
Received: from w241.dkm.cz ([62.24.88.241]:63389 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261279AbVFJWTj (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Jun 2005 18:19:39 -0400
Received: (qmail 26433 invoked by uid 2001); 10 Jun 2005 22:19:36 -0000
To: Frank Sorenson <frank@tuxrocks.com>,
	Chris Wright <chrisw@osdl.org>,
	Dan Holmsand <holmsand@gmail.com>,
	Pavel Roskin <proski@gnu.org>
Content-Disposition: inline
In-Reply-To: <1118353230.2825.10.camel@dv> <42A825C2.1060302@gmail.com> <20050609210641.GK5324@shell0.pdx.osdl.net> <42A7BA17.5050707@tuxrocks.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

  Hello,

  FYI, from the contestants for the octal fix, I've chosen to take Dan's
solution - not that I'd think it's the best, but it's simple and
mainly I'm taking other Dan's changes and I don't like solving
conflicts.

> +	local secs=$1 tzhours=${2:0:3} tzmins=${2:0:1}${2:3} format=$3
> +	# bash doesn't like leading zeros
> +	[ "${tzhours:1:1}" = 0 ] && tzhours=${2:0:1}${2:2:1}
> +	secs=$((secs + tzhours * 3600 + tzmins * 60))

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
<Espy> be careful, some twit might quote you out of context..
