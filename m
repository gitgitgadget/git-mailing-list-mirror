From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 0/2] Make local branches behave like remote branches when --tracked
Date: Thu, 26 Mar 2009 21:53:23 +0100
Message-ID: <1238100805-19619-1-git-send-email-git@drmicha.warpmail.net>
References: <alpine.LNX.1.00.0903201358440.19665@iabervon.org>
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 26 21:55:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lmwbr-0000q8-Uq
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 21:55:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756372AbZCZUxa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 16:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754109AbZCZUxa
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 16:53:30 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:47939 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751069AbZCZUxa (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Mar 2009 16:53:30 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 97C082FF0D5;
	Thu, 26 Mar 2009 16:53:27 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 26 Mar 2009 16:53:27 -0400
X-Sasl-enc: rk5TiJq53I1u+3pKn0B+qzAVgFmzISQWERoYMWO4VXR8 1238100806
Received: from localhost (p4FC63417.dip0.t-ipconnect.de [79.198.52.23])
	by mail.messagingengine.com (Postfix) with ESMTPSA id DE5AE5903;
	Thu, 26 Mar 2009 16:53:26 -0400 (EDT)
X-Mailer: git-send-email 1.6.2.1.507.g0e68d
In-Reply-To: <alpine.LNX.1.00.0903201358440.19665@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114816>

[Sorry it took so long to finish... This is from my "sick bed", I hope
it doesn't show ;)]

This mini series makes local branches behave the same as remote ones
when they are used as --tracked branches. This means differences are
reported by git status and git checkout, and also that the soon to be
released tracking branch short cut (aka BEL) will work.

Michael J Gruber (2):
  Test for local branches being followed with --track
  Make local branches behave like remote branches when --tracked

 remote.c                 |    9 +++++----
 t/t6040-tracking-info.sh |   10 +++++++++-
 2 files changed, 14 insertions(+), 5 deletions(-)
