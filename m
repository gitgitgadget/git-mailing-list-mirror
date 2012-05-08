From: Jiang Xin <worldhello.net@gmail.com>
Subject: Please review this pull request for maint branch with update of de.po
Date: Tue, 8 May 2012 08:30:48 +0800
Message-ID: <CANYiYbFiwvy8Lw+XQTehbc3k2FukrvhCvR6urfAR_3xVqXxNZA@mail.gmail.com>
References: <CANYiYbFf73hVen2sg1viNrXxt-g+tP=bF_ryBF8JYp0ZAL0b6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Ralf Thielow <ralf.thielow@googlemail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	=?ISO-8859-1?Q?Jan_Kr=FCger?= <jk@jk.gs>,
	Christian Stimming <stimming@tuhh.de>
X-From: git-owner@vger.kernel.org Tue May 08 02:30:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRYKM-0002su-Ri
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 02:30:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757975Ab2EHAau convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 May 2012 20:30:50 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:53577 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751396Ab2EHAat convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 May 2012 20:30:49 -0400
Received: by yhmm54 with SMTP id m54so4805513yhm.19
        for <git@vger.kernel.org>; Mon, 07 May 2012 17:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=l+l8MwwxkN/JQFyRu+x0jpkJyGRmlygNMJnWyQGND6Y=;
        b=1Inrp56AXIwoMaZbXWvIiLIRidhOW1rnFXR1NDeVU5WzBlfzf94YcdcpWAYPK/cU27
         ef23N/aFmUp7NNdN5PpqKTz+5sLhRIoHBat7igO+nhBhmxmUUqBFLcWAhhUKQ6B9axzp
         oboKzDHU0GkdaCgSTLfCTwIPvx/TB072hru2Q8hugs27h/wPaCPJeTliSs4egr6a2SXU
         ztDvhnDhZc68xqvgkFDnYIKWbP4G1+6aeNa4dR3b4zCX85lOpCAPu8ufAVDWe42mvqkC
         haGy4mYB0/lpbiZfefd+W7HJMHsI3INJN+dWslKhX88b6xZ7u2SisnkdQTPTR5YXnXfC
         Sl3g==
Received: by 10.42.122.76 with SMTP id m12mr978016icr.38.1336437048349; Mon,
 07 May 2012 17:30:48 -0700 (PDT)
Received: by 10.50.134.102 with HTTP; Mon, 7 May 2012 17:30:48 -0700 (PDT)
In-Reply-To: <CANYiYbFf73hVen2sg1viNrXxt-g+tP=bF_ryBF8JYp0ZAL0b6A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197333>

Hi Junio and members of German l10n team,

Ralf send me two pull requests with improvement of Git German translati=
on.
All look fine except that one commit (fbd994d) by Thomas hacks a file
"git-gui/po/de.po", which is outside of "po/" directory.

The following changes since commit bf505158d0292eed441fff1bc9157da19645=
ee91:

=C2=A0Git 1.7.10.1 (2012-05-01 21:18:44 -0700)

are available in the git repository at:

=C2=A0https://github.com/git-l10n/git-po/ maint

for you to fetch changes up to c7e01d305fd50a216d990fcaf03da66a803a69df=
:

=C2=A0Merge branch 'ralfth/git-po-de/maint' into maint (2012-05-08 06:2=
0:33 +0800)

----------------------------------------------------------------

Jiang Xin (1):
=C2=A0 =C2=A0 =C2=A0Merge branch 'ralfth/git-po-de/maint' into maint

Ralf Thielow (5):
=C2=A0 =C2=A0 =C2=A0l10n: add new members to German translation team
=C2=A0 =C2=A0 =C2=A0l10n: de.po: translate "track" as "beobachten"
=C2=A0 =C2=A0 =C2=A0l10n: de.po: translate "remote" as "extern"
=C2=A0 =C2=A0 =C2=A0l10n: de.po: collection of improvements
=C2=A0 =C2=A0 =C2=A0l10n: de.po: unify translation of "ahead" and "behi=
nd"

Thomas Rast (4):
=C2=A0 =C2=A0 =C2=A0de.po: translate "bare" as "blo=C3=9F"
=C2=A0 =C2=A0 =C2=A0de.po: hopefully uncontroversial fixes
=C2=A0 =C2=A0 =C2=A0de.po: translate "bad" as "ung=C3=BCltig" ("invalid=
")
=C2=A0 =C2=A0 =C2=A0de.po: collection of suggestions

=C2=A0git-gui/po/de.po | =C2=A0 =C2=A02 +-
=C2=A0po/TEAMS =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A03 +
=C2=A0po/de.po =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0452 ++++++++++++++++=
+++++++++++---------------------------
=C2=A03 files changed, 226 insertions(+), 231 deletions(-)

--
Jiang Xin


--=20
=E8=92=8B=E9=91=AB

=E5=8C=97=E4=BA=AC=E7=BE=A4=E8=8B=B1=E6=B1=87=E4=BF=A1=E6=81=AF=E6=8A=80=
=E6=9C=AF=E6=9C=89=E9=99=90=E5=85=AC=E5=8F=B8
=E9=82=AE=E4=BB=B6: worldhello.net@gmail.com
=E7=BD=91=E5=9D=80: http://www.ossxp.com/
=E5=8D=9A=E5=AE=A2: http://www.worldhello.net/
=E5=BE=AE=E5=8D=9A: http://weibo.com/gotgit/
=E7=94=B5=E8=AF=9D: 010-51262007, 18601196889
