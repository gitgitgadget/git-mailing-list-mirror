From: David Kastrup <dak@gnu.org>
Subject: Re: making "git stash" safer to use
Date: Thu, 04 Oct 2007 22:59:31 +0200
Message-ID: <85przuoato.fsf@lola.goethe.zz>
References: <200709301421.52192.bruno@clisp.org>
	<200710021350.54625.bruno@clisp.org> <47023699.3080606@byu.net>
	<200710032331.41385.bruno@clisp.org> <858x6jff2v.fsf@lupus.ig3.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Joachim B Haga <cjhaga@fys.uio.no>
X-From: git-owner@vger.kernel.org Thu Oct 04 23:09:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdXwN-0000Hz-TF
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 23:09:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760176AbXJDVIy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2007 17:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759752AbXJDVIy
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 17:08:54 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:45261 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759469AbXJDVIx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 17:08:53 -0400
Received: from localhost ([127.0.0.1] helo=lola.goethe.zz)
	by fencepost.gnu.org with esmtp (Exim 4.60)
	(envelope-from <dak@gnu.org>)
	id 1IdXvL-0007aa-1m; Thu, 04 Oct 2007 17:07:59 -0400
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id BB8461C46504; Thu,  4 Oct 2007 22:59:31 +0200 (CEST)
In-Reply-To: <858x6jff2v.fsf@lupus.ig3.net> (Joachim B. Haga's message of "Thu\, 04 Oct 2007 10\:40\:08 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60003>

Joachim B Haga <cjhaga@fys.uio.no> writes:

> What makes it most dangerous is that there is no differentiation
> between a name and a command in the same position. I'd argue that
> either the command should be mandatory:
>
> git stash save mywork
> git stash apply mywork
> git stash clear mywork
> git stash mywork       # error
>
> (we can still keep today's shortcuts "git stash" and "git stash apply", 
> but only for the un-named case),
>
> or that the command should be of the option type:
>
> git stash mywork
> git stash --apply mywork
> git stash --clear mywork

Hear, hear!  I vote for the latter.  The former is still better than
the current state, though.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
