From: Pierre Habouzit <madcoder@debian.org>
Subject: Making parse-opt incremental, reworked series
Date: Tue, 24 Jun 2008 11:12:05 +0200
Message-ID: <1214298732-6247-1-git-send-email-madcoder@debian.org>
References: <alpine.LFD.1.10.0806222207220.2926@woody.linux-foundation.org>
Cc: torvalds@linux-foundation.org, gitster@pobox.com, peff@peff.net,
	Johannes.Schindelin@gmx.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 24 11:13:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KB4aP-0007aq-JQ
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 11:13:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752773AbYFXJMQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 05:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752559AbYFXJMQ
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 05:12:16 -0400
Received: from pan.madism.org ([88.191.52.104]:48569 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751166AbYFXJMP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 05:12:15 -0400
Received: from madism.org (APuteaux-103-1-3-109.w217-128.abo.wanadoo.fr [217.128.49.109])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 4E072380D1;
	Tue, 24 Jun 2008 11:12:14 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 0F0C8351FE9; Tue, 24 Jun 2008 11:12:12 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.110.g736c7.dirty
In-Reply-To: <alpine.LFD.1.10.0806222207220.2926@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86021>

Here is a cleaned up series, with Junio's fixes, and some more.

The patch 7 is only a proof of concept, not meant to be merged at all, I
believe the rest is ready enough for now.

I'll try to do what I comment in patch 7/7 (reworking revisions option
parsing to be incremental as well) as soon as I have some time for it.
