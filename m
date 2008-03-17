From: Jan Engelhardt <jengelh@computergmbh.de>
Subject: Re: text-based tree visualizer
Date: Mon, 17 Mar 2008 17:27:03 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0803171716470.18817@fbirervta.pbzchgretzou.qr>
References: <Pine.LNX.4.64.0803061557320.7660@fbirervta.pbzchgretzou.qr>
 <46dff0320803170640g52411015g7bbe315df2b0bb56@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 17 17:28:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JbIBn-00041e-ML
	for gcvg-git-2@gmane.org; Mon, 17 Mar 2008 17:27:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752407AbYCQQ1I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Mar 2008 12:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752554AbYCQQ1H
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Mar 2008 12:27:07 -0400
Received: from sovereign.computergmbh.de ([85.214.69.204]:41629 "EHLO
	sovereign.computergmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752045AbYCQQ1G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2008 12:27:06 -0400
Received: by sovereign.computergmbh.de (Postfix, from userid 25121)
	id E42E81845628E; Mon, 17 Mar 2008 17:27:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by sovereign.computergmbh.de (Postfix) with ESMTP id DEBB01C1B2558;
	Mon, 17 Mar 2008 17:27:03 +0100 (CET)
In-Reply-To: <46dff0320803170640g52411015g7bbe315df2b0bb56@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77445>


On Mar 17 2008 21:40, Ping Yin wrote:
>>
>>  I spent the last two days writing a text-based tree visualizer;
>>  gitk is really convenient, but unfortunately it needs an X display,
>>  tigs tree view left me unimpressed, and I actually wanted a tool
>>  that does not read all commits in like gitk/tig do, but just gives =
me
>>  the treeview.
>>
>Here is my view
>=E2=95=91 =E2=95=91 =E2=95=91 =E2=95=9F Merge branch 'jk/portable'
>=E2=95=91 =E2=95=91 =E2=95=91 =E2=95=A0=E2=95=90=E2=95=97
>=E2=95=91 =E2=95=91 =E2=95=91 =E2=95=9F =E2=95=91 Merge branch 'py/sub=
module'
>=E2=95=91 =E2=95=91 =E2=95=91 =E2=95=A0=E2=95=90=E2=95=AC=E2=95=90=E2=95=
=97
>=E2=95=91 =E2=95=91 =E2=95=91 =E2=95=9F =E2=95=91 =E2=95=91 Merge bran=
ch 'db/diff-to-fp'
>=E2=95=91 =E2=95=91 =E2=95=91 =E2=95=A0=E2=95=90=E2=95=AC=E2=95=90=E2=95=
=AC=E2=95=90=E2=95=97
>=E2=95=91 =E2=95=91 =E2=95=91 =E2=95=9F =E2=95=91 =E2=95=91 =E2=95=91 =
Merge branch 'cc/help'
>=E2=95=91 =E2=95=91 =E2=95=91 =E2=95=A0=E2=95=90=E2=95=AC=E2=95=90=E2=95=
=AC=E2=95=90=E2=95=AC=E2=95=90=E2=95=97
>=E2=95=91 =E2=95=91 =E2=95=91 =E2=95=9F =E2=95=91 =E2=95=91 =E2=95=91 =
=E2=95=91 shortlog: do not require to
>=E2=95=91 =E2=95=91 =E2=95=91 =E2=95=9F =E2=95=91 =E2=95=91 =E2=95=91 =
=E2=95=91 Merge branch 'maint'
>=E2=95=91 =E2=95=91 =E2=95=91 =E2=95=A0=E2=95=90=E2=95=AC=E2=95=90=E2=95=
=AC=E2=95=90=E2=95=AC=E2=95=90=E2=95=AC=E2=95=90=E2=95=97
>
>It seems messed up.

It looks pretty normal. Once a vine-branch (=E2=95=91) branches off [a =
merge is=20
done in history], it stays in its column for the entire time. It is=20
different from gitk which moves branches to the left/right so that
there are less crossovers (=E2=95=AC) in gitk. But in git-forest that i=
s=20
intentional.
Also note that =E2=95=AC is not a "go-everywhere" intersection --
see the top of the git-forest script and/or try --style=3D3 or =3D0
option to make it apparent:

=E2=94=82 =E2=94=9C =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=
=94=82         =E2=94=82 =E2=94=82 Merge branch 'jk/portable'
=E2=94=82 =E2=95=9E=E2=95=90=E2=95=AA=E2=95=90=E2=95=AA=E2=95=90=E2=95=AA=
=E2=95=90=E2=95=AA=E2=95=90=E2=95=AA=E2=95=90=E2=95=AA=E2=95=90=E2=95=95=
       =E2=94=82 =E2=94=82=20
=E2=94=82 =E2=94=9C =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=
=94=82 =E2=94=82       =E2=94=82 =E2=94=82 Merge branch 'py/submodule'
=E2=94=82 =E2=95=9E=E2=95=90=E2=95=AA=E2=95=90=E2=95=AA=E2=95=90=E2=95=AA=
=E2=95=90=E2=95=AA=E2=95=90=E2=95=AA=E2=95=90=E2=95=AA=E2=95=90=E2=95=AA=
=E2=95=90=E2=95=95     =E2=94=82 =E2=94=82=20
=E2=94=82 =E2=94=9C =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=
=94=82 =E2=94=82 =E2=94=82     =E2=94=82 =E2=94=82 Merge branch 'db/dif=
f-to-fp'
=E2=94=82 =E2=95=9E=E2=95=90=E2=95=AA=E2=95=90=E2=95=AA=E2=95=90=E2=95=AA=
=E2=95=90=E2=95=AA=E2=95=90=E2=95=AA=E2=95=90=E2=95=AA=E2=95=90=E2=95=AA=
=E2=95=90=E2=95=AA=E2=95=90=E2=95=95   =E2=94=82 =E2=94=82=20
=E2=94=82 =E2=94=9C =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=
=94=82 =E2=94=82 =E2=94=82 =E2=94=82   =E2=94=82 =E2=94=82 Merge branch=
 'cc/help'
=E2=94=82 =E2=95=9E=E2=95=90=E2=95=AA=E2=95=90=E2=95=AA=E2=95=90=E2=95=AA=
=E2=95=90=E2=95=AA=E2=95=90=E2=95=AA=E2=95=90=E2=95=AA=E2=95=90=E2=95=AA=
=E2=95=90=E2=95=AA=E2=95=90=E2=95=AA=E2=95=90=E2=95=95 =E2=94=82 =E2=94=
=82=20
=E2=94=82 =E2=94=9C =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=
=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 shor=
tlog: do not require to run from inside a git re

Or was it something else you meant to describe with being messed up?
