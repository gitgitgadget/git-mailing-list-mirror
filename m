From: Paul Mackerras <paulus@samba.org>
Subject: Re: More gitweb queries..
Date: Tue, 31 May 2005 09:03:06 +1000
Message-ID: <17051.39850.556062.543875@cargo.ozlabs.ibm.com>
References: <Pine.LNX.4.58.0505271145570.17402@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kay Sievers <kay.sievers@vrfy.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 31 01:03:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DctH4-000173-1g
	for gcvg-git@gmane.org; Tue, 31 May 2005 01:02:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261817AbVE3XDr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 30 May 2005 19:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261811AbVE3XDr
	(ORCPT <rfc822;git-outgoing>); Mon, 30 May 2005 19:03:47 -0400
Received: from ozlabs.org ([203.10.76.45]:48768 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261809AbVE3XDS convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2005 19:03:18 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 000A9679F9; Tue, 31 May 2005 09:03:11 +1000 (EST)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505271145570.17402@ppc970.osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds writes:

>   On that small note, I also find "gitk" very cool indeed, too bad ab=
out=20
>   the fact that tk/tcl seems to always end up looking so _ugly_. Is t=
here=20
>   any way to get anti-aliased fonts and a less 'Motify' blocky look f=
rom=20
>   tcl/tk? Every time I see that, I feel like I'm back in the last cen=
tury =20
>   or something.

Tcl/Tk 8.5 will have anti-aliased fonts (8.5a2 is available on
sourceforge).  There is apparently some support for widget styling in
8.4 which I will have to look into.  The Motif look doesn't bother me,
but it does seem to bother you and Ben H. :)

>   Combining some of the features of the two (that =FCber-cool revisio=
n=20
>   history graph from gitk rules, for example) might be cool. I get th=
e=20
>   urge to do octopus-merges in the kernel just because of how good th=
ey
>   look in gitk ;) ]

Yes, it's nice that a relatively simple algorithm without much
lookahead produces reasonable results.

Paul.
