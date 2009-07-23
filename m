From: Pierre Habouzit <madcoder@madism.org>
Subject: Re: synchronizing 2 heterogenous branches by cherry-pick
Date: Thu, 23 Jul 2009 10:51:25 +0200
Message-ID: <20090723085125.GL4750@laphroaig.corp>
References: <8d53e6220907210542p4c989f3av2b57202fdd2db1f5@mail.gmail.com>
 <8d53e6220907230141l62dd1830g15ca811d5b009f2f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Martin Pirker <git.collector@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 23 10:51:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTu1X-0001ed-1T
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 10:51:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753601AbZGWIv2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Jul 2009 04:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753494AbZGWIv2
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jul 2009 04:51:28 -0400
Received: from pan.madism.org ([88.191.52.104]:40950 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752549AbZGWIv1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2009 04:51:27 -0400
Received: from laphroaig.corp (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(Client did not present a certificate)
	by hermes.madism.org (Postfix) with ESMTPSA id 9C1B041D8F;
	Thu, 23 Jul 2009 10:51:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <8d53e6220907230141l62dd1830g15ca811d5b009f2f@mail.gmail.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123861>

On Thu, Jul 23, 2009 at 10:41:37AM +0200, Martin Pirker wrote:
> I'm replying to myself.... for the archives :-)
>=20
> On Tue, Jul 21, 2009 at 2:42 PM, Martin Pirker<git.collector@gmail.co=
m> wrote:
> [....]
> >Any good idea on how to automagically script these cherry-picking?
>=20
> tag identical content point in different branches:
>  git tag tag1 commitx
>  git tag tag2 commity
>=20
> get list of newer commits:
>  git rev-list tag1^..head1
>  git rev-list tag2^..head2
>=20
> compare content of commits via:
> git diff --exit-code commit1 commit2
>=20
> ....and cherry-pick resulting list from one side to the other

Or use git cherry
--=20
Intersec <http://www.intersec.com>
Pierre Habouzit <pierre.habouzit@intersec.com>
T=C3=A9l : +33 (0)1 5570 3346
Mob : +33 (0)6 1636 8131
=46ax : +33 (0)1 5570 3332
37 Rue Pierre Lhomme
92400 Courbevoie
