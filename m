From: David Brown <git@davidb.org>
Subject: Re: [PATCH] Let git-help prefer man-pages installed with this
	version of git
Date: Fri, 7 Dec 2007 08:19:19 -0800
Message-ID: <20071207161919.GA25490@old.davidb.org>
References: <87hciv7jkt.fsf@osv.gnss.ru> <Pine.LNX.4.64.0712062107520.21625@wbgn129.biozentrum.uni-wuerzburg.de> <87d4ti7qu1.fsf@osv.gnss.ru> <7vodd23i1v.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Sergei Organov <osv@javad.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 07 17:19:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0fvc-0006o3-Ar
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 17:19:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752127AbXLGQT2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 11:19:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751928AbXLGQT2
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 11:19:28 -0500
Received: from mail.davidb.org ([66.93.32.219]:38595 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751178AbXLGQT2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 11:19:28 -0500
Received: from davidb by mail.davidb.org with local (Exim 4.68 #1 (Debian))
	id 1J0fv5-0006hf-BO; Fri, 07 Dec 2007 08:19:19 -0800
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>,
	Sergei Organov <osv@javad.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vodd23i1v.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67434>

On Fri, Dec 07, 2007 at 02:39:24AM -0800, Junio C Hamano wrote:

>    Usually, if a user has his own version of git and regularly uses it
>    by having the non-system executable directory (e.g. $HOME/bin/git)
>    early in his $PATH, its corresponding documentation would also be in
>    a non-system documentation directory (e.g. $HOME/man) early in his
>    $MANPATH, and this change is a no-op.  The only case this change
>    matters is where the user installs his own git outside of his $PATH
>    and $MANPATH, and explicitly runs his git executable
>    (e.g. "$HOME/junk/git-1.5.4/bin/git diff").
>
>When you clarify it this way, the change does not look as useful
>anymore, does it?  How typical would that use be, to run your git
>executable by always naming it by path without relying on $PATH
>environment variable?

Or, git gets installed out of path in its own tree, and then the 'git'
executable itself is symlinked somewhere into the path.  I know this
happens, because this is what IT ended up doing.

It's also fairly easy to add a new executable path, and forget to add a new
manpath directory.

Dave
