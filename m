X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: Re: Did anyone have trouble learning the idea of local vs. remote
 branches?
Date: Wed, 08 Nov 2006 13:17:59 +0100
Message-ID: <4551CAF7.3050008@op5.se>
References: <20061107172450.GA26591@spearce.org> <vpqbqnisegc.fsf@ecrins.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 8 Nov 2006 12:18:19 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <vpqbqnisegc.fsf@ecrins.imag.fr>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31138>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhmNd-00084A-Jr for gcvg-git@gmane.org; Wed, 08 Nov
 2006 13:18:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754558AbWKHMSG (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 8 Nov 2006
 07:18:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754559AbWKHMSF
 (ORCPT <rfc822;git-outgoing>); Wed, 8 Nov 2006 07:18:05 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:55752 "EHLO
 smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1754558AbWKHMSD (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 8 Nov 2006 07:18:03 -0500
Received: by smtp-gw1.op5.se (Postfix, from userid 588) id 45FC26BCFE; Wed, 
 8 Nov 2006 13:18:02 +0100 (CET)
Received: from [192.168.1.20] (unknown [213.88.215.14]) by smtp-gw1.op5.se
 (Postfix) with ESMTP id A12AF6BCDF for <git@vger.kernel.org>; Wed,  8 Nov
 2006 13:17:59 +0100 (CET)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Matthieu Moy wrote:
> Shawn Pearce <spearce@spearce.org> writes:
> 
>> Today I was talking with someone that I collaborate with through
>> Git and they still seemed to not get the idea that all branches
>> in their repository are local, and that at least a 'git fetch'
>> is needed to update the local tracking branches to the version
>> in the central repository that we collaborate through.  And this
>> isn't the first time we've had such discussions.
> 
> To me, the biggest difficulty was to understand the vocubulary.

I had that same problem, although I started with git and came from CVS / 
SVN. I am sufficiently experienced with those two system to hope that I 
wouldn't come across any similarities at all, so I wasn't expecting any, 
so I didn't get too badly bitten.

The Documentation/glossary.txt file is a very good place to start 
reading, although I wouldn't object to it being re-arranged to have the 
terms described there pop up "in order of appearance", so to speak. I 
sent in a couple of patches to the glossary file whenever I encountered 
something in gittish that I didn't understand. Sometimes I had managed 
to guess the correct meaning and the patch got applied. In other cases I 
had it completely wrong and other, more gittish-fluent, people corrected 
the patches and amended the documentation that led to the confusion.

I think this is the only way to keep the docs alive and 
newcomer-friendly. Sadly, neither the maintainer nor the active 
contributors have newbie-eyes so we're relying on everyone who *are* new 
to git to help keep git easy for new people.


> And the git Vs cogito increased the confusion.
> 

I've found that too. It's a shame that some things can be done with git 
that isn't possible (or at least easy) with cogito and the other way 
around. The shared but divergent terminology doesn't exactly help 
either. Now I fear it's too late to do anything about it.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
