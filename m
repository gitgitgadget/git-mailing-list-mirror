From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: How can I easily verify my diffs are in parent branch?
Date: Thu, 05 Apr 2007 11:16:12 +0200
Message-ID: <87y7l7tc4j.fsf@morpheus.local>
References: <1175686583.19898.68.camel@okra.transitives.com> <Pine.LNX.4.64.0704040744160.6730@woody.linux-foundation.org> <7vircbwfym.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 05 11:16:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZO5J-0002wB-Pu
	for gcvg-git@gmane.org; Thu, 05 Apr 2007 11:16:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965105AbXDEJQd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 5 Apr 2007 05:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965158AbXDEJQd
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 05:16:33 -0400
Received: from main.gmane.org ([80.91.229.2]:35922 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965105AbXDEJQd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 05:16:33 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HZO4r-0004rH-O6
	for git@vger.kernel.org; Thu, 05 Apr 2007 11:16:21 +0200
Received: from c83-253-22-207.bredband.comhem.se ([83.253.22.207])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 05 Apr 2007 11:16:21 +0200
Received: from davidk by c83-253-22-207.bredband.comhem.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 05 Apr 2007 11:16:21 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c83-253-22-207.bredband.comhem.se
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:sYWCMuXAJaufXMPG7HeJub5p9M0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43811>

Junio C Hamano <junkio@cox.net> writes:

> I think we should be able to use --left-right and ... operator
> to express what the above cherry does with something like:
>
>     $ git log --left-right --ignore-common-patch cvs-upstream...my-br=
anch

--left-right is not documented, so I think it's hard for people (for
me at least) to follow your reasoning.

Would it be to much to ask for to want to have all options have some
kind of documentation? As in not accepting patches for new options
that don't include documentation?

"git log -Sleft-right" will actually give me the documentation I want,
since the docs are written but only put in the commit message.  A git
user that only uses a git installation has no way of finding that,
though.

--=20
David K=C3=A5gedal
