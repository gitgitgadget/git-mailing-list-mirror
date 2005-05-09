From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [RFC] allow file list editing during cg-commit
Date: Mon, 9 May 2005 10:46:06 +0200
Message-ID: <20050509084606.GD3599@pasky.ji.cz>
References: <20050509041459.GA13475@gate.ebshome.net> <1115627229.8949.132.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eugene Surovegin <ebs@ebshome.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 09 10:39:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DV3n8-0006aB-QI
	for gcvg-git@gmane.org; Mon, 09 May 2005 10:39:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbVEIIqN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 May 2005 04:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261154AbVEIIqN
	(ORCPT <rfc822;git-outgoing>); Mon, 9 May 2005 04:46:13 -0400
Received: from w241.dkm.cz ([62.24.88.241]:28394 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261152AbVEIIqI (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 May 2005 04:46:08 -0400
Received: (qmail 13258 invoked by uid 2001); 9 May 2005 08:46:06 -0000
To: Marcel Holtmann <marcel@holtmann.org>
Content-Disposition: inline
In-Reply-To: <1115627229.8949.132.camel@pegasus>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Mon, May 09, 2005 at 10:27:09AM CEST, I got a letter
where Marcel Holtmann <marcel@holtmann.org> told me that...
> Hi Eugene,

Hello,

> > I just started playing with cogito and failed to find _easy_ way to
> > select which files will be committed and which won't. cg-commit seems
> > to support specifying file list in command line, but this isn't very
> > convenient when the list is big.
> 
> do you know any SCM native text interface that supports such a thing? In
> general this is done by high-level GUI based interfaces to the SCM or a
> special Emacs mode etc.

so what? I still think the idea is cool, why shouldn't support it if
noone else does?

The only thing to watch out for is that cg-commit -C produces no such
list at all; it should deal with that and tell the user he is not going
to be able to control what is going to be committed then.

Another thing is that at the moment you modify the file list, you should
set customfiles - otherwise you will commit even cg-adds and cg-rms of
files you didn't select. But do that really only when you change the
file list, since it is more expensive.

You should also place an appropriate hint near the CG: lines, saying
that removing some of them will limit the list of files to be committed.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
