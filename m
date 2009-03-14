From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] test-lib: write test results to
	test-results/<basename>-<pid>
Date: Sat, 14 Mar 2009 13:28:33 +0100
Message-ID: <20090314122833.GK6808@neumann>
References: <cover.1236961524u.git.johannes.schindelin@gmx.de>
	<3728317206182c4d4539f3d20b8441cb160e72e3.1236961524u.git.johannes.schindelin@gmx.de>
	<alpine.DEB.1.00.0903131735110.6288@intel-tinevez-2-302>
	<20090313172002.GA16232@neumann>
	<alpine.DEB.1.00.0903141250450.10279@pacific.mpi-cbg.de>
	<20090314121617.GJ6808@neumann>
	<alpine.DEB.1.00.0903141321550.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com,
	Sverre Rabbelier <alturin@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Mar 14 13:30:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LiT0B-0003Z5-L1
	for gcvg-git-2@gmane.org; Sat, 14 Mar 2009 13:30:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbZCNM2i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Mar 2009 08:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbZCNM2i
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Mar 2009 08:28:38 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:58047 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751178AbZCNM2i (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Mar 2009 08:28:38 -0400
Received: from [127.0.1.1] (p5B130307.dip0.t-ipconnect.de [91.19.3.7])
	by mrelayeu.kundenserver.de (node=mrelayeu7) with ESMTP (Nemesis)
	id 0ML2xA-1LiSyf0aUF-00012o; Sat, 14 Mar 2009 13:28:35 +0100
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0903141321550.10279@pacific.mpi-cbg.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Provags-ID: V01U2FsdGVkX1+tP8DlF1c4TDBksP6lzViXhUqOBbsi1djECuL
 otqWcR8JaJNFdIHw1tI9izWnTlesgb0OK2E1KdYBt/ltvcEm8c
 MuGAlK9L+SxpFvUd0mFgA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113249>

On Sat, Mar 14, 2009 at 01:22:59PM +0100, Johannes Schindelin wrote:
> On Sat, 14 Mar 2009, SZEDER G=E1bor wrote:
>=20
> > If you have failing tests, or if you interrupt the tests, then you
> > will have stale files lying around _anyway_:  not only test results
> > are left there, but also trash directories.
>=20
> The 'pre-clean' target actually cleans test-results/, and test-lib.sh=
 make=20
> sure that the trash directory is removed and recreated.

With my proposed change there would be no need to clean 'test-results'
before running the tests, because test-lib.sh would take care of that
(not by removing and recreating 'test-results/', but by overwriting
(IOW: removing and recreating, but in one step) individual test result
files).


Best,
G=E1bor
