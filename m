From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 00/15] git-note: A mechanisim for providing free-form after-the-fact annotations on commits
Date: Mon, 28 May 2007 02:59:16 +0200
Organization: At home
Message-ID: <f3d97g$rkk$1@sea.gmane.org>
References: <Pine.LNX.4.64.0705091406350.18541@iabervon.org> <200705102006.08624.johan@herland.net> <alpine.LFD.0.98.0705101116480.3986@woody.linux-foundation.org> <200705271608.02122.johan@herland.net> <7vejl2do5w.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 28 02:54:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsTVE-0006h8-KQ
	for gcvg-git@gmane.org; Mon, 28 May 2007 02:54:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754281AbXE1AyT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 27 May 2007 20:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754295AbXE1AyT
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 20:54:19 -0400
Received: from main.gmane.org ([80.91.229.2]:44825 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753583AbXE1AyS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2007 20:54:18 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HsTV3-0006G9-J7
	for git@vger.kernel.org; Mon, 28 May 2007 02:54:17 +0200
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 28 May 2007 02:54:17 +0200
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 28 May 2007 02:54:17 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48604>

Junio C Hamano wrote:

> You can create a tag object that points at another tag. =A0When we
> peel a tag using "^{}" notation, currently it is peeled all the
> way until we hit a non tag, so if you need to look at
> intermediate tags, you need to parse them yourself. =A0IOW, there
> is no Porcelain feature to let you take advantage of this
> capability, easily. =A0But we could use this to say "I attest that
> he tagged that object".

Hmmm... I wonder why "git show exaples/tag" (where 'examples/tag' is
tag to tag) does show empty output, and why "git show examples/tag^{tag=
}"
does not work...

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
