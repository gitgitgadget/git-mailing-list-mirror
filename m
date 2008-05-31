From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Merging strategy for extending Git.pm (was: [PATCH] perl/Git.pm:
 add rev_parse method)
Date: Sat, 31 May 2008 12:38:51 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805311237100.13507@racer.site.net>
References: <1212122585-7350-1-git-send-email-LeWiemann@gmail.com> <483FA6B3.4070607@gmail.com> <20080530095938.GE18781@machine.or.cz> <48401A09.6060301@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 31 13:41:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2PSh-0002Mj-4b
	for gcvg-git-2@gmane.org; Sat, 31 May 2008 13:41:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751707AbYEaLkC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 May 2008 07:40:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751906AbYEaLkC
	(ORCPT <rfc822;git-outgoing>); Sat, 31 May 2008 07:40:02 -0400
Received: from mail.gmx.net ([213.165.64.20]:47423 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751601AbYEaLkA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 May 2008 07:40:00 -0400
Received: (qmail invoked by alias); 31 May 2008 11:39:57 -0000
Received: from R3073.r.pppool.de (EHLO none.local) [89.54.48.115]
  by mail.gmx.net (mp005) with SMTP; 31 May 2008 13:39:57 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19golwDEApg/s0ZfTMwuiBLwkMXJeUjDGh4QGfIzF
	V3ZoQDcpIetHX4
X-X-Sender: gene099@racer.site.net
In-Reply-To: <48401A09.6060301@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83376>

Hi,

On Fri, 30 May 2008, Lea Wiemann wrote:

> 2. I'll be changing my own API.  In other words, the API is really 
>    unstable while I work on this (with the only user of the API being 
>    Gitweb, which I'll update as I go).

I think it would be best for you to have that in a personal fork of git on 
repo.or.cz.  It is really easy to set up, and working with you will be 
easier, since one can always "git fetch" your newest stuff.

Then, I would recommend making many many small patches.  You can always 
reorder/squash them with "git rebase -i" later, and you will probably need 
to rebase them to newer upstream revisions anyway.

Ciao,
Dscho
