X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: Cleaning up git user-interface warts
Date: Thu, 16 Nov 2006 15:01:41 +0100
Message-ID: <20061116140141.GZ7201@pasky.or.cz>
References: <ejdcg5$4fl$1@sea.gmane.org> <Pine.LNX.4.64.0611141633430.2591@xanadu.home> <7vbqn9y6w6.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611142007010.2591@xanadu.home> <7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611142306090.2591@xanadu.home> <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org> <20061116011411.GB10512@thunk.org> <7vd57of2cv.fsf@assigned-by-dhcp.cox.net> <8764dflj5o.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 16 Nov 2006 14:02:05 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, Theodore Tso <tytso@mit.edu>,
	git@vger.kernel.org, Nicolas Pitre <nico@cam.org>,
	Linus Torvalds <torvalds@osdl.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <8764dflj5o.fsf@wine.dyndns.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31585>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkhoI-0005ue-TO for gcvg-git@gmane.org; Thu, 16 Nov
 2006 15:01:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424056AbWKPOBn (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006
 09:01:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424067AbWKPOBn
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 09:01:43 -0500
Received: from w241.dkm.cz ([62.24.88.241]:39066 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S1424056AbWKPOBn (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 09:01:43 -0500
Received: (qmail 26036 invoked by uid 2001); 16 Nov 2006 15:01:41 +0100
To: Alexandre Julliard <julliard@winehq.org>
Sender: git-owner@vger.kernel.org

On Thu, Nov 16, 2006 at 12:34:27PM CET, Alexandre Julliard wrote:
> Junio C Hamano <junkio@cox.net> writes:
> 
> > I would rather say "use 'git branch' to make sure if you are
> > ready to merge".  Who teaches not to use "git pull"?
> 
> We do that for Wine. The problem is that we recommend using git-rebase
> to make it easier for occasional developers to keep a clean history,
> and rebase and pull interfere badly.

How do those developers submit their changes? Do they push? If they do,
git-rebase can be saving one merge at most, and the merge is actually a
good thing (someone should write some nice standalone writeup about
that).

If they don't have push access and maintain their patches locally until
they get accepted, perhaps it would be far simpler for them to use
StGIT?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
