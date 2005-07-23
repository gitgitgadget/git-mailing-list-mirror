From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 1/2] GIT: Try all addresses for given remote name
Date: Sat, 23 Jul 2005 00:15:50 +0000
Message-ID: <20050723001550.GB8047@mars.ravnborg.org>
References: <20050721.091036.01119516.yoshfuji@linux-ipv6.org> <20050722210913.GH11916@pasky.ji.cz> <20050722.172629.73295196.yoshfuji@linux-ipv6.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: pasky@suse.cz, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 23 00:43:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dw6Ef-0007b8-QB
	for gcvg-git@gmane.org; Sat, 23 Jul 2005 00:43:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262209AbVGVWnH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jul 2005 18:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262210AbVGVWnH
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jul 2005 18:43:07 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:4701 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S262209AbVGVWnG
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2005 18:43:06 -0400
Received: from mars.ravnborg.org (0x50a0757d.hrnxx9.adsl-dhcp.tele.dk [80.160.117.125])
	by pfepb.post.tele.dk (Postfix) with ESMTP id 0680C5EE01E;
	Sat, 23 Jul 2005 00:42:58 +0200 (CEST)
Received: by mars.ravnborg.org (Postfix, from userid 1000)
	id 2992F6AC01D; Sat, 23 Jul 2005 00:15:50 +0000 (UTC)
To: "YOSHIFUJI Hideaki / ?$B5HF#1QL@" <yoshfuji@linux-ipv6.org>
Content-Disposition: inline
In-Reply-To: <20050722.172629.73295196.yoshfuji@linux-ipv6.org>
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 22, 2005 at 05:26:29PM -0400, YOSHIFUJI Hideaki / ?$B5HF#1QL@ wrote:
> In article <20050722210913.GH11916@pasky.ji.cz> (at Fri, 22 Jul 2005 23:09:13 +0200), Petr Baudis <pasky@suse.cz> says:
> 
> > > -}
> > > +#define STR_(s)	# s
> > > +#define STR(s)	STR_(s)
> > 
> > Uh-huh? Why two macros? Well, why any macros at all?
> > 
> :
> > > +	char *colon, *end;
> > > +	char *port = STR(DEFAULT_GIT_PORT);
> > > +	struct addrinfo hints, *ai0, *ai;
> 
> The macro is used here.

You could copy the include/linux/stingify.h file from the kernel also.
That makes it available for other users also.

	Sam
