From: Francis Galiegue <fge@one2team.com>
Subject: Re: [PATCH] sha1_file: make sure correct error is propagated
Date: Fri, 14 Nov 2008 08:44:58 +0100
Organization: One2team
Message-ID: <200811140844.58746.fge@one2team.com>
References: <1226647174-15844-1-git-send-email-sam@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Fri Nov 14 08:49:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0tQQ-0002IC-LR
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 08:49:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750957AbYKNHrw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Nov 2008 02:47:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbYKNHrw
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 02:47:52 -0500
Received: from ns35774.ovh.net ([213.251.185.197]:58482 "EHLO ns35774.ovh.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750734AbYKNHrv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Nov 2008 02:47:51 -0500
Received: from smtp.olympe.o2t (138.193.65-86.rev.gaoland.net [86.65.193.138])
	by ns35774.ovh.net (Postfix) with ESMTP id BB73692C002;
	Fri, 14 Nov 2008 08:47:44 +0100 (CET)
Received: from erwin.olympe.o2t (erwin.olympe.o2t [192.168.1.21])
	by smtp.olympe.o2t (Postfix) with ESMTP id 5AC827001F;
	Fri, 14 Nov 2008 03:45:57 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <1226647174-15844-1-git-send-email-sam@vilain.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100958>

Le vendredi 14 novembre 2008, Sam Vilain a =E9crit=A0:
> From: Sam Vilain <samv@maia.lan>
>=20
> In the case that a object directory exists, but is not writable, the
> code path that tries to create it is followed and the returned errno
> and path that of the directory tried to be created.  The resultant
> error message is confusing.
>=20
> So, if the mkstemp() fails with EPERM, don't try to create the
> directory - return straight away.
>=20

Are you sure you didn't mean EACCESS?

--=20
=46rancis Galiegue
ONE2TEAM
Ing=E9nieur syst=E8me
Mob=A0: +33 (0) 6 83 87 78 75
Tel=A0: +33 (0) 1 78 94 55 52
fge@one2team.com
40 avenue Raymond Poincar=E9
75116 Paris
