From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 0/2] Fix cover letters when they contain non-ASCII
Date: Mon, 10 Aug 2009 18:22:12 +0200 (CEST)
Message-ID: <cover.1249921206u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1289083413-1249921284=:8324"
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Aug 10 18:22:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaXde-0005Lc-G7
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 18:22:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755616AbZHJQWO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 12:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755613AbZHJQWO
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 12:22:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:45952 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755582AbZHJQWO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 12:22:14 -0400
Received: (qmail invoked by alias); 10 Aug 2009 16:22:13 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp008) with SMTP; 10 Aug 2009 18:22:13 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19bNLAuWNZbyMGqxQfhYq413HoZ+yZi1368OaWczM
	mfTfyk4VMzAfPC
X-X-Sender: schindel@intel-tinevez-2-302
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
Content-ID: <alpine.DEB.1.00.0908101821460.8324@intel-tinevez-2-302>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125478>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1289083413-1249921284=:8324
Content-Type: TEXT/PLAIN; CHARSET=VISCII
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.1.00.0908101821461.8324@intel-tinevez-2-302>

Hi,

I saw this issue with Santi's and Nguy­n's patch series.

Johannes Schindelin (2):
  Expose the has_non_ascii() function
  Correctly mark cover letters' encodings if they are not pure ASCII

 builtin-log.c |    4 ++++
 commit.h      |    1 +
 log-tree.c    |   12 ------------
 pretty.c      |   12 ++++++++++++
 4 files changed, 17 insertions(+), 12 deletions(-)
--8323329-1289083413-1249921284=:8324--
