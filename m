From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] format-patch: wrap cover-letter's shortlog
 sensibly
Date: Sun, 2 Mar 2008 17:38:29 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0803021736510.22527@racer.site>
References: <alpine.LSU.1.00.0802290144130.22527@racer.site> <7vwsoofrue.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0802282104500.19665@iabervon.org> <alpine.LSU.1.00.0802291118540.22527@racer.site> <alpine.LSU.1.00.0803021511420.22527@racer.site>
 <alpine.LSU.1.00.0803021531230.22527@racer.site> <alpine.LSU.1.00.0803021552210.22527@racer.site> <alpine.LSU.1.00.0803021553090.22527@racer.site> <7vejatoy2w.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 02 18:39:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVsAA-0007X4-F1
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 18:39:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754637AbYCBRjO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 12:39:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753113AbYCBRjO
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 12:39:14 -0500
Received: from mail.gmx.net ([213.165.64.20]:60699 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752190AbYCBRjN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 12:39:13 -0500
Received: (qmail invoked by alias); 02 Mar 2008 17:39:12 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp056) with SMTP; 02 Mar 2008 18:39:12 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/PX7QQH/PP11M09rQ/fiDqZN5USRc3vQxCYg5UlH
	aEAT/TL0cGarKi
X-X-Sender: gene099@racer.site
In-Reply-To: <7vejatoy2w.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75817>

Hi,

On Sun, 2 Mar 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Earlier, overly-long onelines would not be wrapped at all, and indented
> > with 6 spaces.
> >
> > Instead, we now wrap around at 72 characters, with a first-line indent 
> > of 2 spaces, and the rest with 4 spaces (like the "What's in" messages 
> > of Junio).
> 
> Heh, I seem to personally use 76,2,4 but otherwise I think this makes it 
> easier to read.  Thanks.

Oh?  My first patch was 76,4,8, but then I was unsure, and went to your 
todo branch, and found this:

$ git grep -e -w.*7
Summary:git shortlog -w72,2,4 --no-merges $bottom..$top
WI:     git shortlog -w76,2,4 --no-merges "$@"

Obviously, I missed the second one, and took the first one.

Ciao,
Dscho

