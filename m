From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: GNU ChangeLogs, was Re: [PATCH] show_date(): rename the "relative"
 parameter to "mode"
Date: Wed, 28 Feb 2007 00:18:18 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702280013130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0702271620390.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0702271339550.12485@woody.linux-foundation.org>
 <Pine.LNX.4.63.0702272313020.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0702271453030.12485@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Simon Josefsson <simon@josefsson.org>,
	junkio@cox.net
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Feb 28 00:19:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMBbh-0003f5-GY
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 00:19:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752652AbXB0XTb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 18:19:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752636AbXB0XSn
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 18:18:43 -0500
Received: from mail.gmx.net ([213.165.64.20]:48860 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752613AbXB0XSU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 18:18:20 -0500
Received: (qmail invoked by alias); 27 Feb 2007 23:18:18 -0000
X-Provags-ID: V01U2FsdGVkX19JcKIp4dRJ9NB8QBrSLTzCK5xk/Q+MNsHQugiDps
	bY9A==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.64.0702271453030.12485@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40841>

Hi,

On Tue, 27 Feb 2007, Linus Torvalds wrote:

> I don't think the GNU style ChangeLog is particularly good. In fact, I 
> think it has an unfortunate tendency (thanks to being per-file-log) to 
> encourage people to commit unrelated changes and then explain them per 
> file.

Yes, that is some bad thing.

> Of course, you can't do that under git anyway, but I sure hope people 
> don't start thinking that they should explain their changes in the git 
> commit messages that way - my point being that certain log formats tend 
> to encourage certain behaviour, and the GNU log format I think tends to 
> do that exactly the wrong way around.

Well, if you have to change your committing behaviour to get sensible 
automatic GNU ChangeLog from history, that would be a start, wouldn't it?

> That said, listing the functions that got changed (which I don't know if 
> you did, but some GNU changelogs do) may be a nice thing.

No I did not.

It is not _that_ easy with existing interfaces. Like I illustrated in an 
example I sent in another reply, you miss newly introduced functions.

Besides, without my Java-methods patch I sent yesterday, our function name 
extraction is utterly unusable on Java projects (and C++ projects with 
inlined methods).

> And hey, if some project wants GNU changelogs, I'm not against them. I 
> just don't think they are in any way "superior", and the per-file 
> comments really turn me off.

I think that the standard behaviour of "git log" rocks. But it would not 
hurt to be able to point to "git log --pretty=gnucl", to prove that Git is 
the ultimate SCM.

Ciao,
Dscho
