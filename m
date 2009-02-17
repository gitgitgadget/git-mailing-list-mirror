From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: git commit <path> scanning entire working tree?
Date: Mon, 16 Feb 2009 23:50:50 -0600
Message-ID: <200902162350.50946.bss@iguanasuicide.net>
References: <2729632a0902161458m732af362od59e5f35af5643c3@mail.gmail.com> <7vwsbpewkl.fsf@gitster.siamese.dyndns.org> <2729632a0902161937o4ac3a1aeg143dda509ba5e384@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1531447.Ki06vmpHpM";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: skillzero@gmail.com
X-From: git-owner@vger.kernel.org Tue Feb 17 06:52:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZIsa-0003Jj-Py
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 06:52:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751062AbZBQFu5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 00:50:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751052AbZBQFu5
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 00:50:57 -0500
Received: from eastrmmtao105.cox.net ([68.230.240.47]:34358 "EHLO
	eastrmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751047AbZBQFu4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 00:50:56 -0500
Received: from eastrmimpo01.cox.net ([68.1.16.119])
          by eastrmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090217055056.URLI4139.eastrmmtao105.cox.net@eastrmimpo01.cox.net>;
          Tue, 17 Feb 2009 00:50:56 -0500
Received: from localhost ([72.204.50.125])
	by eastrmimpo01.cox.net with bizsmtp
	id Gtqu1b00D2i4SyG02tqvZg; Tue, 17 Feb 2009 00:50:55 -0500
X-Authority-Analysis: v=1.0 c=1 a=ohHnUL2ZxUIA:10 a=q3Gvrb_Qno0A:10
 a=Fq1VQ0LPAAAA:8 a=6XUCo0twuB8S5lX56vUA:9 a=_Taj8rn-xbHd7qQ8O18A:7
 a=UZ1QtCDTNzDIcR71VuqHm5WFu8YA:4 a=qIVjreYYsbEA:10 a=T3brmoaXcPoA:10
 a=LY0hPdMaydYA:10 a=NVaoerGHXfjodJBP4rwA:9 a=S_WwiBaURpzJLnGXAug80Gs5MUAA:4
 a=rPt6xJ-oxjAA:10
X-CM-Score: 0.00
Received: from bss by localhost with local (Exim 4.69)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LZIr4-000EHO-VE; Mon, 16 Feb 2009 23:50:51 -0600
User-Agent: KMail/1.11.0 (Linux/2.6.26-1-amd64; KDE/4.2.0; x86_64; ; )
In-Reply-To: <2729632a0902161937o4ac3a1aeg143dda509ba5e384@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110312>

--nextPart1531447.Ki06vmpHpM
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 16 February 2009 21:37:57 you wrote:
> On Mon, Feb 16, 2009 at 4:28 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > The template lists "Changes to be committed", but
> > also "Changed but not updated" and "Untracked files".  You cannot
> > generate the latter two lists without checking with your work tree.
>
> It seems like it shouldn't scan/show things outside of the path. If
> I've specified a path on the command line, I most likely only care
> about things in that path. I think it would make committing specific
> paths much faster when you have a large tree. However, it would
> eliminate information (changed/untracked files outside that path), if
> people are relying on that.

Patches reviewed (and possibly accepted) here.
=2D-=20
Boyd Stephen Smith Jr.                   ,=3D ,-_-. =3D.
bss@iguanasuicide.net                   ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy         `-'(. .)`-'
http://iguanasuicide.net/                    \_/


--nextPart1531447.Ki06vmpHpM
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkmaUDoACgkQ55pqL7G1QFkR4gCdGV3wpA+msCS/5ob+SKkP0OHL
G6gAnA/WDLIOB3h8hd1HDYjdSoM8ZXFq
=msD+
-----END PGP SIGNATURE-----

--nextPart1531447.Ki06vmpHpM--
