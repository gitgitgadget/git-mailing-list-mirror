X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: git-pull from git.git - no remote ref for pu or next?
Date: 12 Dec 2006 08:47:08 -0800
Message-ID: <86y7pd6oz7.fsf@blue.stonehenge.com>
References: <863b7l83o9.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 12 Dec 2006 16:47:51 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
x-mayan-date: Long count = 12.19.13.15.19; tzolkin = 13 Cauac; haab = 12 Mac
In-Reply-To: <863b7l83o9.fsf@blue.stonehenge.com>
Original-Lines: 29
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34110>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuAnB-0008Sw-Td for gcvg-git@gmane.org; Tue, 12 Dec
 2006 17:47:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932209AbWLLQrK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 11:47:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751513AbWLLQrK
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 11:47:10 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:33361 "EHLO
 blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1751487AbWLLQrJ (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec 2006
 11:47:09 -0500
Received: from localhost (localhost [127.0.0.1]) by blue.stonehenge.com
 (Postfix) with ESMTP id C4E528F5F1 for <git@vger.kernel.org>; Tue, 12 Dec
 2006 08:47:08 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1]) by localhost
 (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024) with LMTP id
 08478-01-79 for <git@vger.kernel.org>; Tue, 12 Dec 2006 08:47:08 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001) id 2490F8F613;
 Tue, 12 Dec 2006 08:47:08 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

>>>>> "Randal" == Randal L Schwartz <merlyn@stonehenge.com> writes:

Randal> I just got this on this morning's git-fetch:

Randal>     error: no such remote ref refs/heads/pu
Randal>     error: no such remote ref refs/heads/next
Randal>     Fetch failure: git://git.kernel.org/pub/scm/git/git.git

Randal> Here's my remotes/origin:

Randal>     URL: git://git.kernel.org/pub/scm/git/git.git
Randal>     Pull: master:origin
Randal>     Pull: man:man
Randal>     Pull: html:html
Randal>     Pull: +pu:pu
Randal>     Pull: +next:next

And then it mysteriously fixed itself a few minutes later.
Is there some sort of publishing failure, or intermittent race condition?

Or is this something unique to git.git?

Or just bad electron spin or something?

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
