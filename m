From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v4 10/45] sequencer: trivial fix
Date: Sun, 9 Jun 2013 18:37:39 +0100
Message-ID: <20130609173739.GF22905@serenity.lan>
References: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
 <1370796057-25312-11-git-send-email-felipe.contreras@gmail.com>
 <20130609171810.GA10858@goldbirke>
 <CAMP44s3yhVbgkhtrSfHpk=VwcwMkb66ELA-xR0i6FCVGyRwHJw@mail.gmail.com>
 <20130609173342.GB2091@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sun Jun 09 19:38:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UljZ1-0001dp-Ot
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 19:38:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751476Ab3FIRhz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 13:37:55 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:60456 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751429Ab3FIRhy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 13:37:54 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 4DF02CDA5B8;
	Sun,  9 Jun 2013 18:37:54 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.899
X-Spam-Level: 
X-Spam-Status: No, score=-12.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5gDQQtue2cLH; Sun,  9 Jun 2013 18:37:53 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id 24CE8CDA5E7;
	Sun,  9 Jun 2013 18:37:53 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 13CB7161E454;
	Sun,  9 Jun 2013 18:37:53 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9GQ3PSCUbq2O; Sun,  9 Jun 2013 18:37:52 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id D97EF161E418;
	Sun,  9 Jun 2013 18:37:41 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <20130609173342.GB2091@goldbirke>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227044>

On Sun, Jun 09, 2013 at 07:33:42PM +0200, SZEDER G=E1bor wrote:
> On Sun, Jun 09, 2013 at 12:23:01PM -0500, Felipe Contreras wrote:
> > On Sun, Jun 9, 2013 at 12:18 PM, SZEDER G=E1bor <szeder@ira.uka.de>=
 wrote:
> > > On Sun, Jun 09, 2013 at 11:40:22AM -0500, Felipe Contreras wrote:
> > >> We should free objects before leaving.
> > >>
> > >> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> > >
> > > A shortlog-friendlier subject could be: "sequencer: free objects
> > > before leaving".
> >=20
> > I already defended my rationale for this succinct commit message:
> >=20
> > http://thread.gmane.org/gmane.comp.version-control.git/225609/focus=
=3D225610
>=20
> Your arguments were unconvincing.  The mere fact that I raised this
> issue unbeknownst to the earlier posting clearly shows that there's
> demand for descriptive subjects.

Not to mention that with your subject no body is needed, making the
overall message more succinct.

When reading a log, as soon as I see "trivial" I become suspicious that
someone is trying to cover something up, much like "left as an exercise
for the reader".  If the subject says "fix memory leak" then it's
obvious what the patch is meant to do, and when there is no subtlety to
be explained (as there isn't in this patch) there is no need for a body=
=2E
