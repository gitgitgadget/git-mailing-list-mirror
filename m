From: Francis Galiegue <fge@one2team.com>
Subject: Re: [PATCH v3] To make GIT-VERSION-FILE, search for git more widely
Date: Sat, 9 May 2009 19:10:46 +0200
Organization: One2team
Message-ID: <200905091910.46775.fge@one2team.com>
References: <1241688129-31613-1-git-send-email-matthias.andree@gmx.de> <op.utlylkb61e62zd@balu> <7vskje6wsy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Matthias Andree" <matthias.andree@gmx.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 09 19:10:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2q4G-0007j5-Te
	for gcvg-git-2@gmane.org; Sat, 09 May 2009 19:10:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752341AbZEIRKX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 May 2009 13:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752169AbZEIRKX
	(ORCPT <rfc822;git-outgoing>); Sat, 9 May 2009 13:10:23 -0400
Received: from ns35774.ovh.net ([213.251.185.197]:43461 "EHLO ns35774.ovh.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752083AbZEIRKW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 May 2009 13:10:22 -0400
Received: from smtp.olympe.o2t (138.193.65-86.rev.gaoland.net [86.65.193.138])
	by ns35774.ovh.net (Postfix) with ESMTP id C719492C021;
	Sat,  9 May 2009 19:10:12 +0200 (CEST)
Received: from erwin.kitchen.eel (unknown [10.8.0.6])
	by smtp.olympe.o2t (Postfix) with ESMTP id E434B2F2C5;
	Sat,  9 May 2009 19:10:21 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <7vskje6wsy.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118677>

Le Saturday 09 May 2009 18:55:09 Junio C Hamano, vous avez =E9crit=A0:
[...]
>
> What's innovative is whoever is running build as root.
>

Well, maybe not if you just download the source and use=20
the "configure/make/make install" trinity. But when it comes to packagi=
ng,=20
it's another story.

I've been doing RPM packaging for quite a few years. I have been fortun=
ate=20
enough that my first job was with a Linux distribution (it was called=20
Mandrake at the time) and, first things first, they taught me how to se=
t up=20
an RPM environment to build as a regular user.

Believe it or not, but even as of today, in 2009, neither RHEL or its=20
immediate derivative (CentOS) manage to build a decent set of rules to =
build=20
as a non-root user. You have to make your own $HOME/.rpmmacros at the v=
ery=20
least. So, unless you are a skilled enough packager, you cannot even bu=
ild a=20
package as a regular user. And some packages out there DO require skill=
s as a=20
packager to just be built as packages (qmail is one example).

And even as a regular user, and even though you can, say, alter all=20
of /usr/local to be writeable by someone else than root, I wouldn't be=20
surprised to hear that a LOT of Linux beginners, seeing that "make inst=
all=20
doesn't work", resort to being root instead. Because it is a known fact=
 that=20
root can do everything.

Innovative? Not that much.

--=20
=46rancis Galiegue
fge@one2team.com
Ing=E9nieur syst=E8me
Mob : +33 (0) 683 877 875
Tel : +33 (0) 178 945 552
One2team
40 avenue Raymond Poincar=E9
75116 Paris
