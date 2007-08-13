From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: msysgit: merge, stat
Date: Mon, 13 Aug 2007 17:45:07 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708131743360.25989@racer.site>
References: <2C573942-DD22-46EC-AE4A-1334450A7C4D@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Mon Aug 13 18:49:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKd3p-0007qX-RT
	for gcvg-git@gmane.org; Mon, 13 Aug 2007 18:46:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S972949AbXHMQqO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Aug 2007 12:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S973322AbXHMQqJ
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Aug 2007 12:46:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:40183 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S971703AbXHMQqG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2007 12:46:06 -0400
Received: (qmail invoked by alias); 13 Aug 2007 16:46:03 -0000
Received: from R43a9.r.pppool.de (EHLO noname) [89.54.67.169]
  by mail.gmx.net (mp047) with SMTP; 13 Aug 2007 18:46:03 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18yJHtkZl0yWOXmtvyiiVACMAIycggXv+2S+zRamm
	QyZl+zJGNyYsXq
X-X-Sender: gene099@racer.site
In-Reply-To: <2C573942-DD22-46EC-AE4A-1334450A7C4D@zib.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55770>

Hi,

On Sun, 12 Aug 2007, Steffen Prohaska wrote:

> After a 'git merge' in msysgit some stat information of the index
> doesn't match the working tree. Thus 'git diff' looks at files,
> which it shouldn't look at. I need to do a
> 'git update-index --refresh' before everything's in sync.
> 
> Is this a know issue? Do other experience the same?

Yes, it is.  The real issue is that the index is out of date, and the full 
speed of git is not available until a refresh (which you can have with a 
"git status", too).

There are people who want to change the behaviour, and hide the empty diff 
output, preventing the user from ever knowing why git is so slow.

So just run a "git status" and continue.

Ciao,
Dscho
