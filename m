From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: First cut at git port to Cygwin
Date: Sat, 8 Oct 2005 20:27:06 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510082023130.25971@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20051005155457.GA30303@trixie.casa.cgf.cx> <20051005191741.GA25493@steel.home>
 <20051005202947.GA6184@trixie.casa.cgf.cx> <81b0412b0510060205v4cd510c9wb4b06a3ed9242c8@mail.gmail.com>
 <81b0412b0510060307q431b64edt4196553bce28346c@mail.gmail.com>
 <81b0412b0510070544v3e7cf0b4n521db8ff7e4e335a@mail.gmail.com>
 <Pine.LNX.4.64.0510070828270.31407@g5.osdl.org> <20051007205450.GA14827@steel.home>
 <20051007212250.GA1423@steel.home> <4346E8AC.5030503@citi.umich.edu>
 <20051007213952.GA8821@steel.home> <Pine.LNX.4.64.0510080900510.31407@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <fork0@users.sourceforge.net>,
	Chuck Lever <cel@citi.umich.edu>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>,
	Christopher Faylor <me@cgf.cx>,
	"H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Sat Oct 08 20:27:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EOJPn-0006SC-Iz
	for gcvg-git@gmane.org; Sat, 08 Oct 2005 20:27:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbVJHS1L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Oct 2005 14:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbVJHS1K
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Oct 2005 14:27:10 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:9701 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750793AbVJHS1J (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Oct 2005 14:27:09 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 8279513EC38; Sat,  8 Oct 2005 20:27:08 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 652A5B4409; Sat,  8 Oct 2005 20:27:08 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 3AE3BAC86C; Sat,  8 Oct 2005 20:27:08 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 947CD13EC38; Sat,  8 Oct 2005 20:27:06 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510080900510.31407@g5.osdl.org>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9846>

Hi,

On Sat, 8 Oct 2005, Linus Torvalds wrote:

> I really think that you should just get rid of the mmap.
> 
> As it is, you're just slowing the code down on sane architectures. That's 
> not good.
> 
> So I'd suggest something like this instead.
> 
> Totally untested, of course.

Am I missing something? I don't see where the changes are written back to 
the fd. After all, mmap() is called with PROT_WRITE...

*shameless plug* Of course, this problem does not come up with my NO_MMAP 
patch.

Ciao,
Dscho
