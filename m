From: Boyd Lynn Gerber <gerberb@zenez.com>
Subject: Re: [PATCH] Port to 12 other Platforms.
Date: Sun, 8 Jun 2008 10:33:40 -0600
Message-ID: <Pine.LNX.4.64.0806081028460.18454@xenau.zenez.com>
References: <Pine.LNX.4.64.0806080926240.18454@xenau.zenez.com>
 <m3prqsvsiq.fsf@localhost.localdomain> <Pine.LNX.4.64.0806080959390.18454@xenau.zenez.com>
 <vpqve0j3nkd.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, Git List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sun Jun 08 18:34:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5Nqm-0003OG-37
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 18:34:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755565AbYFHQdn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Jun 2008 12:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755564AbYFHQdm
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 12:33:42 -0400
Received: from zenez.com ([166.70.62.2]:1033 "EHLO xenau.zenez.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753487AbYFHQdm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Jun 2008 12:33:42 -0400
Received: by xenau.zenez.com (Postfix, from userid 1000)
	id 6A768E5E00; Sun,  8 Jun 2008 10:33:41 -0600 (MDT)
Received: from localhost (localhost [127.0.0.1])
	by xenau.zenez.com (Postfix) with ESMTP id 5C849E5DFA;
	Sun,  8 Jun 2008 10:33:41 -0600 (MDT)
In-Reply-To: <vpqve0j3nkd.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84291>

On Sun, 8 Jun 2008, Matthieu Moy wrote:
> Boyd Lynn Gerber <gerberb@zenez.com> writes:
> > This was from my own copy of the master archive.  It is my proposal=
=2E  I=20
> > thought you had to get an OK from this list before you do a push to=
 the=20
> > main archive.
>=20
> You won't do a push, the maintainer will apply the patch if it seems
> OK.

Thanks, I understand better now.
=20
> > What am I missing?
>=20
> The format used to send patches. git format-patch and git send-email
> would do that for you, but in particular : what comes after =C2=AB=C2=
=A0---=C2=A0=C2=BB
> and before the patch itself is ignored by the tools, just an
> informative message for people reading your email. What comes before
> this =C2=AB=C2=A0---=C2=A0=C2=BB is the commit message.


I moved the message from above my commiter message because I was told t=
o=20
add comments after the --- with the file being modified.  The reasons f=
or=20
the modifications.  I used git format-patch -p -M -B origin to generate=
=20
this email.  All I did was read the contents into the email I create fo=
r=20
posting.  This was the advice I was given on IRC as the best method to=20
create/send the patch.  When on IRC I was omitting the -p and was not=20
getting the .patch file.  After reading the docs over and over I finall=
y=20
noticed I was missing the -p.  Once I added it I got the patch file and=
=20
then I emailed it to the list.

Thanks,

--
Boyd Gerber <gerberb@zenez.com>
ZENEZ	1042 East Fort Union #135, Midvale Utah  84047
