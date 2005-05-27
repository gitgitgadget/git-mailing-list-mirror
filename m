From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: ALSA official git repository
Date: Fri, 27 May 2005 09:13:02 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505270903230.17402@ppc970.osdl.org>
References: <Pine.LNX.4.58.0505271741490.1757@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 27 18:10:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbhOp-0007W4-Qn
	for gcvg-git@gmane.org; Fri, 27 May 2005 18:09:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262492AbVE0QLT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 May 2005 12:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262489AbVE0QLT
	(ORCPT <rfc822;git-outgoing>); Fri, 27 May 2005 12:11:19 -0400
Received: from fire.osdl.org ([65.172.181.4]:50834 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262486AbVE0QLF (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 May 2005 12:11:05 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4RGAwjA017372
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 27 May 2005 09:10:59 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4RGAvdU027709;
	Fri, 27 May 2005 09:10:58 -0700
To: Jaroslav Kysela <perex@suse.cz>
In-Reply-To: <Pine.LNX.4.58.0505271741490.1757@pnote.perex-int.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 27 May 2005, Jaroslav Kysela wrote:
> 
> 	I created new git tree for the ALSA project at:
> 
> rsync://rsync.kernel.org/pub/scm/linux/kernel/git/perex/alsa.git

Your scripts(?) to generate these things are a bit strange, since they
leave an extra empty line in the commit message, which confuses at least
gitweb (ie just look at

   http://www.kernel.org/git/?p=linux/kernel/git/perex/alsa.git;a=summary

and note how the summary thing looks empty).

Now, arguably gitweb should ignore whitespace at the beginning, but 
equally arguably your commits shouldn't have them either...

		Linus

