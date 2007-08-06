From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH v2] user-manual: mention git gui citool (commit, amend)
Date: Mon, 6 Aug 2007 21:36:49 +0200
Message-ID: <200708062136.50462.robin.rosenberg.lists@dewire.com>
References: <20070803125634.GB28323@fieldses.org> <Pine.LNX.4.64.0708060124120.14781@racer.site> <20070806035119.GB30269@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Steffen Prohaska <prohaska@zib.de>, gitster@pobox.com,
	git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Mon Aug 06 21:39:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1II8Ml-00024y-PY
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 21:35:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757725AbXHFTfl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 6 Aug 2007 15:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758219AbXHFTfl
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 15:35:41 -0400
Received: from [83.140.172.130] ([83.140.172.130]:27999 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1757723AbXHFTfk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 15:35:40 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 7565B802880;
	Mon,  6 Aug 2007 21:28:11 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 03710-10; Mon,  6 Aug 2007 21:28:11 +0200 (CEST)
Received: from [10.9.0.4] (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 2C8AC800199;
	Mon,  6 Aug 2007 21:28:11 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <20070806035119.GB30269@fieldses.org>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

m=E5ndag 06 augusti 2007 skrev J. Bruce Fields:
> On Mon, Aug 06, 2007 at 01:26:21AM +0100, Johannes Schindelin wrote:
> > On Sun, 5 Aug 2007, J. Bruce Fields wrote:
> > > A big warning would be out of place in what is for now just an is=
olated
> > > sentence in two different places.  But I agree with you that this=
 would
> > > be worth mentioning in any eventual full-fledged git-gui tutorial=
=2E
> >=20
> > Unfortunately, I am really wasted by this weekend's efforts to brin=
g=20
> > msysgit.git along... could you be so kind as to cut&paste the relev=
ant=20
> > section in a reply to me, so I do not have to search for myself?
>=20
> Sure; appended.  This isn't that different from Steffen's proposal.
>=20
> > I would not normally ask for such a favour; it is relatively easy t=
o go on=20
> > a search with Git, but I do have only 8 hours of sleep in the last =
60=20
> > hours under my saddle...
>=20
> Hm.  On the other hand, maybe we should just be refusing to feed your
> addiction till you get some sleep.
>=20
> I wanna keep this short for now, so if we really think we shouldn't
> mention of the hunk-selection thing without a warning, I'd rather jus=
t
> omit mention of it, and go for something like: "You can also use
> gitlink:git-gui[1] to create commits and view changes in the index an=
d
> working tree", and drop the second hunk.  Whatever.

Who reads manuals for GUI's? Rougly nobody, unless the user needs the g=
ui=20
badly AND the GUI sucks badly. Manuals for GUI's are mostly tick-in-the=
-box=20
documentation (which is the probably reason most GUI documentation suck=
 too).

Uncommon/dangerous features should generally be harder to find, but can=
 you=20
can also use the common pattern of popping a dialog explaining the dang=
ers=20
and forcing the user to click away the box. Of course there should be a=
=20
checkbox in the dialog "[X] Void warranty and don't bother me with this=
=20
question anymore."

Nevertheless the dangers should be explained somewhere, maybe in the gi=
t user=20
manual. I believe most people will learn from experience.

-- robin
