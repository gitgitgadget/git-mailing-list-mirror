From: John Keeping <john@keeping.me.uk>
Subject: Re: git ignore logic does not work as advertised
Date: Sat, 15 Jun 2013 18:07:59 +0100
Message-ID: <20130615170759.GH23890@serenity.lan>
References: <1766682.Es1SNxTkk2@x121e>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Koch <thomas@koch.ro>
X-From: git-owner@vger.kernel.org Sat Jun 15 19:08:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UntxW-00022b-5F
	for gcvg-git-2@plane.gmane.org; Sat, 15 Jun 2013 19:08:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753741Ab3FORIH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Jun 2013 13:08:07 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:33685 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751837Ab3FORIG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Jun 2013 13:08:06 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 5623B198002;
	Sat, 15 Jun 2013 18:08:05 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PYKmnTV3CUCE; Sat, 15 Jun 2013 18:08:04 +0100 (BST)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 127266064D0;
	Sat, 15 Jun 2013 18:08:01 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <1766682.Es1SNxTkk2@x121e>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227961>

On Sat, Jun 15, 2013 at 06:18:46PM +0200, Thomas Koch wrote:
> I'm using vcsh[1] to have my dotfiles in GIT. With that I use a .gitignore file 
> referenced by core.excludesfile that looks like this:
> 
> # ignore everything by default
> *
> 
> # but do not ignore emacs stuff
> !.emacs.d/
> 
> # but than again please ignore backup files inside the .emacs.d folder
> .emacs.d/backups
> 
> Now I'd expect git status to show everything in .emacs.d but not to show 
> .emacs.d/backups. However the .emacs.d/backups folder is still shown in git 
> status. I'd say that this is not in line with the man page and might be 
> considered a bug.

Which version of Git are you using?  You may be hitting a regression
that was introduced in Git 1.8.3 and is fixed in Git 1.8.3.1.
