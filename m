From: Frank Sorenson <frank@tuxrocks.com>
Subject: Re: How do I...
Date: Fri, 06 May 2005 13:07:29 -0600
Message-ID: <427BC071.5090000@tuxrocks.com>
References: <427B3DB3.4000507@tuxrocks.com>	 <1115390221.10459.4.camel@localhost>  <427B9DC5.9060905@tuxrocks.com> <1115402331.10460.16.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 06 21:01:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DU84H-0003IT-Vt
	for gcvg-git@gmane.org; Fri, 06 May 2005 21:00:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261271AbVEFTHk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 May 2005 15:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261272AbVEFTHk
	(ORCPT <rfc822;git-outgoing>); Fri, 6 May 2005 15:07:40 -0400
Received: from www.tuxrocks.com ([64.62.190.123]:58123 "EHLO tuxrocks.com")
	by vger.kernel.org with ESMTP id S261271AbVEFTHd (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2005 15:07:33 -0400
Received: from [128.187.171.102] (obelix.cs.byu.edu [128.187.171.102])
	(authenticated bits=0)
	by tuxrocks.com (8.13.1/8.13.1) with ESMTP id j46J7TRT012428
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 6 May 2005 13:07:31 -0600
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
To: Dave Kleikamp <shaggy@austin.ibm.com>
In-Reply-To: <1115402331.10460.16.camel@localhost>
X-Enigmail-Version: 0.91.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Dave Kleikamp wrote:
> I'm not sure if I was clear.  cg-pull should be 'cg-pull origin".

Got it, and it does just what I wanted.

> I take this to mean you're seeing problems with cg-update too. cg-update
> simply runs cg-pull & cg-merge together, so running them separately
> shouldn't make any difference.

Yes.  cg-pull and cg-update have both shown odd breakage of this sort,
putting my tree into a bad state.  Sometimes deleting files fixes it,
but more often than not, I've needed to just start a new tree again in
order to fix it.  This is probably due to inexperience with git, but
tree corruption probably shouldn't occur like this.

Frank
- --
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCe8BxaI0dwg4A47wRAk2OAJ915s2KHTNxrpi6k3wa7HiDhpOFGgCgrMxp
73JzFxl7lg2c9korTF8L7Ek=
=ILPh
-----END PGP SIGNATURE-----
