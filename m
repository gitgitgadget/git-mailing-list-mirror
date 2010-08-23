From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [RFC/PATCH 00/17] unexpected backslashes in man pages
Date: Mon, 23 Aug 2010 13:51:01 +0200
Message-ID: <201008231351.01826.trast@student.ethz.ch>
References: <20100820101902.GA10356@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>, Ramkumar Ramachandra <artagnon@gmail.com>,
	=?iso-8859-1?q?Fr=E9d=E9ric_Bri=E8re?= <fbriere@fbriere.net>,
	Christian Couder <chriscool@tuxfamily.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 23 13:51:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnVYV-0006Xw-5w
	for gcvg-git-2@lo.gmane.org; Mon, 23 Aug 2010 13:51:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752204Ab0HWLvF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Aug 2010 07:51:05 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:32149 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751453Ab0HWLvE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Aug 2010 07:51:04 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Mon, 23 Aug
 2010 13:51:01 +0200
Received: from thomas.site (129.132.246.171) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.0.702.0; Mon, 23 Aug
 2010 13:51:02 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.34-12-desktop; KDE/4.4.4; x86_64; ; )
In-Reply-To: <20100820101902.GA10356@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154218>

Jonathan Nieder wrote:
> This series is longer than I would like, and I am not happy to
> impose the review burden.  So if something does not look obviously
> correct at a glance, please let me know and I'll try to simplify it.
>=20
> The topic: as Fr=E9d=E9ric Bri=E8re noticed in
> <http://bugs.debian.org/540001>, various man pages have collected
> backslashes where they don't belong.

Apart from 13/17 which I was too lazy to fix manually, I have looked
through all the results.  The patches fix a lot of stray backslashes,
exactly as claimed.  For the record, this is on asciidoc 8.4.5 with
ASCIIDOC8=3D1 ASCIIDOC_NO_ROFF=3D1 GNU_ROFF=3D1.

I did some random checking on a box with asciidoc 8.2.7, which is the
oldest that I have at hand.  It seems to fix the issues there, too; in
any case I didn't find any of the regressions that I wanted to check
for.

So,

  Acked-by: Thomas Rast <trast@student.ethz.ch>

for the series.

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
