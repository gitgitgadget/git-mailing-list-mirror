From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git and larger trees, not so fast?
Date: Sat, 11 Aug 2007 15:27:20 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708111522570.30176@woody.linux-foundation.org>
References: <20070809163026.GD568@mbox.bz>
 <alpine.LFD.0.999.0708111137250.30176@woody.linux-foundation.org>
 <20070811190201.GB4710@ferdyx.org> <alpine.LFD.0.999.0708111337280.30176@woody.linux-foundation.org>
 <20070811205137.GC4710@ferdyx.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: moe <moe-git@mbox.bz>, git@vger.kernel.org
To: "Fernando J. Pereda" <ferdy@gentoo.org>
X-From: git-owner@vger.kernel.org Sun Aug 12 00:28:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJzRV-0001DF-Lp
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 00:28:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760013AbXHKW2A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Aug 2007 18:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759579AbXHKW2A
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Aug 2007 18:28:00 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:55435 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759538AbXHKW2A (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Aug 2007 18:28:00 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7BMRQYi022227
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 11 Aug 2007 15:27:27 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7BMRKKU027809;
	Sat, 11 Aug 2007 15:27:20 -0700
In-Reply-To: <20070811205137.GC4710@ferdyx.org>
X-Spam-Status: No, hits=-2.723 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.24__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55643>



On Sat, 11 Aug 2007, Fernando J. Pereda wrote:
> > 
> > What does "usable" mean? Is it still slow ("barely usable") or is it 
> > actually fast enough to be truly _nice_ to use?
> 
> Very nice to use considering my hardware is rather old. git status used
> to take >1m and it now takes ~3s and git commit takes ~7s while it used
> to take >1m too. So it makes things nice to use and I guess things are
> MUCH better on faster hardware.

Oh, ok. Having a 7s commit sounds fine - certainly not instantaneous, but 
it doesn't sound too painful. Certainly not compared to what people live 
with normally in some other environments, at least.

Thanks go to moe for just giving a trivial script to reproduce the 
performance anomaly. It wasn't that hard to fix once there was a trivial 
and unambiguous test case.

		Linus
