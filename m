From: Francis Galiegue <fg@one2team.com>
Subject: Re: [PATCH] git send-email: edit recipient addresses with the --compose flag
Date: Mon, 10 Nov 2008 08:59:48 +0100
Organization: One2team
Message-ID: <200811100859.48918.fg@one2team.com>
References: <1226235588-2997-1-git-send-email-ian.hilt@gmx.com> <200811100857.10802.fg@one2team.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>
To: Ian Hilt <ian.hilt@gmx.com>
X-From: git-owner@vger.kernel.org Mon Nov 10 09:01:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzRiB-0000BZ-De
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 09:01:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753509AbYKJIAM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Nov 2008 03:00:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753497AbYKJIAL
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 03:00:11 -0500
Received: from ns35774.ovh.net ([213.251.185.197]:47493 "EHLO ns35774.ovh.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753353AbYKJIAK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Nov 2008 03:00:10 -0500
Received: from smtp.olympe.o2t (138.193.65-86.rev.gaoland.net [86.65.193.138])
	by ns35774.ovh.net (Postfix) with ESMTP id F0ADB92C003;
	Mon, 10 Nov 2008 09:00:05 +0100 (CET)
Received: from erwin.kitchen.eel (unknown [10.8.0.6])
	by smtp.olympe.o2t (Postfix) with ESMTP id F0B567001F;
	Mon, 10 Nov 2008 09:00:08 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <200811100857.10802.fg@one2team.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100498>

Le Monday 10 November 2008 08:57:10 Francis Galiegue, vous avez =E9crit=
=A0:
> Le Sunday 09 November 2008 13:59:48 Ian Hilt, vous avez =E9crit=A0:
> [...]
>
> > +	my @recipients =3D split(/\s*,\s*/, $match);
>
> This is where it gets complicated, for the "hey, I am" <some@one> cas=
e...
>
> But then there is a solution: use a negative lookahead for the split =
regex.
>
> I thought about splitting against /\s*,\s*(?![^"]+(?:\"[^*]*)*)"/.
>

Oops, that should have been /\s*,\s*(?![^"]+(?:\"[^*]*)*")/, sorry :/

--=20
=46rancis Galiegue
ONE2TEAM
Ing=E9nieur syst=E8me
Mob : +33 (0) 6 83 87 78 75
Tel : +33 (0) 1 78 94 55 52
fge@one2team.com
40 avenue Raymond Poincar=E9
75116 Paris
