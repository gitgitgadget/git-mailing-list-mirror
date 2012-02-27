From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 2/3] parse-options: allow positivation of options starting, with no-
Date: Mon, 27 Feb 2012 09:30:09 +0100
Message-ID: <87d390smpa.fsf@thomas.inf.ethz.ch>
References: <4F49317A.3080809@lsrfire.ath.cx>
	<4F49332E.7070003@lsrfire.ath.cx>
	<7vy5rpcgrk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	<git@vger.kernel.org>, Bert Wesarg <bert.wesarg@googlemail.com>,
	Geoffrey Irving <irving@naml.us>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pierre Habouzit <madcoder@debian.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 27 09:30:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1vyQ-0005Ks-7S
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 09:30:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752867Ab2B0IaP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Feb 2012 03:30:15 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:50191 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752274Ab2B0IaO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Feb 2012 03:30:14 -0500
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 27 Feb
 2012 09:30:10 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 27 Feb
 2012 09:30:11 +0100
In-Reply-To: <7vy5rpcgrk.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 26 Feb 2012 15:32:47 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191618>

Junio C Hamano <gitster@pobox.com> writes:

> I would na=C3=AFvely expect that it would be sufficient to update an =
existing
> definition for "--no-frotz" that uses PARSE_OPT_NONEG to instead defi=
ne
> "--frotz" that by itself is a no-op, and "--no-frotz" would cause wha=
tever
> the option currently means, with an update to the help text that says
> something to the effect that "--frotz by itself is meaningless and is
> always used as --no-frotz".

Doesn't that last quote already answer your question?  It would be
rather awkward to see, in 'git apply -h',

  --add                 Also apply additions in the patch.  This is the
                        default; use --no-add to disable it.

Compare to the current concise wording

  --no-add              ignore additions made by the patch

which lists the main (or mainly used) form in the left column, and
doesn't have to implicitly mention the 'no-' convention again to make
the help display useful.

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
