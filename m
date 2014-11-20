From: Jiang Xin <worldhello.net@gmail.com>
Subject: [L10N] please review a batch l10n update for Git 2.2.0 final
Date: Thu, 20 Nov 2014 11:26:23 +0800
Message-ID: <CANYiYbFrNCqxfrcaOWjeEZ2no=DRHVoDic8Qg989=U_VUTWiWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Alexander Shopov <ash@kambanaria.org>,
	Alex Henrie <alexhenrie24@gmail.com>,
	Ralf Thielow <ralf.thielow@googlemail.com>,
	=?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
	Marco Paolone <marcopaolone@gmail.com>,
	Marco Sousa <marcomsousa@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 20 04:26:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrIOF-0005MF-7h
	for gcvg-git-2@plane.gmane.org; Thu, 20 Nov 2014 04:26:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756132AbaKTD00 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Nov 2014 22:26:26 -0500
Received: from mail-wi0-f179.google.com ([209.85.212.179]:37924 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756062AbaKTD0Z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Nov 2014 22:26:25 -0500
Received: by mail-wi0-f179.google.com with SMTP id ex7so3925450wid.12
        for <git@vger.kernel.org>; Wed, 19 Nov 2014 19:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=stPl4yBL2eh4dN95MdL5z95JNAkB5T3O8U/Ic+i3cfQ=;
        b=O81lPwiMmaLVLjWU3ikWTu9gO+vntJVqdhCI8X2E7O9/mTxQ1QlQACZa5Iq0MRmdDu
         VDPy3sfd5QPY+uABCsedZ5E8VKTkLDaPjklAVO2GuIj1kCOPENiXA6vhO3bSDOXk79e2
         1p5rcs88WLcIYewO29AFj/HPC7TvhW58FX1UZjMMKPQ9XknLCt3pcqOUYs48s8ZLHZ/2
         nnGc8nd6g8GRvTMox7mVg9uf2kCAm1yVnNZk36rVboXNPKs/dHSRQNMON5XbZt7mNUf8
         G+VkM9gE7fD2/T1p80Hv6iuxjrBDYzBOLu7iey+JFknaF2HgLAJSqsi6I7953fD0ViiA
         cDzg==
X-Received: by 10.194.119.230 with SMTP id kx6mr58605273wjb.80.1416453984013;
 Wed, 19 Nov 2014 19:26:24 -0800 (PST)
Received: by 10.194.56.8 with HTTP; Wed, 19 Nov 2014 19:26:23 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Only two days left for Git 2.2.0 final according to Git calendar
(http://tinyurl.com/gitCal),
but there is a new update for our L10N team to respond.

The change is so small, I can handle it. git-diff shows:

    -msgid "empty trailer token in trailer '%s'"
    +msgid "empty trailer token in trailer '%.*s'"

In order to catch up with Git 2.2.0 final, I update all affected l10n
translations.
If there are errors or you want to update yourself, please send me new
pull request and I will rebase on your commit.  What I have made:

    l10n: batch updates for one trivial change

    In order to catch up with the release of Git 2.2.0 final, make a ba=
tch
    l10n update for the new l10n change brought by commit d52adf1 (trai=
ler:
    display a trailer without its trailing newline).

    Signed-off-by: Jiang Xin <worldhello.net@gmail.com>

    po/bg.po    | 110 +++++-----
    po/ca.po    |  56 ++---
    po/de.po    | 629 ++++++++++++++++++++++++++++---------------------=
-----
    po/fr.po    |  90 ++++----
    po/sv.po    |  76 +++----
    po/vi.po    |  56 ++---
    po/zh_CN.po |  56 ++---
    7 files changed, 554 insertions(+), 519 deletions(-)

Because I update the .po files with msgmerge, this update also
brings some format changes, so not panic. :)  What I changed are:

    bg.po:msgid "empty trailer token in trailer '%.*s'"
    bg.po-msgstr "=D0=BF=D1=80=D0=B0=D0=B7=D0=BD=D0=B0 =D0=B7=D0=B0=D0=B2=
=D1=8A=D1=80=D1=88=D0=B2=D0=B0=D1=89=D0=B0 =D0=BB=D0=B5=D0=BA=D1=81=D0=B5=
=D0=BC=D0=B0 =D0=B2 =D0=B5=D0=BF=D0=B8=D0=BB=D0=BE=D0=B3=D0=B0 =E2=80=9E=
%.*s=E2=80=9C"
    --
    ca.po:msgid "empty trailer token in trailer '%.*s'"
    ca.po-msgstr "fitxa de remolc buida en el remolc '%.*s'"
    --
    de.po:msgid "empty trailer token in trailer '%.*s'"
    de.po-msgstr "leerer Anhang-Token in Anhang '%.*s'"
    --
    fr.po:msgid "empty trailer token in trailer '%.*s'"
    fr.po-msgstr "symbole vide dans la ligne de fin '%.*s'"
    --
    sv.po:msgid "empty trailer token in trailer '%.*s'"
    sv.po-msgstr "tom sl=C3=A4pradssymbol i sl=C3=A4praden \"%.*s\""
    --
    vi.po:msgid "empty trailer token in trailer '%.*s'"
    vi.po-msgstr "th=E1=BA=BB th=E1=BB=ABa tr=E1=BB=91ng r=E1=BB=97ng t=
rong ph=E1=BA=A7n th=E1=BB=ABa =E2=80=9C%.*s=E2=80=9D"
    --
    zh_CN.po:msgid "empty trailer token in trailer '%.*s'"
    zh_CN.po-msgstr "=E7=AD=BE=E5=90=8D '%.*s' =E7=9A=84=E9=94=AE=E4=B8=
=BA=E7=A9=BA"

NOTE for Ralf:  After I updated de.po, there are 3 fuzzies instead of o=
ne.
I can only fix one of them.

--=20
Jiang Xin
