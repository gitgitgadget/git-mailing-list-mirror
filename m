From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] test-lib: write test results to
	test-results/<basename>-<pid>
Date: Mon, 16 Mar 2009 11:41:38 +0100
Message-ID: <20090316104138.GD10963@neumann>
References: <cover.1236961524u.git.johannes.schindelin@gmx.de>
	<3728317206182c4d4539f3d20b8441cb160e72e3.1236961524u.git.johannes.schindelin@gmx.de>
	<alpine.DEB.1.00.0903131735110.6288@intel-tinevez-2-302>
	<20090313172002.GA16232@neumann>
	<alpine.DEB.1.00.0903141250450.10279@pacific.mpi-cbg.de>
	<20090314121617.GJ6808@neumann>
	<alpine.DEB.1.00.0903141321550.10279@pacific.mpi-cbg.de>
	<20090314122833.GK6808@neumann>
	<fabb9a1e0903140616q3770f89axff84755abb1f47c7@mail.gmail.com>
	<alpine.DEB.1.00.0903161115520.5741@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 16 11:43:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjAHs-0002Ad-CV
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 11:43:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754432AbZCPKlp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Mar 2009 06:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754262AbZCPKlp
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 06:41:45 -0400
Received: from francis.fzi.de ([141.21.7.5]:52889 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753904AbZCPKlo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2009 06:41:44 -0400
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 16 Mar 2009 11:41:38 +0100
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0903161115520.5741@eeepc-johanness>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-OriginalArrivalTime: 16 Mar 2009 10:41:38.0064 (UTC) FILETIME=[C8DB2100:01C9A623]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113318>

On Mon, Mar 16, 2009 at 11:18:19AM +0100, Johannes Schindelin wrote:
> On Sat, 14 Mar 2009, Sverre Rabbelier wrote:
>=20
> > On Sat, Mar 14, 2009 at 13:28, SZEDER G=E1bor <szeder@ira.uka.de> w=
rote:
> > > With my proposed change there would be no need to clean 'test-res=
ults'
> > > before running the tests, because test-lib.sh would take care of =
that
> > > (not by removing and recreating 'test-results/', but by overwriti=
ng
> > > (IOW: removing and recreating, but in one step) individual test r=
esult
> > > files).
> >=20
> > Wouldn't that result in possible stale files being counted in the
> > result (e.g., if those tests were not run this time, but they were =
run
> > previously)?
>=20
> Yes.  Stale files would be counted in.  The fact that aggregate-resul=
ts.sh=20
> is called when running "make" in t/ is a sure sign for me that you sh=
ould=20
> not muddy waters by making unnecessary changes that break the default=
=20
> usage from time to time.

As I explained earlier, it won't change the default usage at all, but,
as I explained in my response to Sverre, it would actually fix a
current breakage in certain cases (i.e. make t1234-foo.sh ; make
t1234-foo.sh ; make aggregate-results would report the correct
numbers).

> And I really would like to be able to spend my time on other things t=
han=20
> discussing this at more length than necessary.

Ok, then I will also spare the effort of updating the patch.
Unless, of course, there are others who are interested.


Thanks,
G=E1bor
