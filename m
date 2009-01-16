From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [RFC PATCH] Make the rebase edit mode really end up in an edit
	state
Date: Fri, 16 Jan 2009 13:42:39 +0100
Message-ID: <20090116124239.GA28870@neumann>
References: <87ab9th0rh.fsf@cup.kalibalik.dk>
	<200901161050.13971.johan@herland.net>
	<49548.bFoQE3daRhY=.1232101666.squirrel@webmail.hotelhot.dk>
	<200901161158.06828.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Anders Melchiorsen <mail@cup.kalibalik.dk>, git@vger.kernel.org,
	Jay Soffian <jaysoffian@gmail.com>,
	Wincent Colaiuta <win@wincent.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Jan 16 13:44:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNo3U-00053b-GZ
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 13:44:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756998AbZAPMmo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Jan 2009 07:42:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756803AbZAPMmo
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 07:42:44 -0500
Received: from francis.fzi.de ([141.21.7.5]:30174 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756451AbZAPMmo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2009 07:42:44 -0500
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 16 Jan 2009 13:42:39 +0100
Content-Disposition: inline
In-Reply-To: <200901161158.06828.johan@herland.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-OriginalArrivalTime: 16 Jan 2009 12:42:39.0300 (UTC) FILETIME=[EA849040:01C977D7]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105948>

On Fri, Jan 16, 2009 at 11:58:06AM +0100, Johan Herland wrote:
> On Friday 16 January 2009, Anders Melchiorsen wrote:
> > Johan Herland wrote:
> > > 	amend e8902c1 Foo
> > >
> > > does a "pick" followed by "commit --amend" (for editing the commi=
t
> > > message), followed by "rebase --continue".
> >
> > I do not think that "amend" is the best word for editing only the
> > commit message. A "commit --amend" can also make a new tree, so
> > reusing the word with a different meaning could be bad.
> >
> > As for alternatives, however, I can only come up with "copyedit", a=
nd
> > that is so horrible that I will not even propose it :-)
>=20
> "rephrase"?

This is the first one that I found acceptable.

'amend', 'modify' and 'edit' are just too close and non-intuitive:
they don't indicate _what_ will be amended, modified or edited at all.

'rephrase', on the other hand, is better, as you can rephrase a commit
message, but it's weird to say "rephrase the patch".  But it's still
not as to-the-point as 'editmsg' (but that one has conflicting
abbreviation).

Best,
G=E1bor
