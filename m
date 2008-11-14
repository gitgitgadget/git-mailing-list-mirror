From: Francis Galiegue <fg@one2team.com>
Subject: Re: multiple-commit cherry-pick?
Date: Fri, 14 Nov 2008 19:38:24 +0100
Organization: One2team
Message-ID: <200811141938.24734.fg@one2team.com>
References: <buoiqr18tdk.fsf@dhapc248.dev.necel.com> <20081114050822.GA23963@foursquare.net> <alpine.LFD.2.00.0811140800540.3468@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Chris Frey <cdfrey@foursquare.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Alex Riesen <raa.lkml@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Miles Bader <miles@gnu.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Nov 14 19:41:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L13bS-0004HA-Mm
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 19:41:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752510AbYKNSj4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Nov 2008 13:39:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752198AbYKNSj4
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 13:39:56 -0500
Received: from ns35774.ovh.net ([213.251.185.197]:41135 "EHLO ns35774.ovh.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751295AbYKNSjz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Nov 2008 13:39:55 -0500
Received: from smtp.olympe.o2t (138.193.65-86.rev.gaoland.net [86.65.193.138])
	by ns35774.ovh.net (Postfix) with ESMTP id 8F4D892C002;
	Fri, 14 Nov 2008 19:39:41 +0100 (CET)
Received: from erwin.kitchen.eel (unknown [10.8.0.6])
	by smtp.olympe.o2t (Postfix) with ESMTP id 475907001F;
	Fri, 14 Nov 2008 19:39:51 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.LFD.2.00.0811140800540.3468@nehalem.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101000>

Le Friday 14 November 2008 17:11:41 Linus Torvalds, vous avez =E9crit=A0=
:
[...]
>
> So we _could_ do something like
>
> 	git log {a..b} [...]
>

I don't know if you really meant this, but entering SHA1s as is at a sh=
ell=20
prompt may have dangerous side effects... If not right now, then in (so=
me not=20
so distant time in) the future. Consider this (I use bash 3.2, maintain=
ed by=20
Gentoo):

$ echo {a..c}
a b c

Who knows if some day they won't have the idea of, say,=20
extending "{aeb32ca..ee23ff1}" to, well... You see what I mean.

--=20
=46rancis Galiegue
ONE2TEAM
Ing=E9nieur syst=E8me
Mob : +33 (0) 6 83 87 78 75
Tel : +33 (0) 1 78 94 55 52
fge@one2team.com
40 avenue Raymond Poincar=E9
75116 Paris
