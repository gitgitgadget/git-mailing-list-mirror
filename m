X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicholas Allen <nick.allen@onlinehome.de>
Subject: Re: git and bzr
Date: Tue, 28 Nov 2006 23:46:21 +0100
Message-ID: <456CBC3D.8020409@onlinehome.de>
References: <45357CC3.4040507@utoronto.ca> <a7e835d40610250308v5d577482m139742e7fe1db185@mail.gmail.com> <87slhcz8zh.wl%cworth@cworth.org> <a7e835d40610260152k658aeaf0hb900cb63870c04e4@mail.gmail.com> <7vu01ro20b.fsf@assigned-by-dhcp.cox.net> <a7e835d40610260257r5f05ea4gc934f1c1cc267977@mail.gmail.com> <20061026101038.GA13310@coredump.intra.peff.net> <877iyne4dm.fsf@alplog.fr> <Pine.LNX.4.64.0610260753090.3962@g5.osdl.org> <456B7C6A.80104@webdrake.net> <845b6e870611280410j58bdcd99nc05d0f67489293e4@mail.gmail.com> <ekhaeg$etk$1@sea.gmane.org> <Pine.LNX.4.63.0611281433270.30004@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0611280754050.30076@woody.osdl.org> <456C7592.6020700@ableton.com> <ekhtnt$rkk$1@sea.gmane.org> <456C9DFF.1040407@onlinehome.de> <456CA981.4010808@onlinehome.de> <Pine.LNX.4.64.0611281346490.4244@woody.osdl.org> <456CB197.2030201@onlinehome.de> <Pine.LNX.4.64.06112
 81413310.4244@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 28 Nov 2006 22:46:45 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (X11/20061115)
In-Reply-To: <Pine.LNX.4.64.0611281413310.4244@woody.osdl.org>
X-Enigmail-Version: 0.94.0.0
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:8f68dfdb39f9894a8a7411e7c5df1048
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32602>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpBie-0004dN-HY for gcvg-git@gmane.org; Tue, 28 Nov
 2006 23:46:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755198AbWK1WqZ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 17:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755296AbWK1WqZ
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 17:46:25 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:23032 "EHLO
 moutng.kundenserver.de") by vger.kernel.org with ESMTP id S1755198AbWK1WqY
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 17:46:24 -0500
Received: from [84.190.155.117] (helo=[192.168.1.100]) by
 mrelayeu.kundenserver.de (node=mrelayeu3) with ESMTP (Nemesis), id
 0MKxQS-1GpBiY1Sq5-0004dj; Tue, 28 Nov 2006 23:46:23 +0100
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org


> 
> The other useful tools to be used are "git log --merge" (explained in a 
> separate mail) and for people like me who like the git index and grok it 
> fully, doing a
> 
> 	git ls-files --unmerged --stage
> 
> is probably what I'd do (but I have to admit, that is _not_ a very 
> user-friendly interface - you need to not only have understood the index 
> file, you actually need to understand it on a very deep level).
> 
> "git status" is really used to be just a stupid around "git ls-files" 
> (it's now largely a built-in), but it was really _so_ stupid that it 
> doesn't really try to explain what it does - it's more like a simplified 
> version of ls-files with some of the information pruned away, and other 
> parts in a slightly more palatable format ;)
> 
> So improving "git status" might mean that some people could avoid having 
> to learn about the index file details ;)

That sounds good. Better output on status would be nice ;-)

