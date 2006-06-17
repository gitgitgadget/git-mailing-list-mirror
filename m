From: Dennis Stosberg <dennis@stosberg.net>
Subject: Re: git-1.4.0 make problems
Date: Sat, 17 Jun 2006 15:09:58 +0200
Message-ID: <20060617130957.G199de590@leonov.stosberg.net>
References: <200606171016.k5HAGQ1D005560@grail.cba.csuohio.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: rene.scharfe@lsrfire.ath.cx, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 17 15:10:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FraZ4-00005b-AD
	for gcvg-git@gmane.org; Sat, 17 Jun 2006 15:10:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751513AbWFQNKE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Jun 2006 09:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751615AbWFQNKE
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jun 2006 09:10:04 -0400
Received: from ncs.stosberg.net ([89.110.145.104]:38083 "EHLO ncs.stosberg.net")
	by vger.kernel.org with ESMTP id S1751513AbWFQNKC (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Jun 2006 09:10:02 -0400
Received: from leonov.stosberg.net (p213.54.79.58.tisdip.tiscali.de [213.54.79.58])
	by ncs.stosberg.net (Postfix) with ESMTP id 49AC5AEBA005;
	Sat, 17 Jun 2006 15:09:54 +0200 (CEST)
Received: by leonov.stosberg.net (Postfix, from userid 500)
	id 9871A10C677; Sat, 17 Jun 2006 15:09:58 +0200 (CEST)
To: Michael Somos <somos@grail.cba.csuohio.edu>
Content-Disposition: inline
In-Reply-To: <200606171016.k5HAGQ1D005560@grail.cba.csuohio.edu>
OpenPGP: id=1B2F2863BA13A814C3B133DACC2811F494951CAB; url=http://stosberg.net/dennis.asc
User-Agent: mutt-ng/devel-r802 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22014>

Michael Somos wrote:

> A good suggestion, but I am a newbie as you can tell, and would prefer to
> play in a sandbox for some time before I would attempt it. Of more concern
> to me now is a failed test :
> 
> > * FAIL 12: apply diff between 3 and 2
> >        git-apply <diff.3-2 && diff frotz.2 frotz
> > * failed 2 among 12 test(s)
> > make[1]: *** [t4101-apply-nonl.sh] Error 1

I have seen this test failing on FreeBSD 5.3, too.  FreeBSD comes with a
version of "diff" which does not add the "\ No newline at end of file"
remark.  Maybe your "diff" is simply too old.  In that case, it's not a
serious problem because Git uses its own internal diff implementation.

The intention of this test is to test git-apply and not the system's
"diff", so perhaps it should bring along all its patches and not rely
on the system's "diff" to generate them...

Regards,
Dennis
