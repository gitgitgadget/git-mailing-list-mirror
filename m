X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Fix bad usage of mkpath in builtin-branch.sh
Date: Thu, 26 Oct 2006 00:43:13 +0200
Message-ID: <20061025224313.GM20017@pasky.or.cz>
References: <1161655176461-git-send-email-hjemli@gmail.com> <7vlkn6qkh2.fsf@assigned-by-dhcp.cox.net> <20061024113806.GB20017@pasky.or.cz> <7vac3lf3jl.fsf@assigned-by-dhcp.cox.net> <7vslhddmtu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 25 Oct 2006 22:43:39 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vslhddmtu.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30116>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GcrSx-0001q9-6Q for gcvg-git@gmane.org; Thu, 26 Oct
 2006 00:43:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965242AbWJYWnQ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006
 18:43:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965243AbWJYWnQ
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 18:43:16 -0400
Received: from w241.dkm.cz ([62.24.88.241]:50846 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S965242AbWJYWnP (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 18:43:15 -0400
Received: (qmail 24162 invoked by uid 2001); 26 Oct 2006 00:43:13 +0200
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Dear diary, on Wed, Oct 25, 2006 at 06:46:37AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> Junio C Hamano <junkio@cox.net> writes:
> 
> > Petr Baudis <pasky@suse.cz> writes:
> >
> >> I have made my fair share of inadverent mode changes as well (I don't
> >> even know how that *happenned*), and I don't seem to be alone; since
> >> this is something you are doing only rarely anyway, perhaps we should
> >> try to make mode changes more visible?
> >
> > Well we already do and that's how I noticed.
> 
> Ah, sorry, I think I misunderstood you.
> Did you mean something like this?
> 
> diff --git a/git-commit.sh b/git-commit.sh
> index 5b1cf85..8bae734 100755
> --- a/git-commit.sh
> +++ b/git-commit.sh
> @@ -629,4 +629,7 @@ if test -x "$GIT_DIR"/hooks/post-commit
>  then
>  	"$GIT_DIR"/hooks/post-commit
>  fi
> +
> +test "$ret" = 0 && git-diff-tree --summary --root --no-commit-id HEAD
> +
>  exit "$ret"

Yes, this might be a good idea, although after the commit is perhaps too
late.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
