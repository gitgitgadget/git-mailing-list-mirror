X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: Cleaning up git user-interface warts
Date: Wed, 15 Nov 2006 15:21:18 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0611151516360.2591@xanadu.home>
References: <87k61yt1x2.wl%cworth@cworth.org>
 <Pine.LNX.4.64.0611142306090.2591@xanadu.home>
 <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org>
 <200611151858.51833.andyparkins@gmail.com>
 <Pine.LNX.4.64.0611151111250.3349@woody.osdl.org>
 <f2b55d220611151139v66fba16ax97ce6b9966b33ce7@mail.gmail.com>
 <Pine.LNX.4.64.0611151203450.3349@woody.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Wed, 15 Nov 2006 20:21:29 +0000 (UTC)
Cc: "Michael K. Edwards" <medwards.linux@gmail.com>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <Pine.LNX.4.64.0611151203450.3349@woody.osdl.org>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31484>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkRG8-0006em-K1 for gcvg-git@gmane.org; Wed, 15 Nov
 2006 21:21:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030960AbWKOUVU (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 15:21:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030961AbWKOUVT
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 15:21:19 -0500
Received: from relais.videotron.ca ([24.201.245.36]:5361 "EHLO
 relais.videotron.ca") by vger.kernel.org with ESMTP id S1030960AbWKOUVT
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 15:21:19 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0J8S00390GJI1910@VL-MH-MR001.ip.videotron.ca> for git@vger.kernel.org; Wed,
 15 Nov 2006 15:21:18 -0500 (EST)
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

On Wed, 15 Nov 2006, Linus Torvalds wrote:

> I'm saying that even if you _never_ end up using "git fetch" ever again 
> (because in practice you always want to do a "fetch + merge == pull"), 
> people who teach others the concepts and usage of git should probably 
> start by talking about "git fetch".
> 
> Then, when the user says (and he obviously will say this) "but I don't 
> want to just fetch the other persons work into some local branch, I want 
> to actually get it into _my_ branch", you say "Ahhah!" and talk about how 
> "pull" is a shorthand for first fetching and then merging the result into 
> the current branch.

Actually I believe it would make things even clearer if "merge" was 
taught at that point.  Only when the user is comfortable with the 
separate notions of fetching and merging might the pull shorthand 
possibly be mentioned.


