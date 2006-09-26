From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] gitweb: tree view: eliminate redundant "blob"
Date: Tue, 26 Sep 2006 13:33:24 -0700 (PDT)
Message-ID: <20060926203324.99745.qmail@web31813.mail.mud.yahoo.com>
References: <20060926160729.GH20017@pasky.or.cz>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 26 22:34:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSJcd-000210-Iv
	for gcvg-git@gmane.org; Tue, 26 Sep 2006 22:33:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964792AbWIZUd0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 16:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964790AbWIZUd0
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 16:33:26 -0400
Received: from web31813.mail.mud.yahoo.com ([68.142.207.76]:5557 "HELO
	web31813.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964792AbWIZUdZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Sep 2006 16:33:25 -0400
Received: (qmail 99747 invoked by uid 60001); 26 Sep 2006 20:33:24 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=ibY0nbvsPj3axl9s1cRRVwXhXessxcW1ovKe4RjSPozRLACuESVUBxJ8pMGPJQIgrhsnDeZYyHXWNY3x3wdRk/3eWjpV06aIb0Fta3qOsCaXboFTS0wn6Hc1Etvk/Dz8Gb2y5eeteQQtWLaBsSCCOzmXdg6HU7QwC4QpGZNpFPo=  ;
Received: from [64.215.88.90] by web31813.mail.mud.yahoo.com via HTTP; Tue, 26 Sep 2006 13:33:24 PDT
To: Petr Baudis <pasky@suse.cz>, Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <20060926160729.GH20017@pasky.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27819>

--- Petr Baudis <pasky@suse.cz> wrote:
> And directories should have trailing slash in their name in the tree
> listing, for people with non-UNIX background who don't understand the
> ls -l like output.

In the non-UNIX environment, there is "folders", not "directories".
Also, in the non-UNIX environment, the path separator is '\'.

The point is that it is not unreasonable to draw the line somewhere.

A 'd' at the front of directories is easy enough to understand,
plus the fact that directory entries are underlined and blue, wlg.

   Luben

> 
> > And for example for commits and heads there are two possible
> > views, commit and commitdiff for commit, shortlog and log for head,
> > of which we arbitrary chose one for the subject link. So in that
> > case the additional self link is needed. I'd rather have both.
> 
> For commits and heads, I agree. But that's not what this patch does.
> 
> > And for consistency I'd rather always have visible form default
> > self link/
> 
> A parse error kicked me off here, sorry.
> 
> 
> (I'm personally kind of ambivalent to the change.)
> 
> -- 
> 				Petr "Pasky" Baudis
> Stuff: http://pasky.or.cz/
> #!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
> $/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
> lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
