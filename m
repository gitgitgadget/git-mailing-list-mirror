From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] show_date(): rename the "relative" parameter to "mode"
Date: Tue, 27 Feb 2007 23:13:54 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702272313020.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0702271620390.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0702271339550.12485@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Simon Josefsson <simon@josefsson.org>,
	junkio@cox.net
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Feb 27 23:13:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMAa7-0007J5-0J
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 23:13:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751924AbXB0WN4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 17:13:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751927AbXB0WN4
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 17:13:56 -0500
Received: from mail.gmx.net ([213.165.64.20]:50303 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751924AbXB0WN4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 17:13:56 -0500
Received: (qmail invoked by alias); 27 Feb 2007 22:13:54 -0000
X-Provags-ID: V01U2FsdGVkX19xRqkW6Yhxin28TYblOTrnZWKYwsfyuoVYTB4Fxm
	B9IA==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.64.0702271339550.12485@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40822>

Hi,

On Tue, 27 Feb 2007, Linus Torvalds wrote:

> On Tue, 27 Feb 2007, Johannes Schindelin wrote:
> > 
> > Now, show_date() can print three different kinds of dates: normal, 
> > relative and short (%Y-%m-%s) dates.
> > 
> > To achieve this, the "int relative" was changed to "enum date_mode 
> > mode", which has three states: DATE_NORMAL, DATE_RELATIVE and 
> > DATE_SHORT.
> 
> Ack. I think this kind of thing is worth it regardless of any of the 
> other issues (ie the whole "changelog" thing).

Gee, thanks!

And you are no supporter of a GNU ChangeLog? Imagine being able to produce 
a GNU style ChangeLog of the Linux kernel in no time at all...

Ciao,
Dscho
