From: Francis Galiegue <fg@one2team.com>
Subject: Re: [PATCH 2/3] git send-email: do not ask questions when  --compose is used.
Date: Sat, 1 Nov 2008 18:34:32 +0100
Organization: One2team
Message-ID: <200811011834.32702.fg@one2team.com>
References: <20081031220149.GD21345@maintenance05.msc.mcgregor-surmount.com> <20081101130033.GD17961@sys-0.hiltweb.site> <20081101170817.GC26229@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 01 18:36:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwKOp-0005Vd-Uf
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 18:36:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751774AbYKARfW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Nov 2008 13:35:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751735AbYKARfW
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 13:35:22 -0400
Received: from ns35774.ovh.net ([213.251.185.197]:49499 "EHLO ns35774.ovh.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751373AbYKARfV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Nov 2008 13:35:21 -0400
Received: from smtp.olympe.o2t (138.193.65-86.rev.gaoland.net [86.65.193.138])
	by ns35774.ovh.net (Postfix) with ESMTP id E2AB992C011
	for <git@vger.kernel.org>; Sat,  1 Nov 2008 18:35:10 +0100 (CET)
Received: from erwin.kitchen.eel (unknown [10.8.0.6])
	by smtp.olympe.o2t (Postfix) with ESMTP id 615507001F
	for <git@vger.kernel.org>; Sat,  1 Nov 2008 18:35:19 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <20081101170817.GC26229@artemis.corp>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99751>

Le Saturday 01 November 2008 18:08:17 Pierre Habouzit, vous avez =E9cri=
t=A0:
[...]
>
> To: John Doe <some.address@some.tld>, Random Joe <random.joe@abc.def>=
,
>   Superman <batman@nyc.us>,
>   "Someone with a comma, inside its tag name" <a@b.com>
>

fg@erwin ~ $ cat t.txt
To: John Doe <some.address@some.tld>, Random Joe <random.joe@abc.def>,=20
Superman <batman@nyc.us>, "Someone with a comma, inside its tag name"=20
<a@b.com>
fg@erwin ~ $ <t.txt perl -ne 's,^To:\s*,,i; @mails =3D m/\s*((?:"[^"]+"=
)?
\s*<[^@]+@[^@]+>)\s*,?/g; END { print join("\n", @mails) . "\n"}'
<some.address@some.tld>
<random.joe@abc.def>
<batman@nyc.us>
"Someone with a comma, inside its tag name" <a@b.com>

That's regex, not especially perl ;)

--=20
=46rancis Galiegue
ONE2TEAM
Ing=E9nieur syst=E8me
Mob : +33 (0) 6 83 87 78 75
Tel : +33 (0) 1 78 94 55 52
fge@one2team.com
40 avenue Raymond Poincar=E9
75116 Paris
