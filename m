From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] commit encoding: store it in commit header rather than mucking with NUL
Date: Mon, 25 Dec 2006 23:54:47 +0100
Organization: At home
Message-ID: <empkme$qp$2@sea.gmane.org>
References: <Pine.LNX.4.63.0612241505290.19693@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.63.0612241643440.19693@wbgn013.biozentrum.uni-wuerzburg.de> <7v3b74q1c9.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0612250134040.19693@wbgn013.biozentrum.uni-wuerzburg.de> <7vr6uoo2ow.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Mon Dec 25 23:52:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gyyga-0004Ug-7z
	for gcvg-git@gmane.org; Mon, 25 Dec 2006 23:52:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754556AbWLYWwj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 25 Dec 2006 17:52:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754560AbWLYWwj
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Dec 2006 17:52:39 -0500
Received: from main.gmane.org ([80.91.229.2]:56974 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754556AbWLYWwj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Dec 2006 17:52:39 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Gyyg7-0005GG-Cf
	for git@vger.kernel.org; Mon, 25 Dec 2006 23:52:19 +0100
Received: from host-81-190-19-121.torun.mm.pl ([81.190.19.121])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 25 Dec 2006 23:52:19 +0100
Received: from jnareb by host-81-190-19-121.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 25 Dec 2006 23:52:19 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-19-121.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35399>

Junio C Hamano wrote:

> I was afraid that there might be something we did (or we did not
> do) that encouraged people to have their names (via environment
> variables, or perhaps user.name) always in UTF-8 while recording
> the log messages in the legacy encoding, and if that kind of use
> is already done in the wild, we would end up having to not
> reencode the header field but reencode the body.
>=20
> But I do not think we ever encouraged encoding names in UTF-8 or
> anything else (we did encourage use of UTF-8 in the commit log),
> so I think we are Ok.
 =A0
By the way, it would be nice to have .mailmap like mechanism to tell gi=
t
that those two (three or more) names are the same comitter and should b=
e
shown (at least in git-shortlog) as this. This is because some people
changed their email, some people have sometimes middle initial and
sometimes not, some people have name outside US-ASCII and it is sometim=
es
broken...
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
