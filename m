From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: Gitk feature - show nearby tags
Date: Mon, 5 Jun 2006 02:04:23 +0200
Message-ID: <20060605000423.GA29521@diku.dk>
References: <17537.22675.678700.118093@cargo.ozlabs.ibm.com> <7vslmm8rcd.fsf@assigned-by-dhcp.cox.net> <20060603151240.GA4024@diku.dk> <7vejy48wp5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 05 02:04:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fn2a6-0007aF-1o
	for gcvg-git@gmane.org; Mon, 05 Jun 2006 02:04:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932343AbWFEAE1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 4 Jun 2006 20:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932344AbWFEAE1
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jun 2006 20:04:27 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:24965 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S932343AbWFEAE1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Jun 2006 20:04:27 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id CA218770018;
	Mon,  5 Jun 2006 02:04:25 +0200 (CEST)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 28690-11; Mon,  5 Jun 2006 02:04:24 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 444D3770014;
	Mon,  5 Jun 2006 02:04:24 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 255D16DF88D; Mon,  5 Jun 2006 02:01:07 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 12881625E6; Mon,  5 Jun 2006 02:04:24 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vejy48wp5.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21298>

Junio C Hamano <junkio@cox.net> wrote Sun, Jun 04, 2006:
>=20
> I may not be using tig in the way it was intended to, but I
> often find it frustrating having to do the following:
>=20
>     - start tig, which shows list of one-line logs.  Wonderful.
>=20
>     - browsing around by UP or DOWN and stop at one particular commit
>       I want to view closely.  Press Enter and the screen split
>       into two and I see what I want to see.  Again, wonderful.
>=20
>     - I want to see the neighbouring commits, but UP or DOWN
>       does not do what I na=EFvely expect.  It scrolls the lower
>       pane.  I say TAB to go up.

I wonder what tig version you are using. If you are using the tig
version from my git repo this should also be working to your
expectation, making ...

>     - Press UP or DOWN and I can move the highlight to
>       neighbouring commits.  This is wonderful, but the lower
>       pane does not follow this -- it keeps showing the original
>       commit, and I have to say ENTER again.

=2E. this unnecessary. At least, I'd like to keep the one-line log view
from forcing updates of the diff view so it is more responsive over slo=
w
links.

> It might make sense to make the log/diff view follow what
> happens on the main view when both are on-screen.

With my current version, the two views are much more integrated, e.g.
you can press 'd' to show full-screen diff view and use Up and Down to
navigate the log view.

--=20
Jonas Fonseca
