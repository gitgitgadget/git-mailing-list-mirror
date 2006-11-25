X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: Show remote branches on gitweb
Date: Sat, 25 Nov 2006 01:50:29 +0100
Message-ID: <20061125005029.GN4842@pasky.or.cz>
References: <loom.20061124T210559-701@post.gmane.org> <ek7jsp$j83$1@sea.gmane.org> <ek7m6m$qqd$1@sea.gmane.org> <20061124235911.GO7201@pasky.or.cz> <7vy7q08iko.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 25 Nov 2006 00:50:46 +0000 (UTC)
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vy7q08iko.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32251>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gnlkc-0003JB-57 for gcvg-git@gmane.org; Sat, 25 Nov
 2006 01:50:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934530AbWKYAub (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 24 Nov 2006
 19:50:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935102AbWKYAub
 (ORCPT <rfc822;git-outgoing>); Fri, 24 Nov 2006 19:50:31 -0500
Received: from w241.dkm.cz ([62.24.88.241]:35250 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S934530AbWKYAub (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 24 Nov 2006 19:50:31 -0500
Received: (qmail 30295 invoked by uid 2001); 25 Nov 2006 01:50:29 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Sat, Nov 25, 2006 at 01:40:23AM CET, Junio C Hamano wrote:
> Petr Baudis <pasky@suse.cz> writes:
> 
> >> The problem is that to implement it _well_ we have to get remotes, both
> >> $GIT_DIR/remotes and config remote.xxx, info. And the latter (config
> >> remotes info) needs config parsing, something we lack.
> >
> > Does that mean we _can_ parse $GIT_DIR/remotes? ;-)
> 
> Surely you should be able to.  You are working in Perl and the
> remotes and config are trivially parsable text files.

But so is the configuration file, unless I'm missing something...?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
The meaning of Stonehenge in Traflamadorian, when viewed from above, is:
"Replacement part being rushed with all possible speed."
