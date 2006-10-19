From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Use diff3 instead of merge in merge-recursive.
Date: Thu, 19 Oct 2006 02:31:25 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0610190229590.9789@iabervon.org>
References: <20061018085949.GA26501@cepheus.pub> <eh4sfr$3ej$1@sea.gmane.org>
 <Pine.LNX.4.64.0610180835000.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 19 08:31:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaRRE-0007ou-4R
	for gcvg-git@gmane.org; Thu, 19 Oct 2006 08:31:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161333AbWJSGb2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Oct 2006 02:31:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161338AbWJSGb1
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Oct 2006 02:31:27 -0400
Received: from iabervon.org ([66.92.72.58]:35592 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1161336AbWJSGb1 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Oct 2006 02:31:27 -0400
Received: (qmail 25999 invoked by uid 1000); 19 Oct 2006 02:31:25 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 19 Oct 2006 02:31:25 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610180835000.3962@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29327>

On Wed, 18 Oct 2006, Linus Torvalds wrote:

> As to why git uses "merge" - I have this strong memory of having seen 
> machines that had one but not the other, and that, along with the fact 
> that I've used "merge" personally, is why we call "merge" rather than 
> diff3.
> 
> In Linux systems, "merge" usually comes with the RCS package, and "diff3" 
> is usually from "diffutils". It may be that "diff3" is more common. I'm 
> not sure what the history is, and what the situation would tend to be like 
> on other systems..

AFAICT, "merge" actually execs "diff3", so if a system has only one, 
either it's diff3, it's a "merge" from somewhere other than current rcs, 
or it doesn't actually work.

	-Daniel
*This .sig left intentionally blank*
