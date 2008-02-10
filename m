From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] Improve git-help--browse browser support under OS X
Date: Sun, 10 Feb 2008 14:45:15 +0100
Message-ID: <200802101445.16033.chriscool@tuxfamily.org>
References: <1202505794-13409-1-git-send-email-jaysoffian+git@gmail.com> <76718490802091815s45c19113t938f5257aad3f46c@mail.gmail.com> <20080210124336.GH30368@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jay Soffian <jaysoffian+git@gmail.com>, git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 14:39:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOCPV-0001Kl-IO
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 14:39:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750851AbYBJNjX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Feb 2008 08:39:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750829AbYBJNjX
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 08:39:23 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:49465 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750751AbYBJNjW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Feb 2008 08:39:22 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 5DA731AB2B7;
	Sun, 10 Feb 2008 14:39:18 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 3EA491AB2B3;
	Sun, 10 Feb 2008 14:39:18 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <20080210124336.GH30368@dpotapov.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73354>

Le dimanche 10 f=E9vrier 2008, Dmitry Potapov a =E9crit :
> On Sat, Feb 09, 2008 at 09:15:30PM -0500, Jay Soffian wrote:
> > I guess I'm confused by the criticism as I thought that's what I di=
d.
> > "open" is only added to the list of browsers to try if the
> > SECURITYSESSIONID environment variable is set (indicating an OS X G=
UI
> > login environment).=20

I wonder if "open" works on OS X outside the OS X GUI environment. (And=
 do=20
people use OS X outside the OS X GUI environment ?)

> > I don't see how the change I made could adversely=20
> > impact the users of other systems.
>
> Would not be better to use uname instead like this
>
>   if test "$(uname -s)" =3D=3D "Darwin"; then
>     ...
> or in addition to SECURITYSESSIONID:
>
>   if test -n "$SECURITYSESSIONID" -a "$(uname -s)" =3D=3D "Darwin"; t=
hen
>     ...
> ?
>
> I think it would be more reliable and more importantly it makes the
> code easier to understand, because it is clear now for everyone that
> this is OS X specific.
>
> BTW, should not it be mentioned in the documentation? Probably, in
> the list of supported web browsers in git-help.txt.

In the git "next" branch, "git-help--browse" has been=20
renamed "git-web--browse". And the original patch is=20
against "git-web--browse" except in the title where it is=20
about "git-help--browse".

Anyway now in "next", "git-web--browse" is used by both "git help" and =
"git=20
instaweb", so the documentation of both commands need an update.

Thanks,
Christian.=20
