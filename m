From: Fabian Franz <FabianFranz@gmx.de>
Subject: Re: Git-commits mailing list feed.
Date: Sat, 23 Apr 2005 19:50:39 +0200
Message-ID: <200504231950.43903.FabianFranz@gmx.de>
References: <200504210422.j3L4Mo8L021495@hera.kernel.org> <1114266907.3419.43.camel@localhost.localdomain> <Pine.LNX.4.58.0504231010580.2344@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jan Dittmer <jdittmer@ppp0.net>, Greg KH <greg@kroah.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 23 19:50:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPOlw-000831-Uv
	for gcvg-git@gmane.org; Sat, 23 Apr 2005 19:50:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261648AbVDWRyt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 13:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261646AbVDWRyo
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 13:54:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:38830 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261639AbVDWRy0 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2005 13:54:26 -0400
Received: (qmail invoked by alias); 23 Apr 2005 17:54:25 -0000
Received: from p54A3BD94.dip.t-dialin.net (EHLO ff.cornils.net) [84.163.189.148]
  by mail.gmx.net (mp026) with SMTP; 23 Apr 2005 19:54:25 +0200
X-Authenticated: #590723
To: Linus Torvalds <torvalds@osdl.org>,
	David Woodhouse <dwmw2@infradead.org>
User-Agent: KMail/1.5.4
In-Reply-To: <Pine.LNX.4.58.0504231010580.2344@ppc970.osdl.org>
Content-Description: clearsigned data
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Am Samstag, 23. April 2005 19:31 schrieb Linus Torvalds:
> On Sun, 24 Apr 2005, David Woodhouse wrote:
> > Nah, asking Linus to tag his releases is the most comfortable way.
> >
> The reason I've not done tags yet is that I haven't decided how to do
> them.
>
> 	commit a2755a80f40e5794ddc20e00f781af9d6320fafb
> 	tag v2.6.12-rc3
> 	signer Linus Torvalds
>
> 	This is my official original 2.6.12-rc2 release
>
> 	-----BEGIN PGP SIGNATURE-----
> 	....
> 	-----END PGP SIGNATURE-----
>
> If somebody writes a script to generate the above kind of thing (and tells
> me how to validate it), I'll do the rest, and start tagging things
> properly. Oh, and make sure the above sounds sane (ie if somebody has a
> better idea for how to more easily identify how to find the public key to
> check against, please speak up).

To generate those you do:

# cat unsigned_tag

	commit a2755a80f40e5794ddc20e00f781af9d6320fafb
	tag v2.6.12-rc3
	signer Linus Torvalds
	This is my official original 2.6.12-rc2 release

# gpg --clearsign < unsigned_tag > signed_tag # gpg will ask here for the 
secret key phrase

To verify you do:

# gpg --verify < signed_tag

and check exit status.

Hope that helps,

cu

Fabian 
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFCaorzI0lSH7CXz7MRAr3QAJ45f2CQTgJ0sYfF9kRyrWHbsazVQQCeMqW7
HCsah/llt/I8sQ36dlDnRWg=
=Fgq1
-----END PGP SIGNATURE-----

