From: Sean <seanlkml@sympatico.ca>
Subject: Re: [PATCH 0/5] More ref logging
Date: Fri, 19 May 2006 07:16:03 -0400
Message-ID: <BAYC1-PASMTP04D6ED73408969450597A9AEA70@CEZ.ICE>
References: <20060519091456.GH22257@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 19 13:22:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fh33Q-0006ML-61
	for gcvg-git@gmane.org; Fri, 19 May 2006 13:22:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273AbWESLVs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 May 2006 07:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932275AbWESLVs
	(ORCPT <rfc822;git-outgoing>); Fri, 19 May 2006 07:21:48 -0400
Received: from bayc1-pasmtp04.bayc1.hotmail.com ([65.54.191.164]:38236 "EHLO
	BAYC1-PASMTP04.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S932273AbWESLVs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 May 2006 07:21:48 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP04.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 19 May 2006 04:21:47 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 426C4644C28;
	Fri, 19 May 2006 07:21:46 -0400 (EDT)
To: Shawn Pearce <spearce@spearce.org>
Message-Id: <20060519071603.11d3be5d.seanlkml@sympatico.ca>
In-Reply-To: <20060519091456.GH22257@spearce.org>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 19 May 2006 11:21:47.0714 (UTC) FILETIME=[6AD08A20:01C67B36]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 19 May 2006 05:14:56 -0400
Shawn Pearce <spearce@spearce.org> wrote:

> * [PATCH 5/5] Enable ref log creation in git checkout -b.
> 
> 	Fix git checkout -b to behave like git branch.

It seems that the ref log is a new way of tagging commits with some
extra meta data.  Conceptually this seems very close to what git tags 
already do.  So... what about using regular git tags rather than
creating a ref log?  All the regular git-rev-list tools could be
used to query the tags and prune would delete them automatically etc.

Just a thought, feel free to ignore it :o)

Sean
