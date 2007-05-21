From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [RFC] Third round of support for cloning submodules
Date: Sun, 20 May 2007 17:39:10 -0700
Message-ID: <4650EA2E.7070204@midwinter.com>
References: <11796842882917-git-send-email-skimo@liacs.nl> <7vhcq7l3ar.fsf@assigned-by-dhcp.cox.net> <20070520195930.GX942MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Mon May 21 02:39:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hpvvk-0006Ao-Qe
	for gcvg-git@gmane.org; Mon, 21 May 2007 02:39:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758386AbXEUAjN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 20:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758459AbXEUAjN
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 20:39:13 -0400
Received: from tater.midwinter.com ([216.32.86.90]:57563 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758352AbXEUAjM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 20:39:12 -0400
Received: (qmail 25880 invoked from network); 21 May 2007 00:39:11 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=SdGclOy7ZDlCcrUMWB0h7g75nGg4jnHgKS/775ANbbzYvs5m5MG/PZ+2w0Z2Phgo  ;
Received: from localhost (HELO sgrimm-mbp.local) (koreth@127.0.0.1)
  by localhost with SMTP; 21 May 2007 00:39:11 -0000
User-Agent: Thunderbird 2.0.0.0 (Macintosh/20070326)
In-Reply-To: <20070520195930.GX942MdfPADPa@greensroom.kotnet.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47955>

Sven Verdoolaege wrote:
> It's pretty easy to add a "submodule.*.skip" or "submodule.*.ignore".
> Since the subcloning only happens at checkout, you could set these
> before doing a checkout.
>   

Can I take this to mean that you intend the default behavior to be to 
check out all subprojects, with individual ones suppressed via 
configuration as needed?

Picture a corporate development environment with a common build system, 
a couple common libraries, and a bunch of separate products. Product 
developers will want to check out the build system (which would perhaps 
be in the superproject), the libraries they need, and their own product. 
They will rarely want to check out the other products, which could 
account for the vast majority of the subprojects, and certainly won't 
want to have to keep track of which new subprojects are appearing so 
they can add those to the exclude list.

In other words, "I want the superproject and these four subprojects and 
nothing else" should be a well-supported mode of operation. In many 
cases developers will already know at clone time exactly what they want.

If I'm misunderstanding your intent, then never mind. :)

-Steve
