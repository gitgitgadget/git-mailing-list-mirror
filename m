X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Do not ignore hidden refs
Date: Sat, 18 Nov 2006 20:28:30 +0100
Message-ID: <20061118192830.GP7201@pasky.or.cz>
References: <20061118041137.6064.75827.stgit@machine.or.cz> <7v8xi9fjw9.fsf@assigned-by-dhcp.cox.net> <20061118045323.GK7201@pasky.or.cz> <7vzmapdxki.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 18 Nov 2006 19:28:49 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vzmapdxki.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31794>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlVrk-0007tV-1O for gcvg-git@gmane.org; Sat, 18 Nov
 2006 20:28:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1756389AbWKRT2d (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 18 Nov 2006
 14:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756395AbWKRT2d
 (ORCPT <rfc822;git-outgoing>); Sat, 18 Nov 2006 14:28:33 -0500
Received: from w241.dkm.cz ([62.24.88.241]:28615 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S1756389AbWKRT2c (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 18 Nov 2006 14:28:32 -0500
Received: (qmail 23030 invoked by uid 2001); 18 Nov 2006 20:28:30 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Sat, Nov 18, 2006 at 08:27:09AM CET, Junio C Hamano wrote:
> I think, however, if we (collectively as all the Porcelain
> writers although I am not really one of them) are to support it,
> they should not make distinction to the core, and it should be
> handled with the agreed-upon convention.

I guess I agree.

> Personally I established a convention to treat heads/??/* as
> "private namespace" while using heads/* as public refs for my
> own work (I do that for git.git as people know, and I do that
> for my day job project as well).  I do not think it is a great
> enough convention to be promoted as the official BCP, but it has
> been good enough for me, especially commands like "show-branch"
> and "tag -l" understands the shell-style filegrobs (e.g
> "show-branch master heads/??/*" would show what's yet to be
> polished and merged).

That's way too arbitrary for my taste, I think I needn't explain why.
:-)


What about leading underscore?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
The meaning of Stonehenge in Traflamadorian, when viewed from above, is:
"Replacement part being rushed with all possible speed."
