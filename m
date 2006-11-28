X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicholas Allen <nick.allen@onlinehome.de>
Subject: Re: git and bzr
Date: Tue, 28 Nov 2006 21:37:19 +0100
Message-ID: <456C9DFF.1040407@onlinehome.de>
References: <45357CC3.4040507@utoronto.ca>	<a7e835d40610250308v5d577482m139742e7fe1db185@mail.gmail.com>	<87slhcz8zh.wl%cworth@cworth.org>	<a7e835d40610260152k658aeaf0hb900cb63870c04e4@mail.gmail.com>	<7vu01ro20b.fsf@assigned-by-dhcp.cox.net>	<a7e835d40610260257r5f05ea4gc934f1c1cc267977@mail.gmail.com>	<20061026101038.GA13310@coredump.intra.peff.net>	<877iyne4dm.fsf@alplog.fr>	<Pine.LNX.4.64.0610260753090.3962@g5.osdl.org>	<456B7C6A.80104@webdrake.net>	<845b6e870611280410j58bdcd99nc05d0f67489293e4@mail.gmail.com>	<ekhaeg$etk$1@sea.gmane.org>	<Pine.LNX.4.63.0611281433270.30004@wbgn013.biozentrum.uni-wuerzburg.de>	<Pine.LNX.4.64.0611280754050.30076@woody.osdl.org>	<456C7592.6020700@ableton.com> <ekhtnt$rkk$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 28 Nov 2006 20:37:48 +0000 (UTC)
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (X11/20061115)
In-Reply-To: <ekhtnt$rkk$1@sea.gmane.org>
X-Enigmail-Version: 0.94.0.0
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:8f68dfdb39f9894a8a7411e7c5df1048
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32574>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gp9hr-0007Eu-Er for gcvg-git@gmane.org; Tue, 28 Nov
 2006 21:37:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754368AbWK1Uh1 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 15:37:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754665AbWK1Uh1
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 15:37:27 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:64203 "EHLO
 moutng.kundenserver.de") by vger.kernel.org with ESMTP id S1754368AbWK1Uh0
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 15:37:26 -0500
Received: from [84.190.155.117] (helo=[192.168.1.100]) by
 mrelayeu.kundenserver.de (node=mrelayeu6) with ESMTP (Nemesis), id
 0ML29c-1Gp9hg3qWH-0008Uy; Tue, 28 Nov 2006 21:37:24 +0100
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski wrote:
> Nicholas Allen wrote:
> 
>>> The reason this is a good example is simply the fact that it should 
>>> totally silence anybody who still thinks that tracking file identities is 
>>> a good thing. It explains well why tracking file identities is just 
>>> _stupid_.
>> I'm unfamiliar with git so I could be totally wrong here!
>>
>> I know that bzr supports file renames/moves very effectively and I 
> 
> This means: _usually_ works, doesn't it? Emphasisis on "usually"?

Having not used git I can't really say whether git is better than bzr or
not in this regard. I know in the kind of development I do the case
where a file with the same name has been added independantly in 2
different branches is a pretty rare one. Usually, when it has happened
the files should have been 2 separate files with different names anyway
- so bzr would have no problem with this.

However, renaming a file is pretty common and I would rather be explicit
about it and have file name changes easily visible/searchable in my log.

Just out of curiosity: How does git handle the case where one file is
renamed differently in 2 branches and then the branches are repeatably
merged? I know that bzr handles this very well and in various tests I
did there were absolutely no repeated conflicts. Would git behave as
well in this scenario?

