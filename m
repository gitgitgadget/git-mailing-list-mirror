From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: Re: Remove "historical" objects from repository to save place
Date: Sun, 22 Jan 2006 02:27:50 +0300
Message-ID: <200601220227.56367.arvidjaar@mail.ru>
References: <200601212218.51055.arvidjaar@mail.ru> <7v1wz1mjy8.fsf@assigned-by-dhcp.cox.net> <20060121200615.GM28365@pasky.or.cz>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 22 00:28:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0S9X-0004pJ-7p
	for gcvg-git@gmane.org; Sun, 22 Jan 2006 00:28:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbWAUX2L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jan 2006 18:28:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbWAUX2L
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jan 2006 18:28:11 -0500
Received: from mx2.mail.ru ([194.67.23.122]:6156 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S1751223AbWAUX2K (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Jan 2006 18:28:10 -0500
Received: from [83.237.195.229] (port=43916 helo=cooker.home.net)
	by mx2.mail.ru with asmtp 
	id 1F0S9R-000KW2-00; Sun, 22 Jan 2006 02:28:09 +0300
To: Petr Baudis <pasky@suse.cz>
User-Agent: KMail/1.9.1
In-Reply-To: <20060121200615.GM28365@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15027>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Saturday 21 January 2006 23:06, Petr Baudis wrote:
> Dear diary, on Sat, Jan 21, 2006 at 08:58:55PM CET, I got a letter
> where Junio C Hamano <junkio@cox.net> said that...
>
> > You might be able to cauterize the history at a specific commit
> > and then re-clone.  I've talked about how in "[QUESTION] about
> > .git/info/grafts file" thread yesterday, so I won't repeat that.
>
> Shouldn't the git-prune be sufficient after cauterizing the history?

this did not work for me, at least applied naively. May be, it is due to the 
way I setup repository - first I created local version from 2.6.15 tree and 
then pulled in remote one.

Anyway repacking and pruning resulted in over 500MB size reduction so its OK 
for me so far. I'll probably try fetching cleanly later.

thank you and best regards

- -andrey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD0sN8R6LMutpd94wRAt1WAKC18LjAl+MbyfmvSvvNQGUF/mlbIgCfcu6s
nuZtYttRsd673Yqlq3aKr+A=
=B6jN
-----END PGP SIGNATURE-----
