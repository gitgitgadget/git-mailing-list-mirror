From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: First cut at git port to Cygwin
Date: Wed, 5 Oct 2005 21:17:41 +0200
Message-ID: <20051005191741.GA25493@steel.home>
References: <433B3B10.5050407@zytor.com> <81b0412b0510040531m441ca759k6d1f3fbf0cd248ce@mail.gmail.com> <434299DB.7020805@zytor.com> <81b0412b0510050424h21fc06bav7677911f52b38426@mail.gmail.com> <81b0412b0510050846l2258775co117bada2d2b5a1ad@mail.gmail.com> <20051005155457.GA30303@trixie.casa.cgf.cx>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 05 21:21:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENEma-0001pt-Oi
	for gcvg-git@gmane.org; Wed, 05 Oct 2005 21:18:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030313AbVJETSA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Oct 2005 15:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965232AbVJETR7
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Oct 2005 15:17:59 -0400
Received: from devrace.com ([198.63.210.113]:22027 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S965233AbVJETR6 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Oct 2005 15:17:58 -0400
Received: from tigra.home (p54A0FB81.dip.t-dialin.net [84.160.251.129])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id j95JTx3E051208;
	Wed, 5 Oct 2005 14:30:06 -0500 (CDT)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1ENElq-0003rX-00; Wed, 05 Oct 2005 21:17:42 +0200
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1ENElp-0006dO-VO; Wed, 05 Oct 2005 21:17:41 +0200
To: Christopher Faylor <me@cgf.cx>
Content-Disposition: inline
In-Reply-To: <20051005155457.GA30303@trixie.casa.cgf.cx>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=1.7 required=4.5 tests=BAYES_05,RCVD_IN_NJABL_DUL,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9727>

Christopher Faylor, Wed, Oct 05, 2005 17:54:57 +0200:
> >Still does not work for me. I cannot isolate the problem out of git,
> >but at the moment the only way for me to make commit_index_file to work
> >is to put unlink(indexfile) before rename(cf->lockfile, indexfile).
> >
> >For everyone interested, I attach cygwin's strace output here.
> 
> I'm sorry that I missed this thread.  I'm usually pretty alert to the word
> "cygwin" showing up in a subject.
> 
> I'll go back and read the archives to catch up but, at the risk of
> making an observation that has already been made, under windows you
> can't always rename a file that is open.  Is that what's happening here?
> 

Don't think so, but will check in about 10 hrs. The code in question
is in index.c, commit_index_file.
