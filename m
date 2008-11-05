From: Francis Galiegue <fg@one2team.net>
Subject: Re: Need help for migration from CVS to git in one go (ie, FORGETTING CVS history)
Date: Thu, 6 Nov 2008 00:34:47 +0100
Organization: One2team
Message-ID: <200811060034.48053.fg@one2team.net>
References: <200811060014.57046.fg@one2team.net> <20081105232348.GP15463@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Nov 06 00:38:05 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kxrwg-0004YQ-DB
	for gcvg-git-2@gmane.org; Thu, 06 Nov 2008 00:37:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752909AbYKEXgk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Nov 2008 18:36:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752856AbYKEXgk
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Nov 2008 18:36:40 -0500
Received: from ns35774.ovh.net ([213.251.185.197]:36591 "EHLO ns35774.ovh.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752713AbYKEXgj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Nov 2008 18:36:39 -0500
Received: from erwin.kitchen.eel (AOrleans-157-1-121-89.w90-20.abo.wanadoo.fr [90.20.196.89])
	(Authenticated sender: fg@one2team.net)
	by ns35774.ovh.net (Postfix) with ESMTP id 8866792C011;
	Thu,  6 Nov 2008 00:36:25 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <20081105232348.GP15463@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100202>

Le Thursday 06 November 2008 00:23:48 Shawn O. Pearce, vous avez =E9cri=
t=A0:
> Francis Galiegue <fg@one2team.net> wrote:
> > Finally, about the Eclipse plugin:
> > * the README says that it has no push capacity, the popup menu says
> > otherwise (last checked last Saturday)... What should I believe?
>
> The README is out of date.  Push is implemented, works, and folks
> actually use it.  That was a nice success from our GSoC program
> this year.
>

Good to hear :p Any chance that the README gets updated? ;)

> > * if the plugin can push, can you configure from within the plugin =
what
> > branches can be pushed where, or should you edit .git/config by han=
d?
>
> I don't think you can edit saved configurations in the plugin UI.
> The APIs are there underneath to do the reading/writing and most
> of the UI to show a configuration is present, I just don't think
> anyone has wired the two together for saved configurations inside
> of .git/config.  So yea, edit by hand.
>

Not a big deal, I guess. This can be handled... (BTW, what about "git c=
lone"?=20
Still not there, although _this_ can be dealt with also)

> > * "git stash": is it supported?
>
> Not in Eclipse, no.
>

What do you mean by this?

> > * can you "copy" a commit, or even a set of commits, and "cherry-pi=
ck"
> > them into another branch? Or even rebase a branch onto antoher?
>
> Not in Eclipse, no.

Same question... What exactly is the problem with Eclipse wrt this kind=
 of=20
operation?

--=20
fge
