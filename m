From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: man pages are littered with .ft C and others
Date: Tue, 5 Feb 2008 01:00:48 +0100
Message-ID: <20080205000048.GA28020@diku.dk>
References: <alpine.DEB.1.00.0802021055180.21831@an.sumeria> <200802031139.48752.jnareb@gmail.com> <20080204220120.GA23798@diku.dk> <200802050026.22262.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Adam Flott <adam@npjh.com>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 01:01:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMBFo-0007oX-Uq
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 01:01:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755822AbYBEAA4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 19:00:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755988AbYBEAAz
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 19:00:55 -0500
Received: from mgw2.diku.dk ([130.225.96.92]:49902 "EHLO mgw2.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755619AbYBEAAz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 19:00:55 -0500
Received: from localhost (localhost [127.0.0.1])
	by mgw2.diku.dk (Postfix) with ESMTP id 91DB519BB54;
	Tue,  5 Feb 2008 01:00:53 +0100 (CET)
Received: from mgw2.diku.dk ([127.0.0.1])
 by localhost (mgw2.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 26613-11; Tue,  5 Feb 2008 01:00:50 +0100 (CET)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw2.diku.dk (Postfix) with ESMTP id F2EB619BB4D;
	Tue,  5 Feb 2008 01:00:48 +0100 (CET)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP
	id A5C986DFAB0; Tue,  5 Feb 2008 00:59:22 +0100 (CET)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id D86A45B8001; Tue,  5 Feb 2008 01:00:48 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <200802050026.22262.jnareb@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72592>

Jakub Narebski <jnareb@gmail.com> wrote Tue, Feb 05, 2008:
> On Mon, 4 Feb 2008, Jonas Fonseca wrote:
> > Jakub Narebski <jnareb@gmail.com> wrote Sun, Feb 03, 2008:
> > > Junio C Hamano wrote:
> > > > Jakub Narebski <jnareb@gmail.com> writes:
> > > >
> > > > [From] http://thread.gmane.org/gmane.comp.version-control.git/53457/focus=53458
> > > Julian Phillips:
> > > > Are you using docbook xsl 1.72?  There are known problems building the 
> > > > manpages with that version.  1.71 works, and 1.73 should work when it get 
> > > > released.
> > 
> > I was able to solve this problem with this patch, which adds a XSL file
> > used specifically for DOCBOOK_XSL_172=YesPlease and where dots and
> > backslashes are escaped properly so they won't be substituted to the
> > wrong thing further down the "DocBook XSL pipeline". Doing the escaping
> > in the existing callout.xsl breaks v1.70.1. Hopefully v1.73 will end
> > this part of the manpage nightmare.
> 
> I have applied this patch, and it makes manpages worse, not better.
> I use DocBook XSL version 1.68.1

OK, I might have been a bit unclear, but the patch was not intended for
you but for users of version 1.72+. ;)

> P.S. writing subset of AsciiDoc in Perl, which would write manpages, HTML
> and perhaps info/texinfo files directly, without fragile xmlto toolchain,
> looks better and better...

But not as easy as just pulling the documentation branches.

-- 
Jonas Fonseca
