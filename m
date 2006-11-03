X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 2/n] gitweb: Use '&iquot;' instead of '?' in esc_path
Date: Fri, 3 Nov 2006 23:50:41 +0100
Message-ID: <20061103225041.GQ20017@pasky.or.cz>
References: <200610301953.01875.jnareb@gmail.com> <200611031719.13073.jnareb@gmail.com> <7virhw5hoi.fsf@assigned-by-dhcp.cox.net> <200611032333.49794.jnareb@gmail.com> <7vwt6c40bj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 3 Nov 2006 22:52:24 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vwt6c40bj.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30893>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gg7s6-0002RG-Jo for gcvg-git@gmane.org; Fri, 03 Nov
 2006 23:50:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753545AbWKCWun (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006
 17:50:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932122AbWKCWun
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 17:50:43 -0500
Received: from w241.dkm.cz ([62.24.88.241]:28631 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S1753545AbWKCWun (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 17:50:43 -0500
Received: (qmail 4346 invoked by uid 2001); 3 Nov 2006 23:50:41 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Dear diary, on Fri, Nov 03, 2006 at 11:44:48PM CET, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> Jakub Narebski <jnareb@gmail.com> writes:
> > Which solution do you think it's best?
> 
> Sorry, if it was not clear in my message, I wanted to say that I
> kinda liked those "control pictures" in U+2400 range.

In principle, right now it should be pretty easy for a project that for
some reason does not use UTF-8 in commits etc. to adjust gitweb to work
properly, right? Just change the encoding in HTTP headers and you're
done, I think.

Is it worth trying to preserve that flexibility?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
