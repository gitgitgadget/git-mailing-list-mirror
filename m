From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [bug-patch] [BUG?] rename patch accepted with --dry-run,
 rejected without (Re: [PATCH V3] arm & sh: factorised duplicated clkdev.c)
Date: Sat, 4 Sep 2010 05:21:17 +0200
Message-ID: <20100904032117.GL17702@game.jcrosoft.org>
References: <1283431716-21540-1-git-send-email-plagnioj@jcrosoft.com>
 <20100903182323.GA17152@pengutronix.de>
 <20100903184351.GC2341@burratino>
 <201009040058.18028.agruen@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, bug-patch@gnu.org,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>, linux-sh@vger.kernel.org,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-arm-kernel@lists.infradead.org, git@vger.kernel.org
To: Andreas Gruenbacher <agruen@suse.de>
X-From: linux-sh-owner@vger.kernel.org Sat Sep 04 05:22:00 2010
Return-path: <linux-sh-owner@vger.kernel.org>
Envelope-to: glps-linuxsh-dev@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-sh-owner@vger.kernel.org>)
	id 1OrjKJ-0007nH-Cr
	for glps-linuxsh-dev@lo.gmane.org; Sat, 04 Sep 2010 05:21:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754018Ab0IDDV6 (ORCPT <rfc822;glps-linuxsh-dev@m.gmane.org>);
	Fri, 3 Sep 2010 23:21:58 -0400
Received: from 68.mail-out.ovh.net ([91.121.185.69]:53753 "HELO
	68.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754041Ab0IDDV6 (ORCPT
	<rfc822;linux-sh@vger.kernel.org>); Fri, 3 Sep 2010 23:21:58 -0400
Received: (qmail 24218 invoked by uid 503); 4 Sep 2010 03:32:30 -0000
Received: from 30.mail-out.ovh.net (213.186.62.213)
  by 68.mail-out.ovh.net with SMTP; 4 Sep 2010 03:32:30 -0000
Received: (qmail 19163 invoked by uid 503); 4 Sep 2010 03:06:27 -0000
Received: from b7.ovh.net (HELO mail637.ha.ovh.net) (213.186.33.57)
  by 30.mail-out.ovh.net with SMTP; 4 Sep 2010 03:06:26 -0000
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 4 Sep 2010 05:26:00 +0200
Received: from ns32433.ovh.net (HELO localhost) (plagnioj%jcrosoft.com@213.251.161.87)
  by ns0.ovh.net with SMTP; 4 Sep 2010 05:25:59 +0200
Content-Disposition: inline
In-Reply-To: <201009040058.18028.agruen@suse.de>
X-PGP-Key: http://uboot.jcrosoft.org/plagnioj.asc
X-PGP-key-fingerprint: 6309 2BBA 16C8 3A07 1772 CC24 DEFC FFA3 279C CE7C
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Ovh-Tracer-Id: 13566812403794488314
X-Ovh-Remote: 213.251.161.87 (ns32433.ovh.net)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-Spam-Check: DONE|U 0.500001/N
Sender: linux-sh-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155300>

> 
> So "git apply" and "patch --dry-run" seem to work only by accident.
> 
> How was this patch generated: with git itself?
I did as usual
git format-patch -M -B -C HEAD~
> 
> The fact that "patch --dry-run" may not work for patches that modify the same 
> file twice is a known defect.  I don't know how to solve this in a reasonably 
> elegant way.  Luckily the problem only triggers when people are doing 
> something "strange" such as concatenating patches.

Best Regards,
J.
