X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Brian Gernhardt <benji@silverinsanity.com>
Subject: More Perl fun: man and System directories
Date: Wed, 13 Dec 2006 08:07:19 -0500
Message-ID: <4F093D53-CFC7-44F1-9460-22DAD35DBAC8@silverinsanity.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 13 Dec 2006 13:08:11 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Mailer: Apple Mail (2.752.3)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34217>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuTq6-0000M7-MT for gcvg-git@gmane.org; Wed, 13 Dec
 2006 14:08:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964935AbWLMNH2 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 08:07:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964956AbWLMNH1
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 08:07:27 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:36214 "EHLO
 silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S964955AbWLMNHZ (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec 2006
 08:07:25 -0500
Received: from [IPv6???1] (localhost [127.0.0.1]) (using TLSv1 with cipher
 AES128-SHA (128/128 bits)) (No client certificate requested) by
 silverinsanity.com (Postfix) with ESMTP id 1AF921FFC05A for
 <git@vger.kernel.org>; Wed, 13 Dec 2006 13:07:23 +0000 (UTC)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hello again!

Perl's MakeMaker seems to be a rather arcane thing.  I'm trying to  
figure out two things:

1) Perl is creating man files in the wrong place.  My system expects  
them to be in /usr/local/share/man, but Perl is installing them in / 
usr/local/man.  Currently I'm just moving them by hand every time I  
pull-make-install, which is less than optimal.

2) In a bit of what I'm sure is OS X strangeness, Perl is creating a / 
usr/local/System directory that contains one file: "System/Library/ 
Perl/5.8.6/darwin-thread-multi-2level/perllocal.pod".  This doesn't  
seem to be useful, and I'm deleting it without anything exploding  
(noticeably) since I doubt anything is looking for a System directory  
there.  Is there a way to keep Perl from creating it in the first place?

Thanks for your time!
