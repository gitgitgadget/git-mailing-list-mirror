From: Francis Galiegue <fge@one2team.com>
Subject: Re: [FR] Encrypting the repository
Date: Fri, 10 Apr 2009 11:14:07 +0200
Organization: One2team
Message-ID: <200904101114.07385.fge@one2team.com>
References: <loom.20090410T084314-918@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Aaron Digulla <digulla@hepe.com>
X-From: git-owner@vger.kernel.org Fri Apr 10 11:49:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LsDMM-0007VP-20
	for gcvg-git-2@gmane.org; Fri, 10 Apr 2009 11:49:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763503AbZDJJoN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Apr 2009 05:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762596AbZDJJoN
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Apr 2009 05:44:13 -0400
Received: from ns35774.ovh.net ([213.251.185.197]:49877 "EHLO ns35774.ovh.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753869AbZDJJoM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Apr 2009 05:44:12 -0400
X-Greylist: delayed 1802 seconds by postgrey-1.27 at vger.kernel.org; Fri, 10 Apr 2009 05:44:12 EDT
Received: from smtp.olympe.o2t (138.193.65-86.rev.gaoland.net [86.65.193.138])
	by ns35774.ovh.net (Postfix) with ESMTP id 2ACA392C004;
	Fri, 10 Apr 2009 11:14:02 +0200 (CEST)
Received: from erwin.olympe.o2t (erwin.olympe.o2t [192.168.1.21])
	by smtp.olympe.o2t (Postfix) with ESMTP id A561C2F2C3;
	Fri, 10 Apr 2009 11:14:07 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <loom.20090410T084314-918@post.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116249>

Le vendredi 10 avril 2009, vous avez =E9crit=A0:
> Hello,
>=20
> I need a way to safely synchronize data between several places using =
an=20
unsafe
> storage (USB stick, Internet drive). So my question is: How much work=
 would=20
it
> be to patch GIT to encrypt all files in the repository using AES-256?
>=20
> I'm aware that this leaves an issue unresolved (where should I store =
the
> password so that GIT doesn't have to ask for it all the time?) but on=
e step=20
at a
> time, please :)
>=20
> Regards,
>=20

Why don't you just create an archive and encrypt that archive, instead =
of=20
encrypting every file?

Also, what are the target systems?

--=20
=46rancis Galiegue
ONE2TEAM
Ing=E9nieur syst=E8me
Mob : +33 (0) 683 877 875
Tel : +33 (0) 178 945 552
fge@one2team.com
40 avenue Raymond Poincar=E9
75116 Paris
