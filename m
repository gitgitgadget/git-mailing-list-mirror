From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Add --show-touched option to show "diff --git" line when contents are unchanged
Date: Mon, 06 Aug 2007 18:16:42 +0200
Message-ID: <864pjcbpud.fsf@lola.quinscape.zz>
References: <vpqwswf8c1i.fsf@bauges.imag.fr> <7v4pjj5fp6.fsf@assigned-by-dhcp.cox.net> <vpqhcni47ek.fsf@bauges.imag.fr> <Pine.LNX.4.64.0708021050500.14781@racer.site> <vpqbqdq45ua.fsf@bauges.imag.fr> <Pine.LNX.4.64.0708021147110.14781@racer.site>  =?ISO-8859-1?Q?=20<?=
	=?ISO-8859-1?Q?AF1190=04E2-A0F4-4?= =?ISO-8859-1?Q?79F-B0A1-50B2C72?=
	=?ISO-8859-1?Q?78995@yahoo.ca>?= <Pine.LNX.4.64.0708021541520.14781@racer.site> <46B1F3F4.5030504@midwinter.com> <Pine.LNX.4.64.0708021614420.14781@racer.site> <20070803053717.GA16379@midwinter.com> <7v3az1qgdg.fsf@assigned-by-dhcp.cox.net>  =?ISO-8859-1?Q?=20<?=
	=?ISO-8859-1?Q?Pine=04.LNX.4.64.0?= =?ISO-8859-1?Q?708031121000.147?=
	=?ISO-8859-1?Q?81@racer.site>?= <7vir7wmk84.fsf@assigned-by-dhcp.cox.net> <86bqdkbq59.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 06 18:17:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1II5GS-0001ny-3j
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 18:17:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753723AbXHFQQ6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Aug 2007 12:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753557AbXHFQQ6
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 12:16:58 -0400
Received: from main.gmane.org ([80.91.229.2]:33249 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753122AbXHFQQ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 12:16:57 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1II5GJ-00012Q-D5
	for git@vger.kernel.org; Mon, 06 Aug 2007 18:16:55 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 06 Aug 2007 18:16:55 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 06 Aug 2007 18:16:55 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:DCouFhbkRVw9GZiqtSaMj7hbR6k=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55159>


David Kastrup <dak@gnu.org> writes:

> I don't even think it prudent to _offer_ the --show-touched option
> in a porcelain such as git-diff as long as purportedly read-only
> porcelain commands like git-status can trash the state: what is
> reported is not actually "touched" but something internal to the
> operation of git.
>
> At least not without a notice in the manual that this option might
> or might not work, depending on what one did previously.

Proposal: if this option is to stay, call it rather --show-stale since
that corresponds better with what the option actually does: show
whether git's inode cache went stale.  It does _not_ show whether the
file has been touched (git-status does not touch files, for example).

-- 
David Kastrup
