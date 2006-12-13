X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Allow building GIT in a different directory from the
 source directory
Date: Wed, 13 Dec 2006 10:28:03 +0100
Message-ID: <457FC7A3.60206@op5.se>
References: <eljo2u$pnq$2@sea.gmane.org> <7vbqm9xz8z.fsf@assigned-by-dhcp.cox.net> <457E979F.9060307@xs4all.nl> <Pine.LNX.4.63.0612121951000.2807@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 13 Dec 2006 09:28:22 +0000 (UTC)
Cc: Han-Wen Nienhuys <hanwen@xs4all.nl>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Greylist: delayed 454 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 04:28:11 EST
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <Pine.LNX.4.63.0612121951000.2807@wbgn013.biozentrum.uni-wuerzburg.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34191>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuQPP-0005iP-BV for gcvg-git@gmane.org; Wed, 13 Dec
 2006 10:28:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932635AbWLMJ2M (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 04:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932637AbWLMJ2M
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 04:28:12 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:41661 "EHLO
 smtp-gw1.op5.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S932635AbWLMJ2L (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec 2006
 04:28:11 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14]) by smtp-gw1.op5.se
 (Postfix) with ESMTP id 7787A6BCBF; Wed, 13 Dec 2006 10:28:09 +0100 (CET)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin wrote:
> Hi,
> 
> On Tue, 12 Dec 2006, Han-Wen Nienhuys wrote:
> 
>> I still don't understand the problem with autoconf; there are already 
>> plenty of baroque shell scripts in GIT.  I hate writing m4 macros as 
>> well, but that's not a problem for GIT users (ie. people who compile 
>> GIT).
> 
> That, together with the complexity of GIT_EXEC_DIR and path mangling 
> problems, makes me take every opportunity to suggest we should build in 
> most if not all of Git into the "git wrapper".
> 
> Granted, without completion scripts, the "git-" convention was nice.
> 
> Granted, with bash, Perl and even Python, you can rapidly prototype your 
> thoughts (even if I often miss the power of C there).
> 

We could still allow that by simply not removing the "run this external 
program" code from the git wrapper even if we make all default commands 
built-ins. Pluggable git, just as it is today, and when something turns 
out to be useful, feature-complete and stable enough "someone" will 
hopefully hop in to make it a built-in.

> But in the end, I'd say it makes lots of sense to have everything in one 
> executable.
> 

Yup. Not least for portability issues. The lack of a native windows 
client has already made us lose at least one major "customer", and afaiu 
it was *only* the lack of a native windows client that caused this, so 
obviously it's a big issue for big cross-platform projects.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
