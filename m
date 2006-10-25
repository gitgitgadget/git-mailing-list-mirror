X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: Re: VCS comparison table
Date: Wed, 25 Oct 2006 11:35:52 +0200
Message-ID: <453F2FF8.2080903@op5.se>
References: <45357CC3.4040507@utoronto.ca> <Pine.LNX.4.64.0610172014250.3962@g5.osdl.org> <4536EC93.9050305@utoronto.ca> <87lkncev90.wl%cworth@cworth.org> <453792A8.1010700@utoronto.ca> <878xjc2qeb.wl%cworth@cworth.org> <453803E6.2060309@utoronto.ca> <87ods727pn.wl%cworth@cworth.org> <45382120.9060702@utoronto.ca> <87irie1wvv.wl%cworth@cworth.org> <20061021130111.GL75501@over-yonder.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 25 Oct 2006 09:36:10 +0000 (UTC)
Cc: Carl Worth <cworth@cworth.org>,
	Aaron Bentley <aaron.bentley@utoronto.ca>,
	Linus Torvalds <torvalds@osdl.org>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <20061021130111.GL75501@over-yonder.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30041>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GcfB1-0007WG-Mn for gcvg-git@gmane.org; Wed, 25 Oct
 2006 11:36:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423153AbWJYJf5 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006
 05:35:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423154AbWJYJf5
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 05:35:57 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:47799 "EHLO
 smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1423153AbWJYJf4 (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 05:35:56 -0400
Received: by smtp-gw1.op5.se (Postfix, from userid 588) id 024726BDDA; Wed,
 25 Oct 2006 11:35:54 +0200 (CEST)
Received: from [192.168.1.20] (unknown [213.88.215.14]) by smtp-gw1.op5.se
 (Postfix) with ESMTP id 650C56BD5E; Wed, 25 Oct 2006 11:35:52 +0200 (CEST)
To: "Matthew D. Fuller" <fullermd@over-yonder.net>
Sender: git-owner@vger.kernel.org

Matthew D. Fuller wrote:
> On Fri, Oct 20, 2006 at 02:48:52PM -0700 I heard the voice of
> Carl Worth, and lo! it spake thus:
> 
>> (since pull seems the only way to synch up without infinite new
>> merge commits being added back and forth).
> 
> The infinite-merge-commits case doesn't happen in bzr-land because we
> generally don't merge other branches except when the branch owner says
> "Hey, I've got something for you to merge".  If you were to setup a
> script to merge two branches back and forth until they were 'equal',
> yes, it'd churn away until you filled up your disk with the N bytes of
> metadata every new revision uses up.
> 

This is new to me. At work, we merge our toy repositories back and forth 
between devs only. There is no central repo at all. Does this mean that 
each merge would add one extra commit per time the one I'm merging with 
has merged with me?

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
