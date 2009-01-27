From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 0/2] Fix two issues found by valgrind
Date: Wed, 28 Jan 2009 00:07:21 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901280005180.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 28 00:08:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRx2k-0005hr-W4
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 00:08:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324AbZA0XHF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 18:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbZA0XHF
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 18:07:05 -0500
Received: from mail.gmx.net ([213.165.64.20]:54646 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750943AbZA0XHD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 18:07:03 -0500
Received: (qmail invoked by alias); 27 Jan 2009 23:07:01 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp021) with SMTP; 28 Jan 2009 00:07:01 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19ZBnlIOOxZ3mO1yd03DtYHyDnVzCwFs7W2rpl630
	XzLX3Jsw6jK0O6
X-X-Sender: schindelin@pacific.mpi-cbg.de
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.72
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107418>

Okay, not tons of issues.  But at least it was worth the hassle.

Johannes Schindelin (2):
  test-path-utils: Fix off by one, found by valgrind
  get_sha1_basic(): fix invalid memory access, found by valgrind

 sha1_name.c       |    2 +-
 test-path-utils.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
