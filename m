From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: OS X and umlauts in file names
Date: Mon, 23 Nov 2009 18:45:00 +0100
Message-ID: <200911231845.04325.trast@student.ethz.ch>
References: <4B0ABA42.1060103@syntevo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: Thomas Singer <thomas.singer@syntevo.com>
X-From: git-owner@vger.kernel.org Mon Nov 23 18:46:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCczD-0004nY-SU
	for gcvg-git-2@lo.gmane.org; Mon, 23 Nov 2009 18:46:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754030AbZKWRpE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Nov 2009 12:45:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754076AbZKWRpD
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Nov 2009 12:45:03 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:27901 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753818AbZKWRpC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Nov 2009 12:45:02 -0500
Received: from CAS02.d.ethz.ch (129.132.178.236) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.176.0; Mon, 23 Nov
 2009 18:45:09 +0100
Received: from thomas.localnet (84.74.103.245) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Mon, 23 Nov
 2009 18:45:06 +0100
User-Agent: KMail/1.12.90 (Linux/2.6.31.5-0.1-desktop; KDE/4.3.75; x86_64; ; )
In-Reply-To: <4B0ABA42.1060103@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133515>

Thomas Singer wrote:
> I'm on an English OS X 10.6.2 and I created a sample file with umlaut=
s in
> its name (=DCberl=E4nge.txt). When I try to stage the file in the ter=
minal, I
> can't complete the file name by typing the =DC and hitting the tab ke=
y, but I
> can complete it by typing an U and hitting the tab key. Unfortunately=
, after
> executing
>=20
>  git stage =DCberl=E4nge.txt

This is because of OS X's unicode normalisation.  Try any of the
many threads on the topic, e.g.,

  http://thread.gmane.org/gmane.comp.version-control.git/70688

The short version is that this =DC is in fact decomposed into an
U-umlaut duo.

Considering that this leads to endless fun[*] not just with git, and
that we German speakers have an easy way out (Ueberlaenge), I can only
suggest that you avoid umlauts wherever possible to preserve
the sanity of your users.


[*] I once had an SVN repo with two different directories both called
=DCbungen.  Took me a while to figure out what was going on.

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
