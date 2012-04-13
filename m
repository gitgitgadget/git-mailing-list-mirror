From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH v2] tests: add initial bash completion tests
Date: Fri, 13 Apr 2012 12:52:38 +0200
Message-ID: <20120413105238.GE2164@goldbirke>
References: <1334181423-4391-1-git-send-email-felipe.contreras@gmail.com>
	<20120413091236.GC2164@goldbirke>
	<CAMP44s0_WQNpkVi0yMfaDgzBaUWOhRiS-2qxLtCHFzx71yKrSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 13 12:52:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIe7Y-0004hv-BH
	for gcvg-git-2@plane.gmane.org; Fri, 13 Apr 2012 12:52:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932961Ab2DMKws convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Apr 2012 06:52:48 -0400
Received: from moutng.kundenserver.de ([212.227.17.9]:63053 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751201Ab2DMKwr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2012 06:52:47 -0400
Received: from localhost6.localdomain6 (p5B130584.dip0.t-ipconnect.de [91.19.5.132])
	by mrelayeu.kundenserver.de (node=mreu4) with ESMTP (Nemesis)
	id 0M0oJP-1S0z4j2EJD-00udTz; Fri, 13 Apr 2012 12:52:39 +0200
Content-Disposition: inline
In-Reply-To: <CAMP44s0_WQNpkVi0yMfaDgzBaUWOhRiS-2qxLtCHFzx71yKrSw@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:oOBNrSYfsX8ZMjn143v/4rMC40TDHqEsPKnAigkD9im
 XxWDuvyyaGWSRJjGibC3DzzOQb/nyd/gzo0qydvEWH9n9q3XJp
 PPxbyPrDtvyfq7jPS074088rs+yVhQoEYPRrWAOBZrJeL4fya6
 BaQb/3nYEWWFKyxQ082rcym1/2N2gvsV1NsRhcI/9fFTxNs3fB
 LdZeBDdWV/K5fYCLr3GIq2gCpIJMk0xfqlBviS9xMeCLvktovW
 iCzCUSOgdcCT4SfoDkT3CY9IYdKJaiRqlvlXxQQl04MCVfgoRm
 6xs8jx09aIwqehygsENVjt12kkpnkRYOOYiy9EluTh+fnPqw+g
 fGYs7bXn2OARN7rDpslc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195409>

On Fri, Apr 13, 2012 at 01:34:46PM +0300, Felipe Contreras wrote:
> >> + =A0 =A0 run_completion "git f" &&
> >> + =A0 =A0 ! grep -q -v "^f" out
> >
> > grep is not a git command, so I'm not sure, but shouldn't these use
> > 'test_must_fail grep' instead of '! grep'?
>=20
> I'm not sure. Junio has already queued this, maybe you should send a
> patch on top of that.

It seems that both are used in the test suite, but '! grep' is more
common, so perhaps it's good as it is.

$ git grep '! grep' -- t |wc -l
136
$ git grep 'test_must_fail grep' -- t |wc -l
17
