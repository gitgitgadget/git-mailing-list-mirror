From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git log of all (modifying) commands run on a repo?
Date: Thu, 8 Feb 2007 00:59:24 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702080057140.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <17866.20355.744025.133326@lisa.zopyra.com>
 <Pine.LNX.4.64.0702071441160.8424@woody.linux-foundation.org>
 <7vd54l60gg.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702071525270.8424@woody.linux-foundation.org>
 <7vtzxx4k1c.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702071539390.8424@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Feb 08 00:59:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEwhI-00083y-6b
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 00:59:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422870AbXBGX72 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 18:59:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422869AbXBGX71
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 18:59:27 -0500
Received: from mail.gmx.net ([213.165.64.20]:60426 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1422864AbXBGX70 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 18:59:26 -0500
Received: (qmail invoked by alias); 07 Feb 2007 23:59:25 -0000
X-Provags-ID: V01U2FsdGVkX19O1hhMIONO2pQoqRtoj11zRrJYsW2Sc+b/x8nc3Z
	ZouA==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.64.0702071539390.8424@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39008>

Hi,

On Wed, 7 Feb 2007, Linus Torvalds wrote:

> On Wed, 7 Feb 2007, Junio C Hamano wrote:
> > 
> > Heh, I do not care if you find "log -g" pretty, since I do not
> > particularly find it pretty ("log --pretty=o --abbrev-commit -g"
> > is probably prettier than "less").
> 
> With "--pretty=oneline --abbrev-commit" I'll agree that it's actually 
> fairly pretty.
> 
> Maybe we can make "-g" default to that? As it is, I'd otherwise still use 
> "less" just because there is less typing...

I don't care either way. I'd even appreciate somebody harvesting the 
low-hanging fruit of making "git reflog show" a wrapper to "git log -p".

Ciao,
Dscho

P.S.: Sorry, Shawn, but I don't think that my version "won". It was 
modeled after yours, but introduced flexibility to use reflog walking to 
other revision walkers. So, I think of it as the "next" version of your 
"git reflog show".
