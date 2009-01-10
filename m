From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] t7501-commit.sh: explicitly check that -F prevents
 invoking the editor
Date: Sat, 10 Jan 2009 12:48:28 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901101248080.30769@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0812301250210.30769@pacific.mpi-cbg.de> <1231522205-10510-1-git-send-email-dato@net.com.org.es> <alpine.DEB.1.00.0901101117100.30769@pacific.mpi-cbg.de> <20090110103252.GA32151@chistera.yi.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-336443607-1231588109=:30769"
Cc: git@vger.kernel.org, gitster@pobox.com
To: =?ISO-8859-15?Q?Adeodato_Sim=F3?= <dato@net.com.org.es>
X-From: git-owner@vger.kernel.org Sat Jan 10 12:49:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLcL1-00055q-Lv
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 12:49:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754115AbZAJLrs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2009 06:47:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753777AbZAJLrr
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jan 2009 06:47:47 -0500
Received: from mail.gmx.net ([213.165.64.20]:42095 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753750AbZAJLrq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2009 06:47:46 -0500
Received: (qmail invoked by alias); 10 Jan 2009 11:47:44 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp045) with SMTP; 10 Jan 2009 12:47:44 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19KHzRRP9hKI3fYMF6SMg41LTWjd3ojGCRysQEBjy
	yJBjruFMisVil0
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090110103252.GA32151@chistera.yi.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105098>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-336443607-1231588109=:30769
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Sat, 10 Jan 2009, Adeodato Simó wrote:

> * Johannes Schindelin [Sat, 10 Jan 2009 11:19:43 +0100]:
> 
> > >  test_expect_success '--signoff' '
> > >  	echo "yet another content *narf*" >> foo &&
> > > -	echo "zort" | (
> > > -		test_set_editor "$TEST_DIRECTORY"/t7500/add-content &&
> > > -		git commit -s -F - foo
> > > -	) &&
> > > +	echo "zort" | git commit -s -F - foo &&
> > >  	git cat-file commit HEAD | sed "1,/^$/d" > output &&
> > >  	test_cmp expect output
> > >  '
> 
> > AFAICT this still tests if -F - launches an editor, except that it _does_ 
> > launch the editor, waiting for the user to quit the editor.  Which is bad.
> 
> The default value of VISUAL for the test suite is ":" AFAICS. Hence,
> even if it's called, it will return immediately.

Ah.  Okay then.

Sorry for the noise,
Dscho
--8323328-336443607-1231588109=:30769--
