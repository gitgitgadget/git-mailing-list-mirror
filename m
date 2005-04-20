From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] Add help details to git help command. (This time with Perl)
Date: Thu, 21 Apr 2005 01:34:53 +0200
Message-ID: <20050420233453.GC12962@pasky.ji.cz>
References: <200504172242.26326.elenstev@mesatop.com> <20050418102412.GJ1461@pasky.ji.cz> <42654153.8080307@mesatop.com> <20050419175051.GK12757@pasky.ji.cz> <42655630.80207@dgreaves.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Cole <elenstev@mesatop.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 01:31:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOOek-00075b-FY
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 01:30:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261842AbVDTXfH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 19:35:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261844AbVDTXfH
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 19:35:07 -0400
Received: from w241.dkm.cz ([62.24.88.241]:61408 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261842AbVDTXe6 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2005 19:34:58 -0400
Received: (qmail 14835 invoked by uid 2001); 20 Apr 2005 23:34:53 -0000
To: David Greaves <david@dgreaves.com>
Content-Disposition: inline
In-Reply-To: <42655630.80207@dgreaves.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Tue, Apr 19, 2005 at 09:04:16PM CEST, I got a letter
where David Greaves <david@dgreaves.com> told me that...
> I don't love the 'require gitadd.pl' but it's a gradual start...

I hate it, for one. ;-)

> Cogito.pm seems to be a good place for the library stuff.

Sounds sensible.

> git.pl
> passes everything to scripts except gitadd.pl

We've decided to go for the individual scripts directly. :-)

Unfortunately, you didn't send the attachments inline, so I can't
comment on them sensibly.

Perhaps my main problem is now style. I'd prefer you do format it alike
the C sources of git, with 8-chars indentation and such. Also make sure
you use spaces around (or after) operators. Also, for just few short
functions I prefer putting the functions before the code itself.

> use IO::File;   # leads to less perlish syntax and is standard in perl dists

Oh come on. Are you writing Perl or not? I think it looks pretty awful,
and you are using Perl filehandle idioms anyway, so...

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
