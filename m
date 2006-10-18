From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] nice ftplugin for vim, that shows the commited diff in a split'ed buffer.
Date: Wed, 18 Oct 2006 03:57:04 +0200
Message-ID: <20061018015704.GQ20017@pasky.or.cz>
References: <11610450702261-git-send-email-madcoder@debian.org> <200610171238.04372.madcoder@debian.org> <802d21790610170359v3f17438dn8009ae9a55b2405c@mail.gmail.com> <200610171304.39131.madcoder@debian.org> <46d6db660610171448h53de5e40wf55f19d6458127ef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 04:04:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ga0gC-0006Gx-9a
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 03:57:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834AbWJRB5J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 21:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750932AbWJRB5I
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 21:57:08 -0400
Received: from w241.dkm.cz ([62.24.88.241]:25266 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750834AbWJRB5G (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Oct 2006 21:57:06 -0400
Received: (qmail 24187 invoked by uid 2001); 18 Oct 2006 03:57:04 +0200
To: Christian MICHON <christian.michon@gmail.com>
Content-Disposition: inline
In-Reply-To: <46d6db660610171448h53de5e40wf55f19d6458127ef@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29176>

Dear diary, on Tue, Oct 17, 2006 at 11:48:51PM CEST, I got a letter
where Christian MICHON <christian.michon@gmail.com> said that...
> I'd like particularly to know if a git-explorer type of plugin makes
> sense for (g)vim and would like in this case be part of the team
> developping it... using git of course :)

See also

	http://news.gmane.org/find-root.php?message_id=<20051124093322.GA3899@mail.yhbt.net>

Personally, I'd say "just use tig". :-)

If you insist on living instide vim, that particular script comes from
the age before git-show and git-cat-file -p so it would probably make
sense to move the bulk of the functionality there.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
