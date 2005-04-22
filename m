From: "Barry K. Nathan" <barryn@pobox.com>
Subject: Re: [ANNOUNCE] git-pasky-0.6.3 && request for testing
Date: Fri, 22 Apr 2005 00:16:26 -0700
Message-ID: <20050422071626.GB8467@ip68-225-251-162.oc.oc.cox.net>
References: <20050422030931.GA14565@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 09:12:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOsKW-0004WJ-Ap
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 09:12:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262001AbVDVHQc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 03:16:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262002AbVDVHQc
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 03:16:32 -0400
Received: from orb.pobox.com ([207.8.226.5]:6553 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S262001AbVDVHQa (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Apr 2005 03:16:30 -0400
Received: from orb (localhost [127.0.0.1])
	by orb.pobox.com (Postfix) with ESMTP
	id 5373390D; Fri, 22 Apr 2005 03:16:27 -0400 (EDT)
Received: from ip68-225-251-162.oc.oc.cox.net (ip68-225-251-162.oc.oc.cox.net [68.225.251.162])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by orb.sasl.smtp.pobox.com (Postfix) with ESMTP id 18D8389;
	Fri, 22 Apr 2005 03:16:26 -0400 (EDT)
Received: by ip68-225-251-162.oc.oc.cox.net (Postfix, from userid 500)
	id 5203558DA9AA; Fri, 22 Apr 2005 00:16:26 -0700 (PDT)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
In-Reply-To: <20050422030931.GA14565@pasky.ji.cz>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

With git-pasky 0.6.3, "git log" is unusable on my Mandrake 10.1 system.
Basically I get a neverending flood of these until I press 'q' to quit
less:

/home/barryn/softbag/git-pasky-0.6.3/gitlog.sh: line 73:  7598 Segmentation faul
t      sed -re '
                                        / *Signed-off-by.*/Is//'$colsignoff'&'$c
oldefault'/
                                        s/^/    /
                                '
/home/barryn/softbag/git-pasky-0.6.3/gitlog.sh: line 73:  7609 Segmentation faul
t      sed -re '
                                        / *Signed-off-by.*/Is//'$colsignoff'&'$c
oldefault'/
                                        s/^/    /
                                '
/home/barryn/softbag/git-pasky-0.6.3/gitlog.sh: line 73:  7620 Segmentation faul
t      sed -re '
                                        / *Signed-off-by.*/Is//'$colsignoff'&'$c
oldefault'/
                                        s/^/    /
                                '

git-pasky-0.6.2 works fine.

I'm not sure if I have time tonight (or tomorrow) to troubleshoot this
further, but I'll see if I can.

-Barry K. Nathan <barryn@pobox.com>

