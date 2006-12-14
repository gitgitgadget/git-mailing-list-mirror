X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: More Perl fun: man and System directories
Date: Thu, 14 Dec 2006 09:15:20 -0500
Message-ID: <B8208A6B-E42B-4BCD-8CAC-7EE222B18195@silverinsanity.com>
References: <4F093D53-CFC7-44F1-9460-22DAD35DBAC8@silverinsanity.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 14 Dec 2006 14:15:41 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <4F093D53-CFC7-44F1-9460-22DAD35DBAC8@silverinsanity.com>
X-Mailer: Apple Mail (2.752.3)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34342>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GurMy-0001vr-0S for gcvg-git@gmane.org; Thu, 14 Dec
 2006 15:15:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932747AbWLNOPY (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 09:15:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932744AbWLNOPY
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 09:15:24 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:48442 "EHLO
 silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S932747AbWLNOPY (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 09:15:24 -0500
Received: from [IPv6???1] (localhost [127.0.0.1]) (using TLSv1 with cipher
 AES128-SHA (128/128 bits)) (No client certificate requested) by
 silverinsanity.com (Postfix) with ESMTP id 08B2E1FFCECA; Thu, 14 Dec 2006
 14:15:22 +0000 (UTC)
To: Sebasitan Harl <sh@tokkee.org>
Sender: git-owner@vger.kernel.org

Sorry about the delay.  My subscription e-mail to the list got  
delayed somewhere along the way, so I missed your message until I  
decided to poke at the web archive.

On Dec 13, 2006, at 1:14 PM, Sebastian Harl wrote:
> On Wed, Dec 13, 2006 at 08:07:19AM -0500, Brian Gernhardt wrote:
> > 1) Perl is creating man files in the wrong place.  My system expects
> > them to be in /usr/local/share/man, but Perl is installing them in /
> > usr/local/man.  Currently I'm just moving them by hand every time I
> > pull-make-install, which is less than optimal.
>
> Try "perl Makefile.PL INSTALLDIRS=vendor".

That doesn't seem to change anything at all, and checking "man  
ExtUtils::MakeMaker" and "perl -V:install.*", that still seems to  
install man files in /usr/local/man instead of /usr/local/share/man.   
And still generates /usr/local/System/...

I ran:
cd perl; perl Makefile.PL INSTALLDIRS=vendor; cd ..; make; sudo make  
install

Maybe I need to tweak Perl's variables somewhere instead.  Or my  
MANPATH.  The latter is probably easier.

