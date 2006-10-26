X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: Re: git-shortlog mailmap
Date: Thu, 26 Oct 2006 14:43:26 +0200
Message-ID: <4540AD6E.6070201@op5.se>
References: <7vk62npipb.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0610261114520.3286@wbgn013.biozentrum.uni-wuerzburg.de> <ehputm$ch2$3@sea.gmane.org> <20061026123424.GQ20017@pasky.or.cz> <ehqaco$r4l$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 26 Oct 2006 12:43:40 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <ehqaco$r4l$1@sea.gmane.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30208>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd4a6-00009n-Cs for gcvg-git@gmane.org; Thu, 26 Oct
 2006 14:43:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423465AbWJZMnb (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 08:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423475AbWJZMnb
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 08:43:31 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:62095 "EHLO
 smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1423465AbWJZMna (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 08:43:30 -0400
Received: by smtp-gw1.op5.se (Postfix, from userid 588) id 36E976BE1C; Thu,
 26 Oct 2006 14:43:29 +0200 (CEST)
Received: from [192.168.1.20] (unknown [213.88.215.14]) by smtp-gw1.op5.se
 (Postfix) with ESMTP id 826F66BD02; Thu, 26 Oct 2006 14:43:26 +0200 (CEST)
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski wrote:
> Petr Baudis wrote:
> 
>> I think I've complained about this in the past, but can't find the mail.
>>
>> Dear diary, on Thu, Oct 26, 2006 at 11:25:50AM CEST, I got a letter
>> where Jakub Narebski <jnareb@gmail.com> said that...
>>> Johannes Schindelin wrote:
>>>
>>>> BTW what happened to the builtin shortlog? It is the last Perl script I 
>>>> use regularly... (should make people happy who are stuck with Activision 
>>>> Perl...)
>>> BTW. both Perl version and builtin shorlog have email->real name translation
>>> table built in. In Perl script version it is in __DATA__ section, and we
>>> could update it using Inline::Files module, in C version it was in table.
>>> But in fact this list is project specific. Shouldn't we make it customizable
>>> (::sigh::, yet another file in $GIT_DIR...).
>> I really dislike the fact that we _do_ this mapping at all, this seems
>> so much a totally wrong point at which to do it. The information tracked
>> in Git is still wrong and all the tools except shortlog still display it
>> wrong - why should shortlog in particular be special? Why don't we do
>> this at the git-am time instead?
> 
> Because git-shortlog has to deal also with _historical_ data, which caused
> one way or the other to have only email and not realname recorded. So till
> history gets rewritteen, and tags resigned, git-shortlog has to do the
> mapping to have meaningfull output.

Wouldn't this be better implemented in the rev-list code then, so all 
log viewers can benefit from it?

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
