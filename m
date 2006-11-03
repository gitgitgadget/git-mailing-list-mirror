X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Allow hand-editing of patches before sending
Date: Fri, 3 Nov 2006 14:39:33 +0100
Message-ID: <20061103133933.GP20017@pasky.or.cz>
References: <20061101090046.1107.81105.stgit@localhost> <b0943d9e0611020232x1e343bbco9451c8183c84d68@mail.gmail.com> <20061102113631.GA30507@diana.vm.bytemark.co.uk> <b0943d9e0611030139i7be9569bh4a29596a768e82a3@mail.gmail.com> <20061103095859.GC16721@diana.vm.bytemark.co.uk> <b0943d9e0611030444w13e04586u185413c2562d45bc@mail.gmail.com> <20061103130259.GA20611@diana.vm.bytemark.co.uk> <b0943d9e0611030525t5da2cce7nf7b41323411e8d2d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 3 Nov 2006 13:40:11 +0000 (UTC)
Cc: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <b0943d9e0611030525t5da2cce7nf7b41323411e8d2d@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30852>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfzGn-0005bf-5F for gcvg-git@gmane.org; Fri, 03 Nov
 2006 14:39:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752972AbWKCNjg (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006
 08:39:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752975AbWKCNjg
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 08:39:36 -0500
Received: from w241.dkm.cz ([62.24.88.241]:7064 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S1752970AbWKCNjf (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 08:39:35 -0500
Received: (qmail 18420 invoked by uid 2001); 3 Nov 2006 14:39:33 +0100
To: Catalin Marinas <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org

Dear diary, on Fri, Nov 03, 2006 at 02:25:36PM CET, I got a letter
where Catalin Marinas <catalin.marinas@gmail.com> said that...
> I just run git-am and "stg uncommit" or "assimilate".

git-am calls git-mailsplit and git-mailinfo, and those two tools will do
most of the work (basically everything except the actual committing) for
you, I use them in cg-patch -m and it should be fairly trivial to make a
stg command reusing those too.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
