From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] test-lib: write test results to
	test-results/<basename>-<pid>
Date: Fri, 13 Mar 2009 18:44:20 +0100
Message-ID: <20090313174420.GF6808@neumann>
References: <cover.1236961524u.git.johannes.schindelin@gmx.de>
	<3728317206182c4d4539f3d20b8441cb160e72e3.1236961524u.git.johannes.schindelin@gmx.de>
	<alpine.DEB.1.00.0903131735110.6288@intel-tinevez-2-302>
	<20090313172002.GA16232@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com,
	Sverre Rabbelier <alturin@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 13 18:46:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LiBSE-0003k1-CH
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 18:45:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754437AbZCMRo0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Mar 2009 13:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754180AbZCMRoZ
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 13:44:25 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:63382 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752785AbZCMRoZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2009 13:44:25 -0400
Received: from [127.0.1.1] (p5B133D40.dip0.t-ipconnect.de [91.19.61.64])
	by mrelayeu.kundenserver.de (node=mrelayeu7) with ESMTP (Nemesis)
	id 0ML2xA-1LiBQi3RSx-00010A; Fri, 13 Mar 2009 18:44:21 +0100
Content-Disposition: inline
In-Reply-To: <20090313172002.GA16232@neumann>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Provags-ID: V01U2FsdGVkX1/wki79bq+i5jx+32xHZ7aMxuHnE+yzuags76B
 J9CXn+3Q1qRip/dFQo6o8GzCEiHV7Pw2LYPsjAt0GTLkuAJ4Yt
 feRuGi81SYlbq6eBmf1gg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113214>

On Fri, Mar 13, 2009 at 06:20:02PM +0100, SZEDER G=E1bor wrote:
> Hi,
>=20
>=20
> On Fri, Mar 13, 2009 at 05:36:13PM +0100, Johannes Schindelin wrote:
> > On Fri, 13 Mar 2009, Johannes Schindelin wrote:
> >=20
> > > The earlier code meant to attempt to strip everything except the =
test
> > > number, but only stripped the part starting with the last dash.
> > >=20
> > > However, there is no reason why we should not use the whole basen=
ame.
>=20
> I agree.
>=20
> > >=20
> > > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > > ---
> > >=20
> > > 	Even if this is not strictly necessary after Hannes' test cleanu=
p,=20
> > > 	it would still be nice.
> >
> > Just to clarify: it fixes the issue that these two tests share the =
same=20
> > file in test-results/: t5521-pull-options.sh  t5521-pull-symlink.sh
> >=20
> > As a consequence, one's results overwrite the other one's.
>=20
> The pid of the test process makes the name of the test result file
> unique for each test, even in the mentioned case, e.g. it would be
> something like t5521-pull-12345 and t5521-pull-23456.

Correction:  those files are not always unique, because although
unlikely, it's possible that these two tests get the same pid.

But with Hannes' patch this issue goes away, and the rest of my
previous mail still holds.


Best,
G=E1bor
