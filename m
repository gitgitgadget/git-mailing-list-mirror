From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: [PATCH 0/2] configure tweaks for NO_PYTHON
Date: Sun, 31 Jan 2010 21:15:03 -0500
Message-ID: <1264990505-29578-1-git-send-email-bwalton@artsci.utoronto.ca>
Cc: Ben Walton <bwalton@artsci.utoronto.ca>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Feb 01 03:15:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nblp4-00005P-Ir
	for gcvg-git-2@lo.gmane.org; Mon, 01 Feb 2010 03:15:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754970Ab0BACPZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jan 2010 21:15:25 -0500
Received: from www.cquest.utoronto.ca ([192.82.128.5]:44665 "EHLO
	www.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754436Ab0BACPU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jan 2010 21:15:20 -0500
Received: from ntdws12.chass.utoronto.ca ([128.100.160.253]:48748 ident=93)
	by www.cquest.utoronto.ca with esmtp (Exim 4.43)
	id 1Nbloi-0003Yb-1r; Sun, 31 Jan 2010 21:15:08 -0500
Received: from localhost
	([127.0.0.1] helo=ntdws12.chass.utoronto.ca ident=505)
	by ntdws12.chass.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1Nbloh-0007hd-Vg; Sun, 31 Jan 2010 21:15:08 -0500
Received: (from bwalton@localhost)
	by ntdws12.chass.utoronto.ca (8.13.8/8.13.8/Submit) id o112F7gj029609;
	Sun, 31 Jan 2010 21:15:07 -0500
X-Mailer: git-send-email 1.6.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138574>

The following patches enable a user to ./configure git with python
disabled.  There is nothing using the remote helper libraries yet.  I
noticed this missing capability after the recent rpm .spec thread.

Ben Walton (2):
  configure: Allow GIT_ARG_SET_PATH to handle --without-PROGRAM
  configure: Allow --without-python

 configure.ac |   17 ++++++++++++++---
 1 files changed, 14 insertions(+), 3 deletions(-)
