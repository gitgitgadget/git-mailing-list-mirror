From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Making git disappear when talking about my code
Date: Wed, 25 Apr 2007 13:29:54 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0704251325260.9964@woody.linux-foundation.org>
References: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com>
 <20070417104520.GB4946@moonlight.home> <8b65902a0704170841q64fe0828mdefe78963394a616@mail.gmail.com>
 <200704171818.28256.andyparkins@gmail.com> <20070417173007.GV2229@spearce.org>
 <462521C7.2050103@softax.com.pl> <Pine.LNX.4.64.0704181130150.12094@racer.site>
 <alpine.LFD.0.98.0704180851060.2828@woody.linux-foundation.org>
 <Pine.LNX.4.64.0704191118050.8822@racer.site>
 <alpine.LFD.0.98.0704190940330.9964@woody.linux-foundation.org>
 <4627ABBB.8060709@softax.com.pl> <alpine.LFD.0.98.0704191341370.9964@woody.linux-foundation.org>
 <877is29b1l.wl%cworth@cworth.org> <7vps5ud91x.fsf@assigned-by-dhcp.cox.net>
 <87vefm7l6g.wl%cworth@cworth.org> <alpine.LFD.0.98.0704231609440.9964@woody.linux-foundation.org>
 <7v1wiabbfr.fsf@assigned-by-dhcp.cox.net> <87mz0w7g3j.wl%cworth@cworth.org>
 <Pine.LNX.4.64.0704251345220.28708@iabervon.org>
 <7vzm4ww7lj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Carl Worth <cworth@cworth.org>,
	Marcin Kasperski <Marcin.Kasperski@softax.com.pl>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Apr 25 22:30:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hgo8Z-00044k-AH
	for gcvg-git@gmane.org; Wed, 25 Apr 2007 22:30:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993100AbXDYUaL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 16:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993050AbXDYUaL
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 16:30:11 -0400
Received: from smtp1.linux-foundation.org ([65.172.181.25]:36852 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S2993101AbXDYUaI (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Apr 2007 16:30:08 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l3PKTtYP011505
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 25 Apr 2007 13:29:56 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3PKTthL012015;
	Wed, 25 Apr 2007 13:29:55 -0700
In-Reply-To: <7vzm4ww7lj.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-3.036 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.53 on 65.172.181.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45565>



On Wed, 25 Apr 2007, Junio C Hamano wrote:
> 
> I think I already suggested this to Carl once, but if you 
> forget about 'git clone' in this case (or any other cases), your
> example would just work.
> 
>    $ git init
>    $ git pull git://server/path branch

The problem with this is that it doesn't set up tracking, so while it 
*works*, you are now forever doomed to re-do that

	git pull git://server/path branch

to update, and if you then ever give the wrong branch name you'll try to 
merge and get really confused as a beginner.

		Linus
