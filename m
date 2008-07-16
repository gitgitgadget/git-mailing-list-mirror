From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Useful tip about !aliases
Date: Wed, 16 Jul 2008 02:50:48 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807160250120.2841@eeepc-johanness>
References: <3BD7F543-7CB4-48B6-8D2C-DEA2ADC6EF5F@sb.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Wed Jul 16 02:51:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIvEd-00007M-6v
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 02:51:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751659AbYGPAuN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 20:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752727AbYGPAuM
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 20:50:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:55756 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751586AbYGPAuL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 20:50:11 -0400
Received: (qmail invoked by alias); 16 Jul 2008 00:50:09 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp068) with SMTP; 16 Jul 2008 02:50:09 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18NVtVNVDUNdr+9p81YKzOv2tZDqgPcOcLeOfhYM4
	PtJNX/ch3MoQ+i
X-X-Sender: user@eeepc-johanness
In-Reply-To: <3BD7F543-7CB4-48B6-8D2C-DEA2ADC6EF5F@sb.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88618>

Hi,

On Tue, 15 Jul 2008, Kevin Ballard wrote:

> Here's something I discovered recently about !aliases that other folks might
> find useful. The canonical form for a shell alias is something like
> 
>  git config alias.foo '!echo bar'
> 
> where any args given to foo, as in `git foo blah` are passed along to the
> shell, so in this case `echo bar blah` would be invoked.
> 
> Something that I find very useful is the ability to interpolate arguments into
> the middle of a command. This doesn't seem possible at first glance, not
> without a helper script. But it certainly is possible, with the help of shell
> functions:
> 
>  git config alias.reverse '!foo () { args=''; while [[ -n "$*" ]]; do args="$1
> $args"; shift; done; echo $args; }; foo'

On the gitwiki, you will find a more elegant solution using "sh -c".

Ciao,
Dscho
