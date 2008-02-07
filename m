From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH 2/4] git.el: Added a command to amend a commit.
Date: Thu, 07 Feb 2008 14:29:30 +0100
Message-ID: <86bq6suc79.fsf@lola.quinscape.zz>
References: <87ve51orq8.fsf@wine.dyndns.org> <87prv8294k.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 07 14:30:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JN6px-0002h3-40
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 14:30:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752718AbYBGNaM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 08:30:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753527AbYBGNaL
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 08:30:11 -0500
Received: from main.gmane.org ([80.91.229.2]:48911 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750953AbYBGNaK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 08:30:10 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1JN6pG-0002aA-LD
	for git@vger.kernel.org; Thu, 07 Feb 2008 13:30:02 +0000
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 07 Feb 2008 13:30:02 +0000
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 07 Feb 2008 13:30:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
Cancel-Lock: sha1:HTzzd8l6uNpMzCwfz1IpNxZN7u4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72942>

Sergei Organov <osv@javad.com> writes:

> Alexandre Julliard <julliard@winehq.org> writes:
>
>> It reverts the commit and sets up the status and edit log buffer to
>> allow making changes and recommitting it. Bound to C-c C-a.
>
> Nice! Doesn't it lack something like this:
>
> diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
> index c3c0c45..9ad37a1 100644
> --- a/contrib/emacs/git.el
> +++ b/contrib/emacs/git.el
> @@ -1385,6 +1385,7 @@ Return the list of files that haven't been handled."
>      `("Git"
>        ["Refresh" git-refresh-status t]
>        ["Commit" git-commit-file t]
> +      ["Ammend Commit" git-ammend-commit t]
>        ("Merge"
>  	["Next Unmerged File" git-next-unmerged-file t]
>  	["Prev Unmerged File" git-prev-unmerged-file t]

"amend", please.

-- 
David Kastrup
