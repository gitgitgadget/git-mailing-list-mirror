X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Do not ignore hidden refs
Date: Sun, 19 Nov 2006 00:18:42 +0100
Message-ID: <20061118231842.GS7201@pasky.or.cz>
References: <20061118041137.6064.75827.stgit@machine.or.cz> <7v8xi9fjw9.fsf@assigned-by-dhcp.cox.net> <20061118045323.GK7201@pasky.or.cz> <7vzmapdxki.fsf@assigned-by-dhcp.cox.net> <20061118192830.GP7201@pasky.or.cz> <7vejs0cz5s.fsf@assigned-by-dhcp.cox.net> <7vy7q8bjwn.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 18 Nov 2006 23:18:53 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vy7q8bjwn.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31813>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlZSS-00012l-C3 for gcvg-git@gmane.org; Sun, 19 Nov
 2006 00:18:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755361AbWKRXSp (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 18 Nov 2006
 18:18:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755369AbWKRXSp
 (ORCPT <rfc822;git-outgoing>); Sat, 18 Nov 2006 18:18:45 -0500
Received: from w241.dkm.cz ([62.24.88.241]:667 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S1755361AbWKRXSo (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 18 Nov 2006 18:18:44 -0500
Received: (qmail 15225 invoked by uid 2001); 19 Nov 2006 00:18:42 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Sat, Nov 18, 2006 at 09:05:12PM CET, Junio C Hamano wrote:
> 	use heads/private/ for your own stuff.  And have
> 	configuration that says "heads/private/" are private
> 	branches that are not subject to default
> 	pushing/pulling.
> 
> The real instruction from the project would say what the syntax
> for telling that to git but I think you got the idea...

Yes, I fully agree that being able to have this configurable is cool,
but I'm still interested in providing a sensible out-of-the-box default
configuration for Cogito to use. But if we can agree that heads/private/
and tags/private/ are good BCP candidates, that's great. (The only
possible problem is a lot of typing incurred. Perhaps the default refs
search order should become configurable first.)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
The meaning of Stonehenge in Traflamadorian, when viewed from above, is:
"Replacement part being rushed with all possible speed."
