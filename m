From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (topics)
Date: Fri, 12 Jan 2007 19:16:14 +0100
Organization: At home
Message-ID: <eo8j8o$ahq$1@sea.gmane.org>
References: <7vr6u3cmsi.fsf@assigned-by-dhcp.cox.net> <7v3b6i75i5.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0701102241230.4964@xanadu.home> <20070111080035.GA28222@spearce.org> <7v1wm16gyd.fsf@assigned-by-dhcp.cox.net> <20070111100800.GB28309@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Fri Jan 12 19:16:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5Qwt-0005yJ-4q
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 19:16:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964843AbXALSQR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 12 Jan 2007 13:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964856AbXALSQR
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jan 2007 13:16:17 -0500
Received: from main.gmane.org ([80.91.229.2]:41210 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964843AbXALSQQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jan 2007 13:16:16 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1H5Qwb-000826-MS
	for git@vger.kernel.org; Fri, 12 Jan 2007 19:16:01 +0100
Received: from host-81-190-18-73.torun.mm.pl ([81.190.18.73])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 12 Jan 2007 19:16:01 +0100
Received: from jnareb by host-81-190-18-73.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 12 Jan 2007 19:16:01 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-18-73.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36687>

Shawn O. Pearce wrote:

>> One minor problem that you inherited from the original algorithm
>> is the name priority. =A0If you have an annotated tag A and a
>> lightweight tag b, and ask "git describe --tags" in this graph:
>>=20
>> =A0 =A0 ---o---o---o---o---x
>> =A0 =A0 =A0 =A0 =A0 =A0A =A0 b
>>=20
>> you would still want to describe 'x' with A, not b.
>> Unfortunately you don't (and the original doesn't either).
>=20
> Actually I think you want to describe it with b. =A0If you ask
> '--tags' then you want the lightweight ones too. =A0In the case above
> the lightweight tag b better describes x as it has more in common
> with x than A has.

Actually I very often want to describe with _annotated_ tags only.
I have few lightweight tags which are former heads (former branches),
few lightweight tags which are branch points or before-merge points,
and are _not_ version tags.

Although perhaps command line switch (to prefer annotated tags to
lightweight tags) would be better...
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
