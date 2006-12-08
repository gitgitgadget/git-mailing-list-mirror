X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: Re: Documentation/git-commit.txt
Date: Fri, 8 Dec 2006 22:56:45 +0000
Message-ID: <200612082256.45456.alan@chandlerfamily.org.uk>
References: <7vy7pik51b.fsf@assigned-by-dhcp.cox.net> <4579529F.9030401@Intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 8 Dec 2006 22:56:56 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.5
In-Reply-To: <4579529F.9030401@Intel.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33764>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsoeB-0001zk-Tm for gcvg-git@gmane.org; Fri, 08 Dec
 2006 23:56:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1947470AbWLHW4s (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 17:56:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947475AbWLHW4s
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 17:56:48 -0500
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk
 ([82.44.22.127]:57867 "EHLO home.chandlerfamily.org.uk"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1947474AbWLHW4r
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006 17:56:47 -0500
Received: from kanger.home ([192.168.0.21]) by home.chandlerfamily.org.uk
 with esmtp (Exim 4.63) (envelope-from <alan@chandlerfamily.org.uk>) id
 1Gsoe6-0001iS-Oq for git@vger.kernel.org; Fri, 08 Dec 2006 22:56:46 +0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Friday 08 December 2006 11:55, Salikh Zakirov wrote:
> Junio Hamano wrote:
> > +Instead of staging files after each individual change, you can
> > +tell `git commit` to notice the changes to the tracked files in
> > +your working tree and do corresponding `git add` and `git rm`
> > +for you.
>
> This part is confusing as hell to anyone having any experience
> with either CVS, SVN, Hg or Monotone, as doing "corresponding `git
> add` and `git rm`" commands automatically will be interpreted as
> adding untracked files automatically, which is not the case here.

I thought the wording here was a little weird too.  I think this stems 
from the mistake of saying "tracked files" instead of "tracked content" 
which then leads to you falling back to the git add and git rm 
commands..

How about the following wording here

Instead of staging the content of each file immediately after changing 
it, you can wait until you have completed all the changes you want to 
make and then use the `-a` option to tell `git commit` to look for all 
changes to the content it is tracking and commit it automatically. That 
is, this example ...


  

-- 
Alan Chandler
