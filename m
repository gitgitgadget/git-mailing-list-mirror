From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 0/3] Resource decorator improvements
Date: Fri, 11 Jul 2008 00:41:05 +0200
Message-ID: <1215729668-26865-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jul 11 00:47:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KH4vZ-0004Lo-T2
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 00:47:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754406AbYGJWqX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 18:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755156AbYGJWqW
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 18:46:22 -0400
Received: from [83.140.172.130] ([83.140.172.130]:13173 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754245AbYGJWqP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 18:46:15 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 445EAA149A3;
	Fri, 11 Jul 2008 00:46:14 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HdpvYIon0uVJ; Fri, 11 Jul 2008 00:46:13 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id B04EF8027F7;
	Fri, 11 Jul 2008 00:46:13 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.2.220.g44701
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88032>

Connect the decorator and fix some problems. The first patch depends
on the repository event mechanism.

-- robin

Robin Rosenberg (3):
  Use a job for the resource decorator
  Avoid errors by allowing phantoms during traversal in the resource
    decorator
  Log decoration problems more silently

 .../internal/decorators/GitResourceDecorator.java  |  168 ++++++++++++--------
 1 files changed, 98 insertions(+), 70 deletions(-)
