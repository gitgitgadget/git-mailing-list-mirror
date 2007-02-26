From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Increase some limits in git-mailinfo
Date: Mon, 26 Feb 2007 21:43:02 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702262135140.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.64.0702261036550.12485@woody.linux-foundation.org>
 <Pine.LNX.4.64.0702261107060.12485@woody.linux-foundation.org>
 <Pine.LNX.4.63.0702262020590.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0702261207520.12485@woody.linux-foundation.org>
 <Pine.LNX.4.63.0702262117160.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0702261221530.12485@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Feb 26 21:43:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLmh1-0006hP-I5
	for gcvg-git@gmane.org; Mon, 26 Feb 2007 21:43:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161033AbXBZUnG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Feb 2007 15:43:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161026AbXBZUnG
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Feb 2007 15:43:06 -0500
Received: from mail.gmx.net ([213.165.64.20]:36934 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161034AbXBZUnD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Feb 2007 15:43:03 -0500
Received: (qmail invoked by alias); 26 Feb 2007 20:43:02 -0000
X-Provags-ID: V01U2FsdGVkX19aPHNbrQpaUEyT69FKk8Oe65QCReFtW56FCAujQo
	P7Hg==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.64.0702261221530.12485@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40665>

Hi,

On Mon, 26 Feb 2007, Linus Torvalds wrote:

> On Mon, 26 Feb 2007, Johannes Schindelin wrote:
> > 
> > > So I'd rather have it return true if it matches, rather than false 
> > > if it matches and -1/1 if it doesn't. But that's water under the 
> > > bridge.
> > 
> > In that case, you'd have to name it has_prefix() or hasprefix() rather 
> > than prefixcmp(), which C programmers used to the semantics of 
> > strcmp() expect to return a tristate result.
> 
> Sure. Or "match_prefix()" or whatever. I agree.

Well, if you look at fnmatch(), or our own match_pathspec(), rather not...

Just my 2 cents: I can live with prefixcmp(). And since I use strcmp() to 
compare strings, not strings_eq() or similar, I am quite happy with 
prefixcmp(), too.

Ciao,
Dscho
