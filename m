From: Ryan Anderson <ryan@michonline.com>
Subject: Re: Errors GITtifying GCC and Binutils
Date: Thu, 23 Mar 2006 16:11:51 -0500
Message-ID: <20060323211151.GI26071@mythryan2.michonline.com>
References: <20060322133337.GU20746@lug-owl.de> <Pine.LNX.4.64.0603221517210.26286@g5.osdl.org> <Pine.LNX.4.64.0603221607580.26286@g5.osdl.org> <44223B90.3040500@zytor.com> <1143128751.6850.35.camel@neko.keithp.com> <Pine.LNX.4.64.0603230758260.26286@g5.osdl.org> <BAYC1-PASMTP0912D2287AB923F3338969AEDE0@CEZ.ICE> <Pine.LNX.4.64.0603231134160.26286@g5.osdl.org> <20060323204825.GE30176@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Mar 23 22:12:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMX6p-0006jv-MO
	for gcvg-git@gmane.org; Thu, 23 Mar 2006 22:12:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964937AbWCWVMk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Mar 2006 16:12:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964943AbWCWVMk
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Mar 2006 16:12:40 -0500
Received: from mail.autoweb.net ([198.172.237.26]:16008 "EHLO
	mail.internal.autoweb.net") by vger.kernel.org with ESMTP
	id S964937AbWCWVMk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Mar 2006 16:12:40 -0500
Received: from c-68-60-186-73.hsd1.mi.comcast.net ([68.60.186.73] helo=h4x0r5.com)
	by mail.internal.autoweb.net with esmtp (Exim 4.50)
	id 1FMX6k-0003eW-DZ; Thu, 23 Mar 2006 16:12:39 -0500
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by h4x0r5.com with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.60)
	(envelope-from <ryan@michonline.com>)
	id 1FMX6i-0005v8-Ag; Thu, 23 Mar 2006 16:12:36 -0500
Received: from ryan by mythical with local (Exim 4.60)
	(envelope-from <ryan@mythryan2.michonline.com>)
	id 1FMX6L-0005JV-Tq; Thu, 23 Mar 2006 16:12:13 -0500
To: Shawn Pearce <spearce@spearce.org>
Content-Disposition: inline
In-Reply-To: <20060323204825.GE30176@spearce.org>
User-Agent: Mutt/1.5.11+cvs20060126
X-h4x0r5.com-MailScanner: Found to be clean
X-h4x0r5.com-MailScanner-From: ryan@michonline.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17873>

On Thu, Mar 23, 2006 at 03:48:25PM -0500, Shawn Pearce wrote:
> 
> But your definately right; once the blame/annotate war settles out
> GIT will have pretty much everything one might need - except a good
> distributed bug/issue tracking type system.  :-)

Junio, where do we stand on this?

I've been a bit busy to finish the bug fixing I need to do on
annotate[1], and frankly, I have no strong feelings either way.

I must admit, I find annotate easier to read, but I wrote it, so I'm a
bit biased.  Maybe it is just that in C you sometimes get lost in the
details.

1 - The only bug I'm aware of, at the moment, is the fact that merges
sometimes get assigned poorly, which I have a plan to fix, I just
haven't had the time to sort it out yet.

-- 

Ryan Anderson
  sometimes Pug Majere
