From: Damien Diederen <dash@foobox.net>
Subject: [PATCH v2 0/7] Enhance TkCVS interoperability
Date: Thu, 27 Mar 2008 23:17:03 +0100
Message-ID: <cover.1206654905.git.dash@foobox.net>
References: <cover.1206393086.git.dash@foobox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rafael Garcia-Suarez <rgarciasuarez@gmail.com>,
	Frank Lichtenheld " <frank@lichtenheld.de>, Martin Langhoff" 
	<martin@catalyst.net.nz>, Damien Diederen <dash@foobox.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 27 23:17:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jf0Pu-0005co-SD
	for gcvg-git-2@gmane.org; Thu, 27 Mar 2008 23:17:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759167AbYC0WRI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2008 18:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759209AbYC0WRG
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Mar 2008 18:17:06 -0400
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:46856 "EHLO
	mail-in-01.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758971AbYC0WRF (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Mar 2008 18:17:05 -0400
Received: from mail-in-16-z2.arcor-online.net (mail-in-16-z2.arcor-online.net [151.189.8.33])
	by mail-in-01.arcor-online.net (Postfix) with ESMTP id 429A9173493;
	Thu, 27 Mar 2008 23:17:04 +0100 (CET)
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net [151.189.21.42])
	by mail-in-16-z2.arcor-online.net (Postfix) with ESMTP id 327C72540DB;
	Thu, 27 Mar 2008 23:17:04 +0100 (CET)
Received: from keem.bcc (dslb-084-057-042-002.pools.arcor-ip.net [84.57.42.2])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id 7CBC17FC8;
	Thu, 27 Mar 2008 23:17:03 +0100 (CET)
In-Reply-To: <cover.1206393086.git.dash@foobox.net>
X-From-Line: f7869cd4f5ed963cbc298ee64b77a43ebd778b0f Mon Sep 17 00:00:00 2001
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/23.0.60 (gnu/linux)
X-Virus-Scanned: ClamAV 0.92.1/6432/Thu Mar 27 22:18:40 2008 on mail-in-02.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78369>

This series was developed to improve interoperability between
git-cvsserver and TkCVS, a CVS client that is fairly popular at least
in some corporate environments.

This revised version incorporates suggestions from Frank Lichtenheld
and Rafael Garcia-Suarez, plus a small internal documentation update.
I have no outstanding changes planned for the near future.  Junio,
this can go in as far as I am concerned.

        Damien

Damien Diederen (7):
  cvsserver: Respond to the 'editors' and 'watchers' commands
  cvsserver: Only print the file part of the filename in status header
  cvsserver: Do not include status output for subdirectories if -l is
    passed
  cvsserver: Add a few tests for 'status' command
  cvsserver: Implement update -p (print to stdout)
  cvsserver: Add test for update -p
  cvsserver: Use the user part of the email in log and annotate results

 git-cvsserver.perl              |   78 +++++++++++++++++++++++++++++---------
 t/t9400-git-cvsserver-server.sh |   50 +++++++++++++++++++++++++
 2 files changed, 109 insertions(+), 19 deletions(-)
