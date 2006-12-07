X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: Commit f84871 breaks build on OS X
Date: 07 Dec 2006 12:18:32 -0800
Message-ID: <86ejrbihnr.fsf@blue.stonehenge.com>
References: <2D096A57-D7B3-49C7-81E4-EB47A0D933B2@silverinsanity.com>
	<81b0412b0612070633i7aec43dse7a8beda64437103@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 7 Dec 2006 20:18:46 +0000 (UTC)
Cc: "Brian Gernhardt" <benji@silverinsanity.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
x-mayan-date: Long count = 12.19.13.15.14; tzolkin = 8 Ix; haab = 7 Mac
In-Reply-To: <81b0412b0612070633i7aec43dse7a8beda64437103@mail.gmail.com>
Original-Lines: 19
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33631>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsPhU-0005YY-QS for gcvg-git@gmane.org; Thu, 07 Dec
 2006 21:18:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1163273AbWLGUSe (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 15:18:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163276AbWLGUSe
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 15:18:34 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:42000 "EHLO
 blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1163273AbWLGUSd (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec 2006
 15:18:33 -0500
Received: from localhost (localhost [127.0.0.1]) by blue.stonehenge.com
 (Postfix) with ESMTP id EF9B88FD33; Thu,  7 Dec 2006 12:18:32 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1]) by localhost
 (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024) with LMTP id
 02642-02-98; Thu,  7 Dec 2006 12:18:32 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001) id 8016F8FD7B;
 Thu,  7 Dec 2006 12:18:32 -0800 (PST)
To: "Alex Riesen" <raa.lkml@gmail.com>
Sender: git-owner@vger.kernel.org

>>>>> "Alex" == Alex Riesen <raa.lkml@gmail.com> writes:

Alex> Strange. You seem to have the old, generated Makefile you perl/
Alex> directory. Haven't your pull failed? If so, I suspect that

Alex>  rm perl/Makefile
Alex>  git reset --hard
Alex>  git pull git...

I ended up having to do another reset afterward.

Definitely something went weird when Makefile was removed
from .gitignore.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
