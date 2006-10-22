From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH 1/4] gitweb: Whitespace cleanup - tabs are for indent, spaces are for align (2)
Date: Sun, 22 Oct 2006 16:36:44 -0700 (PDT)
Message-ID: <20061022233644.82685.qmail@web31806.mail.mud.yahoo.com>
References: <Pine.LNX.4.64.0610221359090.3962@g5.osdl.org>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 23 01:36:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gbms8-00065u-Nd
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 01:36:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbWJVXgq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Oct 2006 19:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750764AbWJVXgp
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 19:36:45 -0400
Received: from web31806.mail.mud.yahoo.com ([68.142.207.69]:4246 "HELO
	web31806.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750743AbWJVXgp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Oct 2006 19:36:45 -0400
Received: (qmail 82687 invoked by uid 60001); 22 Oct 2006 23:36:44 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Uci5toQYh74jvIEVomuzStagSMJfpm3b8Jnb9WBxsZBMjEnSOd0hRqnBqQXiqxffRpOSg77av0Z4LTooNtqkPYSV38nNWzLAOJ0N5lUIQZUvWI+Ota3uMqpQCXWw1ImqxC3K5Q3sja1Rsyv3AoKCeLT6wBUxOTk+QN9D1tl2k3U=  ;
Received: from [71.80.233.118] by web31806.mail.mud.yahoo.com via HTTP; Sun, 22 Oct 2006 16:36:44 PDT
To: Linus Torvalds <torvalds@osdl.org>,
	Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <Pine.LNX.4.64.0610221359090.3962@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29807>

--- Linus Torvalds <torvalds@osdl.org> wrote:
> On Sun, 22 Oct 2006, Jakub Narebski wrote:
> > 
> > To be true I do those "whitespace cleanup" patches when I notice
> > that something is mis-aligned for _my_ tab width (2 spaces).
> 
> Oh, wow.
> 
> You have clearly been damaged by some nasty GNU coding style or similar.
> 
> Please immediately turn tabs into 8 character hard-tabs, and read the 
> kernel Documentation/CodingStyle document.
> 
> After that, you may have to go to some detox unit to purge yourself of the 
> habit of 2-character indents, and I realize it will be hard and you'll 
> feel like shit for a while, but you'll be a better person for it.
> 
> It's like kicking a bad drug habit. It may be painful for a while, and you 
> might wistfully think back on the "happy days" when things went by in a 
> haze of unclear indentations, but really, it's worth it.

Funny, but true.

One way to do it is:

(defun my-perl-mode ()
  (setq perl-indent-level 8)
  (setq perl-continued-statement-offset 8)
)

(add-hook 'perl-mode-hook 'my-perl-mode)

     Luben
