From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] fetch--tool: fix uninitialized buffer when reading from
 stdin
Date: Mon, 26 Feb 2007 18:27:27 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702261827050.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0702261306140.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0702260821310.12485@woody.linux-foundation.org>
 <Pine.LNX.4.63.0702261741360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0702260905420.12485@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, junkio@cox.net
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Feb 26 18:27:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLjdO-00033I-67
	for gcvg-git@gmane.org; Mon, 26 Feb 2007 18:27:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030357AbXBZR1b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Feb 2007 12:27:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030358AbXBZR1a
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Feb 2007 12:27:30 -0500
Received: from mail.gmx.net ([213.165.64.20]:47418 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030357AbXBZR1a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Feb 2007 12:27:30 -0500
Received: (qmail invoked by alias); 26 Feb 2007 17:27:28 -0000
X-Provags-ID: V01U2FsdGVkX18S+Y5iX3oSzR4GuZcpw01bafLsma/fSHSzW7ilA7
	xuAg==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.64.0702260905420.12485@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40633>

Hi,

On Mon, 26 Feb 2007, Linus Torvalds wrote:

> On Mon, 26 Feb 2007, Johannes Schindelin wrote:
> > 
> > But I agree your patch is saner.
> 
> Well, it's not the "saner" I'm worried about, I was more worried about 
> the fact that your patch added random '\0' characters in the middle of 
> the stdin input if it was ever bigger than CHUNK_SIZE. I suspect you 
> only tested with small input to stdin.

Ooops. I did not even realize that after reading your reply.

Ciao,
Dscho
