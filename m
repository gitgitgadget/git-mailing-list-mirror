From: Anders Kaseorg <andersk@MIT.EDU>
Subject: Re: [PATCH] everyday: fsck and gc are not everyday operations
Date: Sun, 14 Mar 2010 21:12:11 -0400 (EDT)
Message-ID: <alpine.DEB.2.00.1003142109020.14055@dr-wily.mit.edu>
References: <alpine.DEB.2.00.0910211559210.5105@dr-wily.mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 15 02:17:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nqyvu-0006WW-Hj
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 02:17:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935117Ab0COBRR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Mar 2010 21:17:17 -0400
Received: from DMZ-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.36]:47261 "EHLO
	dmz-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S935062Ab0COBRQ convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Mar 2010 21:17:16 -0400
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Sun, 14 Mar 2010 21:17:15 EDT
X-AuditID: 12074424-b7b9dae000002832-9e-4b9d896daca7
Received: from mailhub-auth-2.mit.edu (MAILHUB-AUTH-2.MIT.EDU [18.7.62.36])
	by dmz-mailsec-scanner-7.mit.edu (Symantec Brightmail Gateway) with SMTP id DF.C9.10290.D698D9B4; Sun, 14 Mar 2010 21:12:14 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-2.mit.edu (8.13.8/8.9.2) with ESMTP id o2F1CDig016249;
	Sun, 14 Mar 2010 21:12:13 -0400
Received: from localhost (LINERVA.MIT.EDU [18.181.0.232])
	(authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o2F1CBf7017438
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sun, 14 Mar 2010 21:12:12 -0400 (EDT)
In-Reply-To: <alpine.DEB.2.00.0910211559210.5105@dr-wily.mit.edu>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142163>

On Wed, 21 Oct 2009, Anders Kaseorg wrote:
> Back in 2005 when this document was written, it may have made sense t=
o=20
> introduce =E2=80=98git fsck=E2=80=99 (then =E2=80=98git fsck-objects=E2=
=80=99) as the very first example=20
> command for new users of Git 0.99.9.  Now that Git has been stable fo=
r=20
> years and does not actually tend to eat your data, it makes significa=
ntly=20
> less sense.  In fact, it sends an entirely wrong message.
>=20
> =E2=80=98git gc=E2=80=99 is also unnecessary for the purposes of this=
 document, especially=20
> with gc.auto enabled by default.
>=20
> The only other commands in the =E2=80=9CBasic Repository=E2=80=9D sec=
tion were =E2=80=98git init=E2=80=99=20
> and =E2=80=98git clone=E2=80=99.  =E2=80=98clone=E2=80=99 is already =
listed in the =E2=80=9CParticipant=E2=80=9D section,=20
> so move =E2=80=98init=E2=80=99 to the =E2=80=9CStandalone=E2=80=9D se=
ction and get rid of =E2=80=9CBasic=20
> Repository=E2=80=9D entirely.
>=20
> Signed-off-by: Anders Kaseorg <andersk@mit.edu>


This patch seems to have been forgotten.  Are there any opinions on it?=
 =20
I think it goes a long way toward making the =E2=80=9CEveryday=E2=80=9D=
 document look less=20
scary to Git newcomers.

Anders
