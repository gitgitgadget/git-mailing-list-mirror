X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Rogan Dawes <discard@dawes.za.net>
Subject: Re: Locked down (but still shared) repositories
Date: Thu, 07 Dec 2006 21:45:30 +0200
Message-ID: <45786F5A.6020400@dawes.za.net>
References: <20061207113539.GA10781@spearce.org> <Pine.LNX.4.63.0612071640160.28348@wbgn013.biozentrum.uni-wuerzburg.de> <20061207191730.GA12143@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 7 Dec 2006 19:46:02 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
Original-Newsgroups: gmane.comp.version-control.git
In-Reply-To: <20061207191730.GA12143@spearce.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33618>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsPBj-0000WQ-MN for gcvg-git@gmane.org; Thu, 07 Dec
 2006 20:45:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1163239AbWLGTpp (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 14:45:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163241AbWLGTpp
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 14:45:45 -0500
Received: from sd-green-bigip-83.dreamhost.com ([208.97.132.83]:47786 "EHLO
 spunkymail-a6.dreamhost.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
 with ESMTP id S1163239AbWLGTpo (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7
 Dec 2006 14:45:44 -0500
Received: from [192.168.201.102] (dsl-146-24-82.telkomadsl.co.za
 [165.146.24.82]) by spunkymail-a6.dreamhost.com (Postfix) with ESMTP id
 D77EE109F2B; Thu,  7 Dec 2006 11:45:33 -0800 (PST)
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

Shawn Pearce wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>> On Thu, 7 Dec 2006, Shawn Pearce wrote:
>>
>>> For various auditing reasons the repositories need to be tightly
>>> controlled.  That is the following cannot be permitted:
>>>
>>> [...]
>> How about just one such user? After all, you already have this user: the 
>> repo owner. Of course, people have to push via ssh, even on the same 
>> machine.
> 
> How do I know which SSH key the client used to connect?  Remember I'm
> looking at the real uid to determine who is performing the operation.
> In the situation you describe everyone looks the same to the
> update hook...
> 
> For (probably stupid) reasons the server is the commerial F-Secure
> SSH server, btw.  So OpenSSH based things wouldn't apply.  And best
> that I can tell, F-Secure SSH won't tell me which key was used
> to authenticate.
> 

See Section 8.2.6.1

http://www.unix.org.ua/orelly/networking_2ndEd/ssh/ch08_02.htm

You should be able to do something similar for git as they do for SSH.

Rogan
