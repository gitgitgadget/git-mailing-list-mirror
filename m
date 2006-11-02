X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: Minor documentation problems
Date: Thu, 2 Nov 2006 12:41:49 +0100
Message-ID: <20061102114149.GL20017@pasky.or.cz>
References: <vpqmz7a1694.fsf@ecrins.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 2 Nov 2006 11:42:01 +0000 (UTC)
Cc: jnareb@gmail.com
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <vpqmz7a1694.fsf@ecrins.imag.fr>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30738>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfaxG-0001VE-D2 for gcvg-git@gmane.org; Thu, 02 Nov
 2006 12:41:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1750716AbWKBLlv (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006
 06:41:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbWKBLlv
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 06:41:51 -0500
Received: from w241.dkm.cz ([62.24.88.241]:18883 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S1750716AbWKBLlu (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006 06:41:50 -0500
Received: (qmail 13063 invoked by uid 2001); 2 Nov 2006 12:41:49 +0100
To: git <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org

  Hi,

Dear diary, on Thu, Nov 02, 2006 at 11:40:23AM CET, I got a letter
where Matthieu Moy <Matthieu.Moy@imag.fr> said that...
> I found minor problems with the doc, which deserve to be fixed:
> 
> * http://www.kernel.org/pub/software/scm/cogito/docs/cg-commit.1.html
>   Mentions .git/config, but not ~/.gitconfig (which is indeed _the_
>   place where I think most people want to set their name and email).

  thanks for pointing this out, further releases will mention both.

>   Side note: it can be interesting to have a command to do this.
>   For example, bzr has "bzr whoami 'me <myself@myisp.com>'", which
>   avoids having to learn the config file syntax.

  Yes, you are certainly not the first to wish this, I'm seriously
thinking about introducing cg-admin-config for setting the most common
configuration variables.

  Moreover, I'm more and more thinking about removing the fallback on
guessing based on /etc/passwd and hostname. _Many_ people were and will
be burnt by it, and I think it's more sane to require the user to
confirm once what the valid credentials are (at _that_ point it's ok to
guess, but the user has to confirm it) than let them unconsciously do
200 commits with completely bogus author lines.

  What do the Git people think? Perhaps we could introduce GIT_NO_GUESS
environment variable which will prevent var.c from guessing?

> * RSS link on the wiki:
>   The URL
>   http://git.or.cz/gitwiki/RecentChanges?action=rss_rc&ddiffs=1&unique=1
>   seems to be working as an RSS feed for changes, but it's not linked
>   to by http://git.or.cz/gitwiki/RecentChanges. Usually, there's an
>   RSS icon, and an HTML <link rel="alternate" ...> to help finding it.

  Fixed, thanks.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
