From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2 0/4] Notes, reloaded
Date: Sat, 20 Dec 2008 13:04:34 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0812201304210.30769@pacific.mpi-cbg.de>
References: <5d46db230812160015t55b4ff2fubbf1e2f826a97b98@mail.gmail.com> <20081216085108.GA3031@coredump.intra.peff.net> <alpine.DEB.1.00.0812192347261.30769@pacific.mpi-cbg.de> <alpine.DEB.1.00.0812200034450.30769@pacific.mpi-cbg.de>
 <20081220065337.GA2581@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Govind Salinas <govind@sophiasuchtig.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 20 12:58:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LE0Tg-0005g8-EN
	for gcvg-git-2@gmane.org; Sat, 20 Dec 2008 12:58:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754131AbYLTL4z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Dec 2008 06:56:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754135AbYLTL4z
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Dec 2008 06:56:55 -0500
Received: from mail.gmx.net ([213.165.64.20]:39537 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754131AbYLTL4y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Dec 2008 06:56:54 -0500
Received: (qmail invoked by alias); 20 Dec 2008 11:56:53 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp001) with SMTP; 20 Dec 2008 12:56:53 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/7Oncx6HL7lrIg+V8KaTbQCqcKqin34U/iAYrhio
	UJ691K42N/LHvu
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20081220065337.GA2581@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103642>


My apologies; I forgot to rebase the series from my personal fork to Junio's
next.  This is the version that should apply cleanly.

Johannes Schindelin (4):
  Introduce commit notes
  Add a script to edit/inspect notes
  Speed up git notes lookup
  Add an expensive test for git-notes

 .gitignore                       |    1 +
 Documentation/config.txt         |   15 ++++
 Documentation/git-notes.txt      |   46 +++++++++++
 Makefile                         |    3 +
 cache.h                          |    3 +
 command-list.txt                 |    1 +
 commit.c                         |    1 +
 config.c                         |    5 +
 environment.c                    |    1 +
 git-notes.sh                     |   65 +++++++++++++++
 notes.c                          |  159 ++++++++++++++++++++++++++++++++++++++
 notes.h                          |    7 ++
 pretty.c                         |    5 +
 t/t3301-notes.sh                 |   65 +++++++++++++++
 t/t3302-notes-index-expensive.sh |   98 +++++++++++++++++++++++
 15 files changed, 475 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-notes.txt
 create mode 100755 git-notes.sh
 create mode 100644 notes.c
 create mode 100644 notes.h
 create mode 100755 t/t3301-notes.sh
 create mode 100755 t/t3302-notes-index-expensive.sh
