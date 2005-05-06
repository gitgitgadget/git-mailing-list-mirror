From: Frank Sorenson <frank@tuxrocks.com>
Subject: Re: How do I...
Date: Fri, 06 May 2005 10:47:47 -0600
Message-ID: <427B9FB3.1040002@tuxrocks.com>
References: <427B3DB3.4000507@tuxrocks.com>	<Pine.LNX.4.58.0505060905090.2233@ppc970.osdl.org> <7vsm10cnx3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 06 18:42:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DU5tD-0007BO-Ga
	for gcvg-git@gmane.org; Fri, 06 May 2005 18:41:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbVEFQsH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 May 2005 12:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261157AbVEFQsH
	(ORCPT <rfc822;git-outgoing>); Fri, 6 May 2005 12:48:07 -0400
Received: from www.tuxrocks.com ([64.62.190.123]:21771 "EHLO tuxrocks.com")
	by vger.kernel.org with ESMTP id S261226AbVEFQsC (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2005 12:48:02 -0400
Received: from [10.0.0.10] (byu-gw.customer.csolutions.net [216.190.206.130])
	(authenticated bits=0)
	by tuxrocks.com (8.13.1/8.13.1) with ESMTP id j46GlnKA011432
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 6 May 2005 10:47:50 -0600
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vsm10cnx3.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.91.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Junio C Hamano wrote:
> Yourself or not, I think it is a good idea to do something that
> does exactly Frank wants, namely, just list commits.  Even
> better would be, to take commits with multiple parents into
> account, list of <commit> <parent> pairs, like:
> 
>     $ git-file-revs Makefile
>     f7eb55....... aaaaaa.......
>     f7eb55....... bbbbbb.......
>     aaaaaa....... dddddd.......
> 
> which shows commit f7eb55... changed it relative to both of its
> parents aaaaaa... and bbbbbb...

Note that I could be just thinking about this all wrong, so my
terminology could be in left field.  Here, I'm mostly just interested in
the case where "Hey, something broke with drivers/char/i8k.c.  When was
this changed?  Who changed what?"

Thanks,

Frank
- --
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCe5+yaI0dwg4A47wRAhIwAKD7R/D3ZU7JZz0mytEO04u04OTVZwCbBFhG
sEYSTYiLLIMuLxU+r1mNuGw=
=Mcg2
-----END PGP SIGNATURE-----
