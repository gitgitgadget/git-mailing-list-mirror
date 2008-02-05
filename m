From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT Patches] Sort order from hell fixes
Date: Wed,  6 Feb 2008 00:46:04 +0100
Message-ID: <1202255166-4581-1-git-send-email-robin.rosenberg@dewire.com>
Cc: "Roger C. Soares" <rogersoares@intelinet.com.br>,
	Dave Watson <dwatson@mimvista.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 06 00:46:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMXUz-0004GL-IY
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 00:46:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760435AbYBEXqM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 18:46:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760482AbYBEXqL
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 18:46:11 -0500
Received: from [83.140.172.130] ([83.140.172.130]:29917 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1757113AbYBEXqK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 18:46:10 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id DC4AD80068E;
	Wed,  6 Feb 2008 00:46:08 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QbEexguNIu8A; Wed,  6 Feb 2008 00:46:08 +0100 (CET)
Received: from lathund.dewire.com (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 09596800686;
	Wed,  6 Feb 2008 00:46:08 +0100 (CET)
Received: by lathund.dewire.com (Postfix, from userid 500)
	id 26A7828037; Wed,  6 Feb 2008 00:46:05 +0100 (CET)
X-Mailer: git-send-email 1.5.4.rc4.25.g81cc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72723>

This fixes conflict detection in checkout that yielded false conflicts
and, according to a user, a problem where checkin did not find anything
to check in.

-- robin
