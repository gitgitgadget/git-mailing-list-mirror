X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Documentation: Update information about <format> in git-for-each-ref
Date: Wed, 01 Nov 2006 11:23:40 +0100
Message-ID: <454875AC.6060300@op5.se>
References: <200610281930.05889.jnareb@gmail.com>	<7vslh86uz9.fsf@assigned-by-dhcp.cox.net>	<200610282323.57797.jnareb@gmail.com> <45485A0F.3040807@op5.se> <7vd5877duh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 1 Nov 2006 10:24:04 +0000 (UTC)
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <7vd5877duh.fsf@assigned-by-dhcp.cox.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30630>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfDG9-0004kv-C4 for gcvg-git@gmane.org; Wed, 01 Nov
 2006 11:23:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1946582AbWKAKXp (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 1 Nov 2006
 05:23:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946588AbWKAKXp
 (ORCPT <rfc822;git-outgoing>); Wed, 1 Nov 2006 05:23:45 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:63108 "EHLO
 smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1946582AbWKAKXo (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 1 Nov 2006 05:23:44 -0500
Received: by smtp-gw1.op5.se (Postfix, from userid 588) id DAC286BD0E; Wed, 
 1 Nov 2006 11:23:43 +0100 (CET)
Received: from [192.168.1.20] (unknown [213.88.215.14]) by smtp-gw1.op5.se
 (Postfix) with ESMTP id BF1A56BCC9; Wed,  1 Nov 2006 11:23:40 +0100 (CET)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:
> Andreas Ericsson <ae@op5.se> writes:
> 
>> Jakub Narebski wrote:
>>
>>> BTW. I had to translate
>>> +       if (strcmp(who, "tagger") && strcmp(who, "committer"))
>>> to
>>> +       if (strcmp(who, "tagger") == 0 || strcmp(who, "committer") == 0)
>>> to understand it. But this is probably my lack of contact with such
>>> C idioms.
>> But this does the exact opposite....
>> "Compare" (as in "strcmp") also translates to "are equal to" and isn't
>> only a verb. This is unfortunate for people who aren't natively
>> english and has had me confused on many a long night...
> 
> Being a non-English speaker, I always pronounce xxxcmp() used as
> boolean 'is different' in my head.  The (correct version of the)
> above example expression is read as 'if it is different from
> "tagger" and it is different from "committer", then do this'.
> 

Without any slight intended toward your english proficiency, I'd say 
your programming is better than your english. For me it's the other way 
around, so I think of the above as "if it doesn't compare to this or 
that, then do this", but the "are equal to" meaning of "compare" isn't 
intuitive to me as I spent the first several years of my 
english-speaking life using "compare" exclusively as a verb.

And yes. There was a compliment hidden in there. Soak it up. You've 
earned it. ;-)

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
