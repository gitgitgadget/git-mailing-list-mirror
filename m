From: Andreas Ericsson <ae@op5.se>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 16:01:42 +0200
Message-ID: <4534E246.10105@op5.se>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>	<Pine.LNX.4.64.0610161625370.3962@g5.osdl.org>	<45345AEF.6070107@utoronto.ca> <200610171030.35854.jnareb@gmail.com>	<vpqejt76vgz.fsf@ecrins.imag.fr> <4534C5CF.3000508@op5.se> <vpqlknf3wdz.fsf@ecrins.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@osdl.org>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 17 16:02:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZpVx-0005M2-Ur
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 16:01:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751026AbWJQOBu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 17 Oct 2006 10:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751027AbWJQOBu
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 10:01:50 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:27015 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751023AbWJQOBu
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 10:01:50 -0400
Received: by smtp-gw1.op5.se (Postfix, from userid 588)
	id 8AF876BDE4; Tue, 17 Oct 2006 16:01:48 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.1.4 (2006-07-25) on 
	linux-server1.op5.se
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.1.4
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id E53446BDE3; Tue, 17 Oct 2006 16:01:42 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
To: Matthieu Moy <Matthieu.Moy@imag.fr>
In-Reply-To: <vpqlknf3wdz.fsf@ecrins.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29073>

Matthieu Moy wrote:
> Andreas Ericsson <ae@op5.se> writes:
>=20
>> What about
>>
>> 3) getting the repo with all the history while still not having to b=
e
>> online to actually commit to *your* copy of the repo. When you later
>> get online, you can send all your changes in a big hunk, or let baza=
ar
>> email them to the maintainer as patches, or...
>=20
> Well, the discussion was about checkouts, so I was talking about
> checkouts ;-).
>=20

Differences in nomenclature is really messing this discussion up. In=20
git, a "checkout" is the act of pulling objects from the object databas=
e=20
into the working tree. I.e., the act of "clothing" a "bare" repository.


>> but the ability to commit to whatever branch I like in my local repo
>> and then just send the diffs by email or please-pull requests to
>> upstream authors is what makes git work so well for me.
>=20
> Sure. Once again, Bazaar does it this way too. There's an _additional
> feature_ called checkout which allows you to work in another way,
> though. As most "feature", it's not useful to everybody.
>=20

Now I'm really confused. Does bazaar have both "clone" (git-style=20
fetching a full repo and all the branches) and "checkout" (cvs-style=20
fetching only the working tree)?

>=20
>> Side-note 2: Three really great things that have made work a lot
>> easier and more enjoyable since we changed from cvs to git and that
>> aren't mentioned in the comparison table:
>=20
> Sure. And regarding this, hopufully, most modern VCS go in the same
> direction.
>=20
>> * Dependency/history graph display tools =E1 la qgit/gitk
>=20
> http://bazaar-vcs.org/bzr-gtk
> http://samba.org/~jelmer/bzr/bzrk.png
>=20
>> * Bisection tool for finding bug introduction revisions.
>=20
> This took time to come in bzr, but that's the bisect plugin:
>=20
> http://bazaar-vcs.org/PluginRegistry
>=20
>> * Tools for sending commits as emails.
>=20
> (Surprisingly, I had added this in the table, but has been removed fo=
r
> some obscure reasons)
>=20

Merge-conflict with the webpage? ;-)

However, I know that bazaar has many of these features. I was merely=20
commenting on the absence of these killer-features in the table. It=20
might help people pick the right scm for their project, which is always=
=20
a Good Thing(tm).

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
