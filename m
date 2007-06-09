From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH 0/3] submodule improvements
Date: Sat,  9 Jun 2007 23:38:49 +0200
Message-ID: <1181425132239-git-send-email-hjemli@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sven Verdoolaege <skimo@kotnet.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 09 23:36:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hx8bz-00008j-6p
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 23:36:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756336AbXFIVg0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jun 2007 17:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754881AbXFIVg0
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 17:36:26 -0400
Received: from mail43.e.nsc.no ([193.213.115.43]:53407 "EHLO mail43.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756184AbXFIVgY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2007 17:36:24 -0400
Received: from localhost.localdomain (ti231210a080-7628.bb.online.no [80.213.29.208])
	by mail43.nsc.no (8.13.8/8.13.5) with ESMTP id l59LaKTe006815;
	Sat, 9 Jun 2007 23:36:20 +0200 (MEST)
X-Mailer: git-send-email 1.5.2.1.914.gbd3a7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49620>

This is a series of somewhat unrelated changes, but all related to
git-submodule.

1/3 implements a mapping between submodule path and submodule name
2/3 adds a gitmodules(5) document
3/3 fixes a bug in testscript t7400, noticed when making 1/3

The stats:

Documentation/Makefile                             |    2 +-
Documentation/git-submodule.txt                    |   16 +++--
Documentation/gitmodules.txt                       |   63 ++++++++++++++++++++
git-submodule.sh                                   |   44 +++++++++----
t/t7400-submodule-basic.sh                         |    2 +-
...submodule-basic.sh => t7401-submodule-named.sh} |   27 ++++++---
6 files changed, 124 insertions(+), 30 deletions(-)
