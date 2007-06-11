From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH 0/5] misc. submodule related changes
Date: Mon, 11 Jun 2007 21:12:20 +0200
Message-ID: <11815891453464-git-send-email-hjemli@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 11 21:10:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxpHH-0007ab-Js
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 21:10:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751691AbXFKTJz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 15:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751979AbXFKTJz
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 15:09:55 -0400
Received: from mail49.e.nsc.no ([193.213.115.49]:40948 "EHLO mail49.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751691AbXFKTJz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 15:09:55 -0400
Received: from localhost.localdomain (ti231210a341-2365.bb.online.no [85.166.53.63])
	by mail49.nsc.no (8.13.8/8.13.5) with ESMTP id l5BJ9pBP025419;
	Mon, 11 Jun 2007 21:09:51 +0200 (MEST)
X-Mailer: git-send-email 1.5.2.1.914.gbd3a7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49871>

Here is a reworked patch-series for git-submodule, trying to cater for
the issues with the previous series.

Shortlog:
 [1/5] t7400: barf if git-submodule removes or replaces a file
 [2/5] git-submodule: remember to checkout after clone
 [3/5] Rename sections from "module" to "submodule" in .gitmodules
 [4/5] git-submodule: give submodules proper names
 [5/5] Add gitmodules(5)

Diffstat:
Documentation/Makefile       |    2 +-
Documentation/gitmodules.txt |   63 ++++++++++++++++++++++++++++++++++++++++++
git-submodule.sh             |   52 +++++++++++++++++++++++-----------
t/t7400-submodule-basic.sh   |   22 +++++++++++---
4 files changed, 116 insertions(+), 23 deletions(-)
