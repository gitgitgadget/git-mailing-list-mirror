X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: git-fetch not working?
Date: Tue, 24 Oct 2006 22:54:28 +0200
Message-ID: <20061024205428.GI20017@pasky.or.cz>
References: <200610242100.52671.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 24 Oct 2006 20:54:51 +0000 (UTC)
Cc: git@vger.kernel.org, ftpadmin@kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200610242100.52671.andyparkins@gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30013>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GcTIA-0006hI-1p for gcvg-git@gmane.org; Tue, 24 Oct
 2006 22:54:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965192AbWJXUya (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 24 Oct 2006
 16:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965196AbWJXUya
 (ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 16:54:30 -0400
Received: from w241.dkm.cz ([62.24.88.241]:17831 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S965192AbWJXUya (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 24 Oct 2006 16:54:30 -0400
Received: (qmail 13201 invoked by uid 2001); 24 Oct 2006 22:54:28 +0200
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

  Hi,

Dear diary, on Tue, Oct 24, 2006 at 10:00:45PM CEST, I got a letter
where Andy Parkins <andyparkins@gmail.com> said that...
> $ cat .git/remotes/origin 
> URL: git://git.kernel.org/pub/scm/git/git.git
> Pull: refs/heads/master:refs/heads/up/master
> Pull: refs/heads/next:refs/heads/up/next
> Pull: refs/heads/maint:refs/heads/up/maint
> Pull: +refs/heads/pu:refs/heads/up/pu
> 
> $ git fetch
> fatal: unexpected EOF
> Failed to find remote refs
> 
> $ ping -c1 git.kernel.org
> PING zeus-pub.kernel.org (204.152.191.5) 56(84) bytes of data.
> 64 bytes from zeus-pub1.kernel.org (204.152.191.5): icmp_seq=1 ttl=54 time=182 
> ms
> 
> Am I doing something wrong?

  nope, I'm getting it as well (hey I know about broken git.kernel.org
in an hour at most now because of the repo.or.cz cronjobs ;) -
git-daemon at the kernel.org machines seems to be broken.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
