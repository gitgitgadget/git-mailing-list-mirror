From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Performance issue: initial git clone causes massive repack
Date: Mon, 6 Apr 2009 01:28:41 +0200
Message-ID: <200904060128.42095.robin.rosenberg.lists@dewire.com>
References: <20090404220743.GA869@curie-int> <20090405225954.GA18730@vidovic> <alpine.DEB.1.10.0904051613420.6245@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Sebrecht <nicolas.s-dev@laposte.net>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>
To: david@lang.hm
X-From: git-owner@vger.kernel.org Mon Apr 06 01:30:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqbnL-0005Jb-5n
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 01:30:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752937AbZDEX2z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Apr 2009 19:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752586AbZDEX2z
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 19:28:55 -0400
Received: from mail.dewire.com ([83.140.172.130]:25879 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751416AbZDEX2z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Apr 2009 19:28:55 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 576621483A0B;
	Mon,  6 Apr 2009 01:28:52 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FGT1EXuFf49Y; Mon,  6 Apr 2009 01:28:44 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id CFC3413913F4;
	Mon,  6 Apr 2009 01:28:42 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.27-14-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <alpine.DEB.1.10.0904051613420.6245@asgard.lang.hm>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115738>

m=E5ndag 06 april 2009 01:20:07 skrev david@lang.hm:
> >> the problem here is a real one, if you have a large repo, git send=
-pack
> >> will always generate a new pack, even if it doesn't need to (with =
the
> >> extreme case being the the repo is fully packed)
> >
> > What about the rsync solution given in this thread?
>=20
> that may be a work-around for a situation where git just doesn't work=
, but=20
> how do they prevent users from killing their server by trying to do a=
=20
> normal git clone?

Is there no way of telling git not work so hard on packing?=20

If not, you could try JGit and compare. It's still too stupid to pack m=
uch, so it shouldn't spend much CPU time (for that reason at least). I =
haven't tried JGit's deamon for large amounts of data yet.

-- robin
