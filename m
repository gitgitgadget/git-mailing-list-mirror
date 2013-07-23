From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH 2/5] t4211: demonstrate empty -L range crash
Date: Tue, 23 Jul 2013 21:59:02 +0200
Message-ID: <20130723195902.GQ18565@goldbirke>
References: <1374589688-27751-1-git-send-email-sunshine@sunshineco.com>
 <1374589688-27751-3-git-send-email-sunshine@sunshineco.com>
 <20130723175942.GA21019@goldbirke>
 <7vvc416qvq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
	Thomas Rast <trast@inf.ethz.ch>,
	Bo Yang <struggleyb.nku@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 23 21:59:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1ijo-0007dL-0L
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jul 2013 21:59:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933734Ab3GWT7H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Jul 2013 15:59:07 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:60994 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933353Ab3GWT7G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jul 2013 15:59:06 -0400
Received: from localhost6.localdomain6 (g227083251.adsl.alicedsl.de [92.227.83.251])
	by mrelayeu.kundenserver.de (node=mrbap2) with ESMTP (Nemesis)
	id 0M2GKi-1U9cbz1vSW-00sLHt; Tue, 23 Jul 2013 21:59:03 +0200
Content-Disposition: inline
In-Reply-To: <7vvc416qvq.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:/I56mey7JooETBS/dmlOJAMY7uO8+kWNjwouqnO0Sry
 bHjCrEcTxIOhjV9E1+hNl58uEvcFo8/13lDlAPcT/rqJZpSXaT
 rvTLDTgDfxNUUwPNwHpTcZNRNOyzKcngsZpijUl4cwUMaOtqW4
 X+EgMJaVWmwRFzi+2sEVPE5zHOBa8b6F7LAa+Yt8RTlNWFcnIh
 pJ6ZXRSvz5J9P8ZVAELedloTVr8En2X2To8UWOz3JEd6mGheh4
 CVgG9B274bIOELwT6xG4LQ53Y8leFmWWHEAXdNivjbTNGbe0DC
 BPz0/87euhf+h1Ct68F76Q89YHTVeIcqk4p8k4nwFNMecpWg6E
 LUrY29e4+ANjwEefH3Lh1fREVIPwFrA0Iq2nqEyKK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231056>

On Tue, Jul 23, 2013 at 12:03:05PM -0700, Junio C Hamano wrote:
> SZEDER G=E1bor <szeder@ira.uka.de> writes:
> > (Side question: the test suite is full with similar constructs, i.e=
=2E
> > redirecting file contents to stdin, but why not just use wc -l b.c,
> > i.e. let wc open the file?)
>=20
> "wc -l <b.c" is the correct form for the purpose of these tests;
> otherwise you will see the filename in the output, and you need to
> somehow strip it if you are only interested in the line count.

=46acepalm, that should have been obvious...
