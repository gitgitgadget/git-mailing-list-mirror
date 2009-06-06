From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH QGit 0/4] enhancements for the context menu of the Rev list
Date: Sat,  6 Jun 2009 13:57:47 +0200
Message-ID: <1244289471-698-1-git-send-email-markus.heidelberg@web.de>
Cc: git@vger.kernel.org, Markus Heidelberg <markus.heidelberg@web.de>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 06 13:58:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCuXW-0007F6-2v
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 13:58:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753348AbZFFL6K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2009 07:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753239AbZFFL6J
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jun 2009 07:58:09 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:35210 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753206AbZFFL6I (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2009 07:58:08 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate02.web.de (Postfix) with ESMTP id 14C12101F6AC3;
	Sat,  6 Jun 2009 13:58:10 +0200 (CEST)
Received: from [89.59.108.98] (helo=localhost.localdomain)
	by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1MCuXJ-0006b6-00; Sat, 06 Jun 2009 13:58:09 +0200
X-Mailer: git-send-email 1.6.3.2.213.g30b07
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1+NBiKpkXgBKjgK8/FrJiHcgIs6oSJ+qc3605kN
	kWwBWgHsPS3bcmyYLUmzEJEOpZ4es+mSPl3XTpOfvppWQqrLOL
	NIfZgTYAmrLm8/ZXIdgQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120909>

Markus Heidelberg (4):
  Don't count the submenu entries for checking if it is empty
  Correctly count the entries in the revs context menu
  Avoid submenus with merely 1 entry
  Create a separate submenu for tags

 src/mainimpl.cpp |   51 +++++++++++++++++++++++++++++++++++++++------------
 1 files changed, 39 insertions(+), 12 deletions(-)
