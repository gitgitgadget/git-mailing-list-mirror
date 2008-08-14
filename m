From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [EGIT PATCH] Fix invalid menubar and toolbar entries in plugin.xml
Date: Thu, 14 Aug 2008 22:42:19 +0200
Message-ID: <200808142242.20476.robin.rosenberg.lists@dewire.com>
References: <48A3310A.8080306@gmail.com> <200808141942.55448.robin.rosenberg.lists@dewire.com> <48A483EF.10508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Tor Arne =?iso-8859-1?q?Vestb=F8?= <torarnv@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 14 22:45:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTjgk-0001zu-W8
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 22:44:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753955AbYHNUne convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Aug 2008 16:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753618AbYHNUnd
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 16:43:33 -0400
Received: from [83.140.172.130] ([83.140.172.130]:18235 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753952AbYHNUnc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Aug 2008 16:43:32 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 0A5838006AE;
	Thu, 14 Aug 2008 22:43:31 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wWzJ9-SIDhQr; Thu, 14 Aug 2008 22:43:30 +0200 (CEST)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 616AD80069F;
	Thu, 14 Aug 2008 22:43:30 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <48A483EF.10508@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92396>

torsdagen den 14 augusti 2008 21.13.51 skrev Tor Arne Vestb=F8:
> Robin Rosenberg wrote:
> >>> The menu entry was not used, and was causing an extra
> >>> empty space in the menu bar.
> >=20
> > When I applied this patch the Git menu disappeared. (3.3)
>=20
> Ah, I see. It appears the menu was used, but because it had the wrong
> path ('org.spearce.egit.ui.gitmenu' instead of 'additions') the four=20
> entries did not show up in 3.4.=20
That's our first 3.4 incompatibilty.

> Either way I suggest the patch is still valid, because it removes
> the Git menu from the menu bar. This is consistent with what other=20
But I don't want it removed... , but I can consider hiding the git acti=
ons by default.

> platform plugins do, ie. not populating the main menu bar with plugin
Lots of plugins provide both menus and toolsbars so there is no inconsi=
stence
with Git doing it.=20

> specific entries, but instead using sub menus, context menus and view=
s.
You can have it all. Eclipse is good at it. Anywhere there is a customi=
zeable
context menu now you'll get a number of actions for RevObject's like th=
e reset
etc actions. If you add, say a refs view with RevObjects in it you'd ge=
t the
contextg menues there too.

> In the long run we should probably also move the global toolbar entri=
es
No.=20

> to the synchronize view, when I get the chance to look at implementin=
g=20
> that.=20

It is not clear, I think, what the synchronize view would look like to =
be an effective
git gui, but if we toss ideas around we might come to some conclusions/=
agreements.

>=20
> Tor Arne
>=20

-- robin
