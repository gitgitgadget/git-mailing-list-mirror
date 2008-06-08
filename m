From: Boyd Lynn Gerber <gerberb@zenez.com>
Subject: Re: [PATCH] progress.c: avoid use of dynamic-sized array
Date: Sun, 8 Jun 2008 15:53:13 -0600
Message-ID: <Pine.LNX.4.64.0806081551440.18454@xenau.zenez.com>
References: <Pine.LNX.4.64.0806080924330.18454@xenau.zenez.com>
 <200806082151.m58Lp6sH014324@mi0.bluebottle.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?= 
	<nanako3@bluebottle.com>
X-From: git-owner@vger.kernel.org Sun Jun 08 23:54:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5Spz-0003hz-Re
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 23:54:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756371AbYFHVxP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Jun 2008 17:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756378AbYFHVxP
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 17:53:15 -0400
Received: from zenez.com ([166.70.62.2]:26400 "EHLO xenau.zenez.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756366AbYFHVxO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Jun 2008 17:53:14 -0400
Received: by xenau.zenez.com (Postfix, from userid 1000)
	id E2E38E60E7; Sun,  8 Jun 2008 15:53:13 -0600 (MDT)
Received: from localhost (localhost [127.0.0.1])
	by xenau.zenez.com (Postfix) with ESMTP id D2EB2E60E6;
	Sun,  8 Jun 2008 15:53:13 -0600 (MDT)
In-Reply-To: <200806082151.m58Lp6sH014324@mi0.bluebottle.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84331>

On Mon, 9 Jun 2008, =E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=
=AA=E3=81=93 wrote:
> Quoting Boyd Lynn Gerber <gerberb@zenez.com>:
> > Dynamically sized arrays are gcc and C99 construct.  Using them hur=
ts
> > portability to older compilers, although using them is nice in this=
 case
> > it is not desirable.  This patch removes the only use of the constr=
uct
> > in stop_progress_msg(); the function is about writing out a single =
line
> > of a message, and the existing callers of this function feed messag=
es
> > of only bounded size anyway, so use of dynamic array is simply over=
kill.
> >
> > Signed-off-by: Boyd Lynn Gerber <gerberb@zenez.com>
>=20
> I may be mistaken but isn't this Junio's patch?  If so (quoting
> from SubmittingPatches document):
>=20
>   If you are forwarding a patch from somebody else, optionally, at
>   the beginning of the e-mail message just before the commit
>   message starts, you can put a "From: " line to name that person.

It is his from my orignal modifications.  I thought he suggested I make=
=20
the changes and resubmit it as a seperate patch.  Thanks for the=20
clarifications.

--
Boyd Gerber <gerberb@zenez.com>
ZENEZ	1042 East Fort Union #135, Midvale Utah  84047
