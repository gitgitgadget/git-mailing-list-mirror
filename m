From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH Series] Cleanups and javadocs
Date: Tue,  5 Feb 2008 01:15:28 +0100
Message-ID: <1202170534-15788-1-git-send-email-robin.rosenberg@dewire.com>
Cc: "Roger C. Soares" <rogersoares@intelinet.com.br>,
	Dave Watson <dwatson@mimvista.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 05 01:43:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMBtp-0001DL-Vv
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 01:42:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757993AbYBEAmG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 19:42:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757975AbYBEAmG
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 19:42:06 -0500
Received: from [83.140.172.130] ([83.140.172.130]:18374 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1755894AbYBEAmE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 19:42:04 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 42766800694;
	Tue,  5 Feb 2008 01:15:35 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xSpaRc6RRAmJ; Tue,  5 Feb 2008 01:15:34 +0100 (CET)
Received: from lathund.dewire.com (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id CBBC1800686;
	Tue,  5 Feb 2008 01:15:33 +0100 (CET)
Received: by lathund.dewire.com (Postfix, from userid 500)
	id 0EF78290ED; Tue,  5 Feb 2008 01:15:33 +0100 (CET)
X-Mailer: git-send-email 1.5.4.rc4.25.g81cc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72601>

Here is a number of small enhancements that reduce the number of warnings
displayed and raises the standard on comments. We now get javadoc comments
on all public and protected methods which hopefully will make it slighly
easier to get on the train for those interested in helping out with Egit/Jgit.

Disabling the else-warning is probably fairly uncontroversial. Disabling some
warning about boxing/unboxing of integers might be as might be requiring
javadoc comments.

-- robin
