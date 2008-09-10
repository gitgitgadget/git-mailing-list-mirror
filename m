From: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
Subject: [PATCH 0/2] Assist installing documentation with incomplete build chain
Date: Wed, 10 Sep 2008 10:33:40 +0200
Message-ID: <cover.1221035620.git.michaeljgruber+gmane@fastmail.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 10 11:06:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdLej-0001Rc-0V
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 11:06:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751636AbYIJJFV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 05:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751559AbYIJJFV
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 05:05:21 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:44418 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751508AbYIJJFU (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Sep 2008 05:05:20 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 4202415FB72
	for <git@vger.kernel.org>; Wed, 10 Sep 2008 05:05:19 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 10 Sep 2008 05:05:19 -0400
X-Sasl-enc: N2XelgbcTflm7AMrvfXhBsA9Fy/NNCi08JCqAOhuItqq 1221037518
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id CD85125BCE
	for <git@vger.kernel.org>; Wed, 10 Sep 2008 05:05:18 -0400 (EDT)
X-Mailbox-Line: From 81ce09dd0ac69ee7e09731e3ad26ff7cd1ab0765 Mon Sep 17 00:00:00 2001
User-Agent: Thunderbird 2.0.0.16 (X11/20080707)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95502>

This patch series should clarify make targets for documentation and
help those with partial or no documentation build chain, without breaking
existing behaviour. Therefore, the current inconsistency between "make
doc" (builds man and html doc) and "make install-doc" (installs man) is
preserved.

The INSTALL file documents this now, as well as preexisting and new
targets for building and installing man and html separately or from the
convenience branches origin/{man,html}.

Michael J Gruber (2):
  allow installation of man and html doc from the man and html branches
  separate build targets for man and html documentation

 Documentation/Makefile |    4 ++++
 INSTALL                |   20 +++++++++++++++++---
 Makefile               |    9 +++++++++
 3 files changed, 30 insertions(+), 3 deletions(-)
