From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git 1.0 Synopis (Draft v4)
Date: Tue, 16 Aug 2005 12:03:50 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0508161158400.3026@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <20050729082941.GD32263@mythryan2.michonline.com>
 <200507312215.j6VMFeqn030963@laptop11.inf.utfsm.cl>
 <20050815045546.GA7001@mythryan2.michonline.com> <7vr7cv7p61.fsf@assigned-by-dhcp.cox.net>
 <20050815065833.GE7001@mythryan2.michonline.com> <7v7jen6545.fsf@assigned-by-dhcp.cox.net>
 <20050815080218.GG7001@mythryan2.michonline.com> <7vhddr397g.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0508151453100.21501@iabervon.org> <7vy872fiin.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463794688-1486500218-1124186630=:3026"
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Ryan Anderson <ryan@michonline.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 16 12:04:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4yIV-0006Yz-SI
	for gcvg-git@gmane.org; Tue, 16 Aug 2005 12:03:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965187AbVHPKDx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Aug 2005 06:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965188AbVHPKDx
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Aug 2005 06:03:53 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:46273 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S965187AbVHPKDw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2005 06:03:52 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 45CD8E2477; Tue, 16 Aug 2005 12:03:51 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 29C45B3515; Tue, 16 Aug 2005 12:03:51 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 0F596B08AA; Tue, 16 Aug 2005 12:03:51 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 7E448E2477; Tue, 16 Aug 2005 12:03:50 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy872fiin.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463794688-1486500218-1124186630=:3026
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, 16 Aug 2005, Junio C Hamano wrote:

>   - Glossary documentation Johannes Schindelin is working on.

Yeah, yeah. Call _me_ lazy :-) I'll try to come up with a discussable ite=
m=20
today.

> - git prune and git fsck-cache; think about their interactions
>   with an object database that borrows from another.  This
>   includes the case where .git/objects itself is symlinked to
>   somewhere else (i.e. running "git prune" that somewhere else
>   without consulting this repository would lose objects), and
>   alternates pointing at somewhere else (i.e. ditto).

I don=B4t see how git could help in the case you are pruning a repository=
=20
which another repository points to. After all, the first repository=20
doesn=B4t know about being used by the second.

> I am sure I am forgetting something, but the above would be a
> good start.

Maybe your $GIT_DIR/remotes idea? Along with a "--store <remotename>" fla=
g=20
to git-pull-script?

Ciao,
Dscho

---1463794688-1486500218-1124186630=:3026--
