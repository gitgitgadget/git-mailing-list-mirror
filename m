From: Andreas Ericsson <ae@op5.se>
Subject: Re: [MonoDevelop] git integration with monodevelop
Date: Thu, 13 Nov 2008 12:01:34 +0100
Message-ID: <491C090E.4070605@op5.se>
References: <491AAE6D.8030304@op5.se>	 <aec34c770811121556y34465436i9ffb5e29dbf203a7@mail.gmail.com>	 <491BDD70.1080701@op5.se> <6d4a25b10811130128r4ebf60a4s5679d06961b92450@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Michael Hutchinson <m.j.hutchinson@gmail.com>,
	monodevelop-list@lists.ximian.com,
	Git Mailing List <git@vger.kernel.org>,
	Shawn Pearce <spearce@spearce.org>
To: Christian Hergert <christian.hergert@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 13 12:03:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0ZyU-0007Q1-M6
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 12:02:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751802AbYKMLBm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 06:01:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751797AbYKMLBm
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 06:01:42 -0500
Received: from mail.op5.se ([193.201.96.20]:40688 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751792AbYKMLBl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 06:01:41 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id AE3121B80086;
	Thu, 13 Nov 2008 11:56:02 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fsB8uukTx1tt; Thu, 13 Nov 2008 11:55:59 +0100 (CET)
Received: from clix.int.op5.se (unknown [172.27.78.10])
	by mail.op5.se (Postfix) with ESMTP id 623FF1B8006C;
	Thu, 13 Nov 2008 11:55:57 +0100 (CET)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <6d4a25b10811130128r4ebf60a4s5679d06961b92450@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100863>

Christian Hergert wrote:
> By unmanaged, he means the [DllImport] which you would need to do the call
> to the extern in the shared library.
> 
> Everyone that has chimed in has considered doing the git code before,
> believe us when we say we've thought about wrapping C.  In this case, it
> will be far more flexible in C#.  Especially since tools like silverlight do
> not allow DllImport's.
> 

Well, browser plugins may have a fun time with git support, but it's so far
from my priority list I couldn't even poke it with a really long pole. The
fastest way forward is probably to hack on libgit2 and use C# micro-apps
to verify continually that the binding layer works properly, so that's what
I'll be doing. I should also state that while C# seems fun and all, my top
priority is to make the git library usable as quickly as possible so that
it can attract more attention from developers. That's why I think it's so
vitally important to get some few usable steps working fast (such as diffing
against the index, staging stuff for commit and creating a commit).

Once we have that much, basic IDE integration should be fairly easy, and
then people will want to do more so interest (hopefully from developers)
is likely to increase.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
