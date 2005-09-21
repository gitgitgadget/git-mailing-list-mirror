From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 0/8] fetch.c optimizations
Date: Wed, 21 Sep 2005 17:03:31 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0509211700161.23242@iabervon.org>
References: <20050921161829.GA20944@master.mivlgu.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 21 23:01:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIBgT-00039J-RP
	for gcvg-git@gmane.org; Wed, 21 Sep 2005 22:59:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964838AbVIUU7M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Sep 2005 16:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964835AbVIUU7M
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Sep 2005 16:59:12 -0400
Received: from iabervon.org ([66.92.72.58]:63494 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S964833AbVIUU7K (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Sep 2005 16:59:10 -0400
Received: (qmail 10498 invoked by uid 1000); 21 Sep 2005 17:03:31 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 21 Sep 2005 17:03:31 -0400
To: Sergey Vlasov <vsu@altlinux.ru>
In-Reply-To: <20050921161829.GA20944@master.mivlgu.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9078>

On Wed, 21 Sep 2005, Sergey Vlasov wrote:

> Hello!
> 
> I have noticed that git-*-fetch now uses much more CPU than it was
> before the modifications to fix recovery after interrupted fetch.
> Here is a series of small patches which fix the problems which I have
> found (some of the fixes give pretty impressive results, like a 14x
> decrease of CPU time); as a positive side effect, fetch.c becomes
> slightly smaller and hopefully simpler than before.

These all look like good changes. It would also be worth doing some 
optimization in the library, like making parse_object just return the 
object if we already have it.

	-Daniel
*This .sig left intentionally blank*
