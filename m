From: Francis Galiegue <fg@one2team.com>
Subject: Re: Init on push
Date: Sat, 8 Nov 2008 21:08:34 +0100
Organization: One2team
Message-ID: <200811082108.34535.fg@one2team.com>
References: <200811081708.45672.robin.rosenberg.lists@dewire.com> <7viqqyc93w.fsf@gitster.siamese.dyndns.org> <gf4rf6$v52$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 08 21:12:29 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyuAU-0002AF-A7
	for gcvg-git-2@gmane.org; Sat, 08 Nov 2008 21:12:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752352AbYKHULL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Nov 2008 15:11:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751511AbYKHULK
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Nov 2008 15:11:10 -0500
Received: from ns35774.ovh.net ([213.251.185.197]:57805 "EHLO ns35774.ovh.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751056AbYKHULJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Nov 2008 15:11:09 -0500
Received: from smtp.olympe.o2t (138.193.65-86.rev.gaoland.net [86.65.193.138])
	by ns35774.ovh.net (Postfix) with ESMTP id 1D78B92C011;
	Sat,  8 Nov 2008 21:10:57 +0100 (CET)
Received: from erwin.kitchen.eel (unknown [10.8.0.6])
	by smtp.olympe.o2t (Postfix) with ESMTP id 521587001F;
	Sat,  8 Nov 2008 21:11:07 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <gf4rf6$v52$1@ger.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100420>

Le Saturday 08 November 2008 21:06:01 Jakub Narebski, vous avez =E9crit=
=A0:
> Junio C Hamano wrote:
> >  - Teach "-D $there" option to "git init", which does an "mkdir -p =
$it &&
> >    chdird $it" before it does its work.
>
> Shouldn't it be "-C $there" (like make and tar)?

I agree with that. It's pretty much a standard for quite a few "command=
 line=20
people", insofar as I always look for such an option in case I want to =
know=20
whether a command has the ability to chdir() to a different directory t=
han=20
the current one :p

--=20
=46rancis Galiegue
ONE2TEAM
Ing=E9nieur syst=E8me
Mob : +33 (0) 6 83 87 78 75
Tel : +33 (0) 1 78 94 55 52
fge@one2team.com
40 avenue Raymond Poincar=E9
75116 Paris
