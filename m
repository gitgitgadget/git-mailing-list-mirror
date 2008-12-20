From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 4/4] Add an expensive test for git-notes
Date: Sat, 20 Dec 2008 12:51:48 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0812201250570.30769@pacific.mpi-cbg.de>
References: <5d46db230812160015t55b4ff2fubbf1e2f826a97b98@mail.gmail.com> <alpine.DEB.1.00.0812192347261.30769@pacific.mpi-cbg.de> <alpine.DEB.1.00.0812200035590.30769@pacific.mpi-cbg.de> <200812191749.43512.bss@iguanasuicide.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-2019076959-1229773908=:30769"
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Govind Salinas <govind@sophiasuchtig.com>
To: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
X-From: git-owner@vger.kernel.org Sat Dec 20 12:45:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LE0H0-0002Pk-2C
	for gcvg-git-2@gmane.org; Sat, 20 Dec 2008 12:45:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752641AbYLTLoL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Dec 2008 06:44:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752638AbYLTLoK
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Dec 2008 06:44:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:59256 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752454AbYLTLoJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Dec 2008 06:44:09 -0500
Received: (qmail invoked by alias); 20 Dec 2008 11:44:06 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp071) with SMTP; 20 Dec 2008 12:44:06 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19DiiIfnRBDnvN5wCHDkbXkwFIfzr9sxT8fU1HufC
	Zqww6TCgx7Nc6X
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <200812191749.43512.bss@iguanasuicide.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103641>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2019076959-1229773908=:30769
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

Hi,

On Fri, 19 Dec 2008, Boyd Stephen Smith Jr. wrote:

> On Friday 2008 December 19 17:37:15 Johannes Schindelin wrote:
> > +       test_expect_success 'notes timing' "time_notes 100"
>                                                          ^^^
> Probably should be ${count}.

No.  It times a git log 100 times (actually, 99 times due to a thinko).  
This is only to protect against jitter, otherwise I'd do it only once.

Hth,
Dscho
--8323328-2019076959-1229773908=:30769--
