From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Licensing and the library version of git
Date: Thu, 27 Jul 2006 09:46:54 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607270941400.4168@g5.osdl.org>
References: <9e4733910607261436v4c0802e5v7301e904593f9bab@mail.gmail.com> 
 <20060727114105.GZ13776@pasky.or.cz>  <Pine.LNX.4.63.0607271400160.29667@wbgn013.biozentrum.uni-wuerzburg.de>
  <9e4733910607270554p5622ee20ida8c264cf3122500@mail.gmail.com> 
 <20060727131127.GA13776@pasky.or.cz> <9e4733910607270911p50d25d97w1a898fc7a9119e7d@mail.gmail.com>
 <Pine.LNX.4.64.0607270936200.4168@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 27 18:47:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6911-0005x9-2m
	for gcvg-git@gmane.org; Thu, 27 Jul 2006 18:47:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750879AbWG0QrL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Jul 2006 12:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750889AbWG0QrL
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Jul 2006 12:47:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15248 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750879AbWG0QrK (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Jul 2006 12:47:10 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k6RGkwnW011387
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 27 Jul 2006 09:46:59 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k6RGkswa008977;
	Thu, 27 Jul 2006 09:46:55 -0700
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <Pine.LNX.4.64.0607270936200.4168@g5.osdl.org>
X-Spam-Status: No, hits=-0.581 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.141 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24300>



On Thu, 27 Jul 2006, Linus Torvalds wrote:
>
> I'd also like to point out that unlike every single horror I've ever 
> witnessed when looking closer at SCM products, git actually has a simple 
> design, with stable and reasonably well-documented data structures.

Side note: they got even cleaner with the recent 'objformat' merge, where 
the unpacked objects now have the same format as the packed ones. I'd 
suggest that if somebody is interested in duplicating git functionality, 
they should start with the new format, and thus be able to share more 
code.

Also note that a lot of the really _core_ and complex git functionality 
(notably, the revision list parsing, which is really all of the truly 
fundamental stuff) is probably not something that a project like Visual 
Studio or an Eclipse plugin would ever even want.

I seriously doubt that Eclipse or Visual Stupido could ever actually 
_understand_ what git does, so the only parts you actually would want to 
use for those is literally the trivial stuff - the "look up objects" and 
"generate commits" part. 

			Linus
