From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Bug: rebase when an author uses accents in name on MacOSx
Date: Thu, 31 May 2012 16:28:44 +0200
Message-ID: <87bol4ifvn.fsf@thomas.inf.ethz.ch>
References: <06DD2F56-F956-46DF-84A4-3443D4702CDE@spotinfluence.com>
	<7vehq18c82.fsf@alter.siamese.dyndns.org>
	<20120531011911.GC5488@sigill.intra.peff.net>
	<7v62bc97w1.fsf@alter.siamese.dyndns.org>
	<78E7FEAC-6587-4EB3-B78B-08D321F53BF9@spotinfluence.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	<git@vger.kernel.org>
To: Lanny Ripple <lanny@spotinfluence.com>
X-From: git-owner@vger.kernel.org Thu May 31 16:38:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sa6WV-0000Ig-Qu
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 16:38:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754256Ab2EaO3c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 May 2012 10:29:32 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:18845 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753347Ab2EaO3b convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 May 2012 10:29:31 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 31 May
 2012 16:28:43 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (46.126.8.85) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 31 May
 2012 16:28:45 +0200
In-Reply-To: <78E7FEAC-6587-4EB3-B78B-08D321F53BF9@spotinfluence.com> (Lanny
	Ripple's message of "Thu, 31 May 2012 08:36:16 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198907>

Lanny Ripple <lanny@spotinfluence.com> writes:

> Bingo.
>
>   lanny;~> echo "R=C3=A9mi Leblond" | LANG=3DC LC_ALL=3DC /usr/bin/se=
d -ne 's/.*/GIT_AUTHOR_NAME=3D'\''&'\''/p'
>   GIT_AUTHOR_NAME=3D'R=C3=A9mi Leblond'
>
> Just occurred to me that I'm using fink and that git-am doesn't use
> /usr/bin/sed but just sed.  My suggestion is to be explicit on the
> path in git-am.

Then how would you work around a platform sed that is broken?  You can'=
t
just install a new one in another directory if we use an absolute path.
Which apparently is what people have to do on Solaris, see the
SANE_TOOL_PATH setting for the Makefile.

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
