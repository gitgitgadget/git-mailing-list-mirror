From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Cleaning up log messages
Date: Sun, 27 Jul 2008 22:16:53 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807272214120.5526@eeepc-johanness>
References: <9e4733910807271050y7fb5f77coec05bd68421baaab@mail.gmail.com>  <alpine.DEB.1.00.0807272000270.5526@eeepc-johanness>  <9e4733910807271116q29323664l8d44fdded1de8c8e@mail.gmail.com>  <20080727183309.GD32184@machine.or.cz> 
 <9e4733910807271207o2e18cef1h869c659bd0ae31ba@mail.gmail.com>  <alpine.DEB.1.00.0807272116030.5526@eeepc-johanness> <9e4733910807271231s7ff6acf8rf5848cc1a31f3afc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>, Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 27 22:16:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNCfk-0004FL-B4
	for gcvg-git-2@gmane.org; Sun, 27 Jul 2008 22:16:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757737AbYG0UPu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jul 2008 16:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757734AbYG0UPu
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jul 2008 16:15:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:54634 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757727AbYG0UPt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jul 2008 16:15:49 -0400
Received: (qmail invoked by alias); 27 Jul 2008 20:15:47 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp020) with SMTP; 27 Jul 2008 22:15:47 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/3B+A4LvD3E/xcXYUyED+166pyOW6yQiB4dVtsAa
	6/2+1kuM+b+L0M
X-X-Sender: user@eeepc-johanness
In-Reply-To: <9e4733910807271231s7ff6acf8rf5848cc1a31f3afc@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.68
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90365>

Hi,

On Sun, 27 Jul 2008, Jon Smirl wrote:

> How do you do it with git log? --pretty overrides the default of medium
> 
> --pretty[=<format>]
> 
>     Pretty-print the contents of the commit logs in a given format,
> where <format> can be one of oneline, short, medium, full, fuller,
> email, raw and format:<string>. When omitted, the format defaults to
> medium.

You get it _almost_ with

$ f='commit %H%nAuthor: %aN <%ae>%nDate:    %ad%n%n%s%n%n%b'
$ git log --pretty="format:$f"

The only difference being that the commit message is not indented.  If you 
really need that, it is easy to add.

But I rather doubt that you need it, as you want to make statistics, and 
therefore need to pipe the output into a script anyway.

Ciao,
Dscho
