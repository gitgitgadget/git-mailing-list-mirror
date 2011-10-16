From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH 2/6] git-p4: handle utf16 filetype properly
Date: Sun, 16 Oct 2011 11:22:47 -0400
Message-ID: <20111016152247.GA22954@arf.padd.com>
References: <20111016144215.GC22144@arf.padd.com>
 <20111016144435.GE22144@arf.padd.com>
 <201110161659.22261.stefano.lattarini@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Luke Diamand <luke@diamand.org>, Chris Li <git@chrisli.org>
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 16 17:23:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFSYU-0003S6-8L
	for gcvg-git-2@lo.gmane.org; Sun, 16 Oct 2011 17:23:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754594Ab1JPPXF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Oct 2011 11:23:05 -0400
Received: from honk.padd.com ([74.3.171.149]:59448 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754536Ab1JPPXE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Oct 2011 11:23:04 -0400
Received: from arf.padd.com (unknown [50.55.131.180])
	by honk.padd.com (Postfix) with ESMTPSA id 754CB1FEA;
	Sun, 16 Oct 2011 08:23:02 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 834FF313B8; Sun, 16 Oct 2011 11:22:47 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <201110161659.22261.stefano.lattarini@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183724>

stefano.lattarini@gmail.com wrote on Sun, 16 Oct 2011 16:59 +0200:
> Hi Pete, and thanks for taking my previous remarks into account.  I have
> one more nit/question though ...
> 
> On Sunday 16 October 2011, Pete Wyckoff wrote:
> > diff --git a/t/t9802-git-p4-filetype.sh b/t/t9802-git-p4-filetype.sh
> > new file mode 100755
> > index 0000000..dff0e02
> > --- /dev/null
> > +++ b/t/t9802-git-p4-filetype.sh
> > @@ -0,0 +1,108 @@
> > +#!/bin/sh
> > +
> > + [SNIP]
> > +
> > +		printf "three\nline\ntext" >f-ascii &&
> >
> With this command, the `f-ascii' file won't be newline-terminated.  Is
> this intended, or the result of an oversight?  The same goes for further
> similar usages in the rest f the patch.

That is harmless.  I think an earlier version used to count the
lines, but now it is just random text.  Ditto the other places.
A trailing \n might be prettier, though, for some future debugging
of the tests.  I tested that both with and without \n pass.

		-- Pete
