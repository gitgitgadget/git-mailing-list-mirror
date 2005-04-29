From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
Date: Fri, 29 Apr 2005 10:09:38 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504291006450.18901@ppc970.osdl.org>
References: <20050426004111.GI21897@waste.org> <Pine.LNX.4.58.0504251859550.18901@ppc970.osdl.org>
 <20050429060157.GS21897@waste.org> <3817.10.10.10.24.1114756831.squirrel@linux1>
 <20050429074043.GT21897@waste.org> <Pine.LNX.4.58.0504290728090.18901@ppc970.osdl.org>
 <20050429163705.GU21897@waste.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sean <seanlkml@sympatico.ca>,
	linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 19:04:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRYsb-0007Pr-UT
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 19:02:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262842AbVD2RHt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 13:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262840AbVD2RHt
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 13:07:49 -0400
Received: from fire.osdl.org ([65.172.181.4]:58303 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262838AbVD2RHn (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2005 13:07:43 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3TH7es4018219
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 29 Apr 2005 10:07:40 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3TH7d8m024327;
	Fri, 29 Apr 2005 10:07:39 -0700
To: Matt Mackall <mpm@selenic.com>
In-Reply-To: <20050429163705.GU21897@waste.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 29 Apr 2005, Matt Mackall wrote:
> 
> That's because no one paid attention until I posted performance
> numbers comparing it to git! Mercurial's goals are:
> 
> - to scale to the kernel development process
> - to do clone/pull style development
> - to be efficient in CPU, memory, bandwidth, and disk space
>   for all the common SCM operations
> - to have strong repo integrity

Ok, sounds good. Have you looked at how it scales over time, ie what 
happens with files that have a lot of delta's?

Let's see how these things work out..

		Linus
