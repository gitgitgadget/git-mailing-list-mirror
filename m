From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: Re: [PATCH 2/3] fsck_commit: remove duplicate tests
Date: Mon, 4 Feb 2008 08:06:00 +0100
Message-ID: <20080204070600.GA30099@auto.tuwien.ac.at>
References: <12020737593747-git-send-email-mkoegler@auto.tuwien.ac.at> <12020737601683-git-send-email-mkoegler@auto.tuwien.ac.at> <7v3as9r3r2.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0802040003360.7372@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 04 08:06:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLvPY-0002ZV-Ob
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 08:06:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752514AbYBDHGE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Feb 2008 02:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752213AbYBDHGD
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 02:06:03 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:55080 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751439AbYBDHGB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 02:06:01 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 410D2680BF62;
	Mon,  4 Feb 2008 08:06:00 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wSFoX9R1aH-w; Mon,  4 Feb 2008 08:06:00 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 1BAE868018DC; Mon,  4 Feb 2008 08:06:00 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0802040003360.7372@racer.site>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72466>

On Mon, Feb 04, 2008 at 12:04:31AM +0000, Johannes Schindelin wrote:
> On Sun, 3 Feb 2008, Junio C Hamano wrote:
> > Martin Koegler <mkoegler@auto.tuwien.ac.at> writes:
> >=20
> > > All tests on the commit buffer in fsck_cmd are ready done by=20
> > > parse_commit_buffer.
> > >
> > > This patch rips out all redundant tests.
> >=20
> > As I believe in belt-and-suspenders when it comes to validation, I =
am=20
> > somewhat uneasy with this change.
>=20
> Besides, should we really change fsck?  It's not _that_ much of a=20
> performance-critical operation.  Accuracy is much more important.
>=20
> fsck is the reason I trust git with my data.

Then please drop this patch. I hope the other two patches are OK.

mfg Martin K=F6gler
