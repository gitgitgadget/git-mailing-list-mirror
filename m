From: Lluis Sanchez Gual <lluis@novell.com>
Subject: Re: [MonoDevelop] git integration with monodevelop
Date: Thu, 13 Nov 2008 11:10:43 -0500
Message-ID: <1226592643.4213.36.camel@164-99-120-118.boston.ximian.com>
References: <491AAE6D.8030304@op5.se>
	 <aec34c770811121556y34465436i9ffb5e29dbf203a7@mail.gmail.com>
	 <491BDD70.1080701@op5.se>
	 <6d4a25b10811130128r4ebf60a4s5679d06961b92450@mail.gmail.com>
	 <491C090E.4070605@op5.se>
Reply-To: lluis@novell.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Christian Hergert <christian.hergert@gmail.com>,
	monodevelop-list@lists.ximian.com,
	Shawn Pearce <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Nov 13 17:12:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0enb-0000Tn-Fa
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 17:12:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbYKMQKs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 11:10:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751160AbYKMQKs
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 11:10:48 -0500
Received: from victor.provo.novell.com ([137.65.250.26]:56459 "EHLO
	victor.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751089AbYKMQKr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 11:10:47 -0500
Received: from [164.99.120.118] (prv-ext-foundry1.gns.novell.com [137.65.251.240])
	by victor.provo.novell.com with ESMTP (TLS encrypted); Thu, 13 Nov 2008 09:10:44 -0700
In-Reply-To: <491C090E.4070605@op5.se>
X-Mailer: Evolution 2.22.1.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100881>

El dj 13 de 11 de 2008 a les 12:01 +0100, en/na Andreas Ericsson va
escriure:
> Christian Hergert wrote:
> > By unmanaged, he means the [DllImport] which you would need to do the call
> > to the extern in the shared library.
> > 
> > Everyone that has chimed in has considered doing the git code before,
> > believe us when we say we've thought about wrapping C.  In this case, it
> > will be far more flexible in C#.  Especially since tools like silverlight do
> > not allow DllImport's.
> > 
> 
> Well, browser plugins may have a fun time with git support, but it's so far
> from my priority list I couldn't even poke it with a really long pole. The
> fastest way forward is probably to hack on libgit2 and use C# micro-apps
> to verify continually that the binding layer works properly, so that's what
> I'll be doing. I should also state that while C# seems fun and all, my top
> priority is to make the git library usable as quickly as possible so that
> it can attract more attention from developers. That's why I think it's so
> vitally important to get some few usable steps working fast (such as diffing
> against the index, staging stuff for commit and creating a commit).
> 
> Once we have that much, basic IDE integration should be fairly easy, and
> then people will want to do more so interest (hopefully from developers)
> is likely to increase.
> 

I like the plan!

Lluis.
