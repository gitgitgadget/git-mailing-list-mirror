X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: Re: Cleaning up git user-interface warts
Date: Sat, 18 Nov 2006 07:59:51 +0000
Message-ID: <200611180759.52021.alan@chandlerfamily.org.uk>
References: <87k61yt1x2.wl%cworth@cworth.org> <87bqn9u43s.wl%cworth@cworth.org> <7vr6w5y7to.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 18 Nov 2006 08:00:14 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.5
In-Reply-To: <7vr6w5y7to.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31765>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlL7R-0004KK-56 for gcvg-git@gmane.org; Sat, 18 Nov
 2006 09:00:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754237AbWKRH75 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 18 Nov 2006
 02:59:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756228AbWKRH74
 (ORCPT <rfc822;git-outgoing>); Sat, 18 Nov 2006 02:59:56 -0500
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk
 ([82.44.22.127]:39130 "EHLO home.chandlerfamily.org.uk") by vger.kernel.org
 with ESMTP id S1754237AbWKRH74 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 18
 Nov 2006 02:59:56 -0500
Received: from kanger.home ([192.168.0.21]) by home.chandlerfamily.org.uk
 with esmtp (Exim 4.63) (envelope-from <alan@chandlerfamily.org.uk>) id
 1GlL7D-0005mM-40 for git@vger.kernel.org; Sat, 18 Nov 2006 07:59:55 +0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Tuesday 14 November 2006 22:36, Junio C Hamano wrote:
...
>
> And I agree with Pasky that fixing UI is hard unless you are
> willing to get rid of historical warts.  Syntax of the command
> line arguments the current set of Porcelain-ish takes are
> sometimes just horrible.  It may not be a bad idea to start
> building the fixed UI from scratch, using different prefix than
> "git" (say "gu" that stands for "git UI" or "gh" that stands for
> "git for humans").
>
> Of course, it could even be "cg" ;-).

I have been away on business last week and have been following this thread 
from the archives.  There is a comment I want to make about split of 
Porcelain and Plumbing namespaces that is not particularly an answer to this 
particular post, but it does seem an appropriate place to insert it.

I think there were three (historic) mistakes in the development of git
	- to split git and cogito so that some of the commands started git and some 
cg (aided and abetted by putting them in separate repositories).
	- to try and make the distinction between plumbing and porcelein a line in 
the sand (after all this is exactly why git and cg separated) when in 
practice it isn't that straight forward
	- for cogito to (initially) not support the internal branches, but in fact 
deal with them via cloned repositories

On the other hand, it was a good move to bring gitk and gitweb into the core 
repository.

These were not technical mistakes, but social ones.

Much of the discussion on UI warts doesn't exist in the cogito world (not that 
I use it at all anymore, despite its more user friendly interface - just 
because I didn't want to learn two parallel sets of commands and I prefered 
git's branch model so stuck with the slightly less friendly git command set) 
but if you look at any of the SCM comparison discussions that happen now, 
they are always comparing the core git with the other SCM, not git plus all 
its porcelains.

So I think it would be a mistake (which hopefully does seem to be the 
concensus reached in the list) to try and introduce new namespaces to the 
command set.
-- 
Alan Chandler
