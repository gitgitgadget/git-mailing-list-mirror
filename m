From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] perl/Git.pm: add parse_rev method
Date: Sat, 31 May 2008 12:50:14 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805311248050.13507@racer.site.net>
References: <20080530095047.GD18781@machine.or.cz> <1212179270-26170-1-git-send-email-LeWiemann@gmail.com> <20080530210531.GH18781@machine.or.cz> <7vd4n3iivt.fsf@gitster.siamese.dyndns.org> <86r6bjmpqc.fsf@blue.stonehenge.com> <484078C7.7020008@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>,
	Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 31 13:52:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2PdP-0005CK-7H
	for gcvg-git-2@gmane.org; Sat, 31 May 2008 13:52:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752339AbYEaLvY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 May 2008 07:51:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752182AbYEaLvY
	(ORCPT <rfc822;git-outgoing>); Sat, 31 May 2008 07:51:24 -0400
Received: from mail.gmx.net ([213.165.64.20]:48244 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752307AbYEaLvX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 May 2008 07:51:23 -0400
Received: (qmail invoked by alias); 31 May 2008 11:51:21 -0000
Received: from R3073.r.pppool.de (EHLO none.local) [89.54.48.115]
  by mail.gmx.net (mp022) with SMTP; 31 May 2008 13:51:21 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19UcuZgrD1UToOeZ7ajsiu6aEVjtiYSIi+oXJdH4h
	CgUGduMGviNqP5
X-X-Sender: gene099@racer.site.net
In-Reply-To: <484078C7.7020008@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83377>

Hi,

On Fri, 30 May 2008, Lea Wiemann wrote:

> I'm honestly not too keen on sacrificing time (or code prettiness) on 
> 5.6 compatibility, so if there are no reasons besides the memory leak to 
> move away from throw/catch, perhaps we can just keep using it?

I think your opinion would change dramatically if you were stuck on a 
platform with Perl 5.6.  In general, I deem it not nice to sacrifice 
backwards compatibility just because _you_ do not need it.

I mean, by that argument we could scrap the whole Git UI and rewrite it 
anew: a lot of compatibility warts would Just Go Away.

Ciao,
Dscho
