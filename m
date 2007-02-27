From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: RFC: Patch editing
Date: Tue, 27 Feb 2007 21:07:35 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702272106150.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0702252156190.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0702270205540.6485@iabervon.org>
 <Pine.LNX.4.63.0702271247000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0702271201400.6485@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Feb 27 21:07:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM8bs-00026m-S9
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 21:07:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752505AbXB0UHi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 15:07:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752522AbXB0UHi
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 15:07:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:49154 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752505AbXB0UHh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 15:07:37 -0500
Received: (qmail invoked by alias); 27 Feb 2007 20:07:36 -0000
X-Provags-ID: V01U2FsdGVkX19tCMQTB4NtAHdjosMAAf/85VTK68f/N4112uu2EG
	XJNA==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.64.0702271201400.6485@iabervon.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40780>

Hi,

On Tue, 27 Feb 2007, Daniel Barkalow wrote:

> One nice thing about my method is that, if you've had to make a dozen 
> unrelated changes to get something to compile and run far enough to test 
> whether any of the changes are actually correct, you can be sure to get 
> that work preserved. I'd be a lot less comfortable preparing 
> intermediate states if I didn't have the final state securely tucked 
> away.

You _could_ still ensure that by looking in the reflog which was your old 
tip-of-branch, and git-diff with that.

But I agree. That is why I commit _everything_ before rearranging.

Ciao,
Dscho
