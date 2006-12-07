X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-1.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,LIST_MIRROR_BCC,MSGID_FROM_MTA_HEADER,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: Commit f84871 breaks build on OS X
Date: Thu, 7 Dec 2006 11:04:58 -0500
Message-ID: <1557AC03-7909-4507-B39B-F7C78DC97CB7@silverinsanity.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 7 Dec 2006 16:06:19 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Mailer: Apple Mail (2.752.3)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33598>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsLl9-00059L-0h for gcvg-git@gmane.org; Thu, 07 Dec
 2006 17:06:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1032344AbWLGQGD (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 11:06:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032352AbWLGQGD
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 11:06:03 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:39020 "EHLO
 silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S1032344AbWLGQGA (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec 2006
 11:06:00 -0500
Received: from [IPv6???1] (localhost [127.0.0.1]) (using TLSv1 with cipher
 AES128-SHA (128/128 bits)) (No client certificate requested) by
 silverinsanity.com (Postfix) with ESMTP id 064181FFD203 for
 <git@vger.kernel.org>; Thu,  7 Dec 2006 16:05:59 +0000 (UTC)
To: Alex Riesen <raa.lkml@gmail.com>
Sender: git-owner@vger.kernel.org

On Dec 7, 2006, at 10:42 AM, Alex Riesen wrote:

> Does the attached patch help? I highly suspect the perl.mak generated
> by MakeMaker.

No, it doesn't.  In fact, it looks like perl/Makefile is simply  
getting overwritten by MakeMaker.  I'm guessing MakeMaker is supposed  
to be outputting to "perl.mak" instead?

perl version: 5.8.6 (from perl -v)
MakeMaker version: 6.18  (from /System/Library/Perl/5.8.6/ExtUtils/ 
MakeMaker.pm)

