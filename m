From: "Barry K. Nathan" <barryn@pobox.com>
Subject: Re: [ANNOUNCE] git-pasky-0.6.3 && request for testing
Date: Fri, 22 Apr 2005 22:12:35 -0700
Message-ID: <20050423051235.GB9430@ip68-225-251-162.oc.oc.cox.net>
References: <20050422030931.GA14565@pasky.ji.cz> <20050422071626.GB8467@ip68-225-251-162.oc.oc.cox.net> <20050422072437.GC8467@ip68-225-251-162.oc.oc.cox.net> <20050422103737.GC14565@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Barry K. Nathan" <barryn@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 23 07:08:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPCsB-0007KR-D4
	for gcvg-git@gmane.org; Sat, 23 Apr 2005 07:08:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261490AbVDWFMm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 01:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261493AbVDWFMm
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 01:12:42 -0400
Received: from orb.pobox.com ([207.8.226.5]:16788 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S261490AbVDWFMl (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Apr 2005 01:12:41 -0400
Received: from orb (localhost [127.0.0.1])
	by orb.pobox.com (Postfix) with ESMTP
	id DF66190D; Sat, 23 Apr 2005 01:12:37 -0400 (EDT)
Received: from ip68-225-251-162.oc.oc.cox.net (ip68-225-251-162.oc.oc.cox.net [68.225.251.162])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by orb.sasl.smtp.pobox.com (Postfix) with ESMTP id A02E487;
	Sat, 23 Apr 2005 01:12:35 -0400 (EDT)
Received: by ip68-225-251-162.oc.oc.cox.net (Postfix, from userid 500)
	id DAFC958DA9AA; Fri, 22 Apr 2005 22:12:35 -0700 (PDT)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
In-Reply-To: <20050422103737.GC14565@pasky.ji.cz>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 22, 2005 at 12:37:37PM +0200, Petr Baudis wrote:
> Duh, segfaulting sed! Could you please check which of the sed
> invocations actually segfault for you?

                        "")
                                echo; sed -re '
                                        /
*Signed-off-by.*/Is//'$colsignoff'&'$coldefault'/
                                        s/^/    /
                                '
                                ;;

This only happens with an old sed from Mandrake 10.1; as I previously
mentioned, if I install the Mandriva 2005 LE sed package, then the
problem goes away. (And as I previously mentioned, I also need to have
the Mandriva mktemp package installed for git-pasky to work.)

> Thanks,

You're welcome.

-Barry K. Nathan <barryn@pobox.com>
