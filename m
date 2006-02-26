From: Karl =?ISO-8859-1?Q?=20Hasselstr=F6m?= <kha@treskal.com>
Subject: [PATCH 0/4] some git-svnimport improvements
Date: Sun, 26 Feb 2006 06:03:35 +0100
Message-ID: <20060226050335.24860.95155.stgit@backpacker.hemma.treskal.com>
X-From: git-owner@vger.kernel.org Sun Feb 26 06:11:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDEBt-0000Op-U3
	for gcvg-git@gmane.org; Sun, 26 Feb 2006 06:11:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbWBZFL0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Feb 2006 00:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbWBZFL0
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Feb 2006 00:11:26 -0500
Received: from mxfep01.bredband.com ([195.54.107.70]:15301 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S1751204AbWBZFL0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Feb 2006 00:11:26 -0500
Received: from backpacker.hemma.treskal.com ([83.227.180.148] [83.227.180.148])
          by mxfep01.bredband.com with ESMTP
          id <20060226051122.WHXX16046.mxfep01.bredband.com@backpacker.hemma.treskal.com>
          for <git@vger.kernel.org>; Sun, 26 Feb 2006 06:11:22 +0100
Received: from backpacker.hemma.treskal.com (localhost.localdomain [127.0.0.1])
	by backpacker.hemma.treskal.com (Postfix) with ESMTP id AC32D167C
	for <git@vger.kernel.org>; Sun, 26 Feb 2006 06:11:21 +0100 (CET)
To: Git Mailing List <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16772>

This patch series teaches git-svnimport about the svn:executable and
svn:ignore Subversion properties (try to guess from their names what
they do!), and lets the user specify a file with username -> Full Name
<email@address> mappings.

I vaguely recall some discussion some time ago about the format of
this kind of username mapping file, but I ended up just picking the
simplest format I could think of since that was the boring part.
