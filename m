X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Cleaning up git user-interface warts
Date: Wed, 15 Nov 2006 12:50:10 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611151243030.3349@woody.osdl.org>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org>
 <87hcx1u934.wl%cworth@cworth.org> <Pine.LNX.4.64.0611141518590.2591@xanadu.home>
 <87bqn9u43s.wl%cworth@cworth.org> <ejdcg5$4fl$1@sea.gmane.org>
 <Pine.LNX.4.64.0611141633430.2591@xanadu.home> <7vbqn9y6w6.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611142007010.2591@xanadu.home> <7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net>
 <20061115201227.GM7201@pasky.or.cz> <Pine.LNX.4.64.0611151524000.2591@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 15 Nov 2006 20:51:30 +0000 (UTC)
Cc: Petr Baudis <pasky@suse.cz>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0611151524000.2591@xanadu.home>
X-MIMEDefang-Filter: osdl$Revision: 1.156 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31493>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkRin-0004tD-Qi for gcvg-git@gmane.org; Wed, 15 Nov
 2006 21:51:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161439AbWKOUuc (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 15:50:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030985AbWKOUuc
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 15:50:32 -0500
Received: from smtp.osdl.org ([65.172.181.4]:24549 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1030987AbWKOUua (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 15:50:30 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kAFKoBoZ027958
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Wed, 15
 Nov 2006 12:50:12 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kAFKoAQD029225; Wed, 15 Nov
 2006 12:50:10 -0800
To: Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org



On Wed, 15 Nov 2006, Nicolas Pitre wrote:
> 
> I think "fetch" is sane.  Its only problem is a missing symetrical 
> counterpart verb, like "get" and "put".

If you're a dog owner, the obvious counterpart for "fetch" is "throw" ;)

I think "get" and "put" would be bad, just because of confusion with 
"sccs get" (ie it has that "get this file" connotations).

Maybe "fetch" and "push" aren't totally diametrically opposite, but 
really, I don't think they are that hard to understand either. We do have 
the BK legacy of "pull" implying a merge, and that's fairly fundamental. 

It's also true that in a lot of usage schenarios, what people actually 
_use_ is "pull" and "push", and no, they aren't mirror images (since push 
will _not_ do the merge), but at the same time, from a _usage_ standpoint 
they really _are_ each others opposites. 

You "pull" to get other peoples data into your branch (and once you've 
internalized local branches and the merge thing, you know what this 
means), and you "push" to push your changes out. It really _is_ the usage 
schenario, and using "opposite" words really _does_ make sense.

It's true that _technically_ "fetch" is the opposite of "push", but at the 
same time, that really is about technology, not about usage models. You 
normally wouldn't do a "git fetch + git push" pair. You _can_ do so, but 
it's not the natural way to work - unless you're just doing a mirror 
service.

