From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] tests: allow user to specify trash directory
 location
Date: Sun, 9 Aug 2009 19:42:27 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908091941550.8306@pacific.mpi-cbg.de>
References: <20090809083518.GA8147@coredump.intra.peff.net> <20090809083945.GC8250@coredump.intra.peff.net> <200908091533.40227.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Aug 09 19:42:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaCPE-0006YA-31
	for gcvg-git-2@gmane.org; Sun, 09 Aug 2009 19:42:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751891AbZHIRlz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2009 13:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751538AbZHIRlz
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Aug 2009 13:41:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:42462 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751227AbZHIRly (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2009 13:41:54 -0400
Received: (qmail invoked by alias); 09 Aug 2009 17:41:54 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp069) with SMTP; 09 Aug 2009 19:41:54 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Q6NBwKXdQsDiix/FyDt2Mi5tZ/XLnHeWQIYELbo
	VWErwwyjZ9sS+9
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <200908091533.40227.j6t@kdbg.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.68
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125354>

Hi,

On Sun, 9 Aug 2009, Johannes Sixt wrote:

> On Sonntag, 9. August 2009, Jeff King wrote:
> > There is a test below for absolute versus relative path in the root
> > provided.  Do we need some extra magic to make it work on non-Unix
> > platforms?
> 
> Not for Windows. Those devolpers who want to use an absolute path can use the 
> POSIX path notation:
> 
>    GIT_TEST_OPTS=--root=/c/temp/gittests
> 
> This works in t4014.

But I am not aware of any reasonable tmpfs equivalent on Windows.  Are 
you?  I would be _very_ interested.

Ciao,
Dscho
