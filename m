X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicholas Allen <allen@ableton.com>
Subject: Re: git and bzr
Date: Tue, 28 Nov 2006 20:11:35 +0100
Message-ID: <456C89E7.8080404@ableton.com>
References: <45357CC3.4040507@utoronto.ca>	<a7e835d40610250308v5d577482m139742e7fe1db185@mail.gmail.com>	<87slhcz8zh.wl%cworth@cworth.org>	<a7e835d40610260152k658aeaf0hb900cb63870c04e4@mail.gmail.com>	<7vu01ro20b.fsf@assigned-by-dhcp.cox.net>	<a7e835d40610260257r5f05ea4gc934f1c1cc267977@mail.gmail.com>	<20061026101038.GA13310@coredump.intra.peff.net>	<877iyne4dm.fsf@alplog.fr>	<Pine.LNX.4.64.0610260753090.3962@g5.osdl.org>	<456B7C6A.80104@webdrake.net>	<845b6e870611280410j58bdcd99nc05d0f67489293e4@mail.gmail.com>	<ekhaeg$etk$1@sea.gmane.org>	<Pine.LNX.4.63.0611281433270.30004@wbgn013.biozentrum.uni-wuerzburg.de>	<Pine.LNX.4.64.0611280754050.30076@woody.osdl.org>	<456C7592.6020700@ableton.com> <ekhtnt$rkk$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 28 Nov 2006 19:12:10 +0000 (UTC)
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
In-Reply-To: <ekhtnt$rkk$1@sea.gmane.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gp8Mn-0001aS-MU for gcvg-git@gmane.org; Tue, 28 Nov
 2006 20:11:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936028AbWK1TLi (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 14:11:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936035AbWK1TLi
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 14:11:38 -0500
Received: from mail.ableton.net ([62.96.12.115]:44252 "EHLO
 mail.ableton.net") by vger.kernel.org with ESMTP id S936028AbWK1TLh (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 14:11:37 -0500
Received: from client0055.office.ableton.com ([10.1.15.66]) by
 mail.ableton.net with esmtpsa (TLSv1:AES256-SHA:256) (Exim 4.62)
 (envelope-from <allen@ableton.com>) id 1Gp8N3-00048M-DL; Tue, 28 Nov 2006
 20:11:57 +0100
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski wrote:
> Nicholas Allen wrote:
>
>   
>>> The reason this is a good example is simply the fact that it should 
>>> totally silence anybody who still thinks that tracking file identities is 
>>> a good thing. It explains well why tracking file identities is just 
>>> _stupid_.
>>>       
>> I'm unfamiliar with git so I could be totally wrong here!
>>
>> I know that bzr supports file renames/moves very effectively and I 
>>     
>
> This means: _usually_ works, doesn't it? Emphasisis on "usually"?
>
>   
>> understood that git doesn't support this to the same extent (correct me 
>> if I am wrong as I have not used git at all!).
>>     
>
> Git supports renames/moves in different way. Instead of recording renames
> (which has trouble on it's own, for example rename via applying patch)
> in the repository it _detect_ renames when needed.
>   
This can't be fail safe though. I would prefer to also have the option 
to be able to *explicitly* tell the RCS that a file was renamed and not 
have it try to detect from the content  which is bound to have corner 
cases that fail. When I know I renamed a file why can't I explicitly 
tell the RCS and it records the change with the *file identifier*. If I 
change the content then the change is not recorded with the file 
identifier but with the line/content identifier.

