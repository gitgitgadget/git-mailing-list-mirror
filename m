From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-pull and tag objects
Date: Thu, 15 Feb 2007 02:34:08 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702150232340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <1170933407.15431.38.camel@okra.transitives.com>
 <81b0412b0702090133qa4eb0c0v6a2d309fe9653a3f@mail.gmail.com>
 <7v4ppurka1.fsf@assigned-by-dhcp.cox.net> <20070210142322.GB25607@thunk.org>
 <Pine.LNX.4.64.0702100938540.8424@woody.linux-foundation.org>
 <7vy7n5gs0y.fsf@assigned-by-dhcp.cox.net> <20070212162745.GB2741@thunk.org>
 <7vr6su1szp.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702132230490.3604@woody.linux-foundation.org>
 <er0cfg$1m7$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 15 02:34:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHVW1-0007Mr-9g
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 02:34:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751526AbXBOBeM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 20:34:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751517AbXBOBeM
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 20:34:12 -0500
Received: from mail.gmx.net ([213.165.64.20]:32873 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751515AbXBOBeK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 20:34:10 -0500
Received: (qmail invoked by alias); 15 Feb 2007 01:34:08 -0000
X-Provags-ID: V01U2FsdGVkX1+PZx9Mr2WPn7rZLOgxALMYksxtwO2Y3jgGL8sHyl
	ql5w==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <er0cfg$1m7$1@sea.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39784>

Hi,

[*SIGH* I am Cc'ing Linus, since you -- again -- forgot that]

On Thu, 15 Feb 2007, Jakub Narebski wrote:

> Linus Torvalds wrote:
> 
> > One thing that _might_ be a good idea for tags (if people _really_ 
> > want to actually update tags under the same name) is to have a 
> > "parent" pointer for tag objects, the same way we have for commits. 
> > That way you could - if you really wanted to - create a chain of tags, 
> > and show the history of them.
> 
> Wouldn't it be better to just use reflog for given tag? That assuming of 
> course that we could protect tag reflog from pruning...

No. Reflogs are a local thing, tags not necessarily. And much fun 
"pushing" a reflog to another repo.

Ciao,
Dscho
