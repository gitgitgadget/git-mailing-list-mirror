X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: [RFC] requiring Perl SVN libraries for git-svn
Date: 13 Dec 2006 13:17:05 -0800
Message-ID: <86slfj1ooe.fsf@blue.stonehenge.com>
References: <20061213202142.GE8179@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 13 Dec 2006 21:44:27 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Greylist: delayed 1634 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 16:44:20 EST
x-mayan-date: Long count = 12.19.13.16.0; tzolkin = 1 Ahau; haab = 13 Mac
In-Reply-To: <20061213202142.GE8179@localdomain>
Original-Lines: 22
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34234>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gubto-0002Ej-4J for gcvg-git@gmane.org; Wed, 13 Dec
 2006 22:44:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751174AbWLMVoV (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 16:44:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbWLMVoV
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 16:44:21 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:14931 "EHLO
 blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1751174AbWLMVoU (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec 2006
 16:44:20 -0500
Received: from localhost (localhost [127.0.0.1]) by blue.stonehenge.com
 (Postfix) with ESMTP id B2D738FD9B; Wed, 13 Dec 2006 13:17:05 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1]) by localhost
 (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024) with LMTP id
 00778-01-22; Wed, 13 Dec 2006 13:17:05 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001) id 300FC8FDA8;
 Wed, 13 Dec 2006 13:17:05 -0800 (PST)
To: Eric Wong <normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org

>>>>> "Eric" == Eric Wong <normalperson@yhbt.net> writes:

Eric> The API of the SVN:: libraries seem to be relatively stable these days
Eric> and are *much* faster than the command-line client.  I plan on
Eric> maintaining compatibility with version 1.1 of the SVN libraries for at
Eric> least another year; or more if it's not a big problem.

For a while, I would have been upset.  I was building SVN from fink, even
though I was using a private Perl as /usr/local/bin/perl.  And since the Perl
bindings have to be built when the SVN package is built, it was being built
against the core Perl, which I didn't use, so I couldn't use the SVN bindings.

Now, I'm building SVN from darwinports, which builds its own Perl, and I have
~/bin/git-svn wrap the /opt/git/bin/git-svn passing it the /opt/local/bin/perl
instead of the first Perl in the path.  And it all just works.  I suppose
I could have done that before too. :)

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
