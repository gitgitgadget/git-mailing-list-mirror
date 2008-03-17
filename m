From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [RFC/PATCH 2/3] gitweb: Support caching projects list
Date: Mon, 17 Mar 2008 20:10:29 +0100
Message-ID: <20080317191029.GE18624@mail-vs.djpig.de>
References: <1205766570-13550-1-git-send-email-jnareb@gmail.com> <1205766570-13550-3-git-send-email-jnareb@gmail.com> <20080317165405.GD18624@mail-vs.djpig.de> <200803171952.15186.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	"J.H." <warthog19@eaglescrag.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 17 20:11:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JbKk0-0002xU-Qq
	for gcvg-git-2@gmane.org; Mon, 17 Mar 2008 20:11:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752754AbYCQTKp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Mar 2008 15:10:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752577AbYCQTKp
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Mar 2008 15:10:45 -0400
Received: from pauli.djpig.de ([78.46.38.139]:47830 "EHLO pauli.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752499AbYCQTKo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2008 15:10:44 -0400
Received: from localhost (localhost [127.0.0.1])
	by pauli.djpig.de (Postfix) with ESMTP id F34D990071;
	Mon, 17 Mar 2008 20:10:42 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at pauli.djpig.de
Received: from pauli.djpig.de ([127.0.0.1])
	by localhost (pauli.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TwR3uSkoYUqg; Mon, 17 Mar 2008 20:10:31 +0100 (CET)
Received: from mail-vs.djpig.de (mail-vs.djpig.de [78.47.136.189])
	by pauli.djpig.de (Postfix) with ESMTP id 8F03E90075;
	Mon, 17 Mar 2008 20:10:31 +0100 (CET)
Received: from djpig by mail-vs.djpig.de with local (Exim 4.63)
	(envelope-from <djpig@mail-vs.djpig.de>)
	id 1JbKj7-0007Ad-Ko; Mon, 17 Mar 2008 20:10:29 +0100
Content-Disposition: inline
In-Reply-To: <200803171952.15186.jnareb@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77455>

On Mon, Mar 17, 2008 at 07:52:13PM +0100, Jakub Narebski wrote:
> Dnia poniedzia=C5=82ek 17. marca 2008 17:54, Frank Lichtenheld napisa=
=C5=82:
>=20
> >At the very least you should:
> [...]
> > =C2=A0- Check if the file is owned by the uid gitweb is running und=
er and
> > =C2=A0 =C2=A0not word-writable.
>=20
> UID ($>) or PID ($$) should be equal to cache owner: stat($file)->uid=
?

I'm not sure what the PID has to do with anything here?
But yeah, $> was what I meant.
(Although I actually prefer to use POSIX::geteuid instead, since I can
understand that faster).

Gruesse,
--=20
=46rank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
