From: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: git-diff-tree inordinately (O(M*N)) slow on files with many
 changes
Date: Mon, 16 Oct 2006 10:02:03 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610161001200.7697@alien.or.mcafeemobile.com>
References: <87slhopcws.fsf@rho.meyering.net> <Pine.LNX.4.64.0610160838200.3962@g5.osdl.org>
 <Pine.LNX.4.64.0610160904400.3962@g5.osdl.org> <87mz7wp6ek.fsf@rho.meyering.net>
 <Pine.LNX.4.64.0610160941270.7697@alien.or.mcafeemobile.com>
 <87ejt8p5l9.fsf@rho.meyering.net> <Pine.LNX.4.64.0610160953480.7697@alien.or.mcafeemobile.com>
 <878xjgp5az.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 16 19:02:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZVqt-00036R-H0
	for gcvg-git@gmane.org; Mon, 16 Oct 2006 19:02:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422765AbWJPRCH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Oct 2006 13:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964773AbWJPRCH
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Oct 2006 13:02:07 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:20451 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S964771AbWJPRCE
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Oct 2006 13:02:04 -0400
X-AuthUser: davidel@xmailserver.org
Received: from alien.or.mcafeemobile.com
	by xmailserver.org with [XMail 1.23 ESMTP Server]
	id <S1F52BC> for <git@vger.kernel.org> from <davidel@xmailserver.org>;
	Mon, 16 Oct 2006 10:02:04 -0700
X-X-Sender: davide@alien.or.mcafeemobile.com
To: Jim Meyering <jim@meyering.net>
In-Reply-To: <878xjgp5az.fsf@rho.meyering.net>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28976>

On Mon, 16 Oct 2006, Jim Meyering wrote:

> Davide Libenzi <davidel@xmailserver.org> wrote:
> >> That helps a little.
> >> Now, instead of taking 63s, my test takes ~30s.
> >> (32 for XDL_MAX_EQLIMIT = 16, 30 for XDL_MAX_EQLIMIT = 8)
> >
> > That's too much still. May I have the offending files?
> 
> These URLs were in at least one of the messages to which
> you've replied.  Would you like me to send them instead?
> 
> >   http://meyering.net/code/git-perf/configure.gz
> >   http://meyering.net/code/git-perf/configure-curr.gz

Thanks, those are fine.



- Davide
