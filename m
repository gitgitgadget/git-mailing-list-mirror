From: tytso@mit.edu
Subject: Re: My use case
Date: Sat, 30 Jan 2010 12:48:44 -0500
Message-ID: <20100130174844.GD788@thunk.org>
References: <ron1-09825C.00261930012010@news.gmane.org>
 <1264840729-sup-5264@ezyang>
 <ron1-CC0A6E.00541330012010@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ron Garret <ron1@flownet.com>
X-From: git-owner@vger.kernel.org Sat Jan 30 18:48:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbHRH-0000Ze-Vq
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 18:48:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753057Ab0A3Rsv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2010 12:48:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752996Ab0A3Rsv
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jan 2010 12:48:51 -0500
Received: from thunk.org ([69.25.196.29]:39107 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751592Ab0A3Rsu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2010 12:48:50 -0500
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1NbHR9-0002e1-CQ; Sat, 30 Jan 2010 12:48:47 -0500
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@thunk.org>)
	id 1NbHR6-0001oP-Gh; Sat, 30 Jan 2010 12:48:44 -0500
Content-Disposition: inline
In-Reply-To: <ron1-CC0A6E.00541330012010@news.gmane.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138489>

On Sat, Jan 30, 2010 at 12:54:13AM -0800, Ron Garret wrote:
> Don't forget, I'm integrating this *into* the IDE, not just using it 
> *for* the IDE.  So I want to just have a context menu on each code 
> window with "SNAPSHOT" and "ROLLBACK" items that Just Work.  The casual 
> user won't even know that there's git behind the scenes.

This is a workflow question, I suppose, but I find things work much
better if you can get the user to give you explicit commit boundaries
so that (a) bisect works, and (b) they can describe what each commit
does, and (c) so they can more easily move specific bug fixes or
features between different release branches.  The free-form hacking
more may be nice, and very "LISP-like", but there are some real
advantages to having explicitly describable and documented commits.

Best regards,

					- Ted
