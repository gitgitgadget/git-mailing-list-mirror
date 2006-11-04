X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 2/n] gitweb: Use '&iquot;' instead of '?' in esc_path
Date: Sat, 4 Nov 2006 11:31:56 +0100
Message-ID: <20061104103156.GS20017@pasky.or.cz>
References: <200610301953.01875.jnareb@gmail.com> <200611031719.13073.jnareb@gmail.com> <7virhw5hoi.fsf@assigned-by-dhcp.cox.net> <200611032333.49794.jnareb@gmail.com> <7vwt6c40bj.fsf@assigned-by-dhcp.cox.net> <20061103225041.GQ20017@pasky.or.cz> <7vr6wk3wpo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 4 Nov 2006 10:32:05 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vr6wk3wpo.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30917>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GgIok-0008L0-He for gcvg-git@gmane.org; Sat, 04 Nov
 2006 11:32:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965274AbWKDKb7 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 4 Nov 2006
 05:31:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965248AbWKDKb7
 (ORCPT <rfc822;git-outgoing>); Sat, 4 Nov 2006 05:31:59 -0500
Received: from w241.dkm.cz ([62.24.88.241]:49810 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S965274AbWKDKb6 (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 4 Nov 2006 05:31:58 -0500
Received: (qmail 5204 invoked by uid 2001); 4 Nov 2006 11:31:56 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Dear diary, on Sat, Nov 04, 2006 at 01:02:43AM CET, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> Petr Baudis <pasky@suse.cz> writes:
> 
> > Dear diary, on Fri, Nov 03, 2006 at 11:44:48PM CET, I got a letter
> > where Junio C Hamano <junkio@cox.net> said that...
> >> Jakub Narebski <jnareb@gmail.com> writes:
> >> > Which solution do you think it's best?
> >> 
> >> Sorry, if it was not clear in my message, I wanted to say that I
> >> kinda liked those "control pictures" in U+2400 range.
> >
> > In principle, right now it should be pretty easy for a project that for
> > some reason does not use UTF-8 in commits etc. to adjust gitweb to work
> > properly, right? Just change the encoding in HTTP headers and you're
> > done, I think.
> >
> > Is it worth trying to preserve that flexibility?
> 
> Absolutely, and I got your point.  Maybe <blink>\011</blink>
> would be more portable and appropriate.

Actually Jakub is right, &#number; is always a Unicode codepoint,
regardless of document encoding.

Anything but <blink>! ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
