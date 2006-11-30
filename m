X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 0/2] Making "git commit" to mean "git commit -a".
Date: Thu, 30 Nov 2006 10:33:12 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611301026060.3513@woody.osdl.org>
References: <7virgzuf38.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611282322320.9647@xanadu.home> <7vr6vmsnly.fsf@assigned-by-dhcp.cox.net>
 <87ejrlvn7r.wl%cworth@cworth.org> <7vodqpn3t4.fsf@assigned-by-dhcp.cox.net>
 <7vk61dn2yj.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0611300310520.30004@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0611291859070.3513@woody.osdl.org> <456EBBE7.8030404@op5.se>
 <Pine.LNX.4.64.0611300749560.3513@woody.osdl.org> <20061130164046.GB17715@thunk.org>
 <Pine.LNX.4.64.0611300903080.3513@woody.osdl.org> <87k61cu7qe.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 30 Nov 2006 18:35:10 +0000 (UTC)
Cc: Theodore Tso <tytso@mit.edu>, Andreas Ericsson <ae@op5.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>,
	Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <87k61cu7qe.wl%cworth@cworth.org>
X-MIMEDefang-Filter: osdl$Revision: 1.161 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32785>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gpqk0-0001fj-MO for gcvg-git@gmane.org; Thu, 30 Nov
 2006 19:34:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031113AbWK3See (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 13:34:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031146AbWK3See
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 13:34:34 -0500
Received: from smtp.osdl.org ([65.172.181.25]:57755 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1031113AbWK3Sed (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 13:34:33 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kAUIXljQ002095
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Thu, 30
 Nov 2006 10:33:47 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kAUIXCkt014529; Thu, 30 Nov
 2006 10:33:12 -0800
To: Carl Worth <cworth@cworth.org>
Sender: git-owner@vger.kernel.org



On Thu, 30 Nov 2006, Carl Worth wrote:
> >
> > Repeat the above sentence again. IT JUST MAKES SENSE.
> 
> Yes. And it makes sense for the user to be able to say "unless I tell
> you differently, I want to always commit the working-tree state of
> <files> with every commit".

If so, you should make it a special case.

I refuse to believe in the "people who know what the hell they are doing 
should work more at it" philosophy.

The "git commit -a" behaviour as it is now is better than the 
alternatives, exactly because it's more flexible. It _allows_ you to not 
commit anything at all (and as already mentioned, there are cases where 
that is exactly what you want).

If you want to have a "-a by default", then that you require _you_ to do 
more work, and no, it's NOT an excuse to say "I'm a clueless newbie, and I 
don't know how to set a config option, so I think it's the smart and 
beautiful people who should suffer for my shortcomings".

You can even do it by doing an alias like

	[alias]
		ci = commit -a

and then you can revel in your CVS-induced mudpit all you want.  Just 
don't try to convince people who have gotten over that braindamage to live 
in the same muck with you.

Problem solved. For all I care, we can make that alias a default one, so 
people who just can't get their mind out of the gutter that is CVS can 
continue with their evil ways.

