From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: segfault in diff-delta.c on mac os x (commit 8433669)
Date: Sat, 21 Jul 2007 23:35:41 -0400
Message-ID: <233B9D70-9D91-4527-9801-7E2463ABDDAA@silverinsanity.com>
References: <C10CCDA5-6D65-445E-92F3-2D3E4DCA4F8B@zib.de>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Jul 22 05:36:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICSEm-0002oS-Ao
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 05:36:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753747AbXGVDft (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jul 2007 23:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753594AbXGVDft
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jul 2007 23:35:49 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:54537 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750909AbXGVDfs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jul 2007 23:35:48 -0400
Received: from [192.168.1.2] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 3C7D81FFC01F;
	Sun, 22 Jul 2007 03:35:47 +0000 (UTC)
In-Reply-To: <C10CCDA5-6D65-445E-92F3-2D3E4DCA4F8B@zib.de>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53214>


On Jul 21, 2007, at 11:15 AM, Steffen Prohaska wrote:

> 843366961cf14aad6490fbeb30f7b98f37f8833a may cause segfaults on
> Mac OS X. See backtrace below. I only observed the segfault with
> -O2 builds.

I have been using git on my OS X box for quite a while, and that  
commit appears to be nearly two months old.  I have yet to see any  
packing errors in any of my repositories.  (This is with -O2, which  
appears to be the default.)

My gcc reports itself as build 5367 instead of 5250.  Perhaps there  
is a compiler error in an older copy of the DevTools?

Also, did this segfault occur with any publicly available repo or is  
it your own work?

~~ Brian
