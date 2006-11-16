X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: Re: [ANNOUNCE] qgit-1.5.3
Date: Thu, 16 Nov 2006 01:42:17 +0100
Message-ID: <455BB3E9.4000809@op5.se>
References: <e5bfff550611110006p44494ed4h2979232bfc8e957c@mail.gmail.com>	 <45585749.5030200@op5.se> <e5bfff550611150723p691fc480m874cce9ad4d64476@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 16 Nov 2006 00:42:30 +0000 (UTC)
Cc: Git Mailing List <git@vger.kernel.org>,
	linux-kernel@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <e5bfff550611150723p691fc480m874cce9ad4d64476@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31534>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkVKk-0003Ai-Tq for gcvg-git@gmane.org; Thu, 16 Nov
 2006 01:42:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162119AbWKPAmX (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 19:42:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162123AbWKPAmX
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 19:42:23 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:28618 "EHLO
 smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1162119AbWKPAmW (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 19:42:22 -0500
Received: by smtp-gw1.op5.se (Postfix, from userid 588) id 699486BD52; Thu,
 16 Nov 2006 01:42:21 +0100 (CET)
Received: from [192.168.1.20] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
 by smtp-gw1.op5.se (Postfix) with ESMTP id 358AC6BD21; Thu, 16 Nov 2006
 01:42:18 +0100 (CET)
To: Marco Costalba <mcostalba@gmail.com>
Sender: git-owner@vger.kernel.org

Marco Costalba wrote:
> On 11/13/06, Andreas Ericsson <ae@op5.se> wrote:
>> Marco Costalba wrote:
>> >
>> > Download tarball from http://www.sourceforge.net/projects/qgit
>> > or directly from git public repository
>> > git://git.kernel.org/pub/scm/qgit/qgit.git
>> >
>>
>> Love the tool, but can't fetch the tag. Did you forget to
>>
>>         $ git push origin 1.5.3
>>
> 
> I think I have pushed the new tag, indeed the gitweb interface on
> kernel.org/git shows correctly the 1.5.3 tag (and also two new commits
> after that).
> 
> I've also pulled from kernel.org/git/qgit in a test repository and got
> the tag succesfully.
> 
> I'm not able to reproduce this, in any case I will push again the tags.
> 

That's odd. Here's my .git/remotes/origin
---8<---8<---8<---
URL: git://git.kernel.org/pub/scm/qgit/qgit.git
Pull: master:origin
---8<---8<---8<---

I got the tag now, by doing

$ git fetch --tags

although that didn't work last time I fetched the objects (which was 
after you had posted the announcement). Strange. This was with git 
version 1.4.3.rc3.gb32db.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
