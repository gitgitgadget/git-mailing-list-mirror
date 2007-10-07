From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Repository specific config file
Date: Sun, 7 Oct 2007 17:06:37 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710071704550.4174@racer.site>
References: <Pine.NEB.4.64.0710070956340.12867@otaku.Xtrmntr.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Pekka Riikonen <priikone@iki.fi>
X-From: git-owner@vger.kernel.org Sun Oct 07 18:07:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IeYet-0000Ll-7f
	for gcvg-git-2@gmane.org; Sun, 07 Oct 2007 18:07:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751560AbXJGQG7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 12:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751495AbXJGQG7
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 12:06:59 -0400
Received: from mail.gmx.net ([213.165.64.20]:57191 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751425AbXJGQG6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 12:06:58 -0400
Received: (qmail invoked by alias); 07 Oct 2007 16:06:54 -0000
Received: from unknown (EHLO [172.17.38.182]) [38.99.84.33]
  by mail.gmx.net (mp014) with SMTP; 07 Oct 2007 18:06:54 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18QEsg0FRkQgtgrgnLQ956udTIgk7gkXngV2KJrL5
	+uDkwgT5wCvAu+
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.NEB.4.64.0710070956340.12867@otaku.Xtrmntr.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60187>

Hi,

On Sun, 7 Oct 2007, Pekka Riikonen wrote:

> Has there been any discussion or considerations adding a repository 
> specific config file that would be delivered to all cloned repositories 
> automatically? This would allow the publisher of the repository to set 
> up some default settings to all developers cloning the repository.

Sure!  Just check in the file "gitconfig" and tell the good users that 
they can append it to their config with "cat gitconfig >> .git/config".

Or have a script "gitconfig.sh" containing calls to "git config" which the 
users can execute.

But you should not _force_ people to have a certain config.  It's their 
choice.

Ciao,
Dscho
