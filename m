From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH 1/4] Introduce commit notes
Date: Sat, 20 Dec 2008 08:55:14 +0100
Message-ID: <200812200855.14915.robin.rosenberg.lists@dewire.com>
References: <5d46db230812160015t55b4ff2fubbf1e2f826a97b98@mail.gmail.com> <alpine.DEB.1.00.0812200034450.30769@pacific.mpi-cbg.de> <20081220065337.GA2581@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Govind Salinas <govind@sophiasuchtig.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 20 08:56:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDwhd-0005xr-6D
	for gcvg-git-2@gmane.org; Sat, 20 Dec 2008 08:56:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753825AbYLTHzb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Dec 2008 02:55:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753449AbYLTHzb
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Dec 2008 02:55:31 -0500
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:52762 "EHLO
	pne-smtpout1-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753825AbYLTHza convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Dec 2008 02:55:30 -0500
Received: from sleipner.localnet (213.67.100.250) by pne-smtpout1-sn1.fre.skanova.net (7.3.129)
        id 47A979500540F960; Sat, 20 Dec 2008 08:55:21 +0100
User-Agent: KMail/1.10.3 (Linux/2.6.27-10-generic; KDE/4.1.3; i686; ; )
In-Reply-To: <20081220065337.GA2581@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103629>

l=C3=B6rdag 20 december 2008 07:53:38 skrev Jeff King:
> On Sat, Dec 20, 2008 at 12:35:06AM +0100, Johannes Schindelin wrote:
>=20
> > Commit notes are blobs which are shown together with the commit
> > message.  These blobs are taken from the notes ref, which you can
> > configure by the config variable core.notesRef, which in turn can
> > be overridden by the environment variable GIT_NOTES_REF.
>=20
> Hmm. I wanted to try some performance comparisons based on this
> implementation, but I can't get your 1/4 to apply. Conflicts in
> config.txt and cache.h when applying to master, and "sha1 information=
 is
> lacking or useless" for a 3-way merge. What did you base this on?

patch(1) however can crunch it, with the exception of cache.h. Shouldn'=
t
git am/appy and patch agree on git generated patches (without binary di=
ffs)?

-- robin
