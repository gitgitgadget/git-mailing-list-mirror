X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] make 'git add' a first class user friendly interface to
 the index
Date: Sat, 02 Dec 2006 23:34:18 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612022323330.2630@xanadu.home>
References: <Pine.LNX.4.64.0612011444310.9647@xanadu.home>
 <7vpsb36yem.fsf@assigned-by-dhcp.cox.net> <87veku3i0j.wl%cworth@cworth.org>
 <200612020828.57989.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Sun, 3 Dec 2006 04:34:26 +0000 (UTC)
Cc: git@vger.kernel.org, Carl Worth <cworth@cworth.org>,
	Junio C Hamano <junkio@cox.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <200612020828.57989.alan@chandlerfamily.org.uk>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33094>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gqj3X-0004TW-SK for gcvg-git@gmane.org; Sun, 03 Dec
 2006 05:34:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424934AbWLCEeU (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 23:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424935AbWLCEeU
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 23:34:20 -0500
Received: from relais.videotron.ca ([24.201.245.36]:35442 "EHLO
 relais.videotron.ca") by vger.kernel.org with ESMTP id S1424934AbWLCEeT
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 23:34:19 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0J9O00IKSKP62VC0@VL-MO-MR002.ip.videotron.ca> for git@vger.kernel.org; Sat,
 02 Dec 2006 23:34:18 -0500 (EST)
To: Alan Chandler <alan@chandlerfamily.org.uk>
Sender: git-owner@vger.kernel.org

On Sat, 2 Dec 2006, Alan Chandler wrote:

> So I am with you that we need to effective teach
> 
> git add <filename>   #add content of filename to the SCM
> #edit <filename>
> git commit -a		#commit current state of all tracked content
> 
> first, and then move on to teach selective commiting

I think that's pretty much what my patch to the tutorial does.

The tutorial talks about:

	1) git init-db

	2) git add .

	3) git commit

	4) modifying some files then git diff

	5) git commit file1 file2, or git commit -a

Then goes the discussion about what git add does and why.  It is quite 
early in the tutorial and making it earlier would be a bit premature.  
Let's have the user make his first simple commit while blindly 
following the instructions before going with the 
actual usage model.  At that point,since we just mentioned "git commit 
file1 file2" or "git commit -a" will the user be in the proper mindset 
to wonder why not using plain "git commit"... and incidentally the whole 
explanation is there to follow immediately.

I'm reworking my patch with suggestions that have been posted so let's 
hope it'll be even clearer.


