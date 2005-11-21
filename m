From: "David S. Miller" <davem@davemloft.net>
Subject: Re: non-trivial merge failures
Date: Sun, 20 Nov 2005 20:20:32 -0800 (PST)
Message-ID: <20051120.202032.37639519.davem@davemloft.net>
References: <20051120.134945.104623647.davem@davemloft.net>
	<20051120230738.GA16861@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 21 05:21:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ee3AB-0002dR-Pi
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 05:20:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750970AbVKUEUR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 Nov 2005 23:20:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932145AbVKUEUQ
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Nov 2005 23:20:16 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:38573
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750970AbVKUEUP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Nov 2005 23:20:15 -0500
Received: from localhost ([127.0.0.1] ident=davem)
	by sunset.davemloft.net with esmtp (Exim 4.54)
	id 1Ee3AP-0005zs-1w; Sun, 20 Nov 2005 20:20:33 -0800
To: ryan@michonline.com
In-Reply-To: <20051120230738.GA16861@mythryan2.michonline.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12421>

From: Ryan Anderson <ryan@michonline.com>
Date: Sun, 20 Nov 2005 18:07:38 -0500

> On Sun, Nov 20, 2005 at 01:49:45PM -0800, David S. Miller wrote:
> > 
> > Every time I try to do a non-trivial merge, I always
> > get this:
> 
> git-merge-recursive became the default merge tool recently, and Debian
> uses Python 2.3 as the default, which lacks "subprocess.py".  Luckily,
> git ships a backport, so you can do:
> 
> 	make WITH_OWN_SUBPROCESS_PY=YesPlease all doc test install install-doc
> or
> 	make PYTHON_PATH=/usr/bin/python2.4 all doc test install install-doc

All these ways to make it work are nice, and in fact I have
no problem with upgrading to python2.4 on my system if that
makes it work.

I have a huge problem with the fact that "make test" passes %100
cleanly even if you have the wrong python version installed.  It's
amazing that this is that possible if even the most non-trivial merge
needs this Python code :-)
