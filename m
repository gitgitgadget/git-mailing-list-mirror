From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH] Make the rebase edit mode really end up in an edit
 state
Date: Thu, 15 Jan 2009 13:36:10 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901151325310.3586@pacific.mpi-cbg.de>
References: <87ab9th0rh.fsf@cup.kalibalik.dk>  <alpine.DEB.1.00.0901150149130.3586@pacific.mpi-cbg.de>  <496EE74F.6000205@viscovery.net>  <200901151101.53441.johan@herland.net> <bd6139dc0901150352t2d2fa388x3eb842bbc8c4baa6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Johannes Sixt <j.sixt@viscovery.net>,
	Anders Melchiorsen <mail@cup.kalibalik.dk>, gitster@pobox.com
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 15 13:36:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNRSl-0005cP-Qt
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 13:36:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754179AbZAOMfU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 07:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753176AbZAOMfU
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 07:35:20 -0500
Received: from mail.gmx.net ([213.165.64.20]:51238 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753799AbZAOMfT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 07:35:19 -0500
Received: (qmail invoked by alias); 15 Jan 2009 12:35:17 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp016) with SMTP; 15 Jan 2009 13:35:17 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/+BTBh6AL+8SJwDVjXDw6VwRbLhf2HGLmzJhtBo7
	lJNS78BKLdJ2dI
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <bd6139dc0901150352t2d2fa388x3eb842bbc8c4baa6@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105783>

Hi,

On Thu, 15 Jan 2009, Sverre Rabbelier wrote:

> On Thu, Jan 15, 2009 at 11:01, Johan Herland <johan@herland.net> wrote:
> > "modify" does the "git reset --soft HEAD^" (Anders' suggestion)

I could live with "modify".

> > "amend" requires a "git commit --amend" (current behaviour)
> 
> Why have amend do the same as edit? If you add an 'amend' one instead
> make it drop you into an editor to change the commit message. That's a
> workflow I often use. Often times I do not have a proper commit
> message when I commit (sometimes it is the result of "git commit -a -m
> "tmp"). To me having an 'amend' command that allows one to edit the
> commit message would make sense a lot :).
> 
> > "edit" == "amend", but is deprecated and goes away in the future
> 
> And as such, have edit do what it currently does.

FWIW I fully agree.

If at all, I'd introduce 'examine' as a synonym to 'edit' (might be more 
intuitive).

However, for the same reason (is it intuitive?) I am not fully convinced 
of 'amend' either.  Because --amend _can_ mean that you change the 
diff of the commit.  Maybe 'correct', 'redact' or 'rephrase'?

BTW I was not fully happy with 'edit' back then, either, which is the 
reason why I showed the usage in the comment _above_ the commit list.  But 
nobody could suggest a name that I found convincingly better.

Ciao,
Dscho
