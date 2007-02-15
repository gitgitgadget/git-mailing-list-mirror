From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] remotes.not-origin.tagopt
Date: Thu, 15 Feb 2007 11:46:25 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702151055591.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vfy97g3d8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Feb 15 11:47:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHe8n-00061f-4z
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 11:47:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965844AbXBOKq3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Feb 2007 05:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965842AbXBOKq3
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Feb 2007 05:46:29 -0500
Received: from mail.gmx.net ([213.165.64.20]:38367 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965845AbXBOKq2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Feb 2007 05:46:28 -0500
Received: (qmail invoked by alias); 15 Feb 2007 10:46:26 -0000
X-Provags-ID: V01U2FsdGVkX1+kR1BJSaOkM2uL0K9nSB+guKJSAap4k+pVKsXFbx
	a4iQ==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vfy97g3d8.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39813>

Hi,

On Thu, 15 Feb 2007, Junio C Hamano wrote:

> With a configuration entry like this:
> 
> 	[remote "alt-git"]
>         	url = git://repo.or.cz/alt.git/git/
>                 fetch = +refs/heads/*:refs/remotes/alt-git/*
>                 tagopt = --no-tags

How about going the full nine yards, and call it "fetchopt"? Then we would 
not check for the tag options, but instead parse $fetchopt _after_ "$@" in 
git-fetch.

Ciao,
Dscho
