From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] test-lib: write test results to
 test-results/<basename>-<pid>
Date: Sat, 14 Mar 2009 13:22:59 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903141321550.10279@pacific.mpi-cbg.de>
References: <cover.1236961524u.git.johannes.schindelin@gmx.de> <3728317206182c4d4539f3d20b8441cb160e72e3.1236961524u.git.johannes.schindelin@gmx.de> <alpine.DEB.1.00.0903131735110.6288@intel-tinevez-2-302> <20090313172002.GA16232@neumann>
 <alpine.DEB.1.00.0903141250450.10279@pacific.mpi-cbg.de> <20090314121617.GJ6808@neumann>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-252002524-1237033380=:10279"
Cc: git@vger.kernel.org, gitster@pobox.com,
	Sverre Rabbelier <alturin@gmail.com>
To: =?ISO-8859-15?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sat Mar 14 13:22:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LiSt4-0001l4-TW
	for gcvg-git-2@gmane.org; Sat, 14 Mar 2009 13:22:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751542AbZCNMVQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Mar 2009 08:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751465AbZCNMVQ
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Mar 2009 08:21:16 -0400
Received: from mail.gmx.net ([213.165.64.20]:36132 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751396AbZCNMVP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Mar 2009 08:21:15 -0400
Received: (qmail invoked by alias); 14 Mar 2009 12:21:12 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp018) with SMTP; 14 Mar 2009 13:21:12 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19q8ygVd0RqS05qBZmSLZq10/sEBC694wLxNJVaR9
	pkmr84v92vRECi
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090314121617.GJ6808@neumann>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.72
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113248>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-252002524-1237033380=:10279
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Sat, 14 Mar 2009, SZEDER Gábor wrote:

> If you have failing tests, or if you interrupt the tests, then you
> will have stale files lying around _anyway_:  not only test results
> are left there, but also trash directories.

The 'pre-clean' target actually cleans test-results/, and test-lib.sh make 
sure that the trash directory is removed and recreated.

Ciao,
Dscho

--8323328-252002524-1237033380=:10279--
