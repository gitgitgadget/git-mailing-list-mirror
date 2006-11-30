X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: Re: git and bzr
Date: Thu, 30 Nov 2006 13:45:32 +0100
Message-ID: <456ED26C.6070306@op5.se>
References: <45357CC3.4040507@utoronto.ca>	<a7e835d40610260257r5f05ea4gc934f1c1cc267977@mail.gmail.com>	<20061026101038.GA13310@coredump.intra.peff.net>	<877iyne4dm.fsf@alplog.fr>	<Pine.LNX.4.64.0610260753090.3962@g5.osdl.org>	<456B7C6A.80104@webdrake.net>	<845b6e870611280410j58bdcd99nc05d0f67489293e4@mail.gmail.com>	<ekhaeg$etk$1@sea.gmane.org>	<Pine.LNX.4.63.0611281433270.30004@wbgn013.biozentrum.uni-wuerzburg.de>	<Pine.LNX.4.64.0611280754050.30076@woody.osdl.org>	<456C7592.6020700@ableton.com>	<ekhtnt$rkk$1@sea.gmane.org>	<456C9DFF.1040407@onlinehome.de>	<456CA981.4010808@onlinehome.de>	<Pine.LNX.4.64.0611281346490.4244@woody.osdl.org>	<456CB197.2030201@onlinehome.de>	<Pine.LNX.4.64.0611281413310.4244@woody.osdl.org>	<Pine.LNX.4.63.0611291149440.30004@wbgn013.biozentrum.uni-wuerzburg.de>	<Pine.LNX.4.64.0611290922410.3513@woody.osdl.org>	<456DD76C.4010902@gmx.net>	<Pine.LNX.4.64.061129
 1235590.3513@woody.osdl.org> <87bqmpvlxf.wl%cworth@cworth.org> <456E8147.9070304@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 30 Nov 2006 12:46:00 +0000 (UTC)
Cc: Carl Worth <cworth@cworth.org>, git@vger.kernel.org,
	bazaar-ng@lists.canonical.com
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <456E8147.9070304@gmx.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32735>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GplIL-0008V6-1g for gcvg-git@gmane.org; Thu, 30 Nov
 2006 13:45:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936328AbWK3Mpf (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 07:45:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936305AbWK3Mpf
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 07:45:35 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:47561 "EHLO
 smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S936330AbWK3Mpd (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 07:45:33 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14]) by smtp-gw1.op5.se
 (Postfix) with ESMTP id 988806BCC1; Thu, 30 Nov 2006 13:45:32 +0100 (CET)
To: Raimund Bauer <ray007@gmx.net>
Sender: git-owner@vger.kernel.org

Raimund Bauer wrote:
> * Carl Worth wrote, On 30.11.2006 01:05:
>> Let's help people do exactly that by making the behavior of "git
>> commit -a" be the default for "git commit".
>>   
> Maybe we could do that _only_ if the index matches HEAD, and otherwise 
> keep current behavior?
> So people who don't care about the index won't get tripped up, and when 
> you do have a dirty index, you get told about it?

Sounds sane. Especially if we couple it with a hint for the user to use 
"commit -a" when he/she wants to do blanket commits.

So in essence that would mean:
If no pathspecs are given and index matches current HEAD, print out
"Nothing to commit but changes in working tree. Assuming 'git commit -a'

and then act accordingly. Carl, do you think that would satisfy the 
desires of your RedHat peers? Always doing '-a' by default is terribly 
wrong for those of us who actually use partial commits a lot, and it 
would also rob git of a lot of its power.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
