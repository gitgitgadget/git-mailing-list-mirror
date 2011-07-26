From: Alexey Shumkin <zapped@mail.ru>
Subject: Re: ls-tree with non-english characters
Date: Tue, 26 Jul 2011 11:33:00 +0000 (UTC)
Message-ID: <loom.20110726T133202-838@post.gmane.org>
References: <4E2E8B33.6070900@intland.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 26 13:33:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qlft0-0000dc-FH
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jul 2011 13:33:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753239Ab1GZLdO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Jul 2011 07:33:14 -0400
Received: from lo.gmane.org ([80.91.229.12]:36011 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752284Ab1GZLdN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2011 07:33:13 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Qlfsu-0000by-FN
	for git@vger.kernel.org; Tue, 26 Jul 2011 13:33:12 +0200
Received: from 212.34.37.3 ([212.34.37.3])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 26 Jul 2011 13:33:12 +0200
Received: from zapped by 212.34.37.3 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 26 Jul 2011 13:33:12 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 212.34.37.3 (Mozilla/5.0 (X11; Linux i686) AppleWebKit/534.30 (KHTML, like Gecko) Chrome/12.0.742.124 Safari/534.30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177857>

Tajti =C3=81kos <akos.tajti <at> intland.com> writes:

>=20
> Dear List,
>=20
> I tried to use git ls-tree but on blob names containing non-english
> characters I get a strange output. For example:
>=20
> =C3=A1kos=C5=B1 -> \303\241kos\305\261
>=20
> There's no mention of this format in the manual of ls-tree. Could you=
 please
> help me on resolving this cryptic string to the original form?
>=20
> Thanks in advance,
> =C3=81kos Tajti
>=20

Russian Windows git users know this feature

git config [--global] core.quotepath false
resolves it (without -z)

and, yes, man git-config
