From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [RFC] strbuf's in builtin-apply
Date: Sun, 16 Sep 2007 19:28:33 +0200
Message-ID: <20070916172833.GB26457@artemis.corp>
References: <20070915141210.GA27494@artemis.corp> <20070916172134.GA26457@artemis.corp>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="neYutvxvOLaeuPCA";
	protocol="application/pgp-signature"; micalg=SHA1
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 16 19:28:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWxvD-00013s-By
	for gcvg-git-2@gmane.org; Sun, 16 Sep 2007 19:28:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751928AbXIPR2f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2007 13:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751478AbXIPR2f
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Sep 2007 13:28:35 -0400
Received: from pan.madism.org ([88.191.52.104]:42661 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751413AbXIPR2f (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2007 13:28:35 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 433542029B;
	Sun, 16 Sep 2007 19:28:34 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id EBB48F87F; Sun, 16 Sep 2007 19:28:33 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <20070916172134.GA26457@artemis.corp>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58333>


--neYutvxvOLaeuPCA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

  Damn it I forgot to add -n to my format-patch invocation *again*. The
proper ordering is:

The builtin-apply part:
  [1/6] New strbuf APIs: splice and attach.
  [2/6] Rewrite convert_to_{git,working_tree} to use strbuf's.
  [3/6] Now that cache.h needs strbuf.h, remove useless includes.
  [4/6] builtin-apply: use strbuf's instead of buffer_desc's.

And the two somehow more independant patches (need 1/6 still):
  [5/6] Refactor replace_encoding_header.
  [6/6] Remove preemptive allocations.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--neYutvxvOLaeuPCA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG7WfBvGr7W6HudhwRAjLVAKCYNhXd8Sz67FMP8oMebNeh6VZm9ACeOr5f
DBNeLPFBq29tVtPmwvr/tmc=
=CVJh
-----END PGP SIGNATURE-----

--neYutvxvOLaeuPCA--
