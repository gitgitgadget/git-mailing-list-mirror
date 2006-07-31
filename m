From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] gitweb: fill in gitweb configuration by Makefile
Date: Mon, 31 Jul 2006 09:59:04 -0700 (PDT)
Message-ID: <20060731165904.78929.qmail@web31815.mail.mud.yahoo.com>
References: <20060731072200.GE16364@admingilde.org>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Jul 31 18:59:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7b6j-0000QP-OO
	for gcvg-git@gmane.org; Mon, 31 Jul 2006 18:59:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030249AbWGaQ7G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Jul 2006 12:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030251AbWGaQ7G
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Jul 2006 12:59:06 -0400
Received: from web31815.mail.mud.yahoo.com ([68.142.206.168]:23396 "HELO
	web31815.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030249AbWGaQ7F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jul 2006 12:59:05 -0400
Received: (qmail 78931 invoked by uid 60001); 31 Jul 2006 16:59:04 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=klaf4jtDXxQOFbCqzw/AxDIEj7uLAdptqwxRExI6wrgMQynMUiuSJp3YziI4Xz2Mk9rKy5JlFK4iFvW1htbgYjJTUuW8/MiU8TqZQuhWyUt0Pwgw5PYCVEvaNWbkpB663S0wPrxlsVSnStukJTPzcNgyDZ/kn6Y2HcjCFtA9Lv4=  ;
Received: from [71.80.231.253] by web31815.mail.mud.yahoo.com via HTTP; Mon, 31 Jul 2006 09:59:04 PDT
To: Martin Waitz <tali@admingilde.org>
In-Reply-To: <20060731072200.GE16364@admingilde.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24526>

--- Martin Waitz <tali@admingilde.org> wrote:
> > This way, I can just copy gitweb.cgi into my web-server directory
> > and voila it works, since the variable definition file would
> > always be there.  This way:
> >   - no need to run make to build "gitweb.cgi" or "gitweb.pl" whatever
> >     you call it,
> 
> ok, but you have to call make anyway to build the rest of GIT,
> so this shouldn't be a big problem.
> 
> >   - no need to pollute your tree with site defined variables,
> 
> this is achieved by my patch, too.
> 
> >   - simple copy (cp) would install a working version, instead of
> >     the current cp + patch with local settings method.
> 
> this is achieved by my patch, too.

That's true, but the difference is that one needs to keep
a per-site-installation tree which keeps the configuration of
gitweb for that site (installation).

Since you're working on this, can you come up with an alternative way?
At this point I don't care either way, but _if_ there is an alternative
way, I'd rather we considered it.  (Possibly using a symbol table file
("package") to only keep those variables?)

The bash-sed editing is kind of, you have to admit, hackish.

   Luben
