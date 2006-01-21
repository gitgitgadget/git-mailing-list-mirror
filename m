From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: Re: Remove "historical" objects from repository to save place
Date: Sun, 22 Jan 2006 00:46:32 +0300
Message-ID: <200601220046.34151.arvidjaar@mail.ru>
References: <200601212218.51055.arvidjaar@mail.ru> <7v1wz1mjy8.fsf@assigned-by-dhcp.cox.net>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 21 22:47:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0QZQ-00053K-0O
	for gcvg-git@gmane.org; Sat, 21 Jan 2006 22:46:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932394AbWAUVqt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jan 2006 16:46:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbWAUVqt
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jan 2006 16:46:49 -0500
Received: from mx1.mail.ru ([194.67.23.121]:5503 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id S932392AbWAUVqt (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Jan 2006 16:46:49 -0500
Received: from [83.237.195.229] (port=51124 helo=cooker.home.net)
	by mx1.mail.ru with asmtp 
	id 1F0QZB-0009Ff-00; Sun, 22 Jan 2006 00:46:37 +0300
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9.1
In-Reply-To: <7v1wz1mjy8.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15024>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Saturday 21 January 2006 22:58, Junio C Hamano wrote:
>
> You might be able to cauterize the history at a specific commit
> and then re-clone.  I've talked about how in "[QUESTION] about
> ..git/info/grafts file" thread yesterday, so I won't repeat that.

thank you, quite complete description. One question - any caveats in using git 
ls-remote to fetch graft point?

echo $(git ls-remote 
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git v2.6.15 
| cut -f1) > .git/info/grafts

etc

this avoids downloading over 1G in the first place.

regards

- -andrey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD0qu6R6LMutpd94wRAtuzAJoCT15+8d9BcIEhOxmD9lrRGWE6EQCghg5l
SR5g1+nAUNlltYyXydxsFAs=
=U2cu
-----END PGP SIGNATURE-----
