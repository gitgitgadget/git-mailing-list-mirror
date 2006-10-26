X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: What's in git.git
Date: Thu, 26 Oct 2006 14:22:48 +0200
Message-ID: <20061026122248.GP20017@pasky.or.cz>
References: <7vk62npipb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 26 Oct 2006 12:23:37 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vk62npipb.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30203>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd4GU-00059j-09 for gcvg-git@gmane.org; Thu, 26 Oct
 2006 14:23:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423364AbWJZMWv (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 08:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423365AbWJZMWv
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 08:22:51 -0400
Received: from w241.dkm.cz ([62.24.88.241]:31679 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S1423354AbWJZMWu (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 08:22:50 -0400
Received: (qmail 9740 invoked by uid 2001); 26 Oct 2006 14:22:48 +0200
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Dear diary, on Thu, Oct 26, 2006 at 10:47:12AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
>       gitweb: use for-each-ref to show the latest activity across branches

It's a pity that for-each-ref is used only for that, I'd appreciate a
lot if git_get_refs_list() could use it too, for the sake of
repo.or.cz:glibc-cvs.git summary view, which is massive. :-)

>   I looked at Pasky's "project forks" gitweb code, and while I
>   liked it a lot (having a demonstration site repo.or.cz really
>   helps), I read on #git log that Pasky himself was having
>   doubt, so it is parked in "pu", not in "next".

I had doubts in the middle of implementing it, but now I don't - for
summary of why, please see

	http://news.gmane.org/find-root.php?message_id=<20061024173943.GF20017@pasky.or.cz>

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
