From: Mike Taht <mike.taht@timesys.com>
Subject: Re: "git-send-pack"
Date: Fri, 01 Jul 2005 16:44:19 -0700
Message-ID: <42C5D553.80905@timesys.com>
References: <Pine.LNX.4.21.0506301651250.30848-100000@iabervon.org> <Pine.LNX.4.58.0506301412470.14331@ppc970.osdl.org> <42C46A3C.1070104@zytor.com> <Pine.LNX.4.58.0506301514240.14331@ppc970.osdl.org> <42C482ED.1010306@zytor.com> <Pine.LNX.4.58.0506301656570.14331@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 02 01:41:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DoV7i-0007oC-Rr
	for gcvg-git@gmane.org; Sat, 02 Jul 2005 01:40:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263317AbVGAXrp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jul 2005 19:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261638AbVGAXpO
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jul 2005 19:45:14 -0400
Received: from mail.timesys.com ([65.117.135.102]:5537 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S261643AbVGAXoW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2005 19:44:22 -0400
Received: from [10.129.129.220] ([67.180.132.225]) by exchange.timesys.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Fri, 1 Jul 2005 19:36:07 -0400
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506301656570.14331@ppc970.osdl.org>
X-OriginalArrivalTime: 01 Jul 2005 23:36:08.0171 (UTC) FILETIME=[A7E13BB0:01C57E95]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:

> Also, note that the server is usually _more_ ahead than the client is, and 
> the server is the one that potentially has lots of commits that the 
> client doesn't have. Not the other way around. So if the client makes a 
> list of it's top commits, it almost certainly won't have to make a very 
> long list until the server can tell it "ok, stop, I've seen it".
> 
> Yeah, maybe we want to limit the "burst" to 70 sha1's, since that will fit 
> in a regular-sized ethernet packet, but whatever - you'd burst out your 
> commits "latest first", so you'd never even get to the current 4040 unless 
> you've literally done the kind of work we've done in the git tree for the 
> last 3 months _and_you've_not_pulled_from_that_server_in_the_whole_time_.

You are getting closer and closer to where something like bitTorrent or 
a multicast protocol makes sense. The problem isn't just the number of 
outstanding commit objects but the number of machines and developers 
that want to grab those commits at the same time.


Mike Taht
PostCards From The Bleeding Edge
http://the-edge.blogspot.com "Tempel 1 worth 2.2 million trillion bux"
