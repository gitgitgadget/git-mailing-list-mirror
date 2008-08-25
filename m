From: Tommi Virtanen <tv@eagain.net>
Subject: Re: pre-commit hook, non-zero exit status and dangling objects
Date: Mon, 25 Aug 2008 16:35:27 +0300
Message-ID: <20080825133527.GD14930@eagain.net>
References: <48B13EB0.8050704@school9.perm.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?0KHQtdGA0LPQtdC5INCo0LDRgNGL0LHQuNC9?= 
	<nazgul@school9.perm.ru>
X-From: git-owner@vger.kernel.org Mon Aug 25 15:36:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXcFO-0005nu-26
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 15:36:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754425AbYHYNfa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Aug 2008 09:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754604AbYHYNfa
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 09:35:30 -0400
Received: from eagain.net ([208.78.102.120]:46781 "EHLO eagain.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754425AbYHYNfa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 09:35:30 -0400
Received: from musti.eagain.net (a91-156-122-108.elisa-laajakaista.fi [91.156.122.108])
	by eagain.net (Postfix) with ESMTPS id 8C7601EC039;
	Mon, 25 Aug 2008 13:35:29 +0000 (UTC)
Received: by musti.eagain.net (Postfix, from userid 1000)
	id 18764508032; Mon, 25 Aug 2008 16:35:27 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <48B13EB0.8050704@school9.perm.ru>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93622>

On Sun, Aug 24, 2008 at 04:57:52PM +0600, =D0=A1=D0=B5=D1=80=D0=B3=D0=B5=
=D0=B9 =D0=A8=D0=B0=D1=80=D1=8B=D0=B1=D0=B8=D0=BD wrote:
> After pre-commit returned non-zero status, I could see new dangling =20
> objects in my repo. I think it's not normal, because pre-commit is of=
ten =20
> used for checking formation of source files and after changing this =20
> files, hash of object will be also changed and even after successfull=
 =20
> commit dangling object will be still alive.

You also get dangling objects by running git add. There's no harm in
them, they will be cleaned up automatically.

--=20
:(){ :|:&};:
