From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH 1/2] gitweb: Show snapshot links for tree entries in tree listing
Date: Sat, 7 Oct 2006 11:52:53 -0700 (PDT)
Message-ID: <20061007185253.90045.qmail@web31810.mail.mud.yahoo.com>
References: <20061007184148.GE20017@pasky.or.cz>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 07 20:53:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWHI9-0005WI-Rx
	for gcvg-git@gmane.org; Sat, 07 Oct 2006 20:52:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932666AbWJGSwz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Oct 2006 14:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932671AbWJGSwz
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Oct 2006 14:52:55 -0400
Received: from web31810.mail.mud.yahoo.com ([68.142.207.73]:4799 "HELO
	web31810.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932666AbWJGSwy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Oct 2006 14:52:54 -0400
Received: (qmail 90047 invoked by uid 60001); 7 Oct 2006 18:52:53 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Fc2rByXNYNwh7KS6ZCEHhT0I96RHGPnCwCfWY6rFlT0XQ3bvzflys2ZphrcXi8ameU4GkrjuliZluk3m2LUZd9bTCkIyJ+ZlsaJr5FgwpflnN+qqBp93rFqkJL5arNhtkJoF1q9w3FzEWK2gTIzw9QxWjigeA8cE0lK7dNGgsEI=  ;
Received: from [71.80.233.118] by web31810.mail.mud.yahoo.com via HTTP; Sat, 07 Oct 2006 11:52:53 PDT
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20061007184148.GE20017@pasky.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28496>

--- Petr Baudis <pasky@suse.cz> wrote:
> Dear diary, on Sat, Oct 07, 2006 at 08:37:02PM CEST, I got a letter
> where Luben Tuikov <ltuikov@yahoo.com> said that...
> > --- Petr Baudis <pasky@suse.cz> wrote:
> > > Currently that's inconsistently reachable only by first displaying the
> > > tree.
> > 
> > I cannot say that there is any "inconsistency" there per se.  I also
> > fail to see the value of this patch.
> 
> Currently the bottom navbar is more or less the same as the list of
> links in the tree entry (there's the HEAD link but that's a special
> case).

I completely understand where you're coming from.  I do.

But this patch makes the view so much more cluttered.  And it isn't
vital.  Yes we can do it, yes gitweb can do it, but I doubt the core
value.

Another thing is that currently tree/directory entries' third (links)
column to be shortest of all, and this gives my eyes another indication
that this is a tree.

Imagine a long list of files, and in the middle a directory.  Then
you'd see only the "history" link next to it, as opposed to the long
"history | snapshot"...

I'm ambivalent as to whether this goes in or not.  If the people want it,
so be it.

      Luben


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
