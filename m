From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH 00/12] Sparse checkout
Date: Fri, 25 Jul 2008 02:07:25 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807250205270.4140@eeepc-johanness>
References: <20080723145518.GA29035@laptop> <m3tzefvd3q.fsf@localhost.localdomain> <fcaeb9bf0807240358l6584c063u85179196bd6db30a@mail.gmail.com> <200807242201.23991.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 25 02:07:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMAqG-0004bL-Rs
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 02:07:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752262AbYGYAG1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 20:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752203AbYGYAG1
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 20:06:27 -0400
Received: from mail.gmx.net ([213.165.64.20]:38844 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751873AbYGYAG0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 20:06:26 -0400
Received: (qmail invoked by alias); 25 Jul 2008 00:06:25 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp017) with SMTP; 25 Jul 2008 02:06:25 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/MD0d8lJHMUwb6/pf7qqpFZcDzt211NzKJDD1c6u
	FV8NwqzKmfEJfd
X-X-Sender: user@eeepc-johanness
In-Reply-To: <200807242201.23991.jnareb@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.73
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89979>

Hi,

On Thu, 24 Jul 2008, Jakub Narebski wrote:

> I think teaching git to use index version of .git* files (.gitignore,
> .gitattributes, .gitmodules) would be much more work than adding
> default rule that .git* files in leading directories are by default
> checked out, just like leading directories are checked out.

"Teaching" Git that would also directly contradict Git's primary motto: 
"Content is king".

Oh, by some convoluted reasoning you could argue that "content" hidden 
somewhere else than the working directory is "content", but nobody in her 
right mind would buy into that.

Ciao,
Dscho
