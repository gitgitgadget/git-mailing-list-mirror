From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] don't append 'opaquelocktoken:' in PUT and MOVE
Date: Sat, 7 Feb 2009 19:04:44 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902071903020.10279@pacific.mpi-cbg.de>
References: <498DA4F9.20104@gmail.com>  <alpine.DEB.1.00.0902071801570.10279@pacific.mpi-cbg.de> <be6fef0d0902070952l5818e4b7x3048c667661ce31@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 07 19:06:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVrZ1-0002O3-84
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 19:05:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754747AbZBGSEI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 13:04:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754703AbZBGSEH
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 13:04:07 -0500
Received: from mail.gmx.net ([213.165.64.20]:37306 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754338AbZBGSEF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 13:04:05 -0500
Received: (qmail invoked by alias); 07 Feb 2009 18:04:03 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp014) with SMTP; 07 Feb 2009 19:04:03 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18noeFYThonbTMNsADK2lEHL6m8FZhb/A5YXmX0g8
	TWCJUfOJiyl21C
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <be6fef0d0902070952l5818e4b7x3048c667661ce31@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108870>

Hi,

On Sun, 8 Feb 2009, Tay Ray Chuan wrote:

> On Sun, Feb 8, 2009 at 1:03 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> 
> > Besides, I have to wonder where request->lock->token is set, and if 
> > that would not be the better place to fix the issue?
> 
> Are you suggesting perhaps that we revert commit 753bc91? Or perhaps 
> create another way to access lock tokens, say, get_lock_token(int 
> prepend_scheme)?

I do not suggest anything like that.

But I _refuse_ to go and investigate a thing that you should know already, 
and that you should be able to defend, indeed, something you should have 
defended in the commit message:

Why does request->lock->token have the prefix at all?

Ciao,
Dscho
