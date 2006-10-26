X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: What's in git.git
Date: Thu, 26 Oct 2006 14:08:24 +0200
Message-ID: <20061026120824.GO20017@pasky.or.cz>
References: <7vk62npipb.fsf@assigned-by-dhcp.cox.net> <ehpu4t$ch2$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 26 Oct 2006 12:08:40 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <ehpu4t$ch2$1@sea.gmane.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30198>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd42A-0002OW-9C for gcvg-git@gmane.org; Thu, 26 Oct
 2006 14:08:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423336AbWJZMI1 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 08:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423329AbWJZMI0
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 08:08:26 -0400
Received: from w241.dkm.cz ([62.24.88.241]:3529 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S1423336AbWJZMI0 (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 08:08:26 -0400
Received: (qmail 8046 invoked by uid 2001); 26 Oct 2006 14:08:24 +0200
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Dear diary, on Thu, Oct 26, 2006 at 11:12:36AM CEST, I got a letter
where Jakub Narebski <jnareb@gmail.com> said that...
> This unfortunately means that I cannot test gitweb based on 'master'
> branch using _released_ git core, git version 1.4.3.3, as it doesn't have
> git-for-each-ref nor git-show-ref.
> 
> BTW. do people often use latest gitweb with older git binaries? Should
> we try to wait for core feature to mature to released version before using
> it in gitweb? Or perhaps we should add some kind of version checking, and
> provide workrounds, e.g. using $ENV{GIT_DIR} if git core doesn't support
> --git-dir option, pathlimit filtering using git-rev-list piped to 
> git-diff-tree --stdin in git_history if there is no --full-history
> option, show always HEAD activity if there is no git-for-each-ref
> etc.; well the latest we can do without checking for git core version, just
> 
>         if -x qx($GIT --exec-path)/git-for-each-ref

I can't imagine a situation where you would _want_ to use latest gitweb
but refuse to use older git binaries - can you explain why do you want
to do that?

If you don't want to install the latest master systemwide, that's
reasonable, but you can just keep the latest master for the gitweb
script and/or your personal use.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
