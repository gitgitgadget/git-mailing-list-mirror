X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Marko Macek <marko.macek@gmx.net>
Subject: Re: Cleaning up git user-interface warts
Date: Thu, 16 Nov 2006 07:07:47 +0100
Message-ID: <455C0033.2020309@gmx.net>
References: <Pine.LNX.4.64.0611141518590.2591@xanadu.home>	<87bqn9u43s.wl%cworth@cworth.org> <ejdcg5$4fl$1@sea.gmane.org>	<Pine.LNX.4.64.0611141633430.2591@xanadu.home>	<7vbqn9y6w6.fsf@assigned-by-dhcp.cox.net>	<Pine.LNX.4.64.0611142007010.2591@xanadu.home>	<7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net>	<Pine.LNX.4.64.0611142306090.2591@xanadu.home>	<Pine.LNX.4.64.0611150950170.3349@woody.osdl.org>	<Pine.LNX.4.64.0611151315291.2591@xanadu.home>	<20061115184914.GA24122@spearce.org> <455B64F7.9040506@gmx.net> <7vejs4l9wy.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 16 Nov 2006 06:10:41 +0000 (UTC)
Cc: Shawn Pearce <spearce@spearce.org>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
	cworth@cworth.org, pasky@suse.cz
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #420190
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
Original-Newsgroups: gmane.comp.version-control.git
In-Reply-To: <7vejs4l9wy.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31561>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkaSJ-0000Ce-Hj for gcvg-git@gmane.org; Thu, 16 Nov
 2006 07:10:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161859AbWKPGK2 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006
 01:10:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031076AbWKPGK2
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 01:10:28 -0500
Received: from mail.gmx.net ([213.165.64.20]:49095 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1031015AbWKPGK1 (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 01:10:27 -0500
Received: (qmail invoked by alias); 16 Nov 2006 06:10:25 -0000
Received: from BSN-77-245-67.dial-up.dsl.siol.net (EHLO [192.168.2.7])
 [193.77.245.67] by mail.gmx.net (mp038) with SMTP; 16 Nov 2006 07:10:25 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:
> Marko Macek <marko.macek@gmx.net> writes:
> 
>> For people switching from CVS and SVN it would be much better if the
>> index was hidden behind the scenes by using different defaults:
>>
>> git-commit -a
>> git-status -a
>> git-diff HEAD
>>
>> BTW, currently there's a minor bug: git-diff HEAD doesn't work before
>> you make the first commit. Perhaps this should be special cased.
> 
> That's only a _bug_ in your implementation of the synonym for
> "svn diff" which blindly used "git diff HEAD".


My "implementation" is taken from git-diff man page. It seems obvious
that the situation before the first commit is just a special case if 
we consider git-diff to be Porcelain (which I do).

 
> This "there is no HEAD yet" is not related to the index, but I

I agree, this is a separate issue.

