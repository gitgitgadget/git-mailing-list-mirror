From: "Boyd Stephen Smith Jr." <bss03@volumehost.net>
Subject: Re: Grafting mis-aligned trees.
Date: Tue, 2 Dec 2008 12:28:06 -0600
Message-ID: <200812021228.07070.bss03@volumehost.net>
References: <200811171645.12869.bss03@volumehost.net> <200812021119.51857.bss03@volumehost.net> <493572A3.4070205@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart51188186.7imdF1euae";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Dec 02 19:30:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7a0Z-0001E6-Qk
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 19:30:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753126AbYLBS2k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2008 13:28:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753205AbYLBS2k
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 13:28:40 -0500
Received: from eastrmmtao105.cox.net ([68.230.240.47]:38613 "EHLO
	eastrmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752988AbYLBS2j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2008 13:28:39 -0500
Received: from eastrmimpo01.cox.net ([68.1.16.119])
          by eastrmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20081202182837.PAMW6960.eastrmmtao105.cox.net@eastrmimpo01.cox.net>;
          Tue, 2 Dec 2008 13:28:37 -0500
Received: from localhost ([72.204.50.125])
	by eastrmimpo01.cox.net with bizsmtp
	id mJUd1a00D2i4SyG02JUdsH; Tue, 02 Dec 2008 13:28:38 -0500
X-Authority-Analysis: v=1.0 c=1 a=rsX2rq0AEOEA:10 a=nEQGfrJnAAAA:8
 a=HQQM7ZltTVzmoOmx57wA:9 a=5X7MSA344eoq4-wYzLbT6vKF1xkA:4 a=B7iFY6Z7H_gA:10
 a=LY0hPdMaydYA:10 a=oVB4sroyol82axCGB1EA:9 a=reoCcWk6hPUaFcwzpwzxuc4opdMA:4
 a=rPt6xJ-oxjAA:10
X-CM-Score: 0.00
Received: from bss by localhost with local (Exim 4.69)
	(envelope-from <bss03@volumehost.net>)
	id 1L7Zym-0005lT-5G; Tue, 02 Dec 2008 12:28:12 -0600
User-Agent: KMail/1.9.9
In-Reply-To: <493572A3.4070205@drmicha.warpmail.net>
X-Eric-Conspiracy: There is no conspiracy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102167>

--nextPart51188186.7imdF1euae
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 02 December 2008, Michael J Gruber <git@drmicha.warpmail.net>=20
wrote about 'Re: Grafting mis-aligned trees.':
>Boyd Stephen Smith Jr. venit, vidit, dixit 02.12.2008 18:19:
>> I can't help thinking that rebase -ip might have helped.  I wasn't
>> aware of -p when I was initially working on this problem.  (It doesn't
>> help that I generally use Debian stable, and git 1.4 did not have -p.)
>
>rebase rebases one branch at a time, but you need to rebase/rewrite
>several, and the merge info between depends on rewritten sha1s.

Yes.  I guess that's why I employed filter-branch to begin with.

>> I probably don't need the -f.  If there are files that should be
>> ignored (and thus shouldn't be in the repo), I'll filter-branch to cut
>> them out of the history at some point.
>
>'-f' is about not having to clean out refs/original from a previous
>filter-branch run.

Okay, I misread your command line.  For some reason I thought "-f" was an=20
option to add.

>> What *exactly* is the subtree merge.  The documentation I've read
>> sounds like this case, sort of, but it's rather unclear to me.
>
>I think 'subtree' does what you want, but 'merge' doesn't!

*giggle*  I'm not quite sure what makes this funny to me, but it made me=20
laugh.

>'subtree'=20
>saves you the rewriting (putting TI into project/web), but you want a
>one-time conversion anyway. 'subtree' allows you to repeatedly merge
>branches with a different root. What it does is it looks for subdir,
>'rewrites' the incoming tree automatically and merges the result.
>=20
>But you don't want a merge, do you? Or else your whole TI history would
>be tacked onto FT's head "to the left": a new (subtree) merge commit
>would have FT's and TI's head as parents. This is one way of storing TI
>history in the full repo, but not the one you said you wanted.

You are right; that's not what I want.  But, it is a good second-place=20
result that I'll keep in mind.  Sometimes keeping the history at all is=20
more important that keeping the history orderly.

Again, thanks for the help.
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss03@volumehost.net                      ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.org/                      \_/    =20

--nextPart51188186.7imdF1euae
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkk1fjcACgkQ55pqL7G1QFnLUQCffwa7zJChUtvEyCFwxeR84YUH
1XgAnRTrk8881RV8WS0NLJl6ow9skFDN
=8NAO
-----END PGP SIGNATURE-----

--nextPart51188186.7imdF1euae--
