From: David Greaves <david@dgreaves.com>
Subject: Re: Git-commits mailing list feed.
Date: Mon, 25 Apr 2005 10:31:37 +0100
Message-ID: <426CB8F9.5010602@dgreaves.com>
References: <200504210422.j3L4Mo8L021495@hera.kernel.org> <426C4168.6030008@dwheeler.com> <Pine.LNX.4.58.0504241846290.18901@ppc970.osdl.org> <200504250417.17231.FabianFranz@gmx.de> <Pine.LNX.4.58.0504241938410.18901@ppc970.osdl.org> <426C64E4.4090600@dwheeler.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	Fabian Franz <FabianFranz@gmx.de>, Paul Jakma <paul@clubi.ie>,
	Sean <seanlkml@sympatico.ca>,
	Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	David Woodhouse <dwmw2@infradead.org>,
	Jan Dittmer <jdittmer@ppp0.net>, Greg KH <greg@kroah.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 25 11:27:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPzri-0005qB-QL
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 11:26:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262556AbVDYJbo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 05:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262552AbVDYJbo
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 05:31:44 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:65475 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S262544AbVDYJbk (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Apr 2005 05:31:40 -0400
Received: from localhost (lucy.ukfsn.org [127.0.0.1])
	by mail.ukfsn.org (Postfix) with ESMTP
	id 2DBC7E6D7E; Mon, 25 Apr 2005 10:29:26 +0100 (BST)
Received: from mail.ukfsn.org ([127.0.0.1])
 by localhost (lucy.ukfsn.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 25129-02; Mon, 25 Apr 2005 10:29:26 +0100 (BST)
Received: from oak.dgreaves.com (modem-1721.lemur.dialup.pol.co.uk [217.135.134.185])
	by mail.ukfsn.org (Postfix) with ESMTP
	id 5FEF6E6D7B; Mon, 25 Apr 2005 10:29:25 +0100 (BST)
Received: from ash.dgreaves.com ([10.0.0.90])
	by oak.dgreaves.com with esmtp (Exim 4.20)
	id 1DPzwI-0002aL-8U; Mon, 25 Apr 2005 10:31:38 +0100
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
To: dwheeler@dwheeler.com
In-Reply-To: <426C64E4.4090600@dwheeler.com>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

David A. Wheeler wrote:
  > $ cat-file signature 000195297c2a6336c2007548f909769e0862b509
minor comment, cat-file gives you raw access to the object data.

better:
$ cat-file signature $(what-signs 000195297c2a6336c2007548f909769e0862b509)
> signatureof commit 000195297c2a6336c2007548f909769e0862b509
> signer Petr Baudis <pasky@ucw.cz>
> 
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.6 (GNU/Linux)
> 
> iD8DBQBCbFaRCxlT/+f+SU4RAgYSAKCWpPNlDKDkxuuA649zJop7WkQPnACdF1Fg
> JgXatbJU8YJ7JHqvgyGepRU=
> =Kttg
> -----END PGP SIGNATURE-----

David


-- 
