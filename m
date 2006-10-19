From: Petr Baudis <pasky@suse.cz>
Subject: Re: VCS comparison table
Date: Thu, 19 Oct 2006 13:37:31 +0200
Message-ID: <20061019113731.GC20017@pasky.or.cz>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <Pine.LNX.4.64.0610171605440.3962@g5.osdl.org> <45357411.20500@utoronto.ca> <200610180246.18758.jnareb@gmail.com> <45357CC3.4040507@utoronto.ca> <Pine.LNX.4.64.0610172014250.3962@g5.osdl.org> <4536EC93.9050305@utoronto.ca> <845b6e870610190002u420118b8ud634bb9594572c48@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Aaron Bentley <aaron.bentley@utoronto.ca>,
	Linus Torvalds <torvalds@osdl.org>,
	Andreas Ericsson <ae@op5.se>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 19 13:37:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaWDR-0007FD-9z
	for gcvg-git@gmane.org; Thu, 19 Oct 2006 13:37:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423305AbWJSLhe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Oct 2006 07:37:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423308AbWJSLhe
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Oct 2006 07:37:34 -0400
Received: from w241.dkm.cz ([62.24.88.241]:17889 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1423305AbWJSLhd (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Oct 2006 07:37:33 -0400
Received: (qmail 25969 invoked by uid 2001); 19 Oct 2006 13:37:31 +0200
To: Erik B?gfors <zindar@gmail.com>
Content-Disposition: inline
In-Reply-To: <845b6e870610190002u420118b8ud634bb9594572c48@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29343>

Dear diary, on Thu, Oct 19, 2006 at 09:02:16AM CEST, I got a letter
where Erik B?gfors <zindar@gmail.com> said that...
> bzr's use of revision numbers, doesn't mean it hasn't got unique
> revision identifiers, and I can't see any reason why it couldn't be
> used in the same way as git.

There is perhaps no "technical" reason, but it's also what the user
interface is designed around - most probably, using UUIDs instead of
revnos would be a lot less convenient for bzr people because you
probably primarily show revnos everywhere and UUIDs only in few special
places and/or when asked specifically through a command (correct me if
I'm wrong). Also, do you support "UUID autocompletion" so that you can
type just the unique UUID prefix instead of the whole thing?

> Both are excellent tools, and since git
> is more specialized (built to support the exact workflow used in
> kernel development), it's more suited for that exact use.
> 
> bzr tries to take a broader view, for example, it does support a
> centralized workflow if you want one.  Most people don't, but a few
> might. Because of this, it probably fits the kernel development less
> good than git.  That's fine I think! I happens to fit my workflow
> better than git does :)

I think they are in fact just as flexible (+-epsilon). Git can support
centralized workflow as well - you have some central repository
somewhere and all the developers clone it, then pull from it and push to
it in basically the same way they would use CVS. And it is perhaps
currently even more used in practice than the "single-man" workflow
nowadays, as more project are using Git.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
