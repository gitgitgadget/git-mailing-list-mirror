From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [RFC/PATCH] Implement git-cp.
Date: Sun, 10 Feb 2008 14:29:04 +0100
Message-ID: <200802101429.04765.robin.rosenberg.lists@dewire.com>
References: <38b2ab8a0802031023y2ed7a5aax6d3c404b08757a4d@mail.gmail.com> <alpine.LSU.1.00.0802100125510.11591@racer.site> <7vzlu9uu7c.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Francis Moreau <francis.moro@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 14:29:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOCFd-0007aP-3S
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 14:29:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750865AbYBJN3N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Feb 2008 08:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750852AbYBJN3N
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 08:29:13 -0500
Received: from [83.140.172.130] ([83.140.172.130]:12490 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1750781AbYBJN3I (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 08:29:08 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 04B978006AB;
	Sun, 10 Feb 2008 14:29:07 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1FSk5ldHZKsF; Sun, 10 Feb 2008 14:29:06 +0100 (CET)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 6550C800686;
	Sun, 10 Feb 2008 14:29:06 +0100 (CET)
User-Agent: KMail/1.9.6 (enterprise 0.20071123.740460)
In-Reply-To: <7vzlu9uu7c.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73353>

s=F6ndagen den 10 februari 2008 skrev Junio C Hamano:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>=20
> > If you touch builtin-mv.c already, why not just move cmd_cp() in th=
ere? =20
> > It's not like it would be the first cmd_*() function living in the =
same=20
> > file as other cmd_*() functions.
>=20
> Why do we even want "git-cp", especially when git-mv and git-rm
> are already pretty much redundant commands?
>=20
> Especially, why do we even encourage copy-and-paste?

We do not. I've seen too much damage being done through copy/paste. A
much better (safer) way to copy code is to re-type it. I've asked more
than once, when asked to help debug a piece of code: "Did you copy this=
=20
code?".

=46or this reason I have a vision of a "plugin" for Eclipse that disabl=
es paste
if the clipboard contains copied code. Cut and paste would be ok.

-- robin
