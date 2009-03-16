From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] test-lib: write test results to
 test-results/<basename>-<pid>
Date: Mon, 16 Mar 2009 11:18:19 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903161115520.5741@eeepc-johanness>
References: <cover.1236961524u.git.johannes.schindelin@gmx.de>  <3728317206182c4d4539f3d20b8441cb160e72e3.1236961524u.git.johannes.schindelin@gmx.de>  <alpine.DEB.1.00.0903131735110.6288@intel-tinevez-2-302>  <20090313172002.GA16232@neumann> 
 <alpine.DEB.1.00.0903141250450.10279@pacific.mpi-cbg.de>  <20090314121617.GJ6808@neumann>  <alpine.DEB.1.00.0903141321550.10279@pacific.mpi-cbg.de>  <20090314122833.GK6808@neumann> <fabb9a1e0903140616q3770f89axff84755abb1f47c7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="658432-802818595-1237198699=:5741"
Cc: =?ISO-8859-15?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org, gitster@pobox.com
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 16 11:18:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lj9te-0002sh-TY
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 11:18:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757933AbZCPKPw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2009 06:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755265AbZCPKPw
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 06:15:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:33402 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753088AbZCPKPv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2009 06:15:51 -0400
Received: (qmail invoked by alias); 16 Mar 2009 10:15:48 -0000
Received: from BABd231.bab.pppool.de (EHLO eeepc-johanness.st-andrews.ac.uk) [77.129.210.49]
  by mail.gmx.net (mp057) with SMTP; 16 Mar 2009 11:15:48 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX199dDEcw0t9ZB38x6/I/Aen4NN2g1rsEjNghBseDD
	AOOOXKh8tAEd0K
X-X-Sender: user@eeepc-johanness
In-Reply-To: <fabb9a1e0903140616q3770f89axff84755abb1f47c7@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113314>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--658432-802818595-1237198699=:5741
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Sat, 14 Mar 2009, Sverre Rabbelier wrote:

> On Sat, Mar 14, 2009 at 13:28, SZEDER Gábor <szeder@ira.uka.de> wrote:
> > With my proposed change there would be no need to clean 'test-results'
> > before running the tests, because test-lib.sh would take care of that
> > (not by removing and recreating 'test-results/', but by overwriting
> > (IOW: removing and recreating, but in one step) individual test result
> > files).
> 
> Wouldn't that result in possible stale files being counted in the
> result (e.g., if those tests were not run this time, but they were run
> previously)?

Yes.  Stale files would be counted in.  The fact that aggregate-results.sh 
is called when running "make" in t/ is a sure sign for me that you should 
not muddy waters by making unnecessary changes that break the default 
usage from time to time.

So I really, really, really, really would like that patch _not_ to be 
applied.

And I really would like to be able to spend my time on other things than 
discussing this at more length than necessary.

Ciao,
Dscho

--658432-802818595-1237198699=:5741--
