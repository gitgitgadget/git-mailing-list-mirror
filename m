From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Force new line at end of commit message
Date: Mon, 24 Dec 2007 18:38:48 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0712241835210.14355@wbgn129.biozentrum.uni-wuerzburg.de>
References: <87ve6ub3u7.fsf@gollum.intra.norang.ca> <8763yof9lg.fsf@gollum.intra.norang.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Bernt Hansen <bernt@alumni.uwaterloo.ca>
X-From: git-owner@vger.kernel.org Mon Dec 24 18:39:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J6rGq-0001nJ-9P
	for gcvg-git-2@gmane.org; Mon, 24 Dec 2007 18:39:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750981AbXLXRix (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Dec 2007 12:38:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbXLXRix
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Dec 2007 12:38:53 -0500
Received: from mail.gmx.net ([213.165.64.20]:57418 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750851AbXLXRiw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Dec 2007 12:38:52 -0500
Received: (qmail invoked by alias); 24 Dec 2007 17:38:49 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp021) with SMTP; 24 Dec 2007 18:38:49 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/xIG1RXAHxZBUdLQZ+/lB4HvC5F7BMwu5Q5dzrm6
	a5RLwCiaiTxPhx
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <8763yof9lg.fsf@gollum.intra.norang.ca>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69219>

Hi,

On Mon, 24 Dec 2007, Bernt Hansen wrote:

> git rebase --interactive formats the combined commit log message 
> incorrectly when squashing 3 or more commits which have no newline on 
> the last line of the commit message.

This is a patch for git-gui, so why not make that clear in the subject?  
(And I have a hunch that Shawn would have liked the patch relative to 
git-gui.git, not git.git...)

Further, there are other tools than rebase -i that like commit messages 
better when terminated by a newline, and _that_ is what I would like to 
read in the commit message for this patch.

If nobody is quicker, I'll try to fix the problem on the rebase -i side in 
a few days.

Thanks,
Dscho
