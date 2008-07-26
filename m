From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] custom strategies in builtin-merge
Date: Sat, 26 Jul 2008 04:37:02 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807260435470.11976@eeepc-johanness>
References: <20080725113316.GF32057@genesis.frugalware.org> <bd6139dc0807250450m25a932b8h68fcee13f8c343dc@mail.gmail.com> <7viqutpjqq.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0807260250480.11976@eeepc-johanness>
 <7vvdyto3da.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: sverre@rabbelier.nl, Miklos Vajna <vmiklos@frugalware.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 26 04:37:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMZea-0000Lz-Pc
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 04:37:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752508AbYGZCgE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 22:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752512AbYGZCgD
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 22:36:03 -0400
Received: from mail.gmx.net ([213.165.64.20]:55232 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752339AbYGZCgB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 22:36:01 -0400
Received: (qmail invoked by alias); 26 Jul 2008 02:36:00 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp035) with SMTP; 26 Jul 2008 04:36:00 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18/4At4r/4/0PGHnQZAJScESStFrdxuS8UKBlqSr2
	6CAt5EQQxihK7A
X-X-Sender: user@eeepc-johanness
In-Reply-To: <7vvdyto3da.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90153>

Hi,

On Fri, 25 Jul 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > ... especially since I hope that we have them builtin soon, and not 
> > only that, but have builtin-merge call them as C functions, not with 
> > fork() and exec().
> 
> Because builtin-merge.c does not directly use fork/exec but uses 
> run_command() interface, non POSIX platforms can spawn subprocesses just 
> fine, can't they?

Yes, they can.  Slowly, but they do.

But why should they?  Efficient merging is such a prominent feature of 
Git; I do not agree to let it remain a second-class feature.

Ciao,
Dscho
