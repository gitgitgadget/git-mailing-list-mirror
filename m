X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Do not ignore hidden refs
Date: Sat, 18 Nov 2006 20:55:20 +0100
Message-ID: <20061118195520.GQ7201@pasky.or.cz>
References: <20061118041137.6064.75827.stgit@machine.or.cz> <7v8xi9fjw9.fsf@assigned-by-dhcp.cox.net> <20061118045323.GK7201@pasky.or.cz> <7vzmapdxki.fsf@assigned-by-dhcp.cox.net> <20061118192830.GP7201@pasky.or.cz> <7vejs0cz5s.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 18 Nov 2006 19:55:46 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vejs0cz5s.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31798>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlWHh-0005IP-GF for gcvg-git@gmane.org; Sat, 18 Nov
 2006 20:55:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1756407AbWKRTzY (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 18 Nov 2006
 14:55:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756410AbWKRTzY
 (ORCPT <rfc822;git-outgoing>); Sat, 18 Nov 2006 14:55:24 -0500
Received: from w241.dkm.cz ([62.24.88.241]:32918 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S1756409AbWKRTzW (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 18 Nov 2006 14:55:22 -0500
Received: (qmail 28416 invoked by uid 2001); 18 Nov 2006 20:55:20 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Sat, Nov 18, 2006 at 08:50:23PM CET, Junio C Hamano wrote:
> Petr Baudis <pasky@suse.cz> writes:
> 
> > On Sat, Nov 18, 2006 at 08:27:09AM CET, Junio C Hamano wrote:
> >> ...  I do not think it is a great
> >> enough convention to be promoted as the official BCP, but it has
> >> been good enough for me, ...
> >
> > That's way too arbitrary for my taste, I think I needn't explain why.
> 
> Because _I_ explained why already ;-).

Oops. ;-) Me too sloppy today, sorry.

> > What about leading underscore?
> 
> I would rather prefer to do refs/{heads,private}/ and allow
> checkout to treat either of them as branches.  We are talking
> about allowing checkout to go to a non-branch by storing a raw
> commit object name in HEAD instead of leaving it as a symref, so
> we know we are going to touch that area already.

Cogito _heavily_ assumes on a lot of places that heads live in
refs/heads/ and tags live in refs/tags/. Besides, I think private tags
are much more useful to support than private heads (not that you would
necessarily make more private tags than private heads, but you are more
likely to want tags autopushed than heads; or perhaps that just in my
head?). So what about refs/{heads,tags}/private/? :-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
The meaning of Stonehenge in Traflamadorian, when viewed from above, is:
"Replacement part being rushed with all possible speed."
