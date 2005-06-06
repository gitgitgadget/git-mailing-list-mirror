From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Modify git-rev-list ... in merge order [ repost with
 bug fixes ]
Date: Sun, 5 Jun 2005 18:43:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506051842310.1876@ppc970.osdl.org>
References: <20050605134733.3123.qmail@blackcubes.dyndns.org> 
 <Pine.LNX.4.58.0506051741190.1876@ppc970.osdl.org> <2cfc4032050605180958fcf395@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 06 03:38:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Df6ZD-0005q9-PN
	for gcvg-git@gmane.org; Mon, 06 Jun 2005 03:38:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbVFFBlp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Jun 2005 21:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbVFFBlp
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jun 2005 21:41:45 -0400
Received: from fire.osdl.org ([65.172.181.4]:2774 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261152AbVFFBln (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Jun 2005 21:41:43 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j561fejA008633
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 5 Jun 2005 18:41:40 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j561fdVh000934;
	Sun, 5 Jun 2005 18:41:39 -0700
To: jon@blackcubes.dyndns.org
In-Reply-To: <2cfc4032050605180958fcf395@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 6 Jun 2005, Jon Seymour wrote:
> 
> My rationale was to re-use both the filtering logic currently in the
> show_commit_list while loop and the display logic, since I need both
> in order to maximise compatibility with the standard algorithm.

It's obviously ok to re-use the filtering, I'm just objecting to putting
it into a function that is really unrelated to filtering..

> My plan, therefore, is to split the filtering logic from
> show_commit_list's while loop into a separate function and create a
> third function which calls the filtering logic, then show_commit.

Yes.

		Linus
