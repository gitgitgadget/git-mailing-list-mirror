From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: How do I...
Date: Fri, 6 May 2005 11:59:49 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505061158520.2233@ppc970.osdl.org>
References: <427B3DB3.4000507@tuxrocks.com>  <Pine.LNX.4.58.0505060905090.2233@ppc970.osdl.org>
  <7vsm10cnx3.fsf@assigned-by-dhcp.cox.net>  <Pine.LNX.4.58.0505061006060.2233@ppc970.osdl.org>
 <1115404771.16187.343.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Frank Sorenson <frank@tuxrocks.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 06 20:51:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DU7uv-0001z7-HO
	for gcvg-git@gmane.org; Fri, 06 May 2005 20:51:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbVEFS6C (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 May 2005 14:58:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261271AbVEFS6C
	(ORCPT <rfc822;git-outgoing>); Fri, 6 May 2005 14:58:02 -0400
Received: from fire.osdl.org ([65.172.181.4]:30685 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261265AbVEFS56 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2005 14:57:58 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j46IvlU3017191
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 6 May 2005 11:57:47 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j46IvkNW024407;
	Fri, 6 May 2005 11:57:46 -0700
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1115404771.16187.343.camel@hades.cambridge.redhat.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 6 May 2005, David Woodhouse wrote:
>
> On Fri, 2005-05-06 at 10:09 -0700, Linus Torvalds wrote:
> > So now you can do
> > 
> >         git-rev-list HEAD --max-count=10 | git-diff-tree --stdin update-cache.c
> > 
> > to see which of the last 10 commits changed "update-cache.c".
> 
> Now show the graph of revision history which connects those commits.

I don't do no steenking GUI's. That's for others, and you'll need to parse
the git-rev-list output yourself to do that.

		Linus
